From: Christopher Hudson <chris.hudson.comp.eng@gmail.com>
Subject: Re: [PATCH] input:Misc changes against kxtj9 v5 patch
Date: Wed, 6 Jul 2011 11:42:57 -0400
Message-ID: <CAB7Re7VPsfTebXj1xFNR3YpSpGGVn82OHjusGPTxMo-r23z6vA@mail.gmail.com>
References: <1309895754-5441-1-git-send-email-chris.hudson.comp.eng@gmail.com>
	<20110705200548.GB15876@core.coreip.homeip.net>
	<CAB7Re7XDB6Rmckxidgr+90Br5LhYk_5Pi_JQXTLd9QS2V+Vm0A@mail.gmail.com>
	<20110705203502.GC15876@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:49266 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345Ab1GFPm7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jul 2011 11:42:59 -0400
Received: by yia27 with SMTP id 27so27280yia.19
        for <linux-input@vger.kernel.org>; Wed, 06 Jul 2011 08:42:59 -0700 (PDT)
In-Reply-To: <20110705203502.GC15876@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>, linux-input@vger.kernel.org

On Tue, Jul 5, 2011 at 4:35 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Jul 05, 2011 at 04:19:32PM -0400, Christopher Hudson wrote:
>> On Tue, Jul 5, 2011 at 4:05 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Tue, Jul 05, 2011 at 03:55:54PM -0400, chris.hudson.comp.eng@gm=
ail.com wrote:
>> >> From: Chris Hudson <chudson@kionix.com>
>> >>
>> >> As requested, miscellaneous changes originally suggested by Jonat=
han Cameron,
>> >> patched against the original kxtj9 v5 patch.
>> >>
>> >> Signed-off-by: Chris Hudson <chudson@kionix.com>
>> >> ---
>> >> =A0drivers/input/misc/kxtj9.c =A0| =A0 38 +++++++++++++----------=
---------------
>> >> =A0include/linux/input/kxtj9.h | =A0 10 +---------
>> >> =A02 files changed, 14 insertions(+), 34 deletions(-)
>> >>
>> >> diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj=
9.c
>> >> index 7faf155..b2da841 100644
>> >> --- a/drivers/input/misc/kxtj9.c
>> >> +++ b/drivers/input/misc/kxtj9.c
>> >> @@ -71,6 +71,15 @@ static const struct {
>> >> =A0 =A0 =A0 { 0, =A0 =A0ODR12_5F},
>> >> =A0};
>> >>
>> >> +static const struct {
>> >> + =A0 =A0 u8 g_range;
>> >> + =A0 =A0 u8 shift;
>> >> +} kxtj9_range[] =3D {
>> >> + =A0 =A0 { 0, =A0 =A0 =A0 =A0 =A0 =A04 }, =A0 =A0/* +/-2g */
>> >> + =A0 =A0 { (1 << 3), =A0 =A0 3 }, =A0 =A0/* +/-4g */
>> >> + =A0 =A0 { (1 << 4), =A0 =A0 2 }, =A0 =A0/* +/-8g */
>> >> +};
>> >> +
>> >> =A0struct kxtj9_data {
>> >> =A0 =A0 =A0 struct i2c_client *client;
>> >> =A0 =A0 =A0 struct kxtj9_platform_data pdata;
>> >> @@ -129,25 +138,9 @@ static void kxtj9_report_acceleration_data(s=
truct kxtj9_data *tj9)
>> >>
>> >> =A0static int kxtj9_update_g_range(struct kxtj9_data *tj9, u8 new=
_g_range)
>> >> =A0{
>> >> - =A0 =A0 switch (new_g_range) {
>> >> - =A0 =A0 case KXTJ9_G_2G:
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 tj9->shift =3D SHIFT_ADJ_2G;
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> -
>> >> - =A0 =A0 case KXTJ9_G_4G:
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 tj9->shift =3D SHIFT_ADJ_4G;
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> -
>> >> - =A0 =A0 case KXTJ9_G_8G:
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 tj9->shift =3D SHIFT_ADJ_8G;
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> -
>> >> - =A0 =A0 default:
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> >> - =A0 =A0 }
>> >> -
>> >> + =A0 =A0 tj9->shift =3D kxtj9_range[new_g_range].shift;
>> >
>> > This is not safe, you still need to sanitize input to make sure yo=
u do
>> > not go beyond array boundaries.
>>
>> Oops...would a simple
>> if (new_g_range > 2)
>> =A0 =A0 =A0 =A0 return -EINVAL;
>> do the trick?
>
> Or "if (new_g_range >=3D ARRAY_SIZE(kxtj9_range)) ..."
>
> However, why do we use indices instead of values? I.e. why don't we
> allow users to specify 2, 4 and 8 in platform data and use array to
> validate the supplied value and return -EINVAL if this value is not
> found?

Before we were allowing the user to specify KXTJ9_G_2G, etc, which
were bitmasks that represented each available g-range.  I think
Jonathan's intent was to optimize/clean up the update_g_range
function, but I just couldn't figure out the most efficient way to do
this.  It seems that just replacing the globally defined shift
variables with their numerical counterparts within the update_g_range
function probably gives us the best combination of efficiency and
ease-of-use.

>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
