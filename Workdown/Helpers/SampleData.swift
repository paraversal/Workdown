//
//  SampleData.swift
//  Workdown
//
//  Created by paraversal on 26.06.24.
//

import Foundation

var MYWORKOUTS = [
	Workout(
		name: "Upper Body Strength 1",
		historicalRepetitions: 0,
		exercises: [
			Exercise(name: "Standard Push-ups", description: "Place hands shoulder-width apart, lower chest to floor, and push back up.", reps: "8-10 repetitions", rest: 60, sets: 3),
			Exercise(name: "Chair Dips", description: "Sit on edge of a chair, place hands next to hips, lower body by bending elbows, push back up.", reps: "8-10 repetitions", rest: 60, sets: 3),
			Exercise(name: "Plank", description: "Hold body in straight line on forearms and toes, keep core tight.", reps: "30s", rest: 30, sets: 3, exerciseTimer: 30),
			Exercise(name: "Arm Circles", description: "Extend arms to sides, make small circles, gradually increase size.", reps: 15, rest: 30, sets: 3),
			Exercise(name: "Superman", description: "Lie face down, lift arms, chest, and legs off ground, hold briefly, lower back down.", reps: 10, rest: 30, sets: 3)
		]
	),
	Workout(
		name: "Upper Body Strength 2",
		historicalRepetitions: 0,
		exercises: [
			Exercise(name: "Incline Push-ups", description: "Place hands on elevated surface, lower chest to surface, push back up.", reps: "8-10", rest: 60, sets: 3),
			Exercise(name: "Tricep Dips (Floor)", description: "Sit on floor, hands behind hips, lift hips off ground, lower body by bending elbows, push back up.", reps: "8-10 repetitions", rest: 60, sets: 3),
			Exercise(name: "Side Plank", description: "Balance on one forearm and side of one foot, hold body in straight line.", reps: "20s", rest: 30, sets: 3, exerciseTimer: 20),
			Exercise(name: "Pike Push-ups", description: "Start in downward dog position, lower head to floor by bending elbows, push back up.", reps: "5-8 repetitions", rest: 60, sets: 3),
			Exercise(name: "Lying Down Snow Angels", description: "Lie face down, lift arms and legs off ground, move arms out to sides and back like making snow angels.", reps: 10, rest: 30, sets: 3)
		]
	),
	Workout(
		name: "Upper Body Strength 3",
		historicalRepetitions: 0,
		exercises: [
			Exercise(name: "Close-grip Push-ups", description: "Place hands close together under chest, lower chest to floor, push back up.", reps: "6-8 repetitions", rest: 60, sets: 3),
			Exercise(name: "Plank to Push-up", description: "Start in plank position, move to push-up position and back.", reps: "5-8 repetitions", rest: 60, sets: 3),
			Exercise(name: "Bear Crawls", description: "Start on all fours, lift knees off ground, move forward by simultaneously moving opposite hand and foot.", reps: 30, rest: 30, sets: 3),
			Exercise(name: "Diamond Push-ups", description: "Place hands close together under chest forming a diamond shape, lower chest to floor, push back up.", reps: "6-8 repetitions", rest: 60, sets: 3),
			Exercise(name: "Superman", description: "Lie face down, lift arms, chest, and legs off ground, hold briefly, lower back down.", reps: 10, rest: 30, sets: 3)
		]
	),
	Workout(
		name: "Warm-up Routine",
		historicalRepetitions: 0,
		exercises: [
			Exercise(name: "Arm Circles", description: "Stand with arms extended to the sides, make small circles forward for 30s, then backward for 30s.", reps: 1, rest: 0, sets: 1),
			Exercise(name: "Shoulder Rolls", description: "Roll shoulders forward in a circular motion for 30s, then backward for 30s.", reps: 1, rest: 0, sets: 1),
			Exercise(name: "Torso Twists", description: "Stand with feet shoulder-width apart, rotate torso to the left and right, swinging arms gently.", reps: 1, rest: 0, sets: 1),
			Exercise(name: "Jumping Jacks", description: "Jump to a position with legs spread and hands touching overhead, then back to starting position.", reps: 1, rest: 0, sets: 1),
			Exercise(name: "High Knees", description: "Jog in place, lifting knees high towards the chest, pumping arms in rhythm.", reps: 1, rest: 0, sets: 1),
			Exercise(name: "Arm Swings", description: "Swing arms forward and back, crossing them in front of the chest and then swinging them wide apart.", reps: 1, rest: 0, sets: 1),
			Exercise(name: "Neck Circles", description: "Gently rotate the head in a circular motion, 30s clockwise and 30s counterclockwise.", reps: "30s in both directions", rest: 0, sets: 1, exerciseTimer: 60),
			Exercise(name: "Cat-Cow Stretch", description: "On hands and knees, arch back up (cat) and then dip it down (cow), moving smoothly between the two.", reps: 1, rest: 0, sets: 1)
		]
	),
	
	Workout(
		name: "Bouldering Strength 1",
		historicalRepetitions: 0,
		exercises: [
			Exercise(name: "Pull-ups (Door Frame)", description: "Grip the top of a sturdy door frame and pull your body upwards until your chin is above the frame, then lower back down.", reps: "5-8", rest: 90, sets: 3),
			Exercise(name: "Push-ups", description: "Place hands shoulder-width apart, lower chest to floor, and push back up.", reps: "10-12", rest: 60, sets: 3),
			Exercise(name: "Chair Step-ups", description: "Step onto a sturdy chair with one foot, then bring the other foot up to stand on the chair. Step down and repeat.", reps: "10 each leg", rest: 60, sets: 3),
			Exercise(name: "Plank", description: "Hold body in straight line on forearms and toes, keep core tight.", reps: "30-45s hold", rest: 30, sets: 3, exerciseTimer: 45),
			Exercise(name: "Chair Dips", description: "Sit on edge of a chair, place hands next to hips, lower body by bending elbows, push back up.", reps: "8-10 repetitions", rest: 60, sets: 3)
		]
	),
	Workout(
		name: "Bouldering Strength 2",
		historicalRepetitions: 0,
		exercises: [
			Exercise(name: "Pike Push-ups", description: "Start in downward dog position, lower head to floor by bending elbows, push back up.", reps: "6-8 repetitions", rest: 60, sets: 3),
			Exercise(name: "Hollow Body Hold", description: "Lie on your back, lift legs and arms off the floor, keeping lower back pressed to the floor. Hold position.", reps: "20-30s hold", rest: 30, sets: 3, exerciseTimer: 30),
			Exercise(name: "Squats", description: "Stand with feet shoulder-width apart, lower body by bending knees and hips, then stand back up.", reps: "12-15 repetitions", rest: 60, sets: 3),
			Exercise(name: "Single-Leg Romanian Deadlifts", description: "Stand on one leg, bend at the hips, and reach opposite hand towards the floor, then return to standing.", reps: "10 each leg,", rest: 60, sets: 3),
			Exercise(name: "Wall Sit", description: "Stand with back against a wall, slide down until knees are at a 90-degree angle, hold the position.", reps: "30-45s hold", rest: 30, sets: 3, exerciseTimer: 45)
		]
	),
	Workout(
		name: "Bouldering Strength 3",
		historicalRepetitions: 0,
		exercises: [
			Exercise(name: "Diamond Push-ups", description: "Place hands close together under chest forming a diamond shape, lower chest to floor, push back up.", reps: "6-8", rest: 60, sets: 3),
			Exercise(name: "Mountain Climbers", description: "Start in a plank position, drive one knee towards chest, switch legs quickly.", reps: "20 each leg", rest: 30, sets: 3),
			Exercise(name: "Chair Bulgarian Split Squats", description: "Place one foot behind on a chair, lower into a lunge position with front leg, then stand back up.", reps: "10 each leg", rest: 60, sets: 3),
			Exercise(name: "Superman", description: "Lie face down, lift arms, chest, and legs off ground, hold briefly, lower back down.", reps: 10, rest: 30, sets: 3),
			Exercise(name: "Side Plank", description: "Balance on one forearm and side of one foot, hold body in straight line.", reps: "20-30s hold each side", rest: 30, sets: 3, exerciseTimer: 60)
		]
	)
];


