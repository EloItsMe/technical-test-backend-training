================ English ====================
# Backend test

We are building a listing rentals management company

Create a new rails app.


4 main objects populate our app:
- `listings`: apartments of our clients
- `bookings`: periods of time during which our clients leave us their apartment
- `reservations`: periods of time during which a guest rents one of our apartments
- `mission`: cleaning an apartment

`bookings`, `reservations` and `missions` all BELONG to `listing` (they all have a `listing_id`) but are not otherwise directly related to one another.

Here is our plan to clean the apartment, at any time:
- We should have a cleaning mission called `first_checkin` at the beginning of the booking
- We should have  a cleaning mission called `last_checkout` before the owner comes back
- We should have  a cleaning mission called `checkout_checkin` at the end of each reservation UNLESS there is alrea  dy a last_checkout at the same date

Reservation and Bookings could be cancelled, in this case we should not do missions related.

We negotiated the prices with our cleaning partner:
- a first checkin costs 10€ per room
- a checkout checkin costs 10€ per room
- a last checkout costs 5€ per room

Here is the content you have to copy on your file `seed.rb` located in `./db/seeds.rb`
```
Booking.delete_all
Reservation.delete_all
Mission.delete_all
Listing.delete_all

Listing.create!(num_rooms: 2)
Listing.create!(num_rooms: 1)
Listing.create!(num_rooms: 3)

Booking.create!(listing_id: Listing.first.id, start_date: "2016-10-10".to_date, end_date: "2016-10-15".to_date)
Booking.create!(listing_id: Listing.first.id, start_date: "2016-10-16".to_date, end_date: "2016-10-20".to_date)
Booking.create!(listing_id: Listing.second.id, start_date: "2016-10-15".to_date, end_date: "2016-10-20".to_date)

Reservation.create!(listing_id: Listing.first.id, start_date: "2016-10-11".to_date, end_date: "2016-10-13".to_date)
Reservation.create!(listing_id: Listing.first.id, start_date: "2016-10-13".to_date, end_date: "2016-10-15".to_date)
Reservation.create!(listing_id: Listing.first.id, start_date: "2016-10-16".to_date, end_date: "2016-10-20".to_date)
Reservation.create!(listing_id: Listing.second.id, start_date: "2016-10-15".to_date, end_date: "2016-10-18".to_date)
```

## Goal

You need to create a Rails Application using Active records which has:
 - JSON API:
   - CRUD (INDEX/ SH0W/ CREATE/ UPDATE / DELETE ) on `listing`
   - Index endpoint to retrieve missions created

Note: no authentication is required

The output of the index endpoint to retrieve missions created should resemble this after launching the seed
```
{
  "missions": [
    {:listing_id=>1, :mission_type=>"first_checkin", :date=>"2016-10-10", :price=>20},
    {:listing_id=>1, :mission_type=>"last_checkout", :date=>"2016-10-15", :price=>10},
    {:listing_id=>1, :mission_type=>"first_checkin", :date=>"2016-10-16", :price=>20},
    {:listing_id=>1, :mission_type=>"last_checkout", :date=>"2016-10-20", :price=>10},
    {:listing_id=>1, :mission_type=>"checkout_checkin", :date=>"2016-10-13", :price=>20},
    {:listing_id=>2, :mission_type=>"first_checkin", :date=>"2016-10-15", :price=>10},
    {:listing_id=>2, :mission_type=>"last_checkout", :date=>"2016-10-20", :price=>5},
    {:listing_id=>2, :mission_type=>"checkout_checkin", :date=>"2016-10-18", :price=>10}
  ]
}
```
Go slowly, and write code that could be easily extensible and clean.


Tips to get you started :

1. Generate an API only rails app :
  `$ rails new my_api --api`

2. Copy the lines from the readme into seeds.rb

3. Map out the relationships between your models

4. Add the models

5. Add only the necessary CRUD actions for listing and mission

6. Add the logic for creating missions

================== Francais ==========================

Test de backend

Nous construisons une société de gestion de locations immobilières.

Créez une nouvelle application Rails.

Quatre principaux objets peuplent notre application :

