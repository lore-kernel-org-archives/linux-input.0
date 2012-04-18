From: Daniel Kurtz <djkurtz@google.com>
Subject: Re: [PATCH] Driver: HID: hid-apple: Fixed a tab width style issue
Date: Wed, 18 Apr 2012 23:32:37 +0800
Message-ID: <CAGS+omB6a+1+3D1ByU-rR6Xe4uWbeswFJip8rPO8UMj0Pg5Cww@mail.gmail.com>
References: <1334744560-28985-1-git-send-email-bbergenthal@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62855 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab2DRPc6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Apr 2012 11:32:58 -0400
Received: by iagz16 with SMTP id z16so10566816iag.19
        for <linux-input@vger.kernel.org>; Wed, 18 Apr 2012 08:32:57 -0700 (PDT)
In-Reply-To: <1334744560-28985-1-git-send-email-bbergenthal@cern.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benedikt Bergenthal <bbergenthal@cern.ch>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benedikt Bergenthal <benedikt@kdrennert.de>

On Wed, Apr 18, 2012 at 6:22 PM, Benedikt Bergenthal
<bbergenthal@cern.ch> wrote:
>
> From: Benedikt <bbergenthal@cern.ch>
>
> Fixed a style issue.
>
> Signed-off-by: Benedikt Bergenthal <benedikt@kdrennert.de>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
> =A0drivers/hid/hid-apple.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 299d238..7a79e39 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -234,7 +234,7 @@ static int hidinput_apple_event(struct hid_device
> *hid, struct input_dev *input,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0if (iso_layout) {
> + =A0 =A0 =A0 if (iso_layout) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (asc->quirks & APPLE_ISO_KEYBOARD) =
{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0trans =3D apple_find_t=
ranslation(apple_iso_keyboard,
> usage->code);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (trans) {
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

--
Daniel Kurtz=A0|=A0Software Engineer=A0|=A0djkurtz@google.com=A0|=A0650=
=2E204.0722
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
