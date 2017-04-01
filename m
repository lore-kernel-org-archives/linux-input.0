From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 05/33] docs: input/atarikbd: convert it to ReST format
Date: Sat,  1 Apr 2017 15:15:48 -0300
Message-ID: <564bab77d213c4995418de5debc9149f01b44c67.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
 <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
 <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
 <40f1698c0fe55c303f70eac042540c1ce3b76385.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <40f1698c0fe55c303f70eac042540c1ce3b76385.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

This file require minimum adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx.

We opted to remove section numbers, as this can be automatically
generated on Sphinx, by using :numbered: tag at index.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/atarikbd.txt | 214 +++++++++++++++++++++++++++++----------
 1 file changed, 161 insertions(+), 53 deletions(-)

diff --git a/Documentation/input/atarikbd.txt b/Documentation/input/atarikbd.txt
index f3a3ba8847ba..032c065a031a 100644
--- a/Documentation/input/atarikbd.txt
+++ b/Documentation/input/atarikbd.txt
@@ -1,7 +1,10 @@
+====================================
 Intelligent Keyboard (ikbd) Protocol
+====================================
 
 
-1. Introduction
+Introduction
+============
 
 The Atari Corp. Intelligent Keyboard (ikbd) is a general purpose keyboard
 controller that is flexible enough that it can be used in a variety of
@@ -18,7 +21,8 @@ different applications of the keyboard,  joysticks, or mouse. Limited use of
 the controller is possible in applications in which only a unidirectional
 communications medium is available by carefully designing the default modes.
 
-3. Keyboard
+Keyboard
+========
 
 The keyboard always returns key make/break scan codes. The ikbd generates
 keyboard scan codes for each key press and release. The key scan make (key
@@ -28,19 +32,23 @@ exists in that position on a particular keyboard. The break code for each key
 is obtained by ORing 0x80 with the make code.
 
 The special codes 0xF6 through 0xFF are reserved for use as follows:
+
+=================== ====================================================
     0xF6            status report
     0xF7            absolute mouse position record
     0xF8-0xFB       relative mouse position records (lsbs determined by
-                     mouse button states)
+                    mouse button states)
     0xFC            time-of-day
     0xFD            joystick report (both sticks)
     0xFE            joystick 0 event
     0xFF            joystick 1 event
+=================== ====================================================
 
 The two shift keys return different scan codes in this mode. The ENTER key
 and the RETurn key are also distinct.
 
-4. Mouse
+Mouse
+=====
 
 The mouse port should be capable of supporting a mouse with resolution of
 approximately 200 counts (phase changes or 'clicks') per inch of travel. The
@@ -53,7 +61,8 @@ key equivalents.
 The mouse buttons can be treated as part of the mouse or as additional
 keyboard keys.
 
-4.1 Relative Position Reporting
+Relative Position Reporting
+---------------------------
 
 In relative position mode, the ikbd will return relative mouse position
 records whenever a mouse event occurs. A mouse event consists of a mouse
@@ -67,7 +76,8 @@ been 'paused' ( the event will be stored until keyboard communications is
 resumed) (b) while any event is being transmitted.
 
 The relative mouse position record is a three byte record of the form
-(regardless of keyboard mode):
+(regardless of keyboard mode)::
+
     %111110xy           ; mouse position record flag
                         ; where y is the right button state
                         ; and x is the left button state
@@ -81,13 +91,15 @@ If the accumulated motion before the report packet is generated exceeds the
 Note that the sign of the delta y reported is a function of the Y origin
 selected.
 
-4.2 Absolute Position reporting
+Absolute Position reporting
+---------------------------
 
 The ikbd can also maintain absolute mouse position. Commands exist for
 resetting the mouse position, setting X/Y scaling, and interrogating the
 current mouse position.
 
-4.3 Mouse Cursor Key Mode
+Mouse Cursor Key Mode
+---------------------
 
 The ikbd can translate mouse motion into the equivalent cursor keystrokes.
 The number of mouse clicks per keystroke is independently programmable in
