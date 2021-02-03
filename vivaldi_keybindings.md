## Vivaldi + Vimium Keybindings
#### There is no way to export Vivaldi keybindings at this time so saving them here manually.

###### These Vivaldi bindings are designed to work with Vimium. I removed every binding I can natively do in Vivaldi, as they are faster and more consistent (they work on tabs which disable Vimium functions such as an empty tab or Vivaldi settings tabs). These bindings also take into consideration my awesomeWM bindings and mirror them while using a different modifier key.

---
##### Vivaldi Keymap
**You might have to remove some default Vivaldi keybindings that interfere with Vimiums**

```
Quick commands 			 Alt+d
Task Manager 			 Shift+Esc
Settings 				 Alt+Space
Notes 					 Shift+n (N)
Bookmarks 				 Ctrl+b
Break Mode 				 Ctrol+.
Developer Tools 		 Ctrl+i
Element Inspector 		 Shift+i (I)
Developer Tools Console  Ctrl+Shift+i
Status Bar 				 Ctrl+Shift+s
Next Theme 				 Ctrl+t
Address Bar 			 ;
Toggle UI 				 z
UI Zoom in / out 		 Alt +/-
Panel 					 '
Open Next Panel 		 Ctrl+'
Open Previous Panel 	 "
Download Panel 			 Ctrl+d
Notes Panel 			 Ctrl+n
History Panel 			 Ctrl+Shift+h
New Tab 				 t
Pin/Unpin Tab 			 @ (Shift+2)
Close Tab 				 Ctrl+w & x (when cursor is in a text field, single keys do not work, use Ctrl+w)
Previous Tab 			 Ctrl+h
Next Tab 				 Ctrl+l
Move Active Tab backward Shift+, (<)
Move Active Tab forward  Shift+. (>)
Select Previous Tab 	 Ctrl+Shift+,
Select Next Tab 		 Ctrl+Shift+.
Switch to Tab 			 Ctrl+1-8
Switch to Last Tab 		 Ctrl+9
Reopen Closed Tab 		 Ctrl+z & Shift+x
Tile Vertically 		 Alt+2
Tile Horizontally 		 Alt+3
Tile to Grid 			 Alt+4
Untile Tabs 			 Alt+1
Create Tab Stack 		 Alt+t
Ungroup Tab Stack 		 Ctrl+Alt+t
Toggle Reader Mode 		 q
Create Bookmark 		 Alt+b
Focus Address Field 	 Alt+s
Reload Page 			 r & Alt+r
Force Page Reload 		 Ctrl+r
Focus Page 				 Esc
Find in Page 			 . & Ctrl+f
History Back 			 Alt+left-arrow & Alt+h
History Forward 		 Alt+right-arrow & Alt+l
Search with Selection 	 Shift+s (S)
Spacial Navigation 		 WASD
```

---
##### Vimium Custom Key Mappings

###### Insert your preferred key
```
unmap H
unmap L
unmap r
unmap x
unmap X
unmap gt
unmap gT
unmap t
unmap <c-e>
unmap <c-y>
unmap <<
unmap >>
unmap zH
unmap zL
map ge scrollToBottom
map H scrollToLeft
map L scrollToRight
```
---

##### Vimium CSS
```
div > .vimiumHintMarker {
/* linkhint boxes */
background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,indigo),
color-stop(100%,Plum));
border: 1px solid #E3BE23;
}

div > .vimiumHintMarker span {
/* linkhint text */
color: gold;
font-weight: thin;
font-size: 11px;
/* Replace with a font you have installed */
font-face: Fira Code;
}

div > .vimiumHintMarker > .matchingCharacter {
}
```
---
