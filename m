From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 03/12] Input: synaptics - fix minimum reported ABS_TOOL_WIDTH
Date: Wed, 29 Jun 2011 14:46:55 -0500
Message-ID: <BANLkTimuYi0UNjJG_mrHE+fF7UDgPSVwbQ@mail.gmail.com>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
	<1309324042-22943-4-git-send-email-djkurtz@chromium.org>
	<BANLkTinX-mkjQ=qMXra5GLeMK+cb9w+9_Q@mail.gmail.com>
	<CAGS+omCXmc-4WXJDeQKY3uo8h7xBgqfZi=rmDHg2xwWK2OQxMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49076 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112Ab1F2Tq4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 15:46:56 -0400
In-Reply-To: <CAGS+omCXmc-4WXJDeQKY3uo8h7xBgqfZi=rmDHg2xwWK2OQxMg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, chase.douglas@canonical.com, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On Wed, Jun 29, 2011 at 11:48 AM, Daniel Kurtz <djkurtz@chromium.org> w=
rote:
> Hi Chris,
>
> Thanks for taking a look!
>
> On Wed, Jun 29, 2011 at 9:28 PM, Chris Bagwell <chris@cnpbagwell.com>=
 wrote:
>> On Wed, Jun 29, 2011 at 12:07 AM, =A0<djkurtz@chromium.org> wrote:
>>> From: Daniel Kurtz <djkurtz@chromium.org>
>>>
>>> Synaptics touchpads report a 'w' value in each data report.
>>> For touchpads that support palm detection, when there is a single f=
inger
>>> on the pad, the 'w' value reports its width in the range 4 to 15.
>>> Thus, the minimum valid width is 4.
>>
>> FYI: I had debated on this as well. =A0When driver was first modifie=
d to
>> report min/max width, the min width of zero was chosen because when
>> not touching the pad a value of zero is forced by driver to user. =A0=
So
>> the range is 0, 4-15.
>
> Yup, good catch. =A0I now see that this is true for the legacy single=
-touch case.
> For consistency with the existing implementation, I'm ok to drop this=
 patch.
>
> I think we can still keep the range 4-15 for the ABS_MT_TOUCH_MAJOR
> axis, though, right?
> A pure-mt userspace app can get the correct width range, and deduce 0
> fingers from the fact that all MT-B slots have tracking_id =3D=3D -1.

Yeah, at least I'd consider it an app bug.

=46or that matter, it should be true of ABS_TOOL_WIDTH as well (we coul=
d
change to always send minimum 4 as apart of this patch).

Since we are on it, maybe a year ago I tested a version of this patch
and notice xf86-input-synaptics defaulted to non-useful value for
EmulateTwoFingerMinW because of the scale change.  The
xf86-input-synaptics logic in question has since be modified/reverted
so I think thats not an issue anymore.

I found no issues with apps see'ing ABS_TOOL_WIDTH >=3D 4 always.

Chris
>
> -Dan
>
>>>
>>> Note: Other values of 'w' are used to report special conditions:
>>> =A0w=3D0: 2 fingers are on the pad
>>> =A0w=3D1: 3 or more fingers are on the pad
>>> =A0w=3D2: the packet contains "Advanced Gesture Mode" data.
>>>
>>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>>> ---
>>> =A0drivers/input/mouse/synaptics.c | =A0 =A02 +-
>>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/=
synaptics.c
>>> index f6d0c04..a4b7801 100644
>>> --- a/drivers/input/mouse/synaptics.c
>>> +++ b/drivers/input/mouse/synaptics.c
>>> @@ -706,7 +706,7 @@ static void set_input_params(struct input_dev *=
dev, struct synaptics_data *priv)
>>> =A0 =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0 =A0if (SYN_CAP_PALMDETECT(priv->capabilities))
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_TOOL_WI=
DTH, 0, 15, 0, 0);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_TOOL_WI=
DTH, 4, 15, 0, 0);
>>>
>>> =A0 =A0 =A0 =A0__set_bit(EV_KEY, dev->evbit);
>>> =A0 =A0 =A0 =A0__set_bit(BTN_TOUCH, dev->keybit);
>>> --
>>> 1.7.3.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-inp=
ut" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
