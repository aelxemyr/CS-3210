/* Dietary Database */

/* Facts (Based on USDA food groups) */

% Fruits

fruit(apples).
fruit(apricots).
fruit(bananas).
fruit(cherries).
fruit(grapefruit).
fruit(grapes).
fruit(kiwi_fruit).
fruit(mangoes).
fruit(oranges).
fruit(papaya).
fruit(peaches).
fruit(pears).
fruit(pineapple).
fruit(plums).
fruit(raisins).

berry(blackberries).
berry(blueberries).
berry(raspberries).
berry(strawberries).

melon(cantaloupe).
melon(honeydew).
melon(watermelon).

% Vegetables

vegetable(asparagus).
vegetable(avocado).
vegetable(beets).
vegetable(bell_pepper).
vegetable(cauliflower).
vegetable(celery).
vegetable(cucumber).
vegetable(eggplant).
vegetable(green_beans).
vegetable(iceberg_lettuce).
vegetable(mushrooms).
vegetable(radicchio).
vegetable(sugar_snap_peas).
vegetable(zucchini).

beans_and_peas(black_beans).
beans_and_peas(black_eyed_peas).
beans_and_peas(chickpeas).
beans_and_peas(lentils).
beans_and_peas(red_beans).
beans_and_peas(soy_beans).
beans_and_peas(split_peas).
beans_and_peas(white_beans).

dark_green_vegetable(bok_choy).
dark_green_vegetable(broccoli).
dark_green_vegetable(collard_greens).
dark_green_vegetable(dark_green_leaf_lettuce).
dark_green_vegetable(kale).
dark_green_vegetable(romaine_lettuce).
dark_green_vegetable(spinach).

red_and_orange_vegetable(butternut_squash).
red_and_orange_vegetable(carrots).
red_and_orange_vegetable(pumpkin).
red_and_orange_vegetable(sweet_potatoes).
red_and_orange_vegetable(tomatoes).

starchy_vegetable(corn).
starchy_vegetable(green_peas).
starchy_vegetable(plantains).
starchy_vegetable(potatoes).
starchy_vegetable(taro).

% Grains

grain(bread).
grain(crackers).
grain(pasta).

whole_grain(amaranth).
whole_grain(brown_rice).
whole_grain(buckwheat).
whole_grain(bulgar).
whole_grain(millet).
whole_grain(muesli).
whole_grain(oatmeal).
whole_grain(popcorn).
whole_grain(quinoa).
whole_grain(rolled_oats).
whole_grain(whole_grain_barley).
whole_grain(whole_rye).
whole_grain(wild_rice).

refined_grain(cornbread).
refined_grain(corn_tortilla).
refined_grain(couscous).
refined_grain(flour_tortilla).
refined_grain(grits).
refined_grain(noodles).
refined_grain(pretzels).
refined_grain(white_rice).

% Dairy

dairy(milk).
dairy(soymilk).
dairy(yogurt).

cheese(cheddar).
cheese(mozzarella).
cheese(american).
cheese(cottage_cheese).

milk_based_dessert(pudding).
milk_based_dessert(ice_cream).
milk_based_dessert(frozen_yogurt).
milk_based_dessert(ice_milks).

% Protein Foods

protein(eggs).

seafood(anchovies).
seafood(catfish).
seafood(clams).
seafood(cod).
seafood(crab).
seafood(crawfish).
seafood(flounder).
seafood(lobster).
seafood(oysters).
seafood(salmon).
seafood(sardines).
seafood(shrimp).
seafood(squid).
seafood(tilapia).
seafood(tuna).

nuts_and_seeds(almonds).
nuts_and_seeds(peanuts).
nuts_and_seeds(pumpkin_seeds).
nuts_and_seeds(sunflower_seeds).
nuts_and_seeds(walnuts).

processed_soy_product(tofu).
processed_soy_product(tempeh).
processed_soy_product(texturized_vegetable_protein).
processed_soy_product(veggie_burger).

poultry(chicken).
poultry(duck).
poultry(turkey).

meat(beef).
meat(ham).
meat(lamb).
meat(pork).
meat(veal).

/* Rules */

fruit(X) :- berry(X).
fruit(X) :- melon(X).

vegetable(X) :- beans_and_peas(X).
vegetable(X) :- dark_green_vegetable(X).
vegetable(X) :- red_and_orange_vegetable(X).
vegetable(X) :- starchy_vegetable(X).

grain(X) :- whole_grain(X).
grain(X) :- refined_grain(X).

dairy(X) :- cheese(X).
dairy(X) :- milk_based_dessert(X).

protein(X) :- beans_and_peas(X).
protein(X) :- seafood(X).
protein(X) :- nuts_and_seeds(X).
protein(X) :- processed_soy_product(X).
protein(X) :- poultry(X).
protein(X) :- meat(X).

meal(Fruit, Vegetable, Grain, Dairy, Protein) :-
	fruit(Fruit),
	vegetable(Vegetable),
	grain(Grain),
	dairy(Dairy),
	protein(Protein).














