From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v2 1/3] Input: export LEDs as class devices in sysfs
Date: Wed, 22 Jul 2015 21:49:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507222145030.1141@pobox.suse.cz>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com> <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com> <20150609174211.GH6338@dtor-ws> <55AE299F.3010002@suse.cz> <20150721170133.GA39076@dtor-ws> <55AFAB9B.2090101@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.191.203.168] ([89.191.203.168]:50347 "EHLO
	mail.emea.novell.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752016AbbGVTta (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Wed, 22 Jul 2015 15:49:30 -0400
In-Reply-To: <55AFAB9B.2090101@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Wed, 22 Jul 2015, Vlastimil Babka wrote:

> [  101.805120] usb 3-4: new low-speed USB device number 3 using xhci_hcd
> [  101.979584] usb 3-4: New USB device found, idVendor=046d, idProduct=c50e
> [  101.979589] usb 3-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [  101.979592] usb 3-4: Product: USB Receiver
> [  101.979594] usb 3-4: Manufacturer: Logitech
> [  101.979805] usb 3-4: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
> [  101.989010] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> [  101.989014] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> [  101.989017] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> [  101.989019] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> [  101.989021] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> [  101.989023] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> [  101.989025] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> [  101.989027] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> [  101.989091] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:14.0/usb3/3-4/3-4:1.0/0003:046D:C50E.0003/input/input14
> [  102.039320] ------------[ cut here ]------------
> [  102.039329] WARNING: CPU: 6 PID: 168 at ../drivers/input/input-leds.c:115 input_leds_connect+0x22b/0x260()
> 
> (5 WARNINGs as before)
> 
> [  102.040729] hid-generic 0003:046D:C50E.0003: input,hidraw2: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:14.0-4/input0

Alright, I think it's pretty obvious what's happening. Vlastimil, am I 
right that the patch below fixes the issue?

I am however not sure whether input_leds_connect() is not too unkind to 
unnamed LEDs and shouldn't be more tolerant to those in the long term.





From: Jiri Kosina <jkosina@suse.com>
Subject: [PATCH] Input: leds: don't attempt to deregister unnamed LEDs

input_leds_connect() is skipping registration of LEDs for which
there is no symbolic name in input_led_info[].

The way how usages are mapped in hidinput_configure_usage() directly
implies that this will trigger also when there are duplicate mappings
of LEDs (as only the first one will be mapped accordingly to the descriptor,
and the remaining ones will be mapped to first free bits in the ledbit
bitfield).

We are however not skipping such mappings when deregistering, which
causes memory corruption.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/input/input-leds.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
index 074a65e..3be81ac 100644
--- a/drivers/input/input-leds.c
+++ b/drivers/input/input-leds.c
@@ -145,6 +145,10 @@ err_unregister_leds:
 	while (--led_no >= 0) {
 		struct input_led *led = &leds->leds[led_no];
 
+		/* Unnamed LEDs are not registered with led class */
+		if (!input_led_info[led->code].name)
+			continue;
+
 		led_classdev_unregister(&led->cdev);
 		kfree(led->cdev.name);
 	}

-- 
Jiri Kosina
SUSE Labs
