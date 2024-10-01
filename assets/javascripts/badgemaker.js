import { api } from "discourse/lib/api";
import { addObserver } from "discourse-common/lib/object-observer";

export default {
  initialize() {
    api.on('badge:earned', (badge) => {
      // Play sound or display notification
      console.log(`Badge earned: ${badge.name}`);
      
      // Example logic to play sound
      const audio = new Audio('/path/to/ding.mp3');
      audio.play();

      // Optionally, show a notification to the user
      if (badge.name) {
        alert(`Congratulations! You have earned the ${badge.name} badge!`);
      }
    });
  }
};