@@ -99,32 +111,38 @@ break code for the appropriate cursor key. The mouse buttons produce scan
 codes above those normally assigned for the largest envisioned keyboard (i.e.
 LEFT=0x74 & RIGHT=0x75).
 
-5. Joystick
+Joystick
+========
 
-5.1 Joystick Event Reporting
+Joystick Event Reporting
+------------------------
 
 In this mode, the ikbd generates a record whenever the joystick position is
 changed (i.e. for each opening or closing of a joystick switch or trigger).
 
-The joystick event record is two bytes of the form:
+The joystick event record is two bytes of the form::
+
     %1111111x           ; Joystick event marker
                         ; where x is Joystick 0 or 1
     %x000yyyy           ; where yyyy is the stick position
                         ; and x is the trigger
 
-5.2 Joystick Interrogation
+Joystick Interrogation
+----------------------
 
 The current state of the joystick ports may be interrogated at any time in
 this mode by sending an 'Interrogate Joystick' command to the ikbd.
 
-The ikbd response to joystick interrogation is a three byte report of the form
+The ikbd response to joystick interrogation is a three byte report of the form::
+
     0xFD                ; joystick report header
     %x000yyyy           ; Joystick 0
     %x000yyyy           ; Joystick 1
                         ; where x is the trigger
                         ; and yyy is the stick position
 
-5.3 Joystick Monitoring
+Joystick Monitoring
+-------------------
 
 A mode is available that devotes nearly all of the keyboard communications
 time to reporting the state of the joystick ports at a user specifiable rate.
@@ -132,7 +150,8 @@ It remains in this mode until reset or commanded into another mode. The PAUSE
 command in this mode not only stop the output but also temporarily stops
 scanning the joysticks (samples are not queued).
 
-5.4 Fire Button Monitoring
+Fire Button Monitoring
+----------------------
 
 A mode is provided to permit monitoring a single input bit at a high rate. In
 this mode the ikbd monitors the state of the Joystick 1 fire button at the
@@ -142,7 +161,8 @@ until reset or commanded into another mode. The PAUSE command in this mode not
 only stops the output but also temporarily stops scanning the button (samples
 are not queued).
 
-5.5 Joystick Key Code Mode
+Joystick Key Code Mode
+----------------------
 
 The ikbd may be commanded to translate the use of either joystick into the
 equivalent cursor control keystroke(s). The ikbd provides a single breakpoint
@@ -152,18 +172,21 @@ for the appropriate cursor motion keys. The trigger or fire buttons of the
 joysticks produce pseudo key scan codes above those used by the largest key
 matrix envisioned (i.e. JOYSTICK0=0x74, JOYSTICK1=0x75).
 
-6. Time-of-Day Clock
+Time-of-Day Clock
+=================
 
 The ikbd also maintains a time-of-day clock for the system. Commands are
 available to set and interrogate the timer-of-day clock. Time-keeping is
 maintained down to a resolution of one second.
 
-7. Status Inquiries
+Status Inquiries
+================
 
 The current state of ikbd modes and parameters may be found by sending status
 inquiry commands that correspond to the ikbd set commands.
 
-8. Power-Up Mode
+Power-Up Mode
+=============
 
 The keyboard controller will perform a simple self-test on power-up to detect
 major controller faults (ROM checksum and RAM test) and such things as stuck
@@ -183,13 +206,17 @@ both buttons are logically connected to it. If a mouse disable command is
 received while port 0 is presumed to be a mouse, the button is logically
 assigned to Joystick1 (until the mouse is reenabled by another mouse command).
 
-9. ikbd Command Set
+ikbd Command Set
+================
 
 This section contains a list of commands that can be sent to the ikbd. Command
 codes (such as 0x00) which are not specified should perform no operation
 (NOPs).
 
-9.1 RESET
+RESET
+-----
+
+::
 
     0x80
     0x01
