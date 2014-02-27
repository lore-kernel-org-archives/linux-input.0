From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: Re: [PATCH 4/4] Input: wacom: Handle 1024 pressure levels in wacom_tpc_pen
Date: Thu, 27 Feb 2014 10:40:41 -0800
Message-ID: <CAEoswT07Ku8-9O414RVE5paTD1XcfR3DkBa9rt8G0KW=waPR0Q@mail.gmail.com>
References: <1391107728-1306-1-git-send-email-killertofu@gmail.com>
	<1391107728-1306-4-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:49674 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbaB0Skm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Feb 2014 13:40:42 -0500
Received: by mail-ve0-f172.google.com with SMTP id jx11so4322833veb.3
        for <linux-input@vger.kernel.org>; Thu, 27 Feb 2014 10:40:41 -0800 (PST)
In-Reply-To: <1391107728-1306-4-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Thu, Jan 30, 2014 at 10:48 AM, Jason Gerecke <killertofu@gmail.com> wrote:
> Some tablet PC sensors (e.g. the 0xEC found in the Thinkpad
> Yoga) report more than 256 pressure levels and will experience
> wraparound unless the full range is read.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
>  drivers/input/tablet/wacom_wac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 9ff5613..ae1437b 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1087,7 +1087,7 @@ static int wacom_tpc_pen(struct wacom_wac *wacom)
>                 input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
>                 input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
>                 input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&data[4]));
> -               input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x01) << 8) | data[6]);
> +               input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x03) << 8) | data[6]);
>                 input_report_key(input, BTN_TOUCH, data[1] & 0x05);
>                 input_report_key(input, wacom->tool[0], prox);
>                 return 1;
> --
> 1.8.5.3
>
Tested-by: Aaron Skomra <Aaron.Skomra@wacom.com>
