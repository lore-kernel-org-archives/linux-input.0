From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: Make I2C a known bus in hid_connect()
Date: Thu, 17 Sep 2015 16:30:54 -0400
Message-ID: <CAN+gG=EtZLLMxZVsrdX2pZ8nu9ESPWXGW=bfnuiUwW8syxdE7A@mail.gmail.com>
References: <1442502142-21116-1-git-send-email-daniel.martin@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38680 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbbIQUa4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2015 16:30:56 -0400
Received: by wiclk2 with SMTP id lk2so6094952wic.1
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2015 13:30:55 -0700 (PDT)
In-Reply-To: <1442502142-21116-1-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Martin <daniel.martin@secunet.com>, Jiri Kosina <jikos@jikos.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Daniel Martin <consume.noise@gmail.com>

On Thu, Sep 17, 2015 at 11:02 AM, Daniel Martin
<daniel.martin@secunet.com> wrote:
> Just to prettify the log message. Otherwise it would be <UNKNOWN>.
>
> Signed-off-by: Daniel Martin <consume.noise@gmail.com>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/hid-core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index e6fce23..2636fac 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1658,6 +1658,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
>         case BUS_BLUETOOTH:
>                 bus = "BLUETOOTH";
>                 break;
> +       case BUS_I2C:
> +               bus = "I2C";
> +               break;
>         default:
>                 bus = "<UNKNOWN>";
>         }
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
