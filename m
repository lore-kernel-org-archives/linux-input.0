From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 1/5] Input: wacom - Allow any multi-input Intuos device to
 set prox
Date: Fri, 28 Sep 2012 14:18:53 -0700
Message-ID: <CAF8JNhKrkbLCTLUpsWJVCbgtdaDSYa1S7tdH=KHi=LXXc2Ac7w@mail.gmail.com>
References: <1346972010-1330-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:53952 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1033086Ab2I1VSz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Sep 2012 17:18:55 -0400
Received: by lagh6 with SMTP id h6so1272057lag.19
        for <linux-input@vger.kernel.org>; Fri, 28 Sep 2012 14:18:53 -0700 (PDT)
In-Reply-To: <1346972010-1330-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, chris@cnpbagwell.com

On Thu, Sep 6, 2012 at 3:53 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> The ability to set the proximity flag should apply to any device
> that has both pen and touch input. Rather than listing classes of
> devices known to meet this criteria, simply filter on the quirk
> defining all such devices.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>

Tested-by: Ping Cheng <pingc@wacom.com> for the whole set.

Dmitry, do you have questions about this patchset and "input: wacom:
Report correct touch contact size for I5/Bamboo"? We hope they can be
merged soon since we have more patches coming.

Thank you.

Ping

> ---
>  drivers/input/tablet/wacom_wac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 532d067..a8bc6c9 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -326,7 +326,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
>
>         /* Enter report */
>         if ((data[1] & 0xfc) == 0xc0) {
> -               if (features->type >= INTUOS5S && features->type <= INTUOS5L)
> +               if (features->quirks == WACOM_QUIRK_MULTI_INPUT)
>                         wacom->shared->stylus_in_proximity = true;
>
>                 /* serial number of the tool */
> @@ -414,7 +414,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
>
>         /* Exit report */
>         if ((data[1] & 0xfe) == 0x80) {
> -               if (features->type >= INTUOS5S && features->type <= INTUOS5L)
> +               if (features->quirks == WACOM_QUIRK_MULTI_INPUT)
>                         wacom->shared->stylus_in_proximity = false;
>
>                 /*
> --
> 1.7.12
>
