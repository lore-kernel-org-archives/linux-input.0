From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: lenovo: Don't use stack variables for DMA buffers
Date: Tue, 29 Mar 2016 08:50:27 +0200
Message-ID: <20160329065027.GA20424@mail.corp.redhat.com>
References: <1459171334-22943-1-git-send-email-jwboyer@fedoraproject.org>
 <1459171334-22943-2-git-send-email-jwboyer@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39844 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbcC2Guc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 02:50:32 -0400
Content-Disposition: inline
In-Reply-To: <1459171334-22943-2-git-send-email-jwboyer@fedoraproject.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mar 28 2016 or thereabouts, Josh Boyer wrote:
> The lenovo_send_cmd_cptkbd function uses a stack variable to submit
> commands via hid_hw_raw_request.  Eventually this gets to the
> usb_hcd_map_urb_for_dma function, which causes a warning to be thrown
> if the CONFIG_DMA_API_DEBUG option is enabled.
> 
> Fix this by allocating a temporary buffer instead.
> 
> Reported-by: lejeczek <peljasz@yahoo.co.uk>
> Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
> ---

The patch is
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

There is just one nitpick that can be solved while committing (or not,
depending on how Jiri handles it :-P ).

>  drivers/hid/hid-lenovo.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index 0125e356bd8d..2ba5e8ea66a4 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -184,21 +184,31 @@ static int lenovo_send_cmd_cptkbd(struct hid_device *hdev,
>  			unsigned char byte2, unsigned char byte3)
>  {
>  	int ret;
> -	unsigned char buf[] = {0x18, byte2, byte3};
> +	unsigned char *buf = NULL;

No need to initialized buf here :)

Cheers,
Benjamin

> +
> +	buf = kzalloc(3, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	buf[0] = 0x18;
> +	buf[1] = byte2;
> +	buf[2] = byte3;
>  
>  	switch (hdev->product) {
>  	case USB_DEVICE_ID_LENOVO_CUSBKBD:
> -		ret = hid_hw_raw_request(hdev, 0x13, buf, sizeof(buf),
> +		ret = hid_hw_raw_request(hdev, 0x13, buf, 3,
>  					HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
>  		break;
>  	case USB_DEVICE_ID_LENOVO_CBTKBD:
> -		ret = hid_hw_output_report(hdev, buf, sizeof(buf));
> +		ret = hid_hw_output_report(hdev, buf, 3);
>  		break;
>  	default:
>  		ret = -EINVAL;
>  		break;
>  	}
>  
> +	kfree(buf);
> +
>  	return ret < 0 ? ret : 0; /* BT returns 0, USB returns sizeof(buf) */
>  }
>  
> -- 
> 2.5.5
> 
