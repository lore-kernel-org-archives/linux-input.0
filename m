Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A740DFDF
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 04:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775537185; cv=none; b=Zd9/uQNKQ08yL6W9v1IDHLLCbxKoWgr8pyFn177lLTmYlkIJZTjUlOUV3xw6pNerMCYbUM12Pc7nc2DIWb1YesxU+HVv5+j47lX9Pg/Q4jhToXqdLaEXaI7Fvo3ePn+MOYaCHWqJG11x7XTk38vSKEE7fmScohqzrgc5Mggq0Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775537185; c=relaxed/simple;
	bh=QfoRAnnzDQEVFWrwiQ2v88bS57bPWxBCyvnEfQtgmuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBN0kFYvqe5Oa9tFeM6SJTBK4jY61xqWjQKr1HIeA5siw+UWETdkE0H+qWA/VsSgF7cx4GAY8STK+voo9cjOaN/eYwTk9JSSdEnjAF7bu3jbJSFu39Aca6IR1o2NJFQEl9uzbSVs2easj57nyM2zBCwqv7JP1vD+MmByL8z2Cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBhuQ+dG; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBhuQ+dG"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-127380532eeso2754599c88.1
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 21:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775537183; x=1776141983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+EOBjaz06bmhZw+jJa4j/u5irzhXaYVdaghNw7agCw=;
        b=mBhuQ+dGDdqj33zJ/yhmSguvCaH1OsDu1ebL3pGRM8O4wGCRlWD4i11wt78au4nUkH
         QqxqClsr4+mrqlwgvNG5362eUKp7G2ncimzZzys+/dIdhNA8x6+8+qPhFcqypfBFilLS
         gcXF8fFNyIgY05UjC/am5PdnwTr2o/L93uzS7yUETpiyEnTmgXhQJ8Pww5yWKt6I5VJM
         jDa7SAZzUxhLssxSGKlQfGQwn/tJ77ZHXhzdzkTOsz/5McVcXdKctaYo7LMfcjXpTzjn
         Nn/nIQPnWLfjyikRMqS0CY/j7BbBSv8efbFziv/VP7mOBM9UzpCCrS4mVjkcTHxeVv+Y
         0wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775537183; x=1776141983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+EOBjaz06bmhZw+jJa4j/u5irzhXaYVdaghNw7agCw=;
        b=fwXui3OePXy0SyRlYnpgT2hPrwuLT9q1R9NEuCa5f14STCf3V0QaK95Qh2MkXviQSV
         NhxCCARnqgdxBB5lz+jlno62NChJSxQ+2XkiKxMX9NoxgzlCGpLGjjezMOHYvMvKh2n6
         VJRh+W8EYhl1oQzMeqbUsDCFaHcsNdxyHce4gmtJnoNlH/eNMLAGI8u+quWsAshIIMKQ
         uMCtOg9YIIiDW55VLNd7iOClpf4ec8cHn6TkSiODMnrdTEC6TBsbt9G1D76Z4JY27i0q
         nX86lWC2ZDDN1PJGIqXZxdixrjyOoJJCMZ335ch4bNl7FZqnbM8XHdkz2t1HCZI3ypKc
         B98Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgQ/7GDNpvL27xR+OCoO7kVkmKFjnFQ/wwQrhlI2xYi0ZCzpsdE8ObcPT9MYSa1iGKRJaxqkKGg2dz8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcZvoZRqU+0VySwy8jKWdOaAkme1tKjeeOZcR/PZmfGmZTyHqM
	DbYO3I/kVVaH75viOqEFLGdEgUBtGh25m8ZcL14ODuNu55RwIDyHHzlN
X-Gm-Gg: AeBDiet1pTqyeLMrkJhOYNpxjwBRMSsFQUAtv3L27+vyUxRaYrKE3SjhwmaW4Jygwqd
	JcGD5xCf5k71KamjCxs2zloG+Axi9FGE+Q2G1drtvKWh3zTD6J8xF5wVzxHrH8aiIrGOmk+pywy
	PciBlvwlL0XMJuAIqiRzv0wI5yZXAWVGEqEdtYTbVk/XM+9u96weOP6zpUF6R7g9DyMiRBTn8le
	HGPIS5ZXELFroycnXurhBpsOJFTnGGBvYEzAsRi8zDVA/NNMdcaq4i7BmrQ9pOCctRPlFIiJoH0
	yvKqO5hyWzEkHT34hNff/M/FuKcS7b218WOmFXd6OCCEdsRvxW2DJv3GmGek6qxKzQeWgokcxX5
	gMTwXHJIbg0CwjpbmRlXk+cEFh5E3Hp25VlpR7DcCpdHmr8io4J0dpl47k8qddJu1uNL2ryetpc
	B3zD+/o7mSqJBjIRSZQ0HlLWvIs9Kvh5VZyv2sYH+FLqrPNd6bFUFrMG/9mVdsbKqJ