@@ -208,7 +235,10 @@ ikbd will then scan the key matrix for any stuck (closed) keys. Any keys found
 closed will cause the break scan code to be generated (the break code arriving
 without being preceded by the make code is a flag for a key matrix error).
 
-9.2. SET MOUSE BUTTON ACTION
+SET MOUSE BUTTON ACTION
+-----------------------
+
+::
 
     0x07
     %00000mss           ; mouse button action
@@ -217,14 +247,17 @@ without being preceded by the make code is a flag for a key matrix error).
                         ;  position report
                         ;  where y=1, mouse key press causes absolute report
                         ;  and x=1, mouse key release causes absolute report
-                        ; mss=100, mouse buttons act like keys 
+                        ; mss=100, mouse buttons act like keys
 
 This command sets how the ikbd should treat the buttons on the mouse. The
 default mouse button action mode is %00000000, the buttons are treated as part
 of the mouse logically.
 When buttons act like keys, LEFT=0x74 & RIGHT=0x75.
 
-9.3 SET RELATIVE MOUSE POSITION REPORTING
+SET RELATIVE MOUSE POSITION REPORTING
+-------------------------------------
+
+::
 
     0x08
 
@@ -235,14 +268,17 @@ key mode, mouse position reports may also be generated when either mouse
 button is pressed or released. Otherwise the mouse buttons behave as if they
 were keyboard keys.
 
-9.4 SET ABSOLUTE MOUSE POSITIONING
+SET ABSOLUTE MOUSE POSITIONING
+------------------------------
+
+::
 
     0x09
     XMSB                ; X maximum (in scaled mouse clicks)
     XLSB
     YMSB                ; Y maximum (in scaled mouse clicks)
     YLSB
-	
+
 Set absolute mouse position maintenance. Resets the ikbd maintained X and Y
 coordinates.
 In this mode, the value of the internally maintained coordinates does NOT wrap
@@ -250,7 +286,10 @@ between 0 and large positive numbers. Excess motion below 0 is ignored. The
 command sets the maximum positive value that can be attained in the scaled
 coordinate system. Motion beyond that value is also ignored.
 
-9.5 SET MOUSE KEYCODE MOSE
+SET MOUSE KEYCODE MOSE
+----------------------
+
+::
 
     0x0A
     deltax              ; distance in X clicks to return (LEFT) or (RIGHT)
@@ -263,7 +302,10 @@ either axis. When the keyboard is in key scan code mode, mouse motion will
 cause the make code immediately followed by the break code. Note that this
 command is not affected by the mouse motion origin.
 
-9..6 SET MOUSE THRESHOLD
+SET MOUSE THRESHOLD
+-------------------
+
+::
 
     0x0B
     X                   ; x threshold in mouse ticks (positive integers)
@@ -274,7 +316,10 @@ it does NOT affect the resolution of the data returned to the host. This
 command is valid only in RELATIVE MOUSE POSITIONING mode. The thresholds
 default to 1 at RESET (or power-up).
 
-9.7 SET MOUSE SCALE
+SET MOUSE SCALE
+---------------
+
+::
 
     0x0C
     X                   ; horizontal mouse ticks per internal X
@@ -288,7 +333,10 @@ information is available only by interrogating the ikbd in the ABSOLUTE MOUSE
 POSITIONING mode unless the ikbd has been commanded to report on button press
 or release (see SET MOSE BUTTON ACTION).
 
-9.8 INTERROGATE MOUSE POSITION
+INTERROGATE MOUSE POSITION
+--------------------------
+
+::
 
     0x0D
     Returns:
@@ -306,7 +354,10 @@ or release (see SET MOSE BUTTON ACTION).
 The INTERROGATE MOUSE POSITION command is valid when in the ABSOLUTE MOUSE
 POSITIONING mode, regardless of the setting of the MOUSE BUTTON ACTION.
 
-9.9 LOAD MOUSE POSITION
+LOAD MOUSE POSITION
+-------------------
+
+::
 
     0x0E
     0x00                ; filler
