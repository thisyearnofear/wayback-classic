/*
 * Script to extend the HTML4 elements in the HTML to
 * use HTML5 element types and attributes when possible
 *
 * Wayback Classic
 * Copyright (C) 2024 Jessica Stokes
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

if (document.querySelectorAll && window.addEventListener) {
  window.addEventListener('load', function() {
    var input = document.createElement("input");
    input.setAttribute("type", "url");

    if (input.type === "text") {
      return;
    }

    var inputs = document.querySelectorAll('input[type=text][name=q],input[type=text][name=filter]');

    for (var i = inputs.length - 1; i >= 0; i--) {
      inputs[i].setAttribute("spellcheck", "false");
      inputs[i].setAttribute("autocorrect", "off");

      if (inputs[i].name == "q") {
        inputs[i].setAttribute("required", "true");
      }
    }
  });
}
