From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: Samsung series 5 ultra keyboard
Date: Sun, 28 Jul 2013 07:45:05 -0300
Message-ID: <20130728074505.7bc63239@infradead.org>
References: <20130727101153.6a3ece65@samsung.com>
 <20130727150642.5a1f26cd@infradead.org>
 <20130728052243.GA23567@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54460 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab3G1KpN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jul 2013 06:45:13 -0400
In-Reply-To: <20130728052243.GA23567@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Em Sat, 27 Jul 2013 22:22:43 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> escreveu:

> Hi Mauro,
> 
> On Sat, Jul 27, 2013 at 03:06:42PM -0300, Mauro Carvalho Chehab wrote:
> > Em Sat, 27 Jul 2013 10:11:53 -0300
> > Mauro Carvalho Chehab <m.chehab@samsung.com> escreveu:
> > 
> > > Hi Dmitry,
> > > 
> > > I received a new notebook those days that has an extra feature of a "Fn Lock"
> > > key.
> > > 
> > > When this key is pressed, it produces a scan code 0xa8, and the direction
> > > keys (and other keys) start to produce different codes. When pressed again,
> > > it produces a scan code 0xa9, and the keys return to their normal behavior.
> > > 
> > > The input layer doesn't currently produce any EV_KEY event for those two
> > > scancodes. It produces just EV_MSC events (and, of course, EV_SYN).
> > > 
> > > I was wandering that the better would be to have a LED indicator to
> > > track this, and maybe have two new keycodes, like KEY_FN_LOCK_ON and
> > > KEY_FN_LOCK_OFF.
> > > 
> > > This way, some userspace program, like mate-lockkeys-applet could be
> > > presenting not only the CAPS LOCK indicator, but also the FN LOCK
> > > indicator.
> > > 
> > > Do you think it would be doable?
> 
> Hmm, the behavior better matches a switch than a key, but we do have
> quite a few key-like ON/OFF keys/switches so yes, we could add a couple
> more.

We could map it as a switch. Yet, there are just a couple switches
left on kernel 3.10. So, if I understood well, the patch for input.h
would be something like the one below, right?


diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index d584047..13c3c79 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -716,6 +716,10 @@ struct input_keymap_entry {
 #define BTN_DPAD_LEFT		0x222
 #define BTN_DPAD_RIGHT		0x223
 
+#define KEY_FNNLOCK_TOGGLE	0x224	/* Request switch Fn on or off */
+#define KEY_FNLOCK_ON		0x225
+#define KEY_FNLOCK_OFF		0x226
+
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
 #define BTN_TRIGGER_HAPPY2		0x2c1
@@ -853,6 +857,7 @@ struct input_keymap_entry {
 #define SW_FRONT_PROXIMITY	0x0b  /* set = front proximity sensor active */
 #define SW_ROTATE_LOCK		0x0c  /* set = rotate locked/disabled */
 #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
+#define SW_FNLOCK		0x0e  /* set = Fn locked */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)
 
The changes at atkbd could be a little more complex, as it will
require to support more than one fixups at the same time:
	- the release Fn fixup;
	- the table fixup for the two addicional keycodes;
	- the switch (or led) fixup.

I'll work on it after we decide the better approach (either as a
switch or as a LED).

> > > 
> > > FYI, this is how this keyboard identifies itself:
> > > 
> > > $ cat /sys/class/input/event3/device/uevent 
> > > PRODUCT=11/1/1/ab41
> > > NAME="AT Translated Set 2 keyboard"
> > > PHYS="isa0060/serio0/input0"
> > > PROP=0
> > > EV=120013
> > > KEY=500f02000403 3803078f870d001 feffffdffbefffff fffffffffffffffe
> > > MSC=10
> > > LED=7
> > > MODALIAS=input:b0011v0001p0001eAB41-e0,1,4,11,14,k71,72,73,74,75,76,77,79,7A,7B,7C,7D,7E,7F,80,8C,8E,8F,94,95,96,9B,9C,9D,9E,9F,A3,A4,A5,A6,AC,AD,B7,B8,B9,C0,C1,CA,D9,E0,E1,E2,E3,EC,EE,ram4,l0,1,2,sfw
> > > 
> > > I'm not sure if the PRODUCT there is unique, and if it could be used
> > > to add this kind of extra feature to the input subsystem (or if it would
> > > be just fine to add those extra features at the standard AT keyboard
> > > driver, although I personally don't like this idea, as other keyboards
> > > might be using scancodes 0xa8/0xa9 for other meanings).
> > > 
> > > What do you think?
> > 
> > Just discovered something weird while trying to write some code for
> > systemd/udev: there are a few keys that only produce key down events:
> > 	Fn + F1 (KEY_SETUP)
> > 	Fn + F12 (KEY_WLAN)
> > 	Fn Lock (both scan codes 0xa8 and 0xa9)
> 
> That is not new, quite a few laptops do not bother with producing
> release events. There is force_release attribute on serio ports bound to
> atkbd and udev has code to manipulate it to ensure all keys are
> released properly. You just need to add rule for your model.

Ok, that's a trivial patch. 

Patch for that sent (and of course tested on the notebook).

Thanks!
Mauro