@@ -318,7 +369,10 @@ POSITIONING mode, regardless of the setting of the MOUSE BUTTON ACTION.
 This command allows the user to preset the internally maintained absolute
 mouse position.
 
-9.10 SET Y=0 AT BOTTOM
+SET Y=0 AT BOTTOM
+-----------------
+
+::
 
     0x0F
 
@@ -327,7 +381,10 @@ logical coordinate system internal to the ikbd for all relative or absolute
 mouse motion. This causes mouse motion toward the user to be negative in sign
 and away from the user to be positive.
 
-9.11 SET Y=0 AT TOP
+SET Y=0 AT TOP
+--------------
+
+::
 
     0x10
 
@@ -336,7 +393,10 @@ system within the ikbd for all relative or absolute mouse motion. (DEFAULT)
 This causes mouse motion toward the user to be positive in sign and away from
 the user to be negative.
 
-9.12 RESUME
+RESUME
+------
+
+::
 
     0x11
 
@@ -345,7 +405,10 @@ its output has been paused also causes an implicit RESUME this command can be
 thought of as a NO OPERATION command. If this command is received by the ikbd
 and it is not PAUSED, it is simply ignored.
 
-9.13 DISABLE MOUSE
+DISABLE MOUSE
+-------------
+
+::
 
     0x12
 
@@ -356,7 +419,10 @@ ABSOLUTE MOUSE POSITIONING, and SET MOUSE KEYCODE MODE. )
 N.B. If the mouse buttons have been commanded to act like keyboard keys, this
 command DOES affect their actions.
 
-9.14 PAUSE OUTPUT
+PAUSE OUTPUT
+------------
+
+::
 
     0x13
 
@@ -381,21 +447,30 @@ When the ikbd is in either the JOYSTICK MONITORING mode or the FIRE BUTTON
 MONITORING mode, the PAUSE OUTPUT command also temporarily stops the
 monitoring process (i.e. the samples are not enqueued for transmission).
 
-0.15 SET JOYSTICK EVENT REPORTING
+SET JOYSTICK EVENT REPORTING
+----------------------------
+
+::
 
     0x14
 
 Enter JOYSTICK EVENT REPORTING mode (DEFAULT). Each opening or closure of a
 joystick switch or trigger causes a joystick event record to be generated.
 
-9.16 SET JOYSTICK INTERROGATION MODE
+SET JOYSTICK INTERROGATION MODE
+-------------------------------
+
+::
 
     0x15
 
 Disables JOYSTICK EVENT REPORTING. Host must send individual JOYSTICK
 INTERROGATE commands to sense joystick state.
 
-9.17 JOYSTICK INTERROGATE
+JOYSTICK INTERROGATE
+--------------------
+
+::
 
     0x16
 
@@ -403,7 +478,10 @@ Return a record indicating the current state of the joysticks. This command
 is valid in either the JOYSTICK EVENT REPORTING mode or the JOYSTICK
 INTERROGATION MODE.
 
-9.18 SET JOYSTICK MONITORING
+SET JOYSTICK MONITORING
+-----------------------
+
+::
 
     0x17
     rate                ; time between samples in hundredths of a second
@@ -419,7 +497,10 @@ between joystick samples.
 N.B. The user should not set the rate higher than the serial communications
 channel will allow the 2 bytes packets to be transmitted.
 
-9.19 SET FIRE BUTTON MONITORING
+SET FIRE BUTTON MONITORING
+--------------------------
+
+::
 
     0x18
     Returns: (as long as in mode)
@@ -432,7 +513,10 @@ is scanned at a rate that causes 8 samples to be made in the time it takes for
 the previous byte to be sent to the host (i.e. scan rate = 8/10 * baud rate).
 The sample interval should be as constant as possible.
 
-9.20 SET JOYSTICK KEYCODE MODE
+SET JOYSTICK KEYCODE MODE
+-------------------------
+
+::
 
     0x19
     RX                  ; length of time (in tenths of seconds) until
