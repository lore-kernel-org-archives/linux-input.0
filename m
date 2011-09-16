From: Michael Tandy <lkml@mjt.me.uk>
Subject: Re: ADXL34x.h minor documentation cleanup patch
Date: Fri, 16 Sep 2011 20:27:57 +0100
Message-ID: <CAHGSkqg3mHTJJBP0SiizpWJkfDSiGSYpBCd_mv5f3kgBU4Se7g@mail.gmail.com>
References: <CAHGSkqjkQUOPt_5-Xkxtn+HUK69_dwSxx+dyjsbWxRo8MvCRSw@mail.gmail.com>
	<544AC56F16B56944AEC3BD4E3D59177146E7206223@LIMKCMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f43.google.com ([209.85.215.43]:63323 "EHLO
	mail-ew0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932155Ab1IPTjD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 15:39:03 -0400
Received: by ewy20 with SMTP id 20so3017382ewy.2
        for <linux-input@vger.kernel.org>; Fri, 16 Sep 2011 12:39:01 -0700 (PDT)
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177146E7206223@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

diff --git a/include/linux/input/adxl34x.h b/include/linux/input/adxl34=
x.h
index df00d99..538e5d5 100644
--- a/include/linux/input/adxl34x.h
+++ b/include/linux/input/adxl34x.h
@@ -30,8 +30,9 @@ struct adxl34x_platform_data {
        * Y, or Z participation in Tap detection. A '0' excludes the
        * selected axis from participation in Tap detection.
        * Setting the SUPPRESS bit suppresses Double Tap detection if
-        * acceleration greater than tap_threshold is present between
-        * taps.
+        * acceleration greater than tap_threshold is present during th=
e
+        * tap_latency period, i.e. after the first tap but before the
+        * opening of the second tap window.
        */

 #define ADXL_SUPPRESS  (1 << 3)
@@ -226,13 +227,13 @@ struct adxl34x_platform_data {
        * detection will begin and prevent the detection of activity. T=
his
        * bit serially links the activity and inactivity functions. Whe=
n '0'
        * the inactivity and activity functions are concurrent. Additio=
nal
-        * information can be found in the Application section under Li=
nk
-        * Mode.
+        * information can be found in the ADXL34x datasheet's Applicat=
ion
+        * section under Link Mode.
        * AUTO_SLEEP: A '1' sets the ADXL34x to switch to Sleep Mode
        * when inactivity (acceleration has been below inactivity_thres=
hold
        * for at least inactivity_time) is detected and the LINK bit is=
 set.
-        * A '0' disables automatic switching to Sleep Mode. See SLEEP
-        * for further description.
+        * A '0' disables automatic switching to Sleep Mode. See the
+        * Sleep Bit section of the ADXL34x datasheet for more informat=
ion.
        */

 #define ADXL_LINK      (1 << 5)
@@ -266,6 +267,13 @@ struct adxl34x_platform_data {

       u8 watermark;

+       /*
+        * When acceleration measurements are received from the ADXL34x
+        * events are sent to the event subsystem. The following settin=
gs
+        * select the event type and event code for new x, y and z axis=
 data
+        * respectively.
+        */
+
       u32 ev_type;    /* EV_ABS or EV_REL */

       u32 ev_code_x;  /* ABS_X,Y,Z or REL_X,Y,Z */
@@ -289,7 +297,7 @@ struct adxl34x_platform_data {
       u32 ev_code_act_inactivity;     /* EV_KEY */

       /*
-        * Use ADXL34x INT2 instead of INT1
+        * Use ADXL34x INT2 pin instead of INT1 pin for interrupt outpu=
t
        */
       u8 use_int2;

Signed-off-by: Michael Tandy <lkml@mkt.me.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>


On 16 September 2011 20:07, Hennerich, Michael
<Michael.Hennerich@analog.com> wrote:
> Michael Tandy wrote on 2011-09-16:
>> The attached patch just clarifies a few bits of documentation in the
>> header file for the adxl34x header file. Do let me know what you thi=
nk.
>>
>> Thanks,
>>
>> Michael Tandy
>
> Hi Michael,
>
> Looks good. Feel free to send on.
>
> TO: dmitry.torokhov@gmail.com
> CC: linux-input@vger.kernel.org
>
> Signed-off-by: Michael Tandy <lkml@mkt.me.uk>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
>
>
>>
>> diff --git a/include/linux/input/adxl34x.h
>> b/include/linux/input/adxl34x.h index df00d99..538e5d5 100644 ---
>> a/include/linux/input/adxl34x.h +++ b/include/linux/input/adxl34x.h =
@@
>> -30,8 +30,9 @@ struct adxl34x_platform_data {
>> =A0 =A0 =A0 =A0* Y, or Z participation in Tap detection. A '0' exclu=
des the
>> =A0 =A0 =A0 =A0* selected axis from participation in Tap detection.
>> =A0 =A0 =A0 =A0* Setting the SUPPRESS bit suppresses Double Tap dete=
ction if
>> - =A0 =A0 =A0* acceleration greater than tap_threshold is present be=
tween
>> - =A0 =A0 =A0* taps.
>> + =A0 =A0 =A0* acceleration greater than tap_threshold is present du=
ring the
>> + =A0 =A0 =A0* tap_latency period, i.e. after the first tap but befo=
re the
>> + =A0 =A0 =A0* opening of the second tap window.
>> =A0 =A0 =A0 =A0*/
>>
>> =A0#define ADXL_SUPPRESS =A0 =A0 =A0 =A0(1 << 3) @@ -226,13 +227,13 =
@@ struct
>> =A0adxl34x_platform_data { =A0 =A0 =A0 * detection will begin and pr=
event the
>> =A0detection of activity. This =A0 * bit serially links the activity=
 and
>> =A0inactivity functions. When '0' =A0 =A0 =A0 =A0* the inactivity an=
d activity
>> =A0functions are concurrent.
>> Additional - =A0 * information can be found in the Application secti=
on
>> under Link - =A0 * Mode. + =A0 =A0 =A0 * information can be found in=
 the ADXL34x
>> datasheet's Application + =A0 =A0 =A0* section under Link Mode.
>> =A0 =A0 =A0 =A0* AUTO_SLEEP: A '1' sets the ADXL34x to switch to Sle=
ep Mode =A0 =A0* when
>> =A0inactivity (acceleration has been below inactivity_threshold =A0 =
=A0 =A0 =A0 =A0* for at
>> =A0least inactivity_time) is detected and the LINK bit is
>> set.
>> - =A0 =A0 =A0* A '0' disables automatic switching to Sleep Mode. See=
 SLEEP
>> - =A0 =A0 =A0* for further description.
>> + =A0 =A0 =A0* A '0' disables automatic switching to Sleep Mode. See=
 the
>> + =A0 =A0 =A0* Sleep Bit section of the ADXL34x datasheet for more
>> information.
>> =A0 =A0 =A0 =A0*/
>>
>> =A0#define ADXL_LINK =A0 =A0(1 << 5)
>> @@ -266,6 +267,13 @@ struct adxl34x_platform_data {
>>
>> =A0 =A0 =A0 u8 watermark;
>> + =A0 =A0 /* + =A0 =A0 * When acceleration measurements are received=
 from the ADXL34x
>> + =A0 =A0 =A0* events are sent to the event subsystem. The following=
 settings + =A0 =A0 =A0*
>> select the event type and event code for new x, y and z axis data + =
=A0 =A0*
>> respectively. + =A0 =A0 =A0 =A0*/ +
>> =A0 =A0 =A0 u32 ev_type; =A0 =A0/* EV_ABS or EV_REL */
>>
>> =A0 =A0 =A0 u32 ev_code_x; =A0/* ABS_X,Y,Z or REL_X,Y,Z */ @@ -289,7=
 +297,7 @@ struct
>> =A0adxl34x_platform_data { =A0 =A0 =A0u32 ev_code_act_inactivity; =A0=
 =A0 /* EV_KEY */
>>
>> =A0 =A0 =A0 /*
>> - =A0 =A0 =A0* Use ADXL34x INT2 instead of INT1
>> + =A0 =A0 =A0* Use ADXL34x INT2 pin instead of INT1 pin for interrup=
t output
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 u8 use_int2;
>> Signed-off-by: Michael Tandy <lkml@mkt.me.uk>
>
> Greetings,
> Michael
>
> --
> Analog Devices GmbH =A0 =A0 =A0Wilhelm-Wagenfeld-Str. 6 =A0 =A0 =A080=
807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
> Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Marti=
n, Margaret Seif
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
