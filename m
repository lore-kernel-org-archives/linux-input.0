From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Mon, 4 Jan 2010 12:17:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001041217100.2277@pobox.suse.cz>
References: <20091212044425.GA2956@core.coreip.homeip.net> <4B261412.6090409@canonical.com> <20091214173631.GC2373@core.coreip.homeip.net> <alpine.LNX.2.00.0912151357210.3755@pobox.suse.cz> <4B278C67.5050505@canonical.com> <alpine.LNX.2.00.0912170229340.3755@pobox.suse.cz>
 <20091217013831.GF6800@core.coreip.homeip.net> <alpine.LNX.2.00.0912181609310.3755@pobox.suse.cz> <20091218174905.GA23450@core.coreip.homeip.net> <alpine.LNX.2.00.0912221430500.3755@pobox.suse.cz> <20091223185546.GA4525@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59368 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753097Ab0ADLRv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Jan 2010 06:17:51 -0500
In-Reply-To: <20091223185546.GA4525@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stefan Bader <stefan.bader@canonical.com>, Anssi Hannula <anssi.hannula@iki.fi>, Tim Cole <tim.cole@canonical.com>, Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org

On Wed, 23 Dec 2009, Dmitry Torokhov wrote:

> > > > > "Trigger happy" sounds fine.
> > > > 
> > > > OK, so how about something along the lines below?
> > > 
> > > How about we move trigger happy further towards the 0x2ff limit?
> > 
> > Sure, no problem. Just tell me the range you'd be comfortable with, and 
> > I'll apply a patch using that range.
> > 
> 
> How about we start with 0x2c0 - it will give us a buffer of another 20
> to pad with and if that range is not enough that means we need to come
> up with a new story for supporing such joysticks...

I have applied the patch below to my tree.

Thanks.



From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: handle joysticks with large number of buttons

Current HID code doesn't properly handle HID joysticks which have
larger number of buttons than what fits into current range reserved
for BTN_JOYSTICK.

One such joystick reported to not work properly is Saitek X52 Pro
Flight System.

We can't extend the range to fit more buttons in, because of backwards
compatibility reasons.

Therefore this patch introduces a new BTN_TRIGGER_HAPPY range, and
uses these to map the buttons which are over BTN_JOYSTICK limit.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> [for the input.h part]
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-input.c |    7 ++++++-
 include/linux/input.h   |   42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 5862b0f..dad7aae 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -198,7 +198,12 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		switch (field->application) {
 		case HID_GD_MOUSE:
 		case HID_GD_POINTER:  code += 0x110; break;
-		case HID_GD_JOYSTICK: code += 0x120; break;
+		case HID_GD_JOYSTICK:
+				      if (code <= 0xf)
+					      code += BTN_JOYSTICK;
+				      else
+					      code += BTN_TRIGGER_HAPPY;
+				      break;
 		case HID_GD_GAMEPAD:  code += 0x130; break;
 		default:
 			switch (field->physical) {
diff --git a/include/linux/input.h b/include/linux/input.h
index 7be8a65..7c54287 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -597,6 +597,48 @@ struct input_absinfo {
 
 #define KEY_CAMERA_FOCUS	0x210
 
+#define BTN_TRIGGER_HAPPY		0x2c0
+#define BTN_TRIGGER_HAPPY1		0x2c0
+#define BTN_TRIGGER_HAPPY2		0x2c1
+#define BTN_TRIGGER_HAPPY3		0x2c2
+#define BTN_TRIGGER_HAPPY4		0x2c3
+#define BTN_TRIGGER_HAPPY5		0x2c4
+#define BTN_TRIGGER_HAPPY6		0x2c5
+#define BTN_TRIGGER_HAPPY7		0x2c6
+#define BTN_TRIGGER_HAPPY8		0x2c7
+#define BTN_TRIGGER_HAPPY9		0x2c8
+#define BTN_TRIGGER_HAPPY10		0x2c9
+#define BTN_TRIGGER_HAPPY11		0x2ca
+#define BTN_TRIGGER_HAPPY12		0x2cb
+#define BTN_TRIGGER_HAPPY13		0x2cc
+#define BTN_TRIGGER_HAPPY14		0x2cd
+#define BTN_TRIGGER_HAPPY15		0x2ce
+#define BTN_TRIGGER_HAPPY16		0x2cf
+#define BTN_TRIGGER_HAPPY17		0x2d0
+#define BTN_TRIGGER_HAPPY18		0x2d1
+#define BTN_TRIGGER_HAPPY19		0x2d2
+#define BTN_TRIGGER_HAPPY20		0x2d3
+#define BTN_TRIGGER_HAPPY21		0x2d4
+#define BTN_TRIGGER_HAPPY22		0x2d5
+#define BTN_TRIGGER_HAPPY23		0x2d6
+#define BTN_TRIGGER_HAPPY24		0x2d7
+#define BTN_TRIGGER_HAPPY25		0x2d8
+#define BTN_TRIGGER_HAPPY26		0x2d9
+#define BTN_TRIGGER_HAPPY27		0x2da
+#define BTN_TRIGGER_HAPPY28		0x2db
+#define BTN_TRIGGER_HAPPY29		0x2dc
+#define BTN_TRIGGER_HAPPY30		0x2dd
+#define BTN_TRIGGER_HAPPY31		0x2de
+#define BTN_TRIGGER_HAPPY32		0x2df
+#define BTN_TRIGGER_HAPPY33		0x2e0
+#define BTN_TRIGGER_HAPPY34		0x2e1
+#define BTN_TRIGGER_HAPPY35		0x2e2
+#define BTN_TRIGGER_HAPPY36		0x2e3
+#define BTN_TRIGGER_HAPPY37		0x2e4
+#define BTN_TRIGGER_HAPPY38		0x2e5
+#define BTN_TRIGGER_HAPPY39		0x2e6
+#define BTN_TRIGGER_HAPPY40		0x2e7
+
 /* We avoid low common keys in module aliases so they don't get huge. */
 #define KEY_MIN_INTERESTING	KEY_MUTE
 #define KEY_MAX			0x2ff
-- 
1.5.6

