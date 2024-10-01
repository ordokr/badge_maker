import { api } from "discourse/lib/api";

export default {
  initialize() {
    api.on('badge:earned', (badge) => {
      // Play sound or display notification
      console.log(`Badge earned: ${badge.name}`);
      
      // Logic to play sound from the correct path
      const audio = new Audio('/sounds/ding.mp3');
      audio.play();

      // Optionally, show a notification to the user
      if (badge.name) {
        alert(`Congratulations! You have earned the ${badge.name} badge!`);
      }
    });
  }
};