X-Received: by 2002:a05:7022:e02:b0:12a:68cc:3f08 with SMTP id a92af1059eb24-12bfb6e9821mr7867751c88.8.1775537183255;
        Mon, 06 Apr 2026 21:46:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:dd71:7176:b4e4:a7a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bede545e8sm12842344c88.11.2026.04.06.21.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:46:22 -0700 (PDT)
Date: Mon, 6 Apr 2026 21:46:19 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sanjay Govind <sanjay.govind9@gmail.com>
Cc: Vicki Pfau <vi@endrift.com>, 
	Nilton Perim Neto <niltonperimneto@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Antheas Kapenekakis <lkml@antheas.dev>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xpad: Overhaul device data for wireless devices
Message-ID: <adSJp5U47g1JnImj@google.com>
References: <20260404083928.489966-3-sanjay.govind9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404083928.489966-3-sanjay.govind9@gmail.com>

Hi Sanjay,

On Sat, Apr 04, 2026 at 09:39:27PM +1300, Sanjay Govind wrote:
> Xbox 360 wireless controllers expose information in the link and
> capabilities reports.
> 
> Extract and use the vendor id for wireless controllers, and use
> the subtype to build a nicer device name and product id.
> 
> Some xbox 360 controllers put a vid and pid into the stick capability
> data, so check if this was done, and pull the vid, pid and revision from
> there.

Sashuko correctly identified issues areoud re-scheduling work that
already completed, please see:

https://sashiko.dev/#/patchset/20260404083928.489966-3-sanjay.govind9@gmail.com



