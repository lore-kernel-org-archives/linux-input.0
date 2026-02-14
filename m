Received: from mailrelay-egress5.pub.mailoutpod3-cph3.one.com (mailrelay-egress5.pub.mailoutpod3-cph3.one.com [46.30.211.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E58946C
	for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 21:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771103463; cv=none; b=PQbtAA8ISgmjCH3C8bnRdtEsazaq4Rp9qmj7ubDthS/vSW4KsALO2JOnYkO1BTYjGXx7y1nu9bS4SlSu8EpjpVhQcOMh6nAa3yLOw8Bu/1uTaDMYjvpK9+nvw+9A+Q22URoJe3bv86YllkrugUPU2xdUr4dueAyabjKIbFsWJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771103463; c=relaxed/simple;
	bh=iVOvp7zPMGLtF83hNMak+HGoBYBSyK/akqGPDEs5zGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/EvpoJKJ/NBW93Sc/H8x/u6Pqioa5ZL1BcIIoe8BCspNnVQUnpZpckKSJiVN1C8F40eDLwRwH76IrvWOHjCpBj//+KzH6ZtWH4wzpIfiiutVxG1N31JnoZpxbYR04bvQjEeKp/6czkElSisLoe/MZRum9Rs5qG7FDCBA8H0ph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitmath.se; spf=none smtp.mailfrom=bitmath.se; dkim=pass (2048-bit key) header.d=bitmath.se header.i=@bitmath.se header.b=QppZR8fi; dkim=permerror (0-bit key) header.d=bitmath.se header.i=@bitmath.se header.b=qwEWiGQf; arc=none smtp.client-ip=46.30.211.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitmath.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bitmath.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmath.se header.i=@bitmath.se header.b="QppZR8fi";
	dkim=permerror (0-bit key) header.d=bitmath.se header.i=@bitmath.se header.b="qwEWiGQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1771103388; x=1771708188;
	d=bitmath.se; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=RV7HkpizJ01mDfcCFpXzP8BGhiavR1zVcB82by01kjs=;
	b=QppZR8fiTct4yUkL42iMhHOB65zKoqctim5zaIqntI1PrmCmDrSPot8frECq/P3jpkgbXxfueW3qn
	 Bv7UEzGVxjGzEJDbzzKN55e1B9tpZa+8RLu36l8uBedJkT914fkgf4257YcJen9ZfvjGtLP5gw1jP7
	 VQE84X3wuNyEkQZBD5NChSovULBc0tMO2syx9pQa/mW/M1v3v2fUd1bdDxV6DAtMSRMd6MRFJG2rfb
	 MmvNAO1oQ8W0lOTJYRZXVECpuwOsJz1Pd/VGeWpxDMh++GhK4EaME1Gzb+AK3ao8xZycrLl5Oq5dSu
	 r4wzb6c3XHOwrps+ZlF/LSu0BQouh+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1771103388; x=1771708188;
	d=bitmath.se; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=RV7HkpizJ01mDfcCFpXzP8BGhiavR1zVcB82by01kjs=;
	b=qwEWiGQfWgvcM3sSYP5E6l+Kg+Zcuq4Rtv3ID9I2SmdUkfu+dvYnIJ5OuyXGbpYudm/WbgRrHVNCL
	 B41Te3iCw==
X-HalOne-ID: 7e9021ee-09e9-11f1-93f5-85eb291bc831
Received: from [192.168.19.13] (h-155-4-132-124.na.cust.bahnhof.se [155.4.132.124])
	by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 7e9021ee-09e9-11f1-93f5-85eb291bc831;
	Sat, 14 Feb 2026 21:09:48 +0000 (UTC)
Message-ID: <32bcd3e4-6397-43e2-9483-dd2af14e8cd5@bitmath.se>
Date: Sat, 14 Feb 2026 22:09:47 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bcm5974: recover from failed mode switch
To: Liam Mitchell <mitchell.liam@gmail.com>,
 Henrik Rydberg <rydberg@bitmath.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260213-bcm5974-reset-v2-1-1837851336b0@gmail.com>
Content-Language: en-US
From: Henrik Rydberg <rydberg@bitmath.se>
Autocrypt: addr=rydberg@bitmath.se; keydata=
 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 nQ==
In-Reply-To: <20260213-bcm5974-reset-v2-1-1837851336b0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Liam,

thanks for seeing this through! Looks good to me.

Acked-by: Henrik Rydberg <rydberg@bitmath.org>

On 2/13/26 10:25 AM, Liam Mitchell wrote:
> Mode switches sent before control response are ignored.
> On receiving unknown 8-byte packets, assume that mode switch was ignored
> and reset by switching to normal mode, waiting then switching back to
> wellspring mode.
> 
> ---
> This patch addresses an issue where the bcm5974 driver switches modes
> before the device is ready, resulting in an unresponsive trackpad and
> "bcm5974: bad trackpad package, length: 8" repeated in logs.
> 
> Discussion of issue in the thread:
> https://lore.kernel.org/linux-input/CAOQ1CL4+DP1TuLAGNsz5GdFBTHvnTg=5q=Dr2Z1OQc6RXydSYA@mail.gmail.com/
> 
> This fix is conservative, avoiding changing existing mode-switch
> behavior because I cannot test all variations of hardware.
> 
> On receiving an unknown 8-byte packet, we assume the device is not in
> wellspring mode and schedule an asynchronous mode reset.
> 
> Signed-off-by: Liam Mitchell <mitchell.liam@gmail.com>
> Link: https://lore.kernel.org/linux-input/CAOQ1CL4+DP1TuLAGNsz5GdFBTHvnTg=5q=Dr2Z1OQc6RXydSYA@mail.gmail.com/
> ---
> Changes in v2:
> - mutex_lock -> guard(mutex)
> - dprintk -> dev_err
> - msleep -> fsleep
> - removed 0 init
> - cancel_work_sync -> disable_delayed_work_sync
> - work_struct -> delayed_work
> - Link to v1: https://lore.kernel.org/r/20260207-bcm5974-reset-v1-1-af7163903fa6@gmail.com
> ---
>   drivers/input/mouse/bcm5974.c | 40 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> index dfdfb59cc8b5..6ee766ed8402 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -286,6 +286,8 @@ struct bcm5974 {
>   	const struct tp_finger *index[MAX_FINGERS];	/* finger index data */
>   	struct input_mt_pos pos[MAX_FINGERS];		/* position array */
>   	int slots[MAX_FINGERS];				/* slot assignments */
> +	struct delayed_work mode_reset_work;
> +	unsigned long last_mode_reset;
>   };
>   
>   /* trackpad finger block data, le16-aligned */
> @@ -696,6 +698,32 @@ static int bcm5974_wellspring_mode(struct bcm5974 *dev, bool on)
>   	return retval;
>   }
>   
> +/*
> + * Mode switches sent before the control response are ignored.
> + * Fixing this state requires switching to normal mode and waiting
> + * about 1ms before switching back to wellspring mode.
> + */
> +static void bcm5974_mode_reset_work(struct work_struct *work)
> +{
> +	int error;
> +	struct bcm5974 *dev = container_of(work, struct bcm5974, mode_reset_work.work);
> +
> +	guard(mutex)(&dev->pm_mutex);
> +	dev->last_mode_reset = jiffies;
> +
> +	error = bcm5974_wellspring_mode(dev, false);
> +	if (error) {
> +		dev_err(&dev->intf->dev, "reset to normal mode failed\n");
> +		return;
> +	}
> +
> +	fsleep(1000);
> +
> +	error = bcm5974_wellspring_mode(dev, true);
> +	if (error)
> +		dev_err(&dev->intf->dev, "mode switch after reset failed\n");
> +}
> +
>   static void bcm5974_irq_button(struct urb *urb)
>   {
>   	struct bcm5974 *dev = urb->context;
> @@ -752,10 +780,18 @@ static void bcm5974_irq_trackpad(struct urb *urb)
>   	if (dev->tp_urb->actual_length == 2)
>   		goto exit;
>   
> -	if (report_tp_state(dev, dev->tp_urb->actual_length))
> +	if (report_tp_state(dev, dev->tp_urb->actual_length)) {
>   		dprintk(1, "bcm5974: bad trackpad package, length: %d\n",
>   			dev->tp_urb->actual_length);
>   
> +		/* HID packet means we aren't in wellspring mode */
> +		/* If we haven't tried a reset in the last second, try now */
> +		if (dev->tp_urb->actual_length == 8 &&
> +		    time_after(jiffies, dev->last_mode_reset + msecs_to_jiffies(1000))) {
> +			schedule_delayed_work(&dev->mode_reset_work, 0);
> +		}
> +	}
> +
>   exit:
>   	error = usb_submit_urb(dev->tp_urb, GFP_ATOMIC);
>   	if (error)
> @@ -906,6 +942,7 @@ static int bcm5974_probe(struct usb_interface *iface,
>   	dev->intf = iface;
>   	dev->input = input_dev;
>   	dev->cfg = *cfg;
> +	INIT_DELAYED_WORK(&dev->mode_reset_work, bcm5974_mode_reset_work);
>   	mutex_init(&dev->pm_mutex);
>   
>   	/* setup urbs */
> @@ -998,6 +1035,7 @@ static void bcm5974_disconnect(struct usb_interface *iface)
>   {
>   	struct bcm5974 *dev = usb_get_intfdata(iface);
>   
> +	disable_delayed_work_sync(&dev->mode_reset_work);
>   	usb_set_intfdata(iface, NULL);
>   
>   	input_unregister_device(dev->input);
> 
> ---
> base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> change-id: 20260207-bcm5974-reset-85ccdfca9641
> 
> Best regards,

