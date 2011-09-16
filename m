From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - Use snprintf for sysfs attribute
 show method
Date: Fri, 16 Sep 2011 09:52:36 +0900
Message-ID: <4E729DD4.8010208@samsung.com>
References: <1316115647-1244-1-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:11239 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab1IPAxX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Sep 2011 20:53:23 -0400
In-reply-to: <1316115647-1244-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, Yufeng Shen <miletus@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 2011-09-16 =EC=98=A4=EC=A0=84 4:40, Daniel Kurtz wrote:
> Sysfs attribute show methods are always passed a buffer of length
> PAGE_SIZE.  To keep from overwriting this buffer and causing havoc, u=
se
> snprintf() to guarantee we never write more than the buffer can hold.
>
> In addition, at least for my touchscreen, the number and size of obje=
cts
> was far too big to fit in a single 4K page.  Therefore, this patch al=
so
> trims some redundant framing text to leave more room for actual data.
>
> Signed-off-by: Daniel Kurtz<djkurtz@chromium.org>

This patch is working but original problem is object size is increasing
as atmel touchscreen chip updates and we should consider also the
instances of object.

How about splitting attributes to each object?

Iiro, do you have any update plans about atmel touchscreen driver?

> ---
>   drivers/input/touchscreen/atmel_mxt_ts.c |   21 +++++++++++++++----=
--
>   1 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input=
/touchscreen/atmel_mxt_ts.c
> index f5d6685..a596c27 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -910,12 +910,17 @@ static ssize_t mxt_object_show(struct device *d=
ev,
>   	for (i =3D 0; i<  data->info.object_num; i++) {
>   		object =3D data->object_table + i;
>
> -		count +=3D sprintf(buf + count,
> -				"Object Table Element %d(Type %d)\n",
> +		count +=3D snprintf(buf + count, PAGE_SIZE - count,
> +				"Object[%d] (Type %d)\n",
>   				i + 1, object->type);
> +		if (count>=3D PAGE_SIZE)
> +			return PAGE_SIZE - 1;
>
>   		if (!mxt_object_readable(object->type)) {
> -			count +=3D sprintf(buf + count, "\n");
> +			count +=3D snprintf(buf + count, PAGE_SIZE - count,
> +					"\n");
> +			if (count>=3D PAGE_SIZE)
> +				return PAGE_SIZE - 1;
>   			continue;
>   		}
>
> @@ -925,11 +930,15 @@ static ssize_t mxt_object_show(struct device *d=
ev,
>   			if (error)
>   				return error;
>
> -			count +=3D sprintf(buf + count,
> -					"  Byte %d: 0x%x (%d)\n", j, val, val);
> +			count +=3D snprintf(buf + count, PAGE_SIZE - count,
> +					"\t[%2d]: %02x (%d)\n", j, val, val);
> +			if (count>=3D PAGE_SIZE)
> +				return PAGE_SIZE - 1;
>   		}
>
> -		count +=3D sprintf(buf + count, "\n");
> +		count +=3D snprintf(buf + count, PAGE_SIZE - count, "\n");
> +		if (count>=3D PAGE_SIZE)
> +			return PAGE_SIZE - 1;
>   	}
>
>   	return count;

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
