From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] input: wacom: Fix 3rd-gen Bamboo MT when 4+ fingers are
 in use
Date: Tue, 6 Mar 2012 08:52:35 -0600
Message-ID: <CAGzDe_YXovOj_JkGfusCz4qtnkYyrXQ_J2Zq4uJOpAkR47MxYg@mail.gmail.com>
References: <1331000497-10439-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46596 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030772Ab2CFOwh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Mar 2012 09:52:37 -0500
Received: by lahj13 with SMTP id j13so6099436lah.19
        for <linux-input@vger.kernel.org>; Tue, 06 Mar 2012 06:52:35 -0800 (PST)
In-Reply-To: <1331000497-10439-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Opps.  The comment two lines below patch even says max count is 7.

Acked-by: Chris Bagwell <chris@cnpbagwell.com>

Chris

On Mon, Mar 5, 2012 at 8:21 PM, Jason Gerecke <killertofu@gmail.com> wr=
ote:
> The message count field uses three bits of storage, not two.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 9283507..d0b0fc4 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -938,7 +938,7 @@ static int wacom_bpt3_touch(struct wacom_wac *wac=
om)
> =A0{
> =A0 =A0 =A0 =A0struct input_dev *input =3D wacom->input;
> =A0 =A0 =A0 =A0unsigned char *data =3D wacom->data;
> - =A0 =A0 =A0 int count =3D data[1] & 0x03;
> + =A0 =A0 =A0 int count =3D data[1] & 0x07;
> =A0 =A0 =A0 =A0int i;
>
> =A0 =A0 =A0 =A0if (data[0] !=3D 0x02)
> --
> 1.7.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
