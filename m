From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH] HID: wiimote: fix weight conversion error for values > 17kg
Date: Mon, 17 Sep 2012 23:08:25 +0200
Message-ID: <CANq1E4R5-B-9EcPN6B7sqvATZNphXKMEZwSznt_DEiKKgA1_3w@mail.gmail.com>
References: <alpine.DEB.2.02.1209172114000.3968@butterbrot>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33724 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab2IQVI1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 17:08:27 -0400
Received: by weyx8 with SMTP id x8so4147346wey.19
        for <linux-input@vger.kernel.org>; Mon, 17 Sep 2012 14:08:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1209172114000.3968@butterbrot>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On Mon, Sep 17, 2012 at 9:15 PM, Florian Echtler <floe@butterbrot.org> wrote:
> Signed-Off-By: Florian Echtler <floe@butterbrot.org>
> ---
>  drivers/hid/hid-wiimote-ext.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
> index fc98cc9..bc85bf2 100644
> --- a/drivers/hid/hid-wiimote-ext.c
> +++ b/drivers/hid/hid-wiimote-ext.c
> @@ -585,7 +585,8 @@ static void handler_balance_board(struct wiimote_ext
> *ext, const __u8 *payload)
>                 } else {
>                         tmp = val[i] - ext->calib[i][1];
>                         tmp *= 1700;
> -                       tmp /= ext->calib[i][2] - ext->calib[i][1] + 1700;
> +                       tmp /= ext->calib[i][2] - ext->calib[i][1];
> +                       tmp += 1700;

That's the reason why I split up your extra long line from the
original :P I should have checked it again. Thanks for the fix. I've
compared it with the original and I messed it up during conversion.
Sorry.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>

Thanks Jiri for applying them.
David