@@ -462,7 +546,10 @@ Note that by setting RX and/or Ry to zero, the velocity feature can be
 disabled. The values of TX and TY then become meaningless, and the generation
 of cursor 'keystrokes' is set by VX and VY.
 
-9.21 DISABLE JOYSTICKS
+DISABLE JOYSTICKS
+-----------------
+
+::
 
     0x1A
 
@@ -472,7 +559,10 @@ joystick mode commands are SET JOYSTICK EVENT REPORTING, SET JOYSTICK
 INTERROGATION MODE, SET JOYSTICK MONITORING, SET FIRE BUTTON MONITORING, and
 SET JOYSTICK KEYCODE MODE.)
 
-9.22 TIME-OF-DAY CLOCK SET
+TIME-OF-DAY CLOCK SET
+---------------------
+
+::
 
     0x1B
     YY                  ; year (2 least significant digits)
@@ -487,7 +577,10 @@ Any digit that is not a valid BCD digit should be treated as a 'don't care'
 and not alter that particular field of the date or time. This permits setting
 only some subfields of the time-of-day clock.
 
-9.23 INTERROGATE TIME-OF-DAT CLOCK
+INTERROGATE TIME-OF-DAT CLOCK
+-----------------------------
+
+::
 
     0x1C
     Returns:
@@ -501,7 +594,10 @@ only some subfields of the time-of-day clock.
 
     All time-of-day is sent in packed BCD format.
 
-9.24 MEMORY LOAD
+MEMORY LOAD
+-----------
+
+::
 
     0x20
     ADRMSB              ; address in controller
@@ -512,7 +608,10 @@ only some subfields of the time-of-day clock.
 This command permits the host to load arbitrary values into the ikbd
 controller memory. The time between data bytes must be less than 20ms.
 
-9.25 MEMORY READ
+MEMORY READ
+-----------
+
+::
 
     0x21
     ADRMSB              ; address in controller
@@ -524,7 +623,10 @@ controller memory. The time between data bytes must be less than 20ms.
 
 This command permits the host to read from the ikbd controller memory.
 
-9.26 CONTROLLER EXECUTE
+CONTROLLER EXECUTE
+------------------
+
+::
 
     0x22
     ADRMSB              ; address of subroutine in
@@ -533,8 +635,11 @@ This command permits the host to read from the ikbd controller memory.
 This command allows the host to command the execution of a subroutine in the
 ikbd controller memory.
 
-9.27 STATUS INQUIRIES
-	
+STATUS INQUIRIES
+----------------
+
+::
+
     Status commands are formed by inclusively ORing 0x80 with the
     relevant SET command.
 
@@ -568,7 +673,7 @@ off the status report header byte) and later send them back as commands to
 ikbd to restore its state. The 0 pad bytes will be treated as NOPs by the
 ikbd.
 
-    Valid STATUS INQUIRY commands are:
+    Valid STATUS INQUIRY commands are::
 
             0x87    mouse button action
             0x88    mouse mode
@@ -595,13 +700,15 @@ STATUS INQUIRY commands are not valid if the ikbd is in JOYSTICK MONITORING
 mode or FIRE BUTTON MONITORING mode.
 
 
-10. SCAN CODES
+SCAN CODES
+==========
 
 The key scan codes returned by the ikbd are chosen to simplify the
 implementation of GSX.
 
 GSX Standard Keyboard Mapping.
 
+======= ============
 Hex	Keytop
 01	Esc
 02	1
@@ -643,7 +750,7 @@ Hex	Keytop
 26	L
 27	;
 28	'
-29	`
+29	\`
 2A	(LEFT) SHIFT
 2B	\
 2C	Z
@@ -707,3 +814,4 @@ Hex	Keytop
 70	KEYPAD 0
 71	KEYPAD .
 72	KEYPAD ENTER
+======= ============
-- 
2.9.3


