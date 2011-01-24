From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [2/2] input: wacom - Pass touch resolution to clients through input_absinfo
Date: Mon, 24 Jan 2011 12:09:24 -0800
Message-ID: <AANLkTi=8sDff350GAc+tkqYiTz+BQV6d44EgpUC5ToTC@mail.gmail.com>
References: <1295825201-12567-1-git-send-email-pinglinux@gmail.com>
	<20110124144017.GA4367@polaris.bitmath.org>
	<AANLkTim39y5ZNdzvZ2=sO+sccpUMao3pqxyiv5VW9Ckv@mail.gmail.com>
	<20110124183656.GC17855@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37337 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab1AXUJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jan 2011 15:09:26 -0500
Received: by wyb28 with SMTP id 28so4463197wyb.19
        for <linux-input@vger.kernel.org>; Mon, 24 Jan 2011 12:09:24 -0800 (PST)
In-Reply-To: <20110124183656.GC17855@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Mon, Jan 24, 2011 at 10:36 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Jan 24, 2011 at 10:18:54AM -0800, Ping Cheng wrote:
>> On Mon, Jan 24, 2011 at 6:40 AM, Henrik Rydberg <rydberg@euromail.se=
> wrote:
>> > Hi Ping,
>> >
>> >> @@ -1228,8 +1228,13 @@ void wacom_setup_input_capabilities(struct=
 input_dev *input_dev,
>> >> =A0 =A0 =A0 case TABLETPC:
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type =3D=3D BTN_=
TOOL_DOUBLETAP ||
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D=3D =
BTN_TOOL_TRIPLETAP) {
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(in=
put_dev, ABS_RX, 0, features->x_phy, 0, 0);
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(in=
put_dev, ABS_RY, 0, features->y_phy, 0, 0);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set touch resolution=
 in points/mm */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D features->x_phy=
/100;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input=
_dev, ABS_X,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 features->x_max/res);
>> >
>> > It seems to me the construction above looses precision twice for n=
o
>> > apparent reason.
>>
>> Well, there was a reason (logically instead of mathematically though=
):
>> features->x_phy/100 gives us the physical size of the touch area in
>> mm.
>>
>> > How about instead use "100 * features->x_max /
>> > features->x_phy"?
>>
>> Sure.
>>
>> > Besides, it is a bit unfortunate that "res" is short
>> > for both result and resolution.
>>
>> Resolution is defined as __s32 in input_absinfo. How about we use __=
s32 then?
>
> input_abs_set_res() takes and int argument so keep it int =A0(or just
> embed the expression into the call and forgo 'res').

I added 'res' to avoid confusion hence questions about the formula. I
am still questioned ;).

 I'll forgo 'res' in v2. Thank you for the suggestions.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
