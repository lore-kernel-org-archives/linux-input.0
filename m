From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - fix X205TA iap version
Date: Sat, 12 Sep 2015 09:14:23 -0700
Message-ID: <CAKdAkRQanOLaDyjg7F5--+3cajPFgB79NX23jdq67bdd8UyhfA@mail.gmail.com>
References: <1442042684-748-1-git-send-email-michele.curti@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36113 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbbILQOY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Sep 2015 12:14:24 -0400
Received: by obqa2 with SMTP id a2so81757381obq.3
        for <linux-input@vger.kernel.org>; Sat, 12 Sep 2015 09:14:23 -0700 (PDT)
In-Reply-To: <1442042684-748-1-git-send-email-michele.curti@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michele Curti <michele.curti@gmail.com>
Cc: Duson Lin <dusonlin@emc.com.tw>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

HI Michele,

On Sat, Sep 12, 2015 at 12:24 AM, Michele Curti <michele.curti@gmail.com> wrote:
> After commit commit 58f1eae48e53 ("Input: elan_i2c - use iap_version to
> get firmware information") the touchpad on the Asus X205TA does not
> work anymore, iap version is 0, so modify the switch-case index.
>
> The 0x08 case was added for the X205TA in commit 534fcb3bdaab ("Input:
> elan_i2c - enable ELAN0100 acpi panels")
>

I'll sit on this patch a bit - I have a feeling will have to revert
58f1eae48e53.

Thanks.

> Signed-off-by: Michele Curti <michele.curti@gmail.com>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index fa94530..c40a02d 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -98,7 +98,7 @@ static int elan_get_fwinfo(u8 iap_version, u16 *validpage_count,
>                            u16 *signature_address)
>  {
>         switch (iap_version) {
> -       case 0x08:
> +       case 0x00:
>                 *validpage_count = 512;
>                 break;
>         case 0x09:
> --
> 2.5.1
>

-- 
Dmitry
