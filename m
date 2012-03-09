From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] input: wacom: Use touch size for ABS_MT_TOUCH_MAJOR
Date: Fri, 9 Mar 2012 16:30:16 -0600
Message-ID: <CAGzDe_Z2Dpc9ue06V8mgc_fUUqSe0gJLwDK0piE156EsXV__7Q@mail.gmail.com>
References: <1331170746-12636-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34282 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964844Ab2CIWaS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Mar 2012 17:30:18 -0500
Received: by lahj13 with SMTP id j13so2163109lah.19
        for <linux-input@vger.kernel.org>; Fri, 09 Mar 2012 14:30:16 -0800 (PST)
In-Reply-To: <1331170746-12636-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Wed, Mar 7, 2012 at 7:39 PM, Jason Gerecke <killertofu@gmail.com> wr=
ote:
> 3rd-gen Bamboo devices report both "amplitude" and "size" data
> in their touch packets. This patch changes the source for
> ABS_MT_TOUCH_MAJOR to be the latter rather than the former.
> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index d0b0fc4..5daf11d 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -916,7 +916,7 @@ static void wacom_bpt3_touch_msg(struct wacom_wac=
 *wacom, unsigned char *data)
> =A0 =A0 =A0 =A0if (touch) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int x =3D (data[2] << 4) | (data[4] >>=
 4);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int y =3D (data[3] << 4) | (data[4] & =
0x0f);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int w =3D data[6];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int w =3D data[5];
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_MT_POSITIO=
N_X, x);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_MT_POSITIO=
N_Y, y);
> --
> 1.7.9.1
>

I found time to test this patch and used "mtview" so I could get some
visual feedback.

The lines because extremely thin with this change.  Part of reason I
quickly traced to we are setting range as 0-255 but I couldn't get
data[5] to go above a value of 18.  So I changed range to 0-16 and it
works better but the lines still never gets very thick (this could
well be that mtview doesn't scale values and prefers 0-255.  I didn't
look).

Amplitude feels better to me using test apps but your in a better
position to say if we should really change this.  Please adjust
declared range though if you still think we should change this.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
