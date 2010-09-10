From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 3/4] input: wacom - Add support for Bamboo Pen
Date: Fri, 10 Sep 2010 10:28:51 +0200
Message-ID: <AANLkTimwTpQUR=xdvD_W+whO=5RKBM+AigjGK2_3CKUH@mail.gmail.com>
References: <1284004952-12701-1-git-send-email-chris@cnpbagwell.com>
	<1284004952-12701-4-git-send-email-chris@cnpbagwell.com>
	<20100909041422.GA11747@core.coreip.homeip.net>
	<AANLkTikSPnNvUehFi4g=WN6QNnJZ2Y0Rz_fdq=jgCxeh@mail.gmail.com>
	<20100909214630.GA29485@core.coreip.homeip.net>
	<AANLkTi=vtaV09riva-5Gb7kDtnsjcc8mRMq88RVFuJZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:36820 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645Ab0IJI2x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Sep 2010 04:28:53 -0400
Received: by wwb34 with SMTP id 34so150245wwb.1
        for <linux-input@vger.kernel.org>; Fri, 10 Sep 2010 01:28:52 -0700 (PDT)
In-Reply-To: <AANLkTi=vtaV09riva-5Gb7kDtnsjcc8mRMq88RVFuJZQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "pingc@wacom.com" <pingc@wacom.com>

On Friday, September 10, 2010, Chris Bagwell <chris@cnpbagwell.com> wro=
te:
> Ping would you be able to comment on question at end?
>
> On Thu, Sep 9, 2010 at 4:46 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Thu, Sep 09, 2010 at 04:34:35PM -0500, Chris Bagwell wrote:
>>> On Wed, Sep 8, 2010 at 11:14 PM, Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>> > On Wed, Sep 08, 2010 at 11:02:31PM -0500, chris@cnpbagwell.com wr=
ote:
>>> >> From: Chris Bagwell <chris@cnpbagwell.com>
>>> >>
>>> >> This adds support for Pen on Bamboo Pen and Bamboo Pen&Touch
>>> >> devices. =A0Touchpad is handled by previous Bamboo Touch
>>> >> logic.
>>> >>
>>> >> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
>>> >> ---
>>> >> =A0drivers/input/tablet/wacom_wac.c | =A0 75 +++++++++++++++++++=
+++++++++++++++++++
>>> >> =A01 files changed, 75 insertions(+), 0 deletions(-)
>>> >>
>>> >> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/ta=
blet/wacom_wac.c
>>> >> index 2f7ed9a..9cc0cf0 100644
>>> >> --- a/drivers/input/tablet/wacom_wac.c
>>> >> +++ b/drivers/input/tablet/wacom_wac.c
>>> >> @@ -904,10 +904,71 @@ static int wacom_bpt_touch(struct wacom_wa=
c *wacom)
>>> >> =A0 =A0 =A0 return 0;
>>> >> =A0}
>>> >>
>>> >> +static int wacom_bpt_pen(struct wacom_wac *wacom)
>>> >> +{
>>> >> + =A0 =A0 struct input_dev *input =3D wacom->input;
>>> >> + =A0 =A0 unsigned char *data =3D wacom->data;
>>> >> + =A0 =A0 int prox =3D 0, x =3D 0, y =3D 0, p =3D 0, d =3D 0, pe=
n =3D 0, btn1 =3D 0, btn2 =3D 0;
>>> >> +
>>> >> + =A0 =A0 prox =3D (data[1] & 0x10) && (data[1] & 0x20);
>>> >
>>> > =A0 =A0 =A0 =A0prox =3D (data[1] & 0x30) =3D=3D 0x30;
>>> >
>
> The 0x30 check would boil down to simplest safety check for unknown I=
D's.
>
> Ping, if you could confirm this I would be happy to document bit
> meaning in patch update.

I do not remember the detail of this protocol off the top of my head.
And I can not access it in the next 2 weeks. I feel Chris is right.
However, if reverse engineering does confirm your comments, you'll
have to wait.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
