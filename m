From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Sat, 27 Nov 2010 23:22:56 -0800
Message-ID: <20101128072256.GC14499@core.coreip.homeip.net>
References: <4CEE6D2A.9040408@euromail.se>
 <4CEE6EE8.4060805@gmail.com>
 <AANLkTim3D0w5DzmKU6wckxJT3HeHK8eoMO1Zge1zOWOE@mail.gmail.com>
 <4CF0BC13.2010800@gmail.com>
 <20101127083229.GA28745@core.coreip.homeip.net>
 <4CF0C69D.9080904@gmail.com>
 <20101127091533.GA27213@core.coreip.homeip.net>
 <4CF0D35B.4030807@gmail.com>
 <20101127233901.GA29981@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54026 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab0K1HXF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Nov 2010 02:23:05 -0500
Received: by yxt3 with SMTP id 3so1020629yxt.19
        for <linux-input@vger.kernel.org>; Sat, 27 Nov 2010 23:23:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101127233901.GA29981@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Henrik Rydberg <rydberg@euromail.se>, Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suze.cz>

On Sat, Nov 27, 2010 at 03:39:02PM -0800, Dmitry Torokhov wrote:
> On Sat, Nov 27, 2010 at 12:46:03PM +0300, Nikolai Kondrashov wrote:
> > On 11/27/2010 12:15 PM, Dmitry Torokhov wrote:
> > >2000LPI == about 79 l/mm. How is it not useable?
> > TBH, I didn't make any real calculations.
> > The introduced error isn't very high, indeed. The vertical size of 4x3 inch
> > tablet becomes 75 mm instead of 76 mm. So maybe it's alright.
> > 
> > >In mainline synaptics is the only one that does this. We do not know how
> > >many drivers in vendor trees fill and use this data nor we do not know
> > >about userspace. The fact that we were not able to locate them does not
> > >mean they do not exist. The units/mm are part of input ABI now.
> > Well, I can't argue with you here.
> > I didn't think about 3rd party drivers, TBH.
> > 
> > >Right, standarize on existing UOM (which are per/mm) and then implement
> > >other UOM if theya re really needed.
> > Will this fix qualify for inclusion into 2.6.37?
> 
> Yes, I believe it does.
> 

Does the following work by any chance?

Thanks.

-- 
Dmitry


HID: length resolution should be reported units/mm

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input ABI requires reporting resolution on main axes in units per
millimeter, not units per inch, so we need to convert accordingly.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/hid/hid-input.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)


diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index c9c90de..5cde845 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -203,8 +203,8 @@ static int hidinput_setkeycode(struct input_dev *dev,
  *
  * as seen in the HID specification v1.11 6.2.2.7 Global Items.
  *
- * Only exponent 1 length units are processed. Centimeters are converted to
- * inches. Degrees are converted to radians.
+ * Only exponent 1 length units are processed. Centimeters and inches are
+ * converted to millimeters. Degrees are converted to radians.
  */
 static __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code)
 {
@@ -225,13 +225,16 @@ static __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code)
 	 */
 	if (code == ABS_X || code == ABS_Y || code == ABS_Z) {
 		if (field->unit == 0x11) {		/* If centimeters */
-			/* Convert to inches */
-			prev = logical_extents;
-			logical_extents *= 254;
-			if (logical_extents < prev)
+			/* Convert to millimeters */
+			unit_exponent += 1;
+		} else if (field->unit == 0x13) {	/* If inches */
+			/* Convert to millimeters */
+			prev = physical_extents;
+			physical_extents *= 254;
+			if (physical_extents < prev)
 				return 0;
-			unit_exponent += 2;
-		} else if (field->unit != 0x13) {	/* If not inches */
+			unit_exponent -= 1;
+		} else {
 			return 0;
 		}
 	} else if (code == ABS_RX || code == ABS_RY || code == ABS_RZ) {
