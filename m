From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Regression since commit 92bac83
Date: Tue, 20 Oct 2015 13:39:05 +0200
Message-ID: <562627D9.6020109@redhat.com>
References: <5624327B.7080906@lwfinger.net> <5624A503.7090609@redhat.com>
 <56251268.2060203@lwfinger.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020609060209050808000602"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53039 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbbJTLjM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Oct 2015 07:39:12 -0400
In-Reply-To: <56251268.2060203@lwfinger.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020609060209050808000602
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 19-10-15 17:55, Larry Finger wrote:
> On 10/19/2015 03:08 AM, Hans de Goede wrote:
>> Hi,
>>
>> On 19-10-15 01:59, Larry Finger wrote:
>>> Hi,
>>>
>>> I recently upgraded the kernel in a Dell Latitude D600 and found that the
>>> touchpad clicks failed. The problem was bisected to commit
>>> 92bac83dd79e60e65c475222e41a992a70434beb ("Input: alps - non interleaved V2
>>> dualpoint has separate stick button bits"). The laptop has a combination
>>> touchpad and control stick. For this device, the following values are found:
>>>
>>> priv->protoversion is 0x200 (ALPS_PROTO_V2)
>>> priv->flags is 0x6 (ALPS_DUALPOINT | ALPS_PASS)
>>>
>>> As a result, the new code added in this patch is executed, and left, right,
>>> and middle are updated. Once this code is introduced, a left click causes some
>>> event as it will wake a sleeping screen, but not select any windows or do
>>> anything useful.
>>>
>>> Please advise on what information would be needed to help debug this problem.
>>
>> Can you build a recent upstream kernel from source, and when building it
>> comment out these lines in drivers/input/mouse/alps.c, around lines 2555 - 2556
>>
>>          if (dmi_name_in_vendors("Dell"))
>>                  priv->flags |= ALPS_DELL;
>>
>> That should fix things, if that fixes things we need to rename the flag
>> and move to a list of dmi-matched models (rather then vendor) where the new
>> behavior
>> introduced by the patch causing you problems is actually necessary.
>>
>> Step 1 is confirming that not setting the flag fixes things for you,
>> if you can get back to us confirming that, then I'll whip up a patch
>> to switch to model matching (which is not ideal, but seems to be
>> necessary).
>
> Thanks for the quick response. Removing the two lines mentioned above restored correct touchpad operation with kernel 4.2.0. It seems that the Latitude D600 is different than other Dell models.

Thanks, can you undo the commenting of those 2 lines, apply the attached
patch, and then build, install and test, and see if this fixes things ?

Thanks & Regards,

Hans

--------------020609060209050808000602
Content-Type: text/x-patch;
 name="0001-alps-Only-the-Dell-Latitude-D420-430-620-630-have-se.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alps-Only-the-Dell-Latitude-D420-430-620-630-have-se.pa";
 filename*1="tch"

>From 5d21a8004260c3e6287bde81c2a9e8f80144e77c Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 20 Oct 2015 11:12:07 +0200
Subject: [PATCH] alps: Only the Dell Latitude D420/430/620/630 have separate
 stick button bits

commit 92bac83dd79e ("Input: alps - non interleaved V2 dualpoint has
separate stick button bits") assumes that all alps v2 non-interleaved
dual point setups have the separate stick button bits.

Later we limited this to Dell laptops only because of reports that this
broke things on non Dell laptops. Now it turns out that this breaks things
on the Dell Latitude D600 too. So it seems that only the Dell Latitude
D420/430/620/630, which all share the same touchpad / stick combo,
have these separate bits.

This patch limits the checking of the separate bits to only these models
fixing regressions with other models.

Reported-and-tested-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: stable@vger.kernel.org
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 48 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 4d24686..41e6cb5 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -100,7 +100,7 @@ static const struct alps_nibble_commands alps_v6_nibble_commands[] = {
 #define ALPS_FOUR_BUTTONS	0x40	/* 4 direction button present */
 #define ALPS_PS2_INTERLEAVED	0x80	/* 3-byte PS/2 packet interleaved with
 					   6-byte ALPS packet */
-#define ALPS_DELL		0x100	/* device is a Dell laptop */
+#define ALPS_STICK_BITS		0x100	/* separate stick button bits */
 #define ALPS_BUTTONPAD		0x200	/* device is a clickpad */
 
 static const struct alps_model_info alps_model_data[] = {
@@ -159,6 +159,43 @@ static const struct alps_protocol_info alps_v8_protocol_data = {
 	ALPS_PROTO_V8, 0x18, 0x18, 0
 };
 
+/*
+ * Some v2 models report the stick buttons in separate bits
+ */
+static const struct dmi_system_id alps_dmi_has_separate_stick_buttons[] = {
+#if defined(CONFIG_DMI) && defined(CONFIG_X86)
+	{
+		/* Extrapolated from other entries */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D420"),
+		},
+	},
+	{
+		/* Reported-by: Hans de Bruin <jmdebruin@xmsnet.nl> */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D430"),
+		},
+	},
+	{
+		/* Reported-by: Hans de Goede <hdegoede@redhat.com> */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D620"),
+		},
+	},
+	{
+		/* Extrapolated from other entries */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D630"),
+		},
+	},
+#endif
+	{ }
+};
+
 static void alps_set_abs_params_st(struct alps_data *priv,
 				   struct input_dev *dev1);
 static void alps_set_abs_params_semi_mt(struct alps_data *priv,
@@ -253,9 +290,8 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
 		return;
 	}
 
-	/* Dell non interleaved V2 dualpoint has separate stick button bits */
-	if (priv->proto_version == ALPS_PROTO_V2 &&
-	    priv->flags == (ALPS_DELL | ALPS_PASS | ALPS_DUALPOINT)) {
+	/* Some models have separate stick button bits */
+	if (priv->flags & ALPS_STICK_BITS) {
 		left |= packet[0] & 1;
 		right |= packet[0] & 2;
 		middle |= packet[0] & 4;
@@ -2552,8 +2588,6 @@ static int alps_set_protocol(struct psmouse *psmouse,
 	priv->byte0 = protocol->byte0;
 	priv->mask0 = protocol->mask0;
 	priv->flags = protocol->flags;
-	if (dmi_name_in_vendors("Dell"))
-		priv->flags |= ALPS_DELL;
 
 	priv->x_max = 2000;
 	priv->y_max = 1400;
@@ -2568,6 +2602,8 @@ static int alps_set_protocol(struct psmouse *psmouse,
 		priv->set_abs_params = alps_set_abs_params_st;
 		priv->x_max = 1023;
 		priv->y_max = 767;
+		if (dmi_check_system(alps_dmi_has_separate_stick_buttons))
+			priv->flags |= ALPS_STICK_BITS;
 		break;
 
 	case ALPS_PROTO_V3:
-- 
2.5.0


--------------020609060209050808000602--
