From: Juanito <juam+kernel@posteo.net>
Subject: ALPS touchpad ot correctly recognized: GlidePoint vs DualPoint
Date: Thu, 7 Sep 2017 09:05:14 +0200
Message-ID: <ada750eb-daeb-c9ae-2452-fcf027a4e704@posteo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:54653 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753828AbdIGHFR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 7 Sep 2017 03:05:17 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 33B8E208F0
        for <linux-input@vger.kernel.org>; Thu,  7 Sep 2017 09:05:16 +0200 (CEST)
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: "masaki.ota@jp.alps.com" <masaki.ota@jp.alps.com>

Dear Kernel Hackers,

I hope this is the correct place to post this. If not, please forgive me
and feel free to forward it to someplace else. Thank you very much!

I have a ThinkPad with a touchpad that looks exactly like this:
https://www.camerongray.me/wp-content/uploads/2015/02/SCotlGg.jpg

The three pyhsical buttons on top do not work on my debian stretch
(4.9). I think it isn't being recognized correctly. I see a "Rejected
trackstick packet from non DualPoint device" in my syslog whenever I
click on one of them. On the other hand on a Ubuntu 16.04 (4.4 - patched
by Ubuntu y guess) the buttons *do* work. Interestingly enough, it
doesn't work on 17.04 (4.10).

I have noticed that the touchpad gets assigned different names on both
distros. On debian it is recognized as a GlidePoint and on Ubuntu as a
DualPoint. In an upstream kernel 4.13 which I just built, it's also
recognized as a GlidePoint. Unfortunately it doesn't work either.

I am not sure if the device is actually a DualPoint or not (I don't
really understand the terminology here), but the thing is that the
buttons work when the kernel believes it to be one.

This is the info I have managed to find about the device while running
on the non-working debian:

dmesg:
[    2.914806] input: AlpsPS/2 ALPS GlidePoint as
/devices/platform/i8042/serio1/input/input2

lsinput:
/dev/input/event11
   bustype : BUS_I8042
   vendor  : 0x2
   product : 0x8
   version : 1792
   name    : "AlpsPS/2 ALPS GlidePoint"
   phys    : "isa0060/serio1/input0"
   bits ev : (null) (null) (null)

I have played around with the drivers/input/mouse/alps.c file and found
out the following:

e7 and ec are important (although I don't know what these are exactly)
and have the following values:

e7: 73 03 0a
ec: 88 b0 13

This combination is recognized as an ALPS touchpad, but isn't assigned
the ALPS_DUALPOINT flag. As far as I can see, it is actually being
*removed* at this point:

if (alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_V7) < 0)
            priv->flags &= ~ALPS_DUALPOINT;

The bit that says it has a trackpoint (I don't know what this is) is
apparently saying my device doesn't have one and is removing the
ALPS_DUALPOINT flag.

This flag makes the buttons work. I am not sure if it breaks other stuff.

I have written a pretty dummy patch which actually adds the flag again
making the buttons work. Again, I am not sure if it breaks other stuff
but my system isn't whining. Here is the patch:

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 850b00e3ad8e..17aba42e846f 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2804,6 +2804,9 @@ static int alps_set_protocol(struct psmouse *psmouse,
                if (alps_probe_trackstick_v3_v7(psmouse,
ALPS_REG_BASE_V7) < 0)
                        priv->flags &= ~ALPS_DUALPOINT;

+               if (priv->fw_ver[1] == 0xb0)
+                       priv->flags |= ALPS_DUALPOINT;
+
                break;

        case ALPS_PROTO_V8:

After applying this patch dmesg and lsinput say this:

[    8.226543] input: AlpsPS/2 ALPS DualPoint Stick as
/devices/platform/i8042/serio1/input/input13
[    8.247595] input: AlpsPS/2 ALPS DualPoint TouchPad as
/devices/platform/i8042/serio1/input/input2

/dev/input/event11
   bustype : BUS_I8042
   vendor  : 0x2
   product : 0x8
   version : 1792
   name    : "AlpsPS/2 ALPS DualPoint Stick"
   phys    : "isa0060/serio1/input1"
   bits ev : (null) (null) (null)

/dev/input/event12
   bustype : BUS_I8042
   vendor  : 0x2
   product : 0x8
   version : 1792
   name    : "AlpsPS/2 ALPS DualPoint TouchPad"
   phys    : "isa0060/serio1/input0"
   bits ev : (null) (null) (null)

I am a total newbie to kernels and drivers so it would be great if
somebody who actually had some idea could take a look at this and
probably create a patch in a better place. I'll be glad to post more
info if necessary.

Thank you very much!

Cheers,
Juanito

