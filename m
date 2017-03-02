From: Michel Hermier <michel.hermier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] HID: Remove unnecessary OOM messages
Date: Thu, 2 Mar 2017 07:51:11 +0100
Message-ID: <a52260a5-921c-53f9-8709-ae7189395cee@gmail.com>
References: <cover.1488395879.git.joe@perches.com>
 <0fbe692283802d36df389af7cbda9a4bff44db5e.1488395879.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0fbe692283802d36df389af7cbda9a4bff44db5e.1488395879.git.joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, Stefan Achatz <erazor_de-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Le 01/03/2017 à 20:19, Joe Perches a écrit :
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 70b12f89a193..1ee6aac855a3 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -224,7 +224,6 @@ static int asus_start_multitouch(struct hid_device *hdev)
>   
>   	if (!dmabuf) {
>   		ret = -ENOMEM;
> -		hid_err(hdev, "Asus failed to alloc dma buf: %d\n", ret);
>   		return ret;
>   	}

Trivial set and return value missed.
