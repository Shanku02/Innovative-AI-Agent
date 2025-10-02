import openai
import tkinter as tk
from tkinter import ttk
openai.api_key = 'YOUR API KEY'   #openAI API key
import datetime


class TokenUsageApp:
    def __init__(self, master):
        self.master = master
        self.master.title("Token Usage Meter")
        
        self.max_tokens = 300  # Adjust as needed
        self.used_tokens = 0

        self.label_prompt = tk.Label(self.master, text="Prompt Tokens:")
        self.label_prompt.pack(pady=5)

        self.progress_prompt = ttk.Progressbar(self.master, orient="horizontal", length=300, mode="determinate", maximum=self.max_tokens)
        self.progress_prompt.pack()

        self.label_completion = tk.Label(self.master, text="Completion Tokens:")
        self.label_completion.pack(pady=5)

        self.progress_completion = ttk.Progressbar(self.master, orient="horizontal", length=300, mode="determinate", maximum=self.max_tokens)
        self.progress_completion.pack()

        self.label_total = tk.Label(self.master, text="Total Tokens:")
        self.label_total.pack(pady=5)

        self.progress_total = ttk.Progressbar(self.master, orient="horizontal", length=300, mode="determinate", maximum=self.max_tokens)
        self.progress_total.pack()
        self.partial_sequence = [{"role": "system", "content": "I am a household AI agent."}]
       
        user_input = input("Enter the task that user wants to do: ")
        response = openai.ChatCompletion.create(
                    model="gpt-3.5-turbo",
                    messages=[
                        {"role": "user", "content":
                        """you are a household AI agent working in the house for the task anticipation.
                           Here is the list of task you can do:
    "
            (make-bed)
            (make-breakfast)
            (serve-breakfast)
            (feed-pet)
            (load-laundry)
            (start-washer)
            (make-lunch)
            (serve-lunch)
            (start-dryer)
            (water-plant)
            (dust-windows)
            (vacuum-rooms)
            (clean-toilet)
            (serve-snacks)
            (iron-clothes)
            (stack-clothes)
            (clean-table)
            (clean-dishes)
            (make-dinner)
            (serve-dinner)
            (take-out-trash)
            (mow-lawn)
    "
    These are the daily household task that the household AI agent can perform. Make sure that the tasks follows the logic,
    like certain tasks can be done only in morning and and certain tasks cannot be done at night. 
    Now every time user gives a sequence of tasks you have to predict the tasks that user might ask you to do right after the current tasks.
    For every prompt you have to return me the predicted task list in following format
    [make-breakfast,load-laundry,serve-breakfast]. This will be the tasks that you think user will ask you do to right next(the upcoming sequence of task)
    """},
    {"role": "system", "content": "Hi, I am household AI agent I understand your command and I will follow it"},
    {"role": "user", "content": "make-bed,make-breakfast,load-laundry,serve-breakfast"},
    {"role": "system", "content": "[start-washer,water-plants,clean-dishes,feed-pet]"},
    {"role": "user", "content": "water-plants, start-washer, make-lunch, dust-windows"},
    {"role": "system", "content": "[serve-lunch,clean-dishes,start-dryer,clean-toilet,vacuum-rooms"},
    {"role": "user", "content": "make-lunch,serve-lunch,clean-dishes"},
    {"role": "system", "content": "[load-laundry,start-washer,dust-windows,mow-lawn"},
    {"role": "user", "content": "vacuum-rooms,clean-toilet,feed-pet,make-snacks"},
    {"role": "system", "content": "[serve-snacks,clean-dishes,iron-clothes,stack-clothes"},
    {"role": "user", "content": "iron-clothes,clean-table,stack-clothes,feed-pet"},
    {"role": "system", "content": "[make-dinner,serve-dinner,clean-dishes,take-out-trash]"},
    {"role": "user", "content": user_input},
                    ],
                    temperature=0.5,
                    max_tokens=150,
                    top_p=1,
                    frequency_penalty=0,
                    presence_penalty=0,
                    n=1,
                    stop=["\nUser:"],
                )

        upcoming_sequence = response["choices"][0]["message"]["content"]

        print("Upcoming_sequence:", upcoming_sequence)

        #lists are here mapping actions to goal_states
        
        goal_states=["make-bed","make-breakfast","serve-breakfast","feed-pet","load-laundry","start-washer","make-lunch","serve-lunch","start-dryer","water-plants","dust-windows","vacuum-rooms","clean-toilet","serve-snacks","iron-clothes","stack-clothes","clean-table","clean-dishes","make-dinner","serve-dinner","take-out-trash","mow-lawn"] 
        actions=["make-bed","make-breakfast","serve-breakfast","feed-pet","load-laundry","start-washer","make-lunch","serve-lunch","start-dryer","water-plants","dust-windows","vacuum-rooms","clean-toilet","serve-snacks","iron-clothes","stack-clothes","clean-table","clean-dishes","make-dinner","serve-dinner","take-out-trash","mow-lawn"] 

  
        #algorithm of generating goal_state
        goal_file="""(:goal (and """ 
        upcoming_sequence=user_input+upcoming_sequence
        for count,value in enumerate(actions):
            if value in upcoming_sequence:
                goal_file=goal_file+"\n ("+goal_states[count]+")"
        goal_file=goal_file+"))"
        print(goal_file)
                

        self.create_pddl_file(goal_file)
        
        self.update_token_meters()

    def create_pddl_file(gself,goal_string):
        file_string="""

(define (problem household-tasks)

  (:domain household-tasks)

  (:objects
    kitchen laundryRoom diningRoom garden bedroom toilets wardrobe livingRoom - location
    toaster - bUtensil
    bread - bIngredient
    Dal - lIngredient
    Pan1 - lUtensil
    allClothes - clothes
    room - rooms
    vacuum - cleaner
    windows - window
    spray - window-cleaner
    cookies - snacks
    plate - sUtensil  
    salad - dIngredient
    bowl - dUtensil  
    dish - dishes
    spongee - sponge
    plants - plant
    wac - watering-can
    toilet - toilet
    toiletCleaner - tcleaner 
    mop - mcleaner
    beds - bed
    tables - table
    tableCleaner - tacleaner
    dog - pet
    pedigree - petfood
    grass - lawn
    lawnMower - mower
  )

  (:init
    (at-location-din diningRoom)
    (at-location-kit kitchen)
    (at-location-gar garden)
    (at-location-laun laundryRoom)
    (has-bIngredient bread)
    (has-bUtensil toaster)
    (has-lIngredient Dal)
    (has-lUtensil Pan1) 
    (has-laundry-basket)
    (has-clothes allClothes)
    (available-cleaners vacuum)
    (no-person room)
    (needs-cleaning room)
    (has-window-cleaner spray)
    (window-dusty windows)
    (has-snacks cookies)
    (has-sUtensil plate)
    (has-dIngredient salad)
    (has-dUtensil bowl)
    (needs-cleaning-dishes dish)
    (available-sponge spongee)
    (has-watering-can wac )
    (has-washer)
    (washer-off)
    (has-dryer)
    (dryer-off)
    (has-ironbox)
    (has-trash-bag)
    (available-cleanerst toiletCleaner)
    (no-persont toilet)
    (needs-cleaningt toilet)
    (at-locationb bedroom)
    (bed-untidy beds)
    (has-shelf)
    (at-locationw wardrobe)
    (table-messy tables)
    (available-cleanersta tableCleaner)
    (hungry-pet dog)
    (has-pet-food pedigree)
    (at-location-liv livingRoom)
    (lawn-overgrown grass)    
    (available-mower lawnMower)  

    
  )   
    
    
"""
        file=open("New_Household"+datetime.datetime.now().strftime("%Y-%m-%d-%H:%M:%S")+".pddl",'w')
        file_string+=goal_string+"\n)"
        file.write(file_string)
        file.close()


        
        
    def update_token_meters(self):
        # Execute the OpenAI chat completion request
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",           
            messages=self.partial_sequence
        )
        
        # Update token usage values
        self.used_tokens = response.usage['prompt_tokens'] + response.usage['completion_tokens']
               
        # Define the cost per token based on OpenAI's pricing 
        cost_per_token = 0.000002  #cost per token
        
        # Calculate estimated cost
        estimated_cost = self.used_tokens * cost_per_token

        # Update progress bars
        self.progress_prompt["value"] = response.usage['prompt_tokens']
        self.progress_completion["value"] = response.usage['completion_tokens']
        self.progress_total["value"] = self.used_tokens

        # Update labels with usage numbers
        self.label_prompt.config(text=f"Prompt Tokens: {response.usage['prompt_tokens']}/{self.max_tokens}")
        self.label_completion.config(text=f"Completion Tokens: {response.usage['completion_tokens']}/{self.max_tokens}")
        self.label_total.config(text=f"Total Tokens: {self.used_tokens}/{self.max_tokens}")
        
        assistant_reply = response['choices'][0]['message']['content']
        
        print("Estimated Used Dollars:", estimated_cost)
        

if __name__ == "__main__":
    root = tk.Tk()
    app = TokenUsageApp(root)
    root.mainloop()

