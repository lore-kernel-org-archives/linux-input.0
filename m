From: Christopher Hudson <chris.hudson.comp.eng@gmail.com>
Subject: Re: [PATCH] input:Misc changes against kxtj9 v5 patch
Date: Wed, 6 Jul 2011 11:58:41 -0400
Message-ID: <CAB7Re7Vfu4dk+mizH=fzTsYW69MpFi-WeKFocH8t8AuFR7vW3w@mail.gmail.com>
References: <1309895754-5441-1-git-send-email-chris.hudson.comp.eng@gmail.com>
	<20110705200548.GB15876@core.coreip.homeip.net>
	<CAB7Re7XDB6Rmckxidgr+90Br5LhYk_5Pi_JQXTLd9QS2V+Vm0A@mail.gmail.com>
	<20110705203502.GC15876@core.coreip.homeip.net>
	<CAB7Re7VPsfTebXj1xFNR3YpSpGGVn82OHjusGPTxMo-r23z6vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45563 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754Ab1GFP6m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jul 2011 11:58:42 -0400
Received: by pzk9 with SMTP id 9so53448pzk.19
        for <linux-input@vger.kernel.org>; Wed, 06 Jul 2011 08:58:41 -0700 (PDT)
In-Reply-To: <CAB7Re7VPsfTebXj1xFNR3YpSpGGVn82OHjusGPTxMo-r23z6vA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>, linux-input@vger.kernel.org

