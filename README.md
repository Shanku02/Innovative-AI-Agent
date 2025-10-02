# Anticipatory Household AI Model

# Overview
Welcome to the Anticipatory Household AI project! This project aims to develop an efficient household AI system that anticipates and optimizes daily tasks using advanced AI techniques. The system combines Large Language models(GPT),logic-based reasoning(PDDL), and planner(LPG-TD)to enhance household automation.

# Features
- Anticipatory Module: Powered by GPT-3.5-turbo, this module anticipates upcoming high-level tasks based on user input of partial task sequences. The model has been fine-tuned for this task.
- PDDL Integration: In parallel, subtasks of the high-level tasks are encoded in the PDDL. The system translates task anticipation into Planning Domain Definition Language (PDDL) for efficient task planning.
- Task Planning: Utilizes the LPG-TD planner to create optimized task plans.
- User-Friendly Interface: Includes a graphical user interface (GUI) for task input and visualization of token usage.

# Installation and Running

To set up the Anticipatory Household AI project, follow these steps:

1. Clone the repository to your local machine:
   https://github.com/Shanku02/Innovative-AI-Agent.git

2. Guide for running the project:
    Prerequisites Install the below libraries and tools
        - Visual studio
            • Python Extension
            • PDDL Extension
        - LPG-TD https://lpg.unibs.it/lpg/
3. Running the Code
    i. Anticipatory Module:
        • PDDL Extension
        • Run the anticipatory module file
        • Input the sequence of tasks
        • PDDL problem file is generated
    ii. PDDL Problem File:
        • Go to the generated PDDL Problem file
        • Run the planner
        • Specify the planner and then run the file
        • Planner output and report is generated
