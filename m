From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] Input: htcpen - Fix incorrect placement of __initdata
Date: Wed, 14 Aug 2013 11:55:22 +0530
Message-ID: <CAK9yfHy-Q8W=0ujnnMmspsSJuwJeH-GMpOky+_GkPXf14mHK5w@mail.gmail.com>
References: <1375868346-28851-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:39491 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab3HNGZW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Aug 2013 02:25:22 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so12801429oag.10
        for <linux-input@vger.kernel.org>; Tue, 13 Aug 2013 23:25:22 -0700 (PDT)
In-Reply-To: <1375868346-28851-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sachin Kamat <sachin.kamat@linaro.org>, Pau Oliva Fora <pau@eslack.org>

Hi Dmitry,

On 7 August 2013 15:09, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> __initdata should be placed between the variable name and equal
> sign for the variable to be placed in the intended section.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Pau Oliva Fora <pau@eslack.org>
> ---
>  drivers/input/touchscreen/htcpen.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/htcpen.c b/drivers/input/touchscreen/htcpen.c
> index 6c4fb84..6650085 100644
> --- a/drivers/input/touchscreen/htcpen.c
> +++ b/drivers/input/touchscreen/htcpen.c
> @@ -221,7 +221,7 @@ static struct isa_driver htcpen_isa_driver = {
>         }
>  };
>
> -static struct dmi_system_id __initdata htcshift_dmi_table[] = {
> +static struct dmi_system_id htcshift_dmi_table[] __initdata = {
>         {
>                 .ident = "Shift",
>                 .matches = {
> --
> 1.7.9.5
>

Thanks for applying my other patches. Looks like you missed this one though :)

-- 
With warm regards,
Sachin
