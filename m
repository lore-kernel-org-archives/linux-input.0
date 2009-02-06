From: "hartleys" <hartleys@visionengravers.com>
Subject: RE: [PATCH 1/5] input: New MATRIX_KEY macro
Date: Fri, 6 Feb 2009 16:51:42 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090120BD19@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909011A5466@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og106.obsmtp.com ([64.18.1.191]:50321 "HELO
	exprod6og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753846AbZBFVw1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2009 16:52:27 -0500
Content-class: urn:content-classes:message
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909011A5466@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>

On Thursday, February 05, 2009 6:12 PM, David Brownell wrote:
> On Friday 30 January 2009, hartleys wrote:
>>> I'd support an overall cleanup patch that fixes all those things at=
 once.
>>
>> How's this for a starting point? =A0I'm willing to create a cleanup=20
>> patch for all the mach-omap1, mach-omap2, and mach-pxa users.
>>=20
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>
> I think none of the twl4030 keypad users are in mainline, so far...
>
> My first reaction to this is that it's a bit incomplete.
> It replaces only the KEY() macro in the $SUBJECT patch:
>=20
> - There are two more public ones (for board files):
>     * KEY_PERSISTENT flags row/column values to ignore
>     * PERSISTENT_KEY (sigh) generates a row/col entry
>       with such a marking (instead of a keycode)
> - Plus two driver-internal ones:
>     * ROWCOL_MASK to strip R/C from KEY()
>     * KEYCODE_MASK to stip the keycode from a KEY()
>
> If there is going to be something reusable across the whole input
> subsystem (for drivers that don't need fancy stuff), it should
> really address the whole problem...
>

Hello Dave,

I'm responding to your comments through a different thread since I post=
ed a patch series to handle this change.

It appeared to me that only the KEY macro was common for the two keypad=
 drivers that are currently in mainline.

It does appear the two mask values should be added to input.h for compl=
eteness.

#define MATRIX_ROWCOL_MASK	0xff000000
#define MATRIX_KEYCODE_MASK	0x00ffffff

I wasn't quite sure what the KEY_PERSISTENT flag was for in your twl403=
0_keypad driver.  To me it seemed driver dependent and not generic.

Regards,
Hartley



-----Original Message-----
=46rom: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vge=
r.kernel.org] On Behalf Of hartleys
Sent: Friday, January 30, 2009 11:46 AM
To: linux-input@vger.kernel.org
Subject: [PATCH 1/5] input: New MATRIX_KEY macro

Introduce new macro to input.h for packing matrix keypad keycodes.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/include/linux/input.h b/include/linux/input.h index 1249a0=
c..0879493 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -598,6 +598,14 @@ struct input_absinfo {
 #define KEY_CNT			(KEY_MAX+1)

 /*
+ * Macro to pack the row/col of a key on a matrix keypad and it's
associated
+ * KEY_* code into into an array.  4 bits are used for both the row an=
d
column
+ * allowing for up to a 16x16 keypad.  The row (_r) and column (_c) ar=
e
+ * interchangable depending on a keypad drivers usage.
+ */
+#define MATRIX_KEY(_r, _c, _v)	(((_r) << 28) | ((_c) << 24) | (_v))
+
+/*
  * Relative axes
  */
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in the body of a message to majordomo@vger.kernel.org More majordomo in=
fo at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
