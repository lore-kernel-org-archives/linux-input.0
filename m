From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 3/4] input: wacom - Add support for Bamboo Pen
Date: Thu, 9 Sep 2010 22:02:22 -0500
Message-ID: <AANLkTi=vtaV09riva-5Gb7kDtnsjcc8mRMq88RVFuJZQ@mail.gmail.com>
References: <1284004952-12701-1-git-send-email-chris@cnpbagwell.com>
	<1284004952-12701-4-git-send-email-chris@cnpbagwell.com>
	<20100909041422.GA11747@core.coreip.homeip.net>
	<AANLkTikSPnNvUehFi4g=WN6QNnJZ2Y0Rz_fdq=jgCxeh@mail.gmail.com>
	<20100909214630.GA29485@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59703 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab0IJDCY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Sep 2010 23:02:24 -0400
Received: by ywh1 with SMTP id 1so920948ywh.19
        for <linux-input@vger.kernel.org>; Thu, 09 Sep 2010 20:02:23 -0700 (PDT)
In-Reply-To: <20100909214630.GA29485@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, pingc@wacom.com

Ping would you be able to comment on question at end?

On Thu, Sep 9, 2010 at 4:46 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Sep 09, 2010 at 04:34:35PM -0500, Chris Bagwell wrote:
>> On Wed, Sep 8, 2010 at 11:14 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Wed, Sep 08, 2010 at 11:02:31PM -0500, chris@cnpbagwell.com wro=
te:
>> >> From: Chris Bagwell <chris@cnpbagwell.com>
>> >>
>> >> This adds support for Pen on Bamboo Pen and Bamboo Pen&Touch
>> >> devices. =A0Touchpad is handled by previous Bamboo Touch
>> >> logic.
>> >>
>> >> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
>> >> ---
>> >> =A0drivers/input/tablet/wacom_wac.c | =A0 75 ++++++++++++++++++++=
++++++++++++++++++
>> >> =A01 files changed, 75 insertions(+), 0 deletions(-)
>> >>
>> >> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tab=
let/wacom_wac.c
>> >> index 2f7ed9a..9cc0cf0 100644
>> >> --- a/drivers/input/tablet/wacom_wac.c
>> >> +++ b/drivers/input/tablet/wacom_wac.c
>> >> @@ -904,10 +904,71 @@ static int wacom_bpt_touch(struct wacom_wac=
 *wacom)
>> >> =A0 =A0 =A0 return 0;
>> >> =A0}
>> >>
>> >> +static int wacom_bpt_pen(struct wacom_wac *wacom)
>> >> +{
>> >> + =A0 =A0 struct input_dev *input =3D wacom->input;
>> >> + =A0 =A0 unsigned char *data =3D wacom->data;
>> >> + =A0 =A0 int prox =3D 0, x =3D 0, y =3D 0, p =3D 0, d =3D 0, pen=
 =3D 0, btn1 =3D 0, btn2 =3D 0;
>> >> +
>> >> + =A0 =A0 prox =3D (data[1] & 0x10) && (data[1] & 0x20);
>> >
>> > =A0 =A0 =A0 =A0prox =3D (data[1] & 0x30) =3D=3D 0x30;
>> >
>> > ?
>> >
>> > --
>> > Dmitry
>> >
>>
>>
>> Agree thats faster to understand. =A0I'll update patch and resend so=
on.
>>
>
> I am just curious - why is it that _both_ bits should be set for the =
tools
> to be considered "in proximity"?..
>

Below is my guess and these values ultimately came from Ping's driver.

The Bamboo Pen protocol seems to be derived from Graphire protocol.
Based on that, they also use 3 bits from data[1] in this area.  1 bit
for in-proximity and 2 bits for a tool ID of what's being reported
(pen vs. eraser vs mouse).

Although these 3 bits order are slightly different between two
protocols, it looks roughly the same to me.  0x20 for in proximity and
0x10 for pen ID and 0x11 for eraser ID.

The 0x30 check would boil down to simplest safety check for unknown ID'=
s.

Ping, if you could confirm this I would be happy to document bit
meaning in patch update.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