On Wed, Jul 6, 2011 at 11:42 AM, Christopher Hudson
<chris.hudson.comp.eng@gmail.com> wrote:
> On Tue, Jul 5, 2011 at 4:35 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Tue, Jul 05, 2011 at 04:19:32PM -0400, Christopher Hudson wrote:
>>> On Tue, Jul 5, 2011 at 4:05 PM, Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>> > On Tue, Jul 05, 2011 at 03:55:54PM -0400, chris.hudson.comp.eng@g=
mail.com wrote:
>>> >> From: Chris Hudson <chudson@kionix.com>
>>> >>
>>> >> As requested, miscellaneous changes originally suggested by Jona=
than Cameron,
>>> >> patched against the original kxtj9 v5 patch.
>>> >>
>>> >> Signed-off-by: Chris Hudson <chudson@kionix.com>
>>> >> ---
>>> >> =A0drivers/input/misc/kxtj9.c =A0| =A0 38 +++++++++++++---------=
----------------
>>> >> =A0include/linux/input/kxtj9.h | =A0 10 +---------
>>> >> =A02 files changed, 14 insertions(+), 34 deletions(-)
>>> >>
>>> >> diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxt=
j9.c
>>> >> index 7faf155..b2da841 100644
>>> >> --- a/drivers/input/misc/kxtj9.c
>>> >> +++ b/drivers/input/misc/kxtj9.c
>>> >> @@ -71,6 +71,15 @@ static const struct {
>>> >> =A0 =A0 =A0 { 0, =A0 =A0ODR12_5F},
>>> >> =A0};
>>> >>
>>> >> +static const struct {
>>> >> + =A0 =A0 u8 g_range;
>>> >> + =A0 =A0 u8 shift;
>>> >> +} kxtj9_range[] =3D {
>>> >> + =A0 =A0 { 0, =A0 =A0 =A0 =A0 =A0 =A04 }, =A0 =A0/* +/-2g */
>>> >> + =A0 =A0 { (1 << 3), =A0 =A0 3 }, =A0 =A0/* +/-4g */
>>> >> + =A0 =A0 { (1 << 4), =A0 =A0 2 }, =A0 =A0/* +/-8g */
>>> >> +};
>>> >> +
>>> >> =A0struct kxtj9_data {
>>> >> =A0 =A0 =A0 struct i2c_client *client;
>>> >> =A0 =A0 =A0 struct kxtj9_platform_data pdata;
>>> >> @@ -129,25 +138,9 @@ static void kxtj9_report_acceleration_data(=
struct kxtj9_data *tj9)
>>> >>
>>> >> =A0static int kxtj9_update_g_range(struct kxtj9_data *tj9, u8 ne=
w_g_range)
>>> >> =A0{
>>> >> - =A0 =A0 switch (new_g_range) {
>>> >> - =A0 =A0 case KXTJ9_G_2G:
>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 tj9->shift =3D SHIFT_ADJ_2G;
>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> >> -
>>> >> - =A0 =A0 case KXTJ9_G_4G:
>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 tj9->shift =3D SHIFT_ADJ_4G;
>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> >> -
>>> >> - =A0 =A0 case KXTJ9_G_8G:
>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 tj9->shift =3D SHIFT_ADJ_8G;
>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> >> -
>>> >> - =A0 =A0 default:
>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>> >> - =A0 =A0 }
>>> >> -
>>> >> + =A0 =A0 tj9->shift =3D kxtj9_range[new_g_range].shift;
>>> >
>>> > This is not safe, you still need to sanitize input to make sure y=
ou do
>>> > not go beyond array boundaries.
>>>
>>> Oops...would a simple
>>> if (new_g_range > 2)
>>> =A0 =A0 =A0 =A0 return -EINVAL;
>>> do the trick?
>>
>> Or "if (new_g_range >=3D ARRAY_SIZE(kxtj9_range)) ..."
>>
>> However, why do we use indices instead of values? I.e. why don't we
>> allow users to specify 2, 4 and 8 in platform data and use array to
>> validate the supplied value and return -EINVAL if this value is not
>> found?
>
> Before we were allowing the user to specify KXTJ9_G_2G, etc, which
> were bitmasks that represented each available g-range. =A0I think
> Jonathan's intent was to optimize/clean up the update_g_range
> function, but I just couldn't figure out the most efficient way to do
> this. =A0It seems that just replacing the globally defined shift
> variables with their numerical counterparts within the update_g_range
> function probably gives us the best combination of efficiency and
> ease-of-use.

My apologies I meant to include the following revised version:

Signed-off-by: Chris Hudson <chudson@kionix.com>
---
 drivers/input/misc/kxtj9.c  |   18 +++++-------------
 include/linux/input/kxtj9.h |    5 -----
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index 7faf155..4cfce82 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -131,17 +131,14 @@ static int kxtj9_update_g_range(struct
kxtj9_data *tj9, u8 new_g_range)
 {
 	switch (new_g_range) {
 	case KXTJ9_G_2G:
-		tj9->shift =3D SHIFT_ADJ_2G;
+		tj9->shift =3D 4;
 		break;
-
 	case KXTJ9_G_4G:
-		tj9->shift =3D SHIFT_ADJ_4G;
+		tj9->shift =3D 3;
 		break;
-
 	case KXTJ9_G_8G:
-		tj9->shift =3D SHIFT_ADJ_8G;
+		tj9->shift =3D 2;
 		break;
-
 	default:
 		return -EINVAL;
 	}
@@ -181,13 +178,8 @@ static int kxtj9_update_odr(struct kxtj9_data
*tj9, int poll_interval)

 static int kxtj9_device_power_on(struct kxtj9_data *tj9)
 {
-	int err;
-
-	if (tj9->pdata.power_on) {
-		err =3D tj9->pdata.power_on();
-		if (err < 0)
-			return err;
-	}
+	if (tj9->pdata.power_on)
+		return tj9->pdata.power_on();

 	return 0;
 }
diff --git a/include/linux/input/kxtj9.h b/include/linux/input/kxtj9.h
index cc5928b..2575205 100644
--- a/include/linux/input/kxtj9.h
+++ b/include/linux/input/kxtj9.h
@@ -22,11 +22,6 @@

 #define KXTJ9_I2C_ADDR		0x0F

-/* These shift values are used to provide consistent output data */
-#define SHIFT_ADJ_2G		4
-#define SHIFT_ADJ_4G		3
-#define SHIFT_ADJ_8G		2
-
 #ifdef __KERNEL__
 struct kxtj9_platform_data {
 	int poll_interval;	/* current poll interval (in milli-seconds) */
--=20
1.5.4.3
>
>>
>> --
>> Dmitry
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