listings : les appartements de nos clients
bookings : les périodes pendant lesquelles nos clients nous laissent leur appartement
reservations : les périodes pendant lesquelles un invité loue l'un de nos appartements
mission : le nettoyage d'un appartement
Les bookings, les reservations et les missions appartiennent tous au listing (ils ont tous un listing_id), mais ils ne sont pas directement liés les uns aux autres.

Voici notre plan de nettoyage de l'appartement, à tout moment :

Nous devons avoir une mission de nettoyage appelée first_checkin au début de la réservation.
Nous devons avoir une mission de nettoyage appelée last_checkout avant que le propriétaire ne revienne.
Nous devons avoir une mission de nettoyage appelée checkout_checkin à la fin de chaque réservation, SAUF s'il y a déjà un last_checkout à la même date.
Les réservations et les bookings peuvent être annulés, dans ce cas, nous ne devons pas effectuer les missions associées.

Nous avons négocié les prix avec notre partenaire de nettoyage :

Un first_checkin coûte 10€ par chambre.
Un checkout_checkin coûte 10€ par chambre.
Un last_checkout coûte 5€ par chambre.
Voici le contenu que vous devez copier dans votre fichier seed.rb situé dans ./db/seeds.rb :

```
Booking.delete_all
Reservation.delete_all
Mission.delete_all
Listing.delete_all

Listing.create!(num_rooms: 2)
Listing.create!(num_rooms: 1)
Listing.create!(num_rooms: 3)

Booking.create!(listing_id: Listing.first.id, start_date: "2016-10-10".to_date, end_date: "2016-10-15".to_date)
Booking.create!(listing_id: Listing.first.id, start_date: "2016-10-16".to_date, end_date: "2016-10-20".to_date)
Booking.create!(listing_id: Listing.second.id, start_date: "2016-10-15".to_date, end_date: "2016-10-20".to_date)

Reservation.create!(listing_id: Listing.first.id, start_date: "2016-10-11".to_date, end_date: "2016-10-13".to_date)
Reservation.create!(listing_id: Listing.first.id, start_date: "2016-10-13".to_date, end_date: "2016-10-15".to_date)
Reservation.create!(listing_id: Listing.first.id, start_date: "2016-10-16".to_date, end_date: "2016-10-20".to_date)
Reservation.create!(listing_id: Listing.second.id, start_date: "2016-10-15".to_date, end_date: "2016-10-18".to_date)
````

## Objectif

Vous devez créer une application Rails utilisant ActiveRecord qui comprend :

Une API JSON :
CRUD (INDEX/SHOW/CREATE/UPDATE/DELETE) pour listing
Un point de terminaison (endpoint) pour récupérer les missions créées (Index)
NB : aucune authentification n'est requise.

La sortie du point de terminaison Index pour récupérer les missions créées devrait ressembler à ceci après avoir lancé le seed :

```
{
  "missions": [
    {:listing_id=>1, :mission_type=>"first_checkin", :date=>"2016-10-10", :price=>20},
    {:listing_id=>1, :mission_type=>"last_checkout", :date=>"2016-10-15", :price=>10},
    {:listing_id=>1, :mission_type=>"first_checkin", :date=>"2016-10-16", :price=>20},
    {:listing_id=>1, :mission_type=>"last_checkout", :date=>"2016-10-20", :price=>10},
    {:listing_id=>1, :mission_type=>"checkout_checkin", :date=>"2016-10-13", :price=>20},
    {:listing_id=>2, :mission_type=>"first_checkin", :date=>"2016-10-15", :price=>10},
    {:listing_id=>2, :mission_type=>"last_checkout", :date=>"2016-10-20", :price=>5},
    {:listing_id=>2, :mission_type=>"checkout_checkin", :date=>"2016-10-18", :price=>10}
  ]
}
```

Avancez lentement et écrivez un code qui soit facilement extensible et propre.

Générez une application Rails API uniquement :
$ rails new my_api --api

Copiez les lignes du fichier readme dans seeds.rb

Définissez les relations entre vos modèles

Ajoutez les modèles

Ajoutez uniquement les actions CRUD nécessaires pour les listings et les missions

Ajoutez la logique pour la création des missions
