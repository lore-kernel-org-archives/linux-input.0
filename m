From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] Input: synaptics - reject out of range position values
Date: Fri, 8 Jun 2012 00:56:39 +0800
Message-ID: <CAGS+omBQ0PLvjRFVWrSSm1v3fegO5V968s7kLT3hGj3+Bhoebg@mail.gmail.com>
References: <1337353224-12333-1-git-send-email-seth.forshee@canonical.com> <20120606153538.GC23884@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52523 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194Ab2FGQ5E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jun 2012 12:57:04 -0400
Received: by yhmm54 with SMTP id m54so592810yhm.19
        for <linux-input@vger.kernel.org>; Thu, 07 Jun 2012 09:57:01 -0700 (PDT)
In-Reply-To: <20120606153538.GC23884@thinkpad-t410>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, Jun 6, 2012 at 11:35 PM, Seth Forshee
<seth.forshee@canonical.com> wrote:
> Ping. Any problem with this patch?
>
> On Fri, May 18, 2012 at 10:00:24AM -0500, Seth Forshee wrote:
>> The synaptics touchpad on the Acer Aspire One D250 will report y
>> coordinate values in excess of 8000 near the bottom of the touchpad,
>> well outside of the range of values that the synaptics documentation
>> says should be reported.
>>
>> In addition, the y values abruptly change from very low values to th=
ese
>> very high values. After the calculation to invert the y coordinates,
>> userspace gets y coordinates that can jump suddenly between large
>> positive and moderately large negative values, causing sudden jumps =
in
>> the pointer position.
>>
>> To work around this odd behavior, reject any coordinates with values
>> outside of absolute limits specified by Synaptics, which is 6143 for
>> both axes.
>>
>> BugLink: http://bugs.launchpad.net/bugs/1001251
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
>> ---
>> I'm not sure whether the limits here should be the hard-coded value =
or
>> the coordinates reported by the device when that's supported (i.e.
>> whether the coordinates reported by the device are always within the
>> range of 0 to 6143). If the latter is more appropriate I can modify =
the
>> patch to use the device-reported values and fall back to the hard-co=
ded
>> values.

Hi Seth,

The patch seems to do what it says it is doing, but perhaps we can do
a little better?  The problem is, it would make fingers at the bottom
of the pad simply disappear, which may not be a great user experience,
either.

Do you have access to the hardware?
What is the y value reported at the top of the pad?
Also, what are the max & min values reported by your device when querie=
d?
  Do they match the values that are actually reported?

Judging just from your comments, it sounds like the trackpad might be
wrapping around, and trying to report "negative" 13-bit numbers near
the bottom.

0x17FF =3D 6143
=2E..
0x0000 =3D 0 =3D 0
0x1FFF =3D 8191 =3D -1
=2E..
0x1F40 =3D 8000 =3D -192

Perhaps we can do this for your pad:
 y =3D (y + 0x0800) & 0x1FFF;

Which would make those negative values positive.

Or, alternatively, we could actually report negative values to
userspace in this case:

y =3D (y <=3D 6143) ? y : (y - 8192);

-Daniel

>>
>> =A0drivers/input/mouse/synaptics.c | =A0 =A05 +++++
>> =A01 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/s=
ynaptics.c
>> index e07eb9b..f62299d 100644
>> --- a/drivers/input/mouse/synaptics.c
>> +++ b/drivers/input/mouse/synaptics.c
>> @@ -40,6 +40,8 @@
>> =A0 * Note that newer firmware allows querying device for maximum us=
eable
>> =A0 * coordinates.
>> =A0 */
>> +#define XMAX 6143
>> +#define YMAX 6143
>> =A0#define XMIN_NOMINAL 1472
>> =A0#define XMAX_NOMINAL 5472
>> =A0#define YMIN_NOMINAL 1408
>> @@ -555,6 +557,9 @@ static int synaptics_parse_hw_state(const unsign=
ed char buf[],
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw->right =3D (buf[0] & 0x02) ? 1 : 0;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (hw->x > XMAX || hw->y > YMAX)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> +
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
