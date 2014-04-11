From: Vadim Trochinsky <lkml@vadim.ws>
Subject: Modifier keys on the Zowie Celeritas keyboard don't work
Date: Sat, 12 Apr 2014 01:11:33 +0200
Message-ID: <10514040.Xk73Z6ossY@madhatter.int.vadim.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 71.Red-2-139-155.staticIP.rima-tde.net ([2.139.155.71]:57209
	"EHLO mail.vadim.ws" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbaDLAy0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Apr 2014 20:54:26 -0400
Received: from [192.168.0.254] (helo=madhatter.int.vadim.ws)
	by mail.vadim.ws with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1)
	(envelope-from <lkml@vadim.ws>)
	id 1WYkbi-0001rF-9i
	for linux-input@vger.kernel.org; Sat, 12 Apr 2014 01:11:39 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello!

I've got this keyboard and it's got the extremely irritating problem of 
that the Alt/Shift/Ctrl keys don't work at all. Caps lock does work 
though.

xev reports the following:

The 'a' key gives this. Holding the key produces a continuous stream of 
these two:

KeyPress event, serial 43, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31503085, (-189,538), root:(859,561),
    state 0x0, keycode 38 (keysym 0x61, a), same_screen YES,
    XLookupString gives 1 bytes: (61) "a"
    XmbLookupString gives 1 bytes: (61) "a"
    XFilterEvent returns: False

KeyRelease event, serial 43, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31503190, (-189,538), root:(859,561),
    state 0x0, keycode 38 (keysym 0x61, a), same_screen YES,
    XLookupString gives 1 bytes: (61) "a"
    XFilterEvent returns: False


The Shift key gives this. Notice how unlike in the previous one, the 
time is exactly the same -- the release is registered immediately, 
though it did take me a bit of time to release the key. Also holding the 
key pressed only ever outputs the Press/Release pair once.

KeyPress event, serial 43, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31524269, (-603,723), root:(445,746),
    state 0x0, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 bytes: 
    XmbLookupString gives 0 bytes: 
    XFilterEvent returns: False

KeyRelease event, serial 43, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31524269, (-603,723), root:(445,746),
    state 0x1, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 bytes: 
    XFilterEvent returns: False


Pressing Shift+A results in this, which shows that both keys are sensed, 
but Shift is being interpreted as being released immediately (and 
twice), hence why it never overlaps the 'a' keypress.

KeyPress event, serial 49, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31724281, (68,-49), root:(1909,91),
    state 0x0, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 bytes: 
    XmbLookupString gives 0 bytes: 
    XFilterEvent returns: False

KeyRelease event, serial 49, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31724281, (68,-49), root:(1909,91),
    state 0x1, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 bytes: 
    XFilterEvent returns: False

KeyPress event, serial 49, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31724442, (68,-49), root:(1909,91),
    state 0x0, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 bytes: 
    XmbLookupString gives 0 bytes: 
    XFilterEvent returns: False

KeyRelease event, serial 49, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31724442, (68,-49), root:(1909,91),
    state 0x1, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 bytes: 
    XFilterEvent returns: False

KeyPress event, serial 49, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31724442, (68,-49), root:(1909,91),
    state 0x0, keycode 38 (keysym 0x61, a), same_screen YES,
    XLookupString gives 1 bytes: (61) "a"
    XmbLookupString gives 1 bytes: (61) "a"
    XFilterEvent returns: False

KeyPress event, serial 49, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31724570, (68,-49), root:(1909,91),
    state 0x0, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 bytes: 
    XmbLookupString gives 0 bytes: 
    XFilterEvent returns: False

KeyRelease event, serial 49, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31724570, (68,-49), root:(1909,91),
    state 0x1, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 bytes: 
    XFilterEvent returns: False

KeyRelease event, serial 49, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31724570, (68,-49), root:(1909,91),
    state 0x0, keycode 38 (keysym 0x61, a), same_screen YES,
    XLookupString gives 1 bytes: (61) "a"
    XFilterEvent returns: False


In comparison, here's another keyboard, which works fine:

KeyPress event, serial 48, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31588524, (-536,223), root:(1305,363),
    state 0x0, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 bytes: 
    XmbLookupString gives 0 bytes: 
    XFilterEvent returns: False

KeyPress event, serial 48, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31593276, (-536,223), root:(1305,363),
    state 0x1, keycode 38 (keysym 0x41, A), same_screen YES,
    XLookupString gives 1 bytes: (41) "A"
    XmbLookupString gives 1 bytes: (41) "A"
    XFilterEvent returns: False

KeyRelease event, serial 48, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31593380, (-536,223), root:(1305,363),
    state 0x1, keycode 38 (keysym 0x41, A), same_screen YES,
    XLookupString gives 1 bytes: (41) "A"
    XFilterEvent returns: False

KeyRelease event, serial 48, synthetic NO, window 0x7200001,
    root 0x29e, subw 0x0, time 31593435, (-536,223), root:(1305,363),
    state 0x1, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 bytes: 
    XFilterEvent returns: False

I found these bug reports, which contain information on the problem. 
What's happening to me is exactly the same:

https://bugzilla.kernel.org/show_bug.cgi?id=51371
https://bugzilla.kernel.org/show_bug.cgi?id=46491


As of 3.13.9, it still doesn't work. I tried usbmon to see what's 
different about this keyboard vs another perfectly good working one that 
I have, and the packet dumps have come out exactly identical, except for 
the minor and expected differences in timestamps. None of this "shift is 
immediately released" behavior detailed above appears in the USB dumps, 
the keyboard seems to work exactly as expected.

I have to say that I'm quite baffled by this revelation.

The keyboard also works perfectly well in GRUB and Windows, and previous 
reports of this problem mentioned it works with the usbkbd driver, but 
that doesn't seem to exist anymore.


Maybe is there something that I'm not capturing? (I used "tshark -i 
usbmon0") Or perhaps some kind of inappropriate quirks mode being turned 
on? I tried looking at the kernel source, but I'm completely 
inexperienced in that area (though I can code), and failed to find 
anything.


I'd like to have this fixed. Please do tell what information might be 
useful.

Thanks!
