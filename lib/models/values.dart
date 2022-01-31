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

String getRandomRestaurantId() {
  List<String> restaurantIdList = [
    'zCXcYUHffLULlZeEPSWH',
    'uqDhLgMYmZG2TlXCDojG',
    '0IORKY7CsnyeD0DalNfR',
    'ynAnhDhCi359JcokBBnP',
    'xarfKPENQdoWLqgcYnaO',
    'JADW2cRRnC3wsUelI1cC',
    'z8IKBc14Pq6ZAJ14Vken',
    'y7z8qA5J4GHnmtU8dGr8',
    'wuGu3JoQxUS3N02065nf',
    'wBQGSii2AHQVJsB2QVBA',
    'vcdt9eXEgdMOgQTHf8wO',
    'teszHD87PeVFWVGeC8Rv',
    'tdEa5siDGdpMwXjCz7cx',
    't38dBRP70BmsHQc4Y2Li',
    'stt9EW8N0rd94Cmb078v',
    'sdvR8A0SdpbvMCroHmxd',
    'sP3F7gubXqhTMHQ7liHL',
    'rPFsiWoIdj3zpYgyxaVD',
  ];
  return restaurantIdList[Random().nextInt(17) + 1];
}

String getRandomFoodName() {
  List<String> foodList = [
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
  ];
  return foodList[Random().nextInt(17) + 1];
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
