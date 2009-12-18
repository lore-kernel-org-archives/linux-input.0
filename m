From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Fri, 18 Dec 2009 16:10:21 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912181609310.3755@pobox.suse.cz>
References: <1260541128.3656.6.camel@bede> <4B225601.3080002@canonical.com> <1260572529.3656.12.camel@bede> <4B22F952.6070001@iki.fi> <20091212044425.GA2956@core.coreip.homeip.net> <4B261412.6090409@canonical.com> <20091214173631.GC2373@core.coreip.homeip.net>
 <alpine.LNX.2.00.0912151357210.3755@pobox.suse.cz> <4B278C67.5050505@canonical.com> <alpine.LNX.2.00.0912170229340.3755@pobox.suse.cz> <20091217013831.GF6800@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59183 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754462AbZLRPKX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Dec 2009 10:10:23 -0500
In-Reply-To: <20091217013831.GF6800@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stefan Bader <stefan.bader@canonical.com>, Anssi Hannula <anssi.hannula@iki.fi>, Tim Cole <tim.cole@canonical.com>, Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org

On Wed, 16 Dec 2009, Dmitry Torokhov wrote:

> > > #define BTN_TRIGGER_HAPPY01	0x210
> > > ...
> > > #define BTN_TRIGGER_HAPPY40	0x238
> > > 
> > > :-P Assuming 40 additional buttons should be crazy enough (but I know
> > > this has been said before about other things).
> > 
> > Dmitry, do you have any preference here yourself?
> 
> "Trigger happy" sounds fine.

OK, so how about something along the lines below?



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
 
+#define BTN_TRIGGER_HAPPY		0x220
+#define BTN_TRIGGER_HAPPY1		0x220
+#define BTN_TRIGGER_HAPPY2		0x221
+#define BTN_TRIGGER_HAPPY3		0x222
+#define BTN_TRIGGER_HAPPY4		0x223
+#define BTN_TRIGGER_HAPPY5		0x224
+#define BTN_TRIGGER_HAPPY6		0x225
+#define BTN_TRIGGER_HAPPY7		0x226
+#define BTN_TRIGGER_HAPPY8		0x227
+#define BTN_TRIGGER_HAPPY9		0x228
+#define BTN_TRIGGER_HAPPY10		0x229
+#define BTN_TRIGGER_HAPPY11		0x22a
+#define BTN_TRIGGER_HAPPY12		0x22b
+#define BTN_TRIGGER_HAPPY13		0x22c
+#define BTN_TRIGGER_HAPPY14		0x22d
+#define BTN_TRIGGER_HAPPY15		0x22e
+#define BTN_TRIGGER_HAPPY16		0x22f
+#define BTN_TRIGGER_HAPPY17		0x230
+#define BTN_TRIGGER_HAPPY18		0x231
+#define BTN_TRIGGER_HAPPY19		0x232
+#define BTN_TRIGGER_HAPPY20		0x233
+#define BTN_TRIGGER_HAPPY21		0x234
+#define BTN_TRIGGER_HAPPY22		0x235
+#define BTN_TRIGGER_HAPPY23		0x236
+#define BTN_TRIGGER_HAPPY24		0x237
+#define BTN_TRIGGER_HAPPY25		0x238
+#define BTN_TRIGGER_HAPPY26		0x239
+#define BTN_TRIGGER_HAPPY27		0x23a
+#define BTN_TRIGGER_HAPPY28		0x23b
+#define BTN_TRIGGER_HAPPY29		0x23c
+#define BTN_TRIGGER_HAPPY30		0x23d
+#define BTN_TRIGGER_HAPPY31		0x23e
+#define BTN_TRIGGER_HAPPY32		0x23f
+#define BTN_TRIGGER_HAPPY33		0x240
+#define BTN_TRIGGER_HAPPY34		0x241
+#define BTN_TRIGGER_HAPPY35		0x242
+#define BTN_TRIGGER_HAPPY36		0x243
+#define BTN_TRIGGER_HAPPY37		0x244
+#define BTN_TRIGGER_HAPPY38		0x245
+#define BTN_TRIGGER_HAPPY39		0x246
+#define BTN_TRIGGER_HAPPY40		0x247
+
 /* We avoid low common keys in module aliases so they don't get huge. */
 #define KEY_MIN_INTERESTING	KEY_MUTE
 #define KEY_MAX			0x2ff
-- 
1.5.6

