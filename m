From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 03/20] Input: atmel_mxt_ts - verify object size in
 mxt_write_object
Date: Wed, 14 Mar 2012 10:33:23 +0900
Message-ID: <4F5FF563.7080308@samsung.com>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
 <1331640263-18935-4-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:13648 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760242Ab2CNBdB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 21:33:01 -0400
In-reply-to: <1331640263-18935-4-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>

On 03/13/2012 09:04 PM, Daniel Kurtz wrote:
> Don't allow writing past the length of an object.
>
> Signed-off-by: Daniel Kurtz<djkurtz@chromium.org>
> ---
>   drivers/input/touchscreen/atmel_mxt_ts.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 0d4d492..e18c698 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -506,7 +506,7 @@ static int mxt_write_object(struct mxt_data *data,
>   	u16 reg;
>
>   	object = mxt_get_object(data, type);
> -	if (!object)
> +	if (!object || offset>= object->size)

The object->size is actual object size - 1.

+	if (!object || offset>  object->size)


>   		return -EINVAL;
>
>   	reg = object->start_address;

