From: Gerald Folcher <geraldf2@free.fr>
Subject: Force Feedback: Thrustmaster FGT Wheel quick-and-dirty in hid-lgff.c
 or hid-tmff.c
Date: Mon, 16 Jul 2007 15:48:17 +0200
Message-ID: <469B7721.9070705@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hello,

I write this as it may be interesting to the peoples involved in the 
force feedback drivers (or if you're just trying to get your 
Thrustmaster wheel's force-feedback to work), I'm sorry I'm not 
proposing a ready to apply patch because at this point I'm not competent 
enough to make something clean that won't break anything. If anybody is 
willing to make a proper patch out of this info it would be very welcome 
as far as I'm concerned, I could try it to confirm that it works with my 
wheel.

So, I got a "Thrustmaster Ferrari GT 2-in-1 Force Feedback" racing wheel 
type game controller. It's USB and is detected and work as a controller 
out of the box. But of course I quickly got interested in trying to get 
the Force Feedback part to also work.

At first, I tried to get it to work using the iforce kernel module, 
adding a vendor/id line in iforce-main.c and iforce-usb.c . But the most 
significant result I got was the module telling me that it timed out 
waiting for response from the device. So I concluded that my wheel was 
probably not talking "I-Force", but I'm still not sure I did not do 
something wrong...

Anyway, next I tried in the usbhid module and I finally got FF_CONSTANT 
type force-feedback working for my wheel, but only after some (very 
small) modifications. This is only proof-of-concept as, as-is, it will 
break Logitech compatibility.

Here's a shell session transcript to show the diffs (kernel 2.6.22) :
  bash-prompt$ cd drivers/hid/usbhid/
  bash-prompt$ diff hid-lgff.c.orig hid-lgff.c
  51a52
  >         { 0x044f, 0xb654, ff_joystick }, /* Thrustmaster FGT Force 
Feedback */
  77,80c78,80
  <               report->field[0]->value[0] = 0x51;
  <               report->field[0]->value[1] = 0x08;
  <               report->field[0]->value[2] = x;
  <               report->field[0]->value[3] = y;
  ---
  >               /* Works on the Thrustmaster but breaks Logitech */
  >               report->field[0]->value[0] = x;
  >               report->field[0]->value[1] = y;
  bash-prompt$ diff hid-ff.c.orig hid-ff.c
  55a56
  >       { 0x44f, 0xb654, hid_lgff_init }, /* Thrustmaster FGT Force 
Feedback */

That's it, with that my wheel can do FF_CONSTANT type force feedback. 
Note that it also loads the 'ff_memless' module, so I guess the wheel 
has no memory. It works well with the 'ffcfstress' and 'ffmvforce' test 
utilities, and here's the output of 'fftest':

Device /dev/input/event2 opened
Axes query:
Effects: Constant
Number of simultaneous effects: 16
Upload effects[0]: Invalid argument
Upload effects[2]: Invalid argument
Upload effects[3]: Invalid argument
Upload effects[4]: Invalid argument
Upload effects[5]: Invalid argument
Enter effect number, -1 to exit

With fftest, only entering '1' applies a left force, but I guess it's to 
be expected since the driver only do FF_CONSTANT (I guess it's the same 
on the Logitech's ?).

I also tested it in Wine with the Live For Speed (aka "LFS") S2 demo, 
and it seems to work quite well (tough I had to modify some small Wine 
code that prevented FF to work with this game, but that's another 
quick-and-dirty story). (OT: About Wine, if anybody can get Force 
Feedback working with the game Grand Prix Legends I would be very 
interested to know.)

I guess that a proper patch for the Thrustmaster wheel(s) would probably 
have better his place in hid-tmff.c (In fact I first gone that route but 
I had to change more code introducing more ugliness... the diff output 
from the hid-lgff.c version was much better for my "presentation" purpose).

That's all, I hope it will be of interest to someone :D


-- 
Gerald Folcher
