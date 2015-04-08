From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: 4.0.0-rc mouse/keyboard events get stuck
Date: Wed, 08 Apr 2015 17:29:45 +0200
Message-ID: <55254969.5060402@redhat.com>
References: <5522D2EF.9070505@xmsnet.nl> <CAKdAkRRao8aXYABV0M-KrqPuzrJG_7M2Qq+6hJQoqe7Q32USKg@mail.gmail.com> <55250A0B.6060608@xmsnet.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060904010501010805070207"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42241 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754207AbbDHP3x (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Apr 2015 11:29:53 -0400
In-Reply-To: <55250A0B.6060608@xmsnet.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Bruin <jmdebruin@xmsnet.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>

This is a multi-part message in MIME format.
--------------060904010501010805070207
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 08-04-15 12:59, Hans de Bruin wrote:
> On 04/06/2015 11:23 PM, Dmitry Torokhov wrote:
>> Hi Hans,
>>
>> On Mon, Apr 6, 2015 at 11:39 AM, Hans de Bruin <jmdebruin@xmsnet.nl> wrote:
>>> Since 4.0.0-rc something mu laptop has some mouse /keyboard problems.
>>> When I play KDE kpatience, a card game, card stick to my mousepointer: left
>>> mouse button down on a card, move mouse pointer and card to another place.
>>> left mouse button up to drop the card. This should drop the card, but often
>>> the mouse button up events gets stuck somewhere until I move he mouse
>>> pointer a little bit.
>>> In web based mail clients something similar happens when I drag mail to
>>> another folder.
>>> Sometime after I start a xterm and start typing, the letters don't appear
>>> until move the mouse pointer.
>>>
>>> Bisecting is out of the question. This kernel realease was so dramatic I was
>>> glad to have functioning kde screen when rc4 arrived.
>>>
>>> My laptop is a Dell Latitude D430, it has a touchpad and a pointer an two
>>> sets of buttons.
>>>
>>> dmesg
>>> [    0.636492] input: AT Translated Set 2 keyboard as
>>> /devices/platform/i8042/serio0/input/input4
>>> [    0.633108] mousedev: PS/2 mouse device common for all mice
>>> [   80.543044] input: PS/2 ALPS Mouse as
>>> /devices/platform/i8042/serio1/input/input8
>>
>> Linus just merged 2 fixes to ALPS driver that might help you. Could
>> you please try compiling tip of the tree and telling me if it fixes
>> your issue?
>>
>
> I am at rc.7 and the problem is still there. But maybe you can get away with "user error". Here is a picture of the layout of my laptop:
>
> http://img.clubic.com/000000DC00604500-photo-dell-latitude-d430-4.jpg
>
> Lets call the blue thing ts. The buttons directly beneath the keys ts-l and ts-r. For the touchpad tp, tp-l and tp-r. And because one can never have to many input devices um, um-l and um-r for a usb mouse.
>
> When I play kpatience and stick to one device ts or ts-l or mp and mp-l no problems arise. I can also mix devices for example um and tp-l. There are several combinations. Only one of these ts and tp-l show the problematic behavior. This is the way i use my laptop (user error?)

Ok, this one is a regression which is caused by:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/input/mouse/alps.c?id=04aae283ba6a8cd4851d937bf9c6d6ef0361d794

I've attached a fix which I will formally send / submit upstream in a few minutes too.

> Now something to distract you from the issue, something almost completely different. Something which is also present in 3.18 and probably before. Firefox and other programs have scrollbars on the right side. One can click on it, move the slider and release the button. Except with the combination tp and ts-l, It does not work. Al other combinations do.

This one is not a regression, it is an issue which we've seem to have had for ages and no one has found, or at least
described this accurately until now :) I've done some debugging and this one is fixable, but that is best left to 4.1

I'll whip up a patch and submit it when it is ready.

Regards,

Hans

--------------060904010501010805070207
Content-Type: text/x-patch;
 name="0001-alps-Fix-left-touchpad-button-getting-stuck-when-usi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alps-Fix-left-touchpad-button-getting-stuck-when-usi.pa";
 filename*1="tch"

>From 45442ba53c07570a4a9fce730b731449dc90ee87 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 8 Apr 2015 16:21:40 +0200
Subject: [PATCH] alps: Fix left touchpad button getting stuck when using it
 with trackpoint

When the left touchpad button gets pressed, and then the trackpoint is moved,
and then the button is released, the following happens:

1) touchpad packet is received, touchpad evdev node reports BTN_LEFT 1
2) pointingstick packet is received, the hw will report a BTN_LEFT 1 in this
   packet because when the trackstick is active it communicates the combined
   touchpad + pointingstick buttons in the trackstick packet, since
   alps_report_bare_ps2_packet passes NULL (*) for the dev2 parameter to
   alps_report_buttons the combining is not detected and the pointingstick
   evdev node will also report BTN_LEFT 1
3) on release of the button a pointingstick packet with BTN_LEFT 0 is received,
   and the pointingstick evdev node will report BTN_LEFT 0

Note how because of the passing as NULL for dev2 the touchpad evdev node
will never send BTN_LEFT 0 in this scenario leading to a stuck mouse button.

This is a regression in 4.0 introduced by commit 04aae283ba6a8
("Input: ALPS - do not mix trackstick and external PS/2 mouse data")

This commit fixes this by passing in the touchpad evdev as dev2 parameter
when calling alps_report_buttons for the pointingstick on alps v2 devices,
so that alps_report_buttons correctly detect that we're already reporting the
button as pressed via the touchpad evdev node, and will also send the release
event there.

Reported-by: Hans de Bruin <jmdebruin@xmsnet.nl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 80b6eca..6962c26 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1159,13 +1159,14 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
 					bool report_buttons)
 {
 	struct alps_data *priv = psmouse->private;
-	struct input_dev *dev;
+	struct input_dev *dev, *dev2 = NULL;
 
 	/* Figure out which device to use to report the bare packet */
 	if (priv->proto_version == ALPS_PROTO_V2 &&
 	    (priv->flags & ALPS_DUALPOINT)) {
 		/* On V2 devices the DualPoint Stick reports bare packets */
 		dev = priv->dev2;
+		dev2 = psmouse->dev;
 	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
 		/* Register dev3 mouse if we received PS/2 packet first time */
 		if (!IS_ERR(priv->dev3))
@@ -1177,7 +1178,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
 	}
 
 	if (report_buttons)
-		alps_report_buttons(dev, NULL,
+		alps_report_buttons(dev, dev2,
 				packet[0] & 1, packet[0] & 2, packet[0] & 4);
 
 	input_report_rel(dev, REL_X,
-- 
2.3.4


--------------060904010501010805070207--
