From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: 4.0.0-rc mouse/keyboard events get stuck
Date: Wed, 08 Apr 2015 18:04:44 +0200
Message-ID: <5525519C.6070304@redhat.com>
References: <5522D2EF.9070505@xmsnet.nl> <CAKdAkRRao8aXYABV0M-KrqPuzrJG_7M2Qq+6hJQoqe7Q32USKg@mail.gmail.com> <55250A0B.6060608@xmsnet.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040004070905080501050107"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55250A0B.6060608@xmsnet.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Bruin <jmdebruin@xmsnet.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------040004070905080501050107
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
>
> When I play kpatience and stick to one device ts or ts-l or mp and mp-l no problems arise. I can also mix devices for example um and tp-l. There are several combinations. Only one of these ts and tp-l show the problematic behavior. This is the way i use my laptop (user error?)
 >
> Now something to distract you from the issue, something almost completely different. Something which is also present in 3.18 and probably before. Firefox and other programs have scrollbars on the right side. One can click on it, move the slider and release the button. Except with the combination tp and ts-l, It does not work. Al other combinations do.

Attached is a patch which fixes this for me on my d620, please test
both patches.

Thanks & Regards,

Hans

--------------040004070905080501050107
Content-Type: text/x-patch;
 name="0001-alps-Non-interleaved-V2-dualpoint-has-separate-stick.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alps-Non-interleaved-V2-dualpoint-has-separate-stick.pa";
 filename*1="tch"

>From b4039f30e8a5b7b2f0002d137265a869cdb95403 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 8 Apr 2015 17:52:36 +0200
Subject: [PATCH 4.0 REGRESSION FIX] alps: Non interleaved V2 dualpoint has
 separate stick button bits

Non interleaved V2 dualpoint touchpad / stick combos have separate stick
button bits in the touchpad packets, if we do not check these then the
trackpoint buttons will not work when using the touchpad, and when pressed
when the user starts using the touchpad will report a release event even
though the button is still pressed.

This commit fixes this by checking the separate bits, note that we simply
combine the buttons, since the hardware does the same when using the touchpad
buttons with the trackpoint, so we do not have enough information to properly
separate them.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 6962c26..58987b5 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -243,6 +243,14 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
 		return;
 	}
 
+	/* Non interleaved V2 dualpoint has separate stick button bits */
+	if (priv->proto_version == ALPS_PROTO_V2 &&
+	    priv->flags == (ALPS_PASS | ALPS_DUALPOINT)) {
+		left |= packet[0] & 1;
+		right |= packet[0] & 2;
+		middle |= packet[0] & 4;
+	}
+
 	alps_report_buttons(dev, dev2, left, right, middle);
 
 	/* Convert hardware tap to a reasonable Z value */
-- 
2.3.4


--------------040004070905080501050107--
