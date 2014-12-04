From: Karl Dahlke <eklhad@comcast.net>
Subject: [PATCH] input/speaker: additional clicks and tones for future...
Date: Wed, 03 Dec 2014 21:00:46 -0500
Message-ID: <20141103210046.eklhad@comcast.net>
References: <20141102001740.eklhad@comcast.net> <20141203225229.GE16951@dtor-ws>
Reply-To: Karl Dahlke <eklhad@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from resqmta-po-02v.sys.comcast.net ([96.114.154.161]:47203 "EHLO
	resqmta-po-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750840AbaLDCAr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Dec 2014 21:00:47 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: vojtech@ucw.cz, linux-input@vger.kernel.org

It seems to be the general consensus that these sound functions
should not be integrated into the kernel - and that's ok.
Allow me then to ask one more question if I may.
I have a module, ttyclicks.ko, that makes sounds and clicks and such,
and is used primarily by adapters.
By design, it operates the pc speaker, and is never intended
to vector through a sound card or other such.
In fact it provides feedback when the sound card is not working.
That might eliminate some of your concerns.
My question is, would it be possible to add this module to the kernel tree?
If you wanted to add it under staging, that would be fine.
After all, the Speakup modules are all under staging,
and since so few people use them, that's not a problem.
My modules would also be used by a slim minority,
but that minority would sure find it convenient to have the modules
distributed with the kernel.
If you think this is at least a possibility, I will put a patch together.
If not, I will maintain them privately, as I already do.
To clarify how the module works,
here is the file that would be added as
Documentation/accessibility/ttyclicks.txt

Thank you for your consideration.

======================================================================


The tty clicks module
			---------------------
			Karl Dahlke
			eklhad@gmail.com

When this module is installed, soft clicks accompany
the nonspace characters that are sent to the console,
while a longer swoop indicates a newline character.
These sounds simulate an old fashion teletype running at 2400 baud.
Why would you want such a thing?
You probably wouldn't, but a blind person might.
He can tell, by clicks alone, when the computer responds to a command,
and he can discern the quantity and format of that response,
without any speech or braille.
In addition, the output is throttled, and does not fly by the screen
in a flash, faster than one could possibly hit control S.

This module is separate from any sound cards, thus providing valuable audio
feedback if the sound card is not working.
It can be loaded very early in the boot sequence,
since it does not depend on anything else.

This module uses the in-built toggle speaker at port 0x61.
Not all machines have this speaker, but most do.
If the speaker is lacking, the module is a no-op.

This module will not click and chirp if you are in X.
It responds to text characters that pass through the standard tty,
and will not do anything in graphics mode.
Even the terminal emulator, running under a desktop, still runs through X,
and won't work with ttyclicks.
Switch to a text console to hear the clicks.

Module parameters:

As always, you can run modinfo ttyclicks.ko to review these parameters.

enabled = 1 or 0

If 1, then sounds are enabled as soon as the module is loaded.
If 0, then sounds are not enabled.
These sounds can be turned on or off at run time by the exported symbol
	bool ttyclicks_on;
Thus other modules can turn sounds on or off.
In particular, any adapter that includes a lodable module
has access to this master switch.

fgtty = 1 or 0

This parameter enables the clicks that accompany the display of characters
from  the foreground tty.
The corresponding exported symbol is
	bool ttyclicks_tty;

kmsg = 1 or 0

Printk messages do not pass through the tty,
and do not generate the aforementioned clicks.
However, if this switch is enabled,
each printk message generates a distinctive sequence of tones.
This is like an alarm,
telling the user that he needs to read the message on the screen.
The corresponding exported symbol is
	bool ttyclicks_kmsg;

cursormotion = 0 or 1

Many screen programs generate ansi escape sequences that position the cursor
and set character attributes such as underline etc.
This is not true output, and does not generate clicks by default.
However, you can set this parameter to 1 if you want these characters
to generate clicks.

Exported functions.
These are all subject to the master switch ttyclicks_on.

void ttyclicks_click(void);

Generate a 0.6 millisecond pulse.

void ttyclicks_cr(void);

Generate a quick frequency swoop from 2900 to 3600 hz.
This sound is associated with the newline character at the console,
but you can use this function to generate the same sound whenever you wish.

void ttyclicks_notes(const short *notelist);

Play a series of notes in the background.
Each note is defined by two shorts, a frequency and a duration.
The frequency is in hurtz, and the duration is in hundredths of a second.
A frequency of -1 is a rest.
A frequency of 0 terminates the array.
The queue can only hold 64 notes, so don't try to play an entire sonata.

void ttyclicks_steps(int freq1, int freq2, int step, int duration)

Play a series of notes, of the specified duration, moving from
frequency freq1 to frequency freq2 in a geometric progression of step%.
This is a customizable chromatic scale.
The traditional scale, based on half tones, and starting at middle C,
has an approximate step of 6%, and looks like this.
ttyclicks_mksteps(260, 530, 6, 150);
Use a negative step for a descending scale.

void ttyclicks_bell(void);

This function generates an 1800 hz tone for a tenth of a second.
this is associated with the control G bell.
The traditional bell is 1000 hz, but I wanted a slightly higher tone.
As long as this module is loaded, it swallows control G, and sounds the bell,
rather then passing it through to the console and letting the console
ring the bell.  This allows the master switch, ttyclicks_on,
to enable or disable the control G bell along with all the other sounds.
You can turn off all the sounds in one go, if they are bothering your roommate.

This module is integral to many command line adapters,
as a complement to speech or braille.  Beyond this,
it can prove invaluable if the adapter is not working for any reason.
