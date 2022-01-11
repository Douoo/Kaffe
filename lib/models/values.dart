import 'dart:math';

final cities = [
  'Addis Ababa',
  'Gondar',
  'Adama',
  'Awassa',
  'Bahir Dar',
  'Dire Dawa',
  'Sodo',
  'Dessie',
  'Jimma',
  'Jijiga',
  'Shashamane',
  'Bishoftu',
  'Bishoftu',
  'Arba Minch',
  'Hosaena',
  'Harar',
  'Dilla',
  'Nekemte',
  'Debre Birhan',
  'Debre Mark',
  'Kombolcha',
  'Debre Tabor',
  'Weldiya',
  'Bonga',
];

final categories = [
  'Brunch',
  'Burgers',
  'Coffee',
  'Cultural',
  'Indian',
  'Italian',
  'Pizza',
  'Fish',
];

final _words = [
  'WOW Burgers',
  'Rome1960',
  'Kaldis coffee',
  'Diner',
  'Fire',
  'Grill',
  'Place',
  'Lewi',
  'Spot',
  'Trattoria',
  'Steakhouse',
  'Churrasco',
  'Tavern',
  'Cafe',
  'Pop-up',
  'Yummy',
  'Belly',
  'Snack',
  'Fast',
  'Turbo',
  'Hyper',
  'Prime',
  'Eatin\'',
];

final _reviewTextPerRating = {
  1: [
    'Would never eat here again!',
    'Such an awful place!',
    'Not sure if they had a bad day off, but the food was very bad.'
  ],
  2: [
    'Not my cup of tea.',
    'Unlikely that we will ever come again.',
    'Quite bad, but I\'ve had worse!'
  ],
  3: ['Exactly okay :/', 'Unimpressed, but not disappointed!', 'Aynefam.'],
  4: [
    'Actually pretty good, would recommend!',
    'I really like this place, I come quite often!',
    'A great experience, as usual!'
  ],
  5: [
    'Ktebkut belay arif nw'
        'This is my favorite place. Literally',
    'This place is ALWAYS great!',
    'I recommend this to all my friends and family!'
  ],
};

final random = Random();

String getRandomReviewText(int rating) {
  final reviews = _reviewTextPerRating[rating];
  return reviews[random.nextInt(reviews.length)];
}

String getRandomName() {
  final firstWord = random.nextInt(_words.length);
  var nextWord;
  do {
    nextWord = random.nextInt(_words.length);
  } while (firstWord == nextWord);
  return '${_words[firstWord]} ${_words[nextWord]}';
}

String getRandomCategory() {
  return categories[random.nextInt(categories.length)];
}

String getRandomCity() {
  return cities[random.nextInt(cities.length)];
}

String getRandomPhoto() {
  final photoId = random.nextInt(21) + 1;
  return 'https://storage.googleapis.com/firestorequickstarts.appspot.com/food_$photoId.png';
}
