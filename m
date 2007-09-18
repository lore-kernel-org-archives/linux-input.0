From: "Phil Endecott" <spam_from_linux_input@chezphil.org>
Subject: Gyration wireless USB mouse; key repeat problem
Date: Wed, 19 Sep 2007 00:11:49 +0100
Message-ID: <1190157109598@dmwebmail.japan.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; format="flowed"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Dear Experts,

I have a Gyration wireless gyroscopic mouse and keyboard, which use a 
USB-connected receiver.  Does anyone else have experience with this 
device?  I can recommend it for giving software demos on a projector.  
Most functions work well.

The mouse has the usual buttons plus three extra ones which generate 
keyboard function key events, rather than mouse button presses.  
Sometimes, when I press one of these extra buttons I get the 'press' 
event but not a 'release' event; I then get lots of 'repeat' events.

Before I go on I should say that this is not with the latest kernel; 
this is 2.6.19.  Feel free to flame me for not trying on a new one :-)  
I have had a quick search through the kernel changelog and can't see 
anything that's immediately relevant.

The symptom is that if I repeatedly click one of these extra buttons 
and "od -x /dev/input/event<n>" I see normal 1/0/1/0 press and release 
events, but after a while (order of 30 clicks perhaps) I see 
1/2/2/2/2/2/ (press followed by repeats), and no release.

When I next press the button, I don't get the press event, but I do get 
the release event, at which point everything seems to be back to normal.

[Aside: I decided to try to turn off auto-repeat for these events, 
mainly to make the debug dumps less cluttered but also in case the 
problem was caused by a bug in the auto-repeat code.  Google quickly 
told me that I needed to use ioctl(EVIOCSREP) but I didn't find a 
command-line program to do this for a specific /dev/input/event<n> file 
- have I missed something?  So I wrote one, which is here: 
http://svn.chezphil.org/utils/trunk/input-kbd-rpt.c - maybe it will be 
useful to someone.  I presume that I'm supposed to pass 0,0 as the 
parameters to disable auto-repeat, yes?  Anyway, it didn't solve the 
problem; I still see a press event and no corresponding release event.]

I have attempted to reconcile the data from /dev/input/event with 
usbmon traces, without much luck, i.e. I can't determine yet whether 
there is a release event in the USB data.  Does anyone know how the 
timestamps in usbmon and in /dev/input/event are related?  They are 
both microseconds, but must be based differently I think.  I need to 
work out how to get the actual data in the usbmon output rather than 
just "<"; I think this might be a kernel version thing.

My feeling is that this could easily be a bug in the microcontroller 
inside the the mouse or the receiver.  I doubt that they have 
engineered the whole thing from scratch, so maybe this is a known quirk 
that other products share?

So, does anyone have any experience with this hardware, or suggestions 
for further debugging or work-arounds?


Many thanks for your attention.

Regards,

Phil.