> 
> Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
> ---
> v2: Delay marking device as present until after capabilities or timeout
>  drivers/input/joystick/xpad.c | 162 ++++++++++++++++++++++++++++++++--
>  1 file changed, 155 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index bf4accf3f581..c35512c7c199 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -68,6 +68,7 @@
>  #include <linux/slab.h>
>  #include <linux/stat.h>
>  #include <linux/module.h>
> +#include <linux/unaligned.h>
>  #include <linux/usb/input.h>
>  #include <linux/usb/quirks.h>
>  
> @@ -94,6 +95,22 @@
>  #define XTYPE_XBOXONE     3
>  #define XTYPE_UNKNOWN     4
>  
> +#define FLAG_FORCE_FEEDBACK	0x01
> +
> +#define SUBTYPE_GAMEPAD			 0x01
> +#define SUBTYPE_WHEEL			 0x02
> +#define SUBTYPE_ARCADE_STICK	 0x03
> +#define SUBTYPE_FLIGHT_SICK		 0x04
> +#define SUBTYPE_DANCE_PAD		 0x05
> +#define SUBTYPE_GUITAR			 0x06
> +#define SUBTYPE_GUITAR_ALTERNATE 0x07
> +#define SUBTYPE_DRUM_KIT		 0x08
> +#define SUBTYPE_GUITAR_BASS		 0x0B
> +#define SUBTYPE_RB_KEYBOARD		 0x0F
> +#define SUBTYPE_ARCADE_PAD		 0x13
> +#define SUBTYPE_TURNTABLE		 0x17
> +#define SUBTYPE_PRO_GUITAR		 0x19
> +
>  /* Send power-off packet to xpad360w after holding the mode button for this many
>   * seconds
>   */
> @@ -795,8 +812,13 @@ struct usb_xpad {
>  	int xtype;			/* type of xbox device */
>  	int packet_type;		/* type of the extended packet */
>  	int pad_nr;			/* the order x360 pads were attached */
> +	u8 sub_type;
> +	u16 flags;
> +	u16 wireless_vid;
> +	u16 wireless_pid;
> +	u16 wireless_version;
>  	const char *name;		/* name of the device */
> -	struct work_struct work;	/* init/remove device from callback */
> +	struct delayed_work work;	/* init/remove device from callback */
>  	time64_t mode_btn_down_ts;
>  	bool delay_init;		/* init packets should be delayed */
>  	bool delayed_init_done;
> @@ -807,6 +829,8 @@ static void xpad_deinit_input(struct usb_xpad *xpad);
>  static int xpad_start_input(struct usb_xpad *xpad);
>  static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num);
>  static void xpad360w_poweroff_controller(struct usb_xpad *xpad);
> +static int xpad_inquiry_pad_capabilities(struct usb_xpad *xpad);
> +
>  
>  /*
>   *	xpad_process_packet
> @@ -980,7 +1004,7 @@ static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
>  
>  static void xpad_presence_work(struct work_struct *work)
>  {
> -	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work);
> +	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work.work);
>  	int error;
>  
>  	if (xpad->pad_present) {
> @@ -1028,10 +1052,60 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
>  
>  		if (xpad->pad_present != present) {
>  			xpad->pad_present = present;
> -			schedule_work(&xpad->work);
> +			if (present) {
> +				/*
> +				 * Delay marking device as present, so we can make sure
> +				 * we have received all the information from the capabilities
> +				 * report. Some devices don't send one, so the delay
> +				 * guarantees that these devices are still initialized.
> +				 */
> +				schedule_delayed_work(&xpad->work, msecs_to_jiffies(500));
> +			} else {
> +				schedule_delayed_work(&xpad->work, 0);

			schedule_delayed_work(&xpad->work,
					      present ? msecs_to_jiffies(500) : 0);
> +			}
>  		}
>  	}
>  
> +	/* Link report */
> +	if (data[0] == 0x00 && data[1] == 0x0F) {
> +		xpad->sub_type = data[25] & 0x7f;
> +
> +		/* Decode vendor id from link report */
> +		xpad->wireless_vid = ((data[0x16] & 0xf) | data[0x18] << 4) << 8 | data[0x17];
> +		/*
> +		 * x360w controllers on windows put the subtype into the product
> +		 * for wheels and gamepads, but it makes sense to do it for all
> +		 * subtypes. This will be used if the capabilities report
> +		 * doesn't provide us with a product id later.
> +		 */
> +		xpad->wireless_pid = 0x02a0 + xpad->sub_type;
> +		xpad->wireless_version = 0;
> +
> +		if ((data[25] & 0x80) != 0)
> +			xpad->flags |= FLAG_FORCE_FEEDBACK;
> +
> +		xpad_inquiry_pad_capabilities(xpad);
> +	}
> +
> +	/* Capabilities report */
> +	if (data[0] == 0x00 && data[1] == 0x05 && data[5] == 0x12) {
> +		xpad->flags |= data[20];
> +		/*
> +		 * A bunch of vendors started putting vids and pids
> +		 * into capabilities data because they can't be
> +		 * retrieved by xinput easliy.
> +		 * Not all of them do though, so check the vids match
> +		 * before extracting that info.
> +		 */
> +		if (get_unaligned_le16(data + 10) == xpad->wireless_vid) {
> +			xpad->wireless_pid = get_unaligned_le16(data + 12);
> +			xpad->wireless_version = get_unaligned_le16(data + 14);
> +		}
> +		/* We got the capabilities report, so mark the device present now */
> +		cancel_delayed_work(&xpad->work);
> +		schedule_delayed_work(&xpad->work, 0);

		mod_delayed_work(&xpad->work, 0);

> +	}
> +
>  	/* Valid pad data */
>  	if (data[1] != 0x1)
>  		return;
> @@ -1495,6 +1569,31 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
>  	return xpad_try_sending_next_out_packet(xpad);
>  }
>  
> +static int xpad_inquiry_pad_capabilities(struct usb_xpad *xpad)
> +{
> +	struct xpad_output_packet *packet =
> +			&xpad->out_packets[XPAD_OUT_CMD_IDX];
> +
> +	guard(spinlock_irqsave)(&xpad->odata_lock);
> +
> +	packet->data[0] = 0x00;
> +	packet->data[1] = 0x00;
> +	packet->data[2] = 0x02;
> +	packet->data[3] = 0x80;
> +	packet->data[4] = 0x00;
> +	packet->data[5] = 0x00;
> +	packet->data[6] = 0x00;
> +	packet->data[7] = 0x00;
> +	packet->data[8] = 0x00;
> +	packet->data[9] = 0x00;
> +	packet->data[10] = 0x00;
> +	packet->data[11] = 0x00;
> +	packet->len = 12;
> +	packet->pending = true;
> +
> +	return xpad_try_sending_next_out_packet(xpad);
> +}
> +
>  static int xpad_start_xbox_one(struct usb_xpad *xpad)
>  {
>  	int error;
> @@ -1893,7 +1992,7 @@ static void xpad360w_stop_input(struct usb_xpad *xpad)
>  	usb_kill_urb(xpad->irq_in);
>  
>  	/* Make sure we are done with presence work if it was scheduled */
> -	flush_work(&xpad->work);
> +	flush_delayed_work(&xpad->work);

Maybe this should be disable_delayed_work() instead...

>  }
>  
>  static int xpad_open(struct input_dev *dev)
> @@ -1965,8 +2064,57 @@ static int xpad_init_input(struct usb_xpad *xpad)
>  	usb_to_input_id(xpad->udev, &input_dev->id);
>  
>  	if (xpad->xtype == XTYPE_XBOX360W) {
> -		/* x360w controllers and the receiver have different ids */
> -		input_dev->id.product = 0x02a1;
> +		/* If the Link report has provided a vid, it won't be set to 1 */
> +		if (xpad->wireless_vid != 1)

When will it be set to 1?

Thanks.

-- 
Dmitry
