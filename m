From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: Re: [REGRESSION] Touchpad failure after e7348396c6d5 ("Input: ALPS -
 fix V8+ protocol handling (73 03 28)")
Date: Mon, 19 Jun 2017 19:20:26 -0400
Message-ID: <20170619232026.GG1855@TopQuark.net>
References: <937d0082-5c51-e0b5-dcf9-efade5ecbde5@redhat.com>
 <20170603040349.GB16345@TopQuark.net>
 <e841f28c-4d63-170a-482f-8ef1deda1900@redhat.com>
 <KAWPR01MB1092C3572946C54C2CC4DEFBC7CD0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <75b84b97-5f36-a3be-bb4e-e43cd72d9921@redhat.com>
 <KAWPR01MB1092CFFDF4C4490669DCE92CC7C00@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <20170619184315.GF1855@TopQuark.net>
 <0995261b-8d19-64af-9b66-e1eab579a3d4@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:57916 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbdFSXU3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 19:20:29 -0400
Content-Disposition: inline
In-Reply-To: <0995261b-8d19-64af-9b66-e1eab579a3d4@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pali Rohar <pali.rohar@gmail.com>, Nick Fletcher <nick.m.fletcher@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "scott.s.lowe@gmail.com" <scott.s.lowe@gmail.com>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 19, 2017 at 01:02:18PM -0700, Laura Abbott wrote:
> On 06/19/2017 11:43 AM, Paul Donohue wrote:
> > I get the same results as you - x_max and y_max affect cursor speed, and x_res and y_res seem to have no effect.  I can't seem to come up with any values that cause intermittent cursor issues on one side of the touchpad.
> > Both max and res do get passed up to the X driver, and I do see references to both max and resolution in xf86-input-evdev, although I haven't actually traced it through to see if/where each value is actually consumed with my setup.
> > 
> > Maybe we should ask the user to try a few more tests?
> > 1) Using the original code (without the modifications from bug 195215), add the following before 'return 0' at the end of alps_update_device_area_ss4_v2(), then run `dmesg | grep num-electrodes` after loading the alps kernel module to get the output.  This should tell us what values the user is actually reading from the hardware:
> > psmouse_err(psmouse,
> >     "pitch %dx%d num-electrodes %dx%d physical size %dx%dmm res %dx%d max %dx%d\n",
> >     x_pitch, y_pitch, num_x_electrode, num_y_electrode,
> >     x_phys / 10, y_phys / 10, priv->x_res, priv->y_res, priv->x_max, priv->y_max);
> > 2) Use the old electrode count code but the new pitch code:
> > 	if (IS_SS4PLUS_DEV(priv->dev_id)) {
> > 		num_x_electrode =
> > 			SS4_NUMSENSOR_XOFFSET + (otp[1][0] & 0x0F);
> > 		num_y_electrode =
> > 			SS4_NUMSENSOR_YOFFSET + ((otp[1][0] >> 4) & 0x0F);
> > 
> > 		priv->x_max =
> > 			(num_x_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
> > 		priv->y_max =
> > 			(num_y_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
> > 
> > 		x_pitch = (otp[0][1] & 0x0F) + SS4PLUS_MIN_PITCH_MM;
> > 		y_pitch = ((otp[0][1] >> 4) & 0x0F) + SS4PLUS_MIN_PITCH_MM;
> > 
> > 	} else {
> > 3) Use the new electrode count code but the old pitch code:
> > 	if (IS_SS4PLUS_DEV(priv->dev_id)) {
> > 		num_x_electrode =
> > 			SS4PLUS_NUMSENSOR_XOFFSET + (otp[0][2] & 0x0F);
> > 		num_y_electrode =
> > 			SS4PLUS_NUMSENSOR_YOFFSET + ((otp[0][2] >> 4) & 0x0F);
> > 
> > 		priv->x_max =
> > 			(num_x_electrode - 1) * SS4PLUS_COUNT_PER_ELECTRODE;
> > 		priv->y_max =
> > 			(num_y_electrode - 1) * SS4PLUS_COUNT_PER_ELECTRODE;
> > 
> > 		x_pitch = ((otp[1][2] >> 2) & 0x07) + SS4_MIN_PITCH_MM;
> > 		y_pitch = ((otp[1][2] >> 5) & 0x07) + SS4_MIN_PITCH_MM;
> > 
> > 	} else {
> > 
> 
> Can you produce patches for these test cases?

I've reduced it to two test cases.  Patches attached.


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch1

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 262d1057c1da..341a6c3bf907 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2467,14 +2467,14 @@ static int alps_update_device_area_ss4_v2(unsigned char otp[][4],
 
 	if (IS_SS4PLUS_DEV(priv->dev_id)) {
 		num_x_electrode =
-			SS4PLUS_NUMSENSOR_XOFFSET + (otp[0][2] & 0x0F);
+			SS4_NUMSENSOR_XOFFSET + (otp[1][0] & 0x0F);
 		num_y_electrode =
-			SS4PLUS_NUMSENSOR_YOFFSET + ((otp[0][2] >> 4) & 0x0F);
+			SS4_NUMSENSOR_YOFFSET + ((otp[1][0] >> 4) & 0x0F);
 
 		priv->x_max =
-			(num_x_electrode - 1) * SS4PLUS_COUNT_PER_ELECTRODE;
+			(num_x_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
 		priv->y_max =
-			(num_y_electrode - 1) * SS4PLUS_COUNT_PER_ELECTRODE;
+			(num_y_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
 
 		x_pitch = (otp[0][1] & 0x0F) + SS4PLUS_MIN_PITCH_MM;
 		y_pitch = ((otp[0][1] >> 4) & 0x0F) + SS4PLUS_MIN_PITCH_MM;
@@ -2500,6 +2500,11 @@ static int alps_update_device_area_ss4_v2(unsigned char otp[][4],
 	priv->x_res = priv->x_max * 10 / x_phys; /* units / mm */
 	priv->y_res = priv->y_max * 10 / y_phys; /* units / mm */
 
+	psmouse_err(psmouse,
+		    "test1 pitch %dx%d num-electrodes %dx%d physical size %dx%dmm res %dx%d max %dx%d\n",
+		    x_pitch, y_pitch, num_x_electrode, num_y_electrode,
+		    x_phys / 10, y_phys / 10, priv->x_res, priv->y_res, priv->x_max, priv->y_max);
+
 	return 0;
 }
 

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch2

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 262d1057c1da..f57dca5cecd5 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2476,8 +2476,8 @@ static int alps_update_device_area_ss4_v2(unsigned char otp[][4],
 		priv->y_max =
 			(num_y_electrode - 1) * SS4PLUS_COUNT_PER_ELECTRODE;
 
-		x_pitch = (otp[0][1] & 0x0F) + SS4PLUS_MIN_PITCH_MM;
-		y_pitch = ((otp[0][1] >> 4) & 0x0F) + SS4PLUS_MIN_PITCH_MM;
+		x_pitch = ((otp[1][2] >> 2) & 0x07) + SS4_MIN_PITCH_MM;
+		y_pitch = ((otp[1][2] >> 5) & 0x07) + SS4_MIN_PITCH_MM;
 
 	} else {
 		num_x_electrode =
@@ -2500,6 +2500,11 @@ static int alps_update_device_area_ss4_v2(unsigned char otp[][4],
 	priv->x_res = priv->x_max * 10 / x_phys; /* units / mm */
 	priv->y_res = priv->y_max * 10 / y_phys; /* units / mm */
 
+	psmouse_err(psmouse,
+		    "test2 pitch %dx%d num-electrodes %dx%d physical size %dx%dmm res %dx%d max %dx%d\n",
+		    x_pitch, y_pitch, num_x_electrode, num_y_electrode,
+		    x_phys / 10, y_phys / 10, priv->x_res, priv->y_res, priv->x_max, priv->y_max);
+
 	return 0;
 }
 

--nFreZHaLTZJo0R7j--
