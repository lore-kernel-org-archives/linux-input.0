From: =?ISO-8859-1?Q?V=E1clav?= Krpec <vencik@razdva.cz>
Subject: Yet another ALPS dualpoint TP protocol in preparation
Date: Mon, 17 Mar 2014 18:53:42 +0100
Message-ID: <1395078822.4834.78.camel@adora>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gmmr4.centrum.cz ([46.255.227.253]:42307 "EHLO gmmr4.centrum.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210AbaCQSBD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Mar 2014 14:01:03 -0400
Received: from gm-as1.cent (mail-g1.snat.cent [10.32.3.101])
	by gmmr4.centrum.cz (Postfix) with ESMTP id 355C1563
	for <linux-input@vger.kernel.org>; Mon, 17 Mar 2014 18:53:45 +0100 (CET)
Received: from [192.168.1.183] (unknown [77.240.100.35])
	by gm-smtp1.centrum.cz (Postfix) with ESMTPX id 6B7DF60048AB3
	for <linux-input@vger.kernel.org>; Mon, 17 Mar 2014 18:53:43 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello everybody,

yes, I'm another poor soul who ended up with an ALPS touchpad.

More specifically (although not much helpfully), it's a device
ALPS manufactured for my Toshiba Portege Z30-A-12N.
I've written to both ALPS and Toshiba with pleads for tech.
documentation, but (not surprisingly) Toshiba didn't respond
at all, ALPS just told me they can't help me...
The same old song (although it never hurts to try).

Well, being Linux user for quite some time and SW developer
myself, I decided to do a reverse analysis of the device,
hoping to get proper support of its capabilities in psmouse
kernel module.

Here's a short list of what I've done (hope I didn't bore
you off up to this point, it'll turn worse ;-):

1/
I've contacted Sebastian Kapfer, the current maintainer
of the ALPS sub-driver; with his advice and support,
I was able to find out that the device responds to
"AlpsPS/2 v3 Rushmore" flavour of HW initialisation routine.
I should note here that the device works in plain PS/2 mouse
compatibility mode unless the HW init. sequence above is executed.

2/
I've created a simple tool for reverse analysis of the device PS/2
protocol; it's here (just in case someone else would find it helpful):
https://github.com/vencik/alsp-ra
I was able to successfully unravel the device protocol packet structure
and have drafted a new version (codename "v7").

3/
I'm now in process of implementing the driver; so far, the trackstick
works fine, the TP sends abs. coords OK, I got tap and tap-and-drag
working too (although fine tuning shall be nice).
I can distinguish 2 fingers, either, and get secondary coords.
I've however hit a few issues:

4/
I'm using the (apparently) old BTN_TOOL_FINGER / BTN_TOOL_DOUBLETAP
input_report_* interface.
Accordingly to the documentation and what I saw in the code,
the new input_mt_slot & input_mt_report_slot_state should be more
suitable for multitouch (the touchpad can apparently detect at least
3, maybe even more, fingers).
Although I don't really need that, it seems better to use the more
general approach.
However, I don't seem to be able to get any events reported using
that new iface.
Do I need to do any special initialisation or something?
Note that I do use alps_set_abs_params_mt for the set_abs_params
callback.
Or perhaps do I need to set something on the synaptics X11 driver?

5/
I've also noticed that the TP seems to get out-of-sync or something
if I re-load the driver and touch it too soon before the X server
loads the synaptics driver.
If I wait for about 3 seconds, it works fine.
If I touch it sooner, I get no cursor (although the other trackstick
device still works nicely and so do the TP buttons).
Is there any reset required/possible?

6/
I also have a bit of trouble reporting switch from 2 to one touch.
When that happens, I try to
input_report_key(dev, BTN_TOOL_DOUBLETAP, 0)
and then
input_report_key(dev, BTN_TOOL_FINGER, 1)
(with sync) to avoid cursor skip if the primary touch is the lost
one, but that doesn't seem to do the trick.
What should I do?

7/
Well, there'll be much more to do, but so far, the above are the most
interesting/bugging issues.

Any help/advice/moral support highly appreciated. :-)

Also, don't hesitate to point me to any existing info resources
(and at this point, I'd like to apologise if asking an already responded
question).

Of course, if anyone else have similar device, I'd very much like to
share findings or (at some point) perhaps get the opportunity to
test the code on another machine.

Thanks,

Best regards

vencik