var SAMPLEWORKOUT_LIST = [
			Workout(
				name: "Upper Body Strength",
				historicalRepetitions: 100,
				exercises: [
					Exercise(name: "Bench Press", description: "Press the barbell upwards", reps: 10, rest: 60, sets: 3),
					Exercise(name: "Pull Ups", description: "Pull your body upwards", reps: 8, rest: 90, sets: 3),
					Exercise(name: "Shoulder Press", description: "Press the weights upwards", reps: 12, rest: 60, sets: 4)
				]
			),
			Workout(
				name: "Leg Day",
				historicalRepetitions: 120,
				exercises: [
					Exercise(name: "Squats", description: "Squat down and stand back up", reps: 15, rest: 90, sets: 4),
					Exercise(name: "Lunges", description: "Step forward into a lunge", reps: 12, rest: 60, sets: 3),
					Exercise(name: "Leg Press", description: "Press the weight upwards with your legs", reps: 10, rest: 60, sets: 3)
				]
			),
			Workout(
				name: "Cardio Blast",
				historicalRepetitions: 200,
				exercises: [
					Exercise(name: "Running", description: "Run at a moderate pace", reps: 1, rest: 0, sets: 1),
					Exercise(name: "Jump Rope", description: "Jump over the rope", reps: 100, rest: 30, sets: 3),
					Exercise(name: "Burpees", description: "Full body exercise", reps: 15, rest: 45, sets: 4)
				]
			)
		]

var SAMPLEWORKOUT = Workout(
	name: "Upper Body Strength",
			 historicalRepetitions: 100,
			 exercises: [
				 Exercise(name: "Bench Press", description: "Press the barbell upwards", reps: 10, rest: 5, sets: 3),
				 Exercise(name: "Pull Ups", description: "Pull your body upwards", reps: 8, rest: 90, sets: 3),
				 Exercise(name: "Shoulder Press", description: "Press the weights upwards", reps: 12, rest: 60, sets: 4)
			 ]
		 )

var SAMPLEEXERCISE = Exercise(name: "Standard Push-ups", description: "Place hands shoulder-width apart, lower chest to floor, and push back up.", reps: 8, rest: 60, sets: 3)
