From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: patch staging-htc-dream-touchscreen-driver-for-staging.patch
	added to gregkh-2.6 tree
Date: Tue, 28 Jul 2009 19:51:43 -0700
Message-ID: <d6200be20907281951t53c12cdfo82282318eb6fcd33@mail.gmail.com>
References: <20090720105340.GF19341@elf.ucw.cz> <1248710770577@kroah.org>
	 <d6200be20907271545l4edc4480v22f6dec4cd3d5dc9@mail.gmail.com>
	 <20090727225545.GC7142@elf.ucw.cz>
	 <d6200be20907271729l4cf2f519occ8ebc1024e5140a@mail.gmail.com>
	 <20090728111417.GB17323@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:41525 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbZG2Cvn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2009 22:51:43 -0400
Received: by qw-out-2122.google.com with SMTP id 8so290830qwh.37
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2009 19:51:43 -0700 (PDT)
In-Reply-To: <20090728111417.GB17323@elf.ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: gregkh@suse.de, greg@kroah.com, swetland@google.com, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

On Tue, Jul 28, 2009 at 4:14 AM, Pavel Machek<pavel@ucw.cz> wrote:
> Hi!
>
>> >> Don't see canceling timer nor shutting off WQ here. Also, maybe
>> >> implement open() and close() so we don't reschedule WQ while poll=
ing?_
>> > )
>>
>> Unless you changed something there should be no failure path after
>> starting the timer or enabling the interrupt.
>>
>> synaptics_ts_remove is missing a flush_work call though.
>
> Can you submit patch to fix that?
>

When fix it, sure. This code is unreachable in the configurations we
use though so I never noticed it before.

>> > 2) it uses non-standard multitouch support. Either multitouch need=
s to
>> > be disabled for merge, or it needs to switch to standard config.
>>
>> I have a patch that adds support for the new protocol, but it does n=
ot
>> yet remove the old hack.
>
> Yes, such patch would be welcome. I guess we could wrap old, hacky
> protocol in ifdef, and then remove it when moving to drivers/input.

I included the patch below. It is not against your cleaned up version
of the driver, but it could use a review in its current form since I'm
unclear on how up events should be handled. Another touchscreen only
sends events for the finger that moved, so the absence of a finger
report is not a good indication that it was released.

--=20
Arve Hj=F8nnev=E5g

---

=46rom edc71cab6a21fd0415b626bf2cbe737af29e3491 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?utf-8?q?Arve=3D20Hj=3DC3=3DB8nnev=3DC3=3DA5g?=3D <arve@andr=
oid.com>
Date: Mon, 20 Jul 2009 20:11:31 -0700
Subject: [PATCH] Input: synaptics_i2c_rmi: Send new multi touch events
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

Send both fingers using the new multitouch protocol in addition to
the old single finger event and second finger ABS_HAT* hack.

The new protocol does not specify how to report up events. To make
sure the user-space frameworks can generate up events, we send at
least one event where ABS_MT_TOUCH_MAJOR is zero before we stop
sending events for a finger.

Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
---
 drivers/input/touchscreen/synaptics_i2c_rmi.c |   25 +++++++++++++++++=
++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/synaptics_i2c_rmi.c
b/drivers/input/touchscreen/synaptics_i2c_rmi.c
index 56cf371..e003e42 100644
--- a/drivers/input/touchscreen/synaptics_i2c_rmi.c
+++ b/drivers/input/touchscreen/synaptics_i2c_rmi.c
@@ -43,6 +43,7 @@ struct synaptics_ts_data {
        int snap_down[2];
        int snap_up[2];
        uint32_t flags;
+       int reported_finger_count;
        int8_t sensitivity_adjust;
        int (*power)(int on);
        struct early_suspend early_suspend;
@@ -204,6 +205,26 @@ static void synaptics_ts_work_func(struct
work_struct *work)

input_report_abs(ts->input_dev, ABS_HAT0X, pos[1][0]);

input_report_abs(ts->input_dev, ABS_HAT0Y, pos[1][1]);
                                }
+
+                               if (!finger)
+                                       z =3D 0;
+                               input_report_abs(ts->input_dev,
ABS_MT_TOUCH_MAJOR, z);
+                               input_report_abs(ts->input_dev,
ABS_MT_WIDTH_MAJOR, w);
+                               input_report_abs(ts->input_dev,
ABS_MT_POSITION_X, pos[0][0]);
+                               input_report_abs(ts->input_dev,
ABS_MT_POSITION_Y, pos[0][1]);
+                               input_mt_sync(ts->input_dev);
+                               if (finger2_pressed) {
+
input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, z);
+
input_report_abs(ts->input_dev, ABS_MT_WIDTH_MAJOR, w);
+
input_report_abs(ts->input_dev, ABS_MT_POSITION_X, pos[1][0]);
+
input_report_abs(ts->input_dev, ABS_MT_POSITION_Y, pos[1][1]);
+                                       input_mt_sync(ts->input_dev);
+                               } else if (ts->reported_finger_count > =
1) {
+
input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0);
+
input_report_abs(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0);
+                                       input_mt_sync(ts->input_dev);
+                               }
+                               ts->reported_finger_count =3D finger;
                                input_sync(ts->input_dev);
                        }
                }
@@ -480,6 +501,10 @@ static int synaptics_ts_probe(
        input_set_abs_params(ts->input_dev, ABS_TOOL_WIDTH, 0, 15, fuzz=
_w, 0);
        input_set_abs_params(ts->input_dev, ABS_HAT0X,
-inactive_area_left, max_x + inactive_area_right, fuzz_x, 0);
input_set_abs_params(ts->input_dev, ABS_HAT0Y, -inactive_area_top,
max_y + inactive_area_bottom, fuzz_y, 0);+
input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
-inactive_area_left, max_x + inactive_area_right, fuzz_x, 0);
+       input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
-inactive_area_top, max_y + inactive_area_bottom, fuzz_y, 0);
+       input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0,
255, fuzz_p, 0);
+       input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 15,
fuzz_w, 0);
        /* ts->input_dev->name =3D ts->keypad_info->name; */
        ret =3D input_register_device(ts->input_dev);
        if (ret) {
--
1.6.1
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
