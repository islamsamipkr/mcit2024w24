variable "restaurants" {
  description = "A map of restaurant names and their types in Montreal"
  type        = map(string)
  default = {
    "Joe Beef"        = "Steakhouse"
    "Schwartz's"      = "Deli"
    "La Banquise"     = "Poutine"
    "Bouillon Bilk"   = "French Cuisine"
  }
}
output "restaurant_upper" {
  description = "Convert restaurant name to uppercase"
  value       = upper("Joe Beef")
}
output "restaurant_lower" {
  description = "Convert restaurant name to lowercase"
  value       = lower("Schwartz's")
}
output "restaurant_replace" {
  description = "Replace 'Beef' with 'Steak'"
  value       = replace("Joe Beef", "Beef", "Steak")
}
output "restaurant_substring" {
  description = "Extract first 4 letters from Bouillon Bilk"
  value       = substr("Bouillon Bilk", 0, 4)
}
output "restaurant_join" {
  description = "Join restaurant names with commas"
  value       = join(", ", ["Joe Beef", "Schwartz's", "La Banquise", "Bouillon Bilk"])
}
output "formatted_restaurant" {
  description = "Format restaurant name by replacing, uppercasing, and extracting substring"
  value       = substr(upper(replace("La Banquise", "La ", "")), 0, 5)
}
