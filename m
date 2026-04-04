Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E08220F3E
	for <linux-input@vger.kernel.org>; Sat,  4 Apr 2026 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775280822; cv=none; b=tGS8jkPMJfjR/AMQ/rH7tSsDgQrRntsZO1wE6u7Dm6DlEjdFSu+oP/zwLdcSpIDsT1zdKMbpGC4yHaS/jQeWbKEV5P6nJFO1Oe0l/uEaEstjwhbvd98pqFDFGtV5iAhbj7H+gKJ/ChkHN656oSq09D20vrGjijjVIw9vIhOEgE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775280822; c=relaxed/simple;
	bh=B996usIYCBCo60/EadERLeQsxWJx5uu/hycNx/jtU8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kqzzu/aTaHk1CYiN86LuSQRVZznppjQo4wMsdIsuRMAFAygUFNX0zVF9RwWHQUI6dVZHSi2opvm5LSpqH4jR+ONISLOBHQROz8+HdCYIB8ZI+KgaQNWgP1vBXiTEsmTd1/sCOJrh7fq/OAYjD5FKG3kVzJw9u0OvYi9b9CVSvPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPRBWe5q; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPRBWe5q"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso2212420eec.1
        for <linux-input@vger.kernel.org>; Fri, 03 Apr 2026 22:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775280820; x=1775885620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/L+igkv/Dr4KK1K3dBsA3AYj3MMuYuKDe+OnJWJOtJw=;
        b=NPRBWe5qxXXneVw6VgKzjGlM5SDiRf5oDQw+a2Hu2sAq/DZUY3Rd8dHH1tIbybgarE
         h5cWjqnkf4V/Ve5fSiTNfJ4LJ7OhYEwyBwOWC3Xmqe4UfuyNBQq7Reji44KvuGejVRg6
         +WnmgvfDbn0bMNEpLMmd7u4maef6bDNBm3KoZV66FczUElomQKHisUAPbL3LLYSKlbN5
         tZ30UNWW9pkE01O1B6X9LoU4MRuq+nMfor1ExT6G1Lg4uG5ZZl19obEgxWre7XbNknvE
         iA/q+IZcTvr4ZR4IFROxoCe9NQ9PvjIAHSrS6E42k4S3bpsdq9h0rGHzpYgFpTlcst4D
         0WGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775280820; x=1775885620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/L+igkv/Dr4KK1K3dBsA3AYj3MMuYuKDe+OnJWJOtJw=;
        b=C9OBmT6Tq6vhqReNUalwa9DV50q5rDmrgSpFQ/aQMdy0QKKABJq9E8oqicJRRr6gLv
         nESKLj1+kXGw2tqjXLBNDEFEGXhbNKbEfrM5K3QRVBm0t3iCVRvX9K1sphsTHgz2cbQr
         8E9GNPEauGPIPa5DID1H588L3Nd98T/GM5qeqmDKF/zO1iPywoo0sQtubZq2O9r6KwrM
         fBD3l46eFLY7JcythDfUt3C9IusAylNtJW1i65QNAlc+Si+CTVaZZAiM9EiGE19rusQd
         +KkNfDW0GuAv1+jt4AjiR4h5/+iPAs/Rvyv+5qFRDLK6HBlsBlr0OMkLfjqsVNsyhWLr
         dEMg==
X-Forwarded-Encrypted: i=1; AJvYcCWkca9QAbdX9Ozc2MSaClLcCZ8rO27FvzPdbiys5DkoExDX1dJgI1GejN6PRUT4g2CVZkN9SfxUOqAjWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk3080DMUDj+UwJ6vQaZp0BoR1GqZPmFf/3iVDGhTX3dqbDFyW
	RELF6Qn0tfQpX7klEQWJ+ix9RJ9U8Mn6o29rWj3eaoNmJQ4EtVU6w1Qp
X-Gm-Gg: AeBDiesnf/yuMjhvrjjf3DVY0aUJ1zfXj6B/QwNCijJkEvINa/Y7OfM/kiLA51BldfZ
	WUH3P14k3OAkvFg1J2iMGGLrouwRs+Wq3Zrl8eCbftcF2WfNi8ojOA26XlZ2PJSSbInWo/ZZnOa
	h3kzVZ80cJn9Pf9fl7E5iO+wdEafqmfebQ5SIbNwlbmWr1yT9WbeA/aKUT8rAYa+znK2NNxW2Wc
	sGJOeP1tWi0afbWTpn6JEqFPSBZX4C3aZWbBe48ohYFzF/Iob4W26c9f8QGWZ8BoVIvdG9zwwd8
	SY3XNk3UYuxH+M+3IN8MVNjK6y33MZQlW1A1YpKLyKC+6fFP/8Q8ZUun3TmlV3tyU5Gjc3EZyHk
	pQAoAo/xkvOEe/tN1dpYKF9zAU5MUAl22+A80+xaMpCP/jl9zJcQ7uUghCBKADgb+df0vkdGmjV
	fDlNEAjVl1nMXpdmqIP6jf5s5viBeRzPFgUwkT5mJtgVftIl7rixn2qfWWRPvQpLbB
X-Received: by 2002:a05:7300:5725:b0:2c5:60d0:703b with SMTP id 5a478bee46e88-2cbfa5be05emr2998884eec.14.1775280819603;
        Fri, 03 Apr 2026 22:33:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2357:9278:e4dd:85f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca792f3f54sm6808763eec.7.2026.04.03.22.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 22:33:37 -0700 (PDT)
Date: Fri, 3 Apr 2026 22:33:33 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sanjay Govind <sanjay.govind9@gmail.com>
Cc: Vicki Pfau <vi@endrift.com>, 
	Nilton Perim Neto <niltonperimneto@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, Antheas Kapenekakis <lkml@antheas.dev>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xpad: Overhaul device data for wireless devices
Message-ID: <adCc8OuHm7wwkysq@google.com>
References: <20260314075034.1488655-2-sanjay.govind9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314075034.1488655-2-sanjay.govind9@gmail.com>

Hi Sanjay,

On Sat, Mar 14, 2026 at 08:50:32PM +1300, Sanjay Govind wrote:
> Xbox 360 wireless controllers expose information in the link and
> capabilities reports.
> 
> Extract and use the vendor id for wireless controllers, and use
> the subtype to build a nicer device name and product id.
> 
> Some xbox 360 controllers put a vid and pid into the stick capability
> data, so check if this was done, and pull the vid, pid and revision from
> there.
> 
> Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 138 +++++++++++++++++++++++++++++++++-
>  1 file changed, 135 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index bf4accf3f581..2490eb21a534 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -94,6 +94,22 @@
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
> @@ -795,6 +811,9 @@ struct usb_xpad {
>  	int xtype;			/* type of xbox device */
>  	int packet_type;		/* type of the extended packet */
>  	int pad_nr;			/* the order x360 pads were attached */
> +	u8 sub_type;
> +	u16 flags;
> +	u16 wireless_vid;
>  	const char *name;		/* name of the device */
>  	struct work_struct work;	/* init/remove device from callback */
>  	time64_t mode_btn_down_ts;
> @@ -807,6 +826,8 @@ static void xpad_deinit_input(struct usb_xpad *xpad);
>  static int xpad_start_input(struct usb_xpad *xpad);
>  static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num);
>  static void xpad360w_poweroff_controller(struct usb_xpad *xpad);
> +static int xpad_inquiry_pad_capabilities(struct usb_xpad *xpad);
> +
>  
>  /*
>   *	xpad_process_packet
> @@ -1026,12 +1047,46 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
>  	if (data[0] & 0x08) {
>  		present = (data[1] & 0x80) != 0;
>  
> -		if (xpad->pad_present != present) {
> +		/* delay prescence until after we get the link report */

s/prescence/presence

But I would say "Only handle no longer being present here. When
a controller appears mark it as present only after receiving link
report".


> +		if (!present && xpad->pad_present) {
>  			xpad->pad_present = present;
>  			schedule_work(&xpad->work);
>  		}
>  	}
>  
> +	/* Link report */
> +	if (data[0] == 0x00 && data[1] == 0x0F) {
> +		xpad->sub_type = data[25] & 0x7f;
> +
> +		/* Decode vendor id from link report */
> +		xpad->wireless_vid = ((data[0x16] & 0xf) | data[0x18] << 4) << 8 | data[0x17];
> +
> +		if ((data[25] & 0x80) != 0)
> +			xpad->flags |= FLAG_FORCE_FEEDBACK;
> +
> +		if (!xpad->pad_present) {
> +			xpad->pad_present = true;
> +			schedule_work(&xpad->work);
> +		}
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

easily.

> +		 * Not all of them do though, so check the vids match
> +		 * before extracting that info.
> +		 */
> +		if (((data[11] << 8) | data[10]) == xpad->wireless_vid) {

get_unaaligned_le16()

> +			xpad->dev->id.product = (data[13] << 8) | data[12];

get_unaligned_le16()

> +			xpad->dev->id.version = (data[15] << 8) | data[14];

get_unaligned_le16()

However you should not change product and version once input device is
registered. So you should delay not until after link packet is received,
but until after capabilities packet.

You might need an enum instead of bool for controller state.

> +		}
> +	}
> +
>  	/* Valid pad data */
>  	if (data[1] != 0x1)
>  		return;
> @@ -1495,6 +1550,31 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
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
> @@ -1965,8 +2045,60 @@ static int xpad_init_input(struct usb_xpad *xpad)
>  	usb_to_input_id(xpad->udev, &input_dev->id);
>  
>  	if (xpad->xtype == XTYPE_XBOX360W) {
> -		/* x360w controllers and the receiver have different ids */
> -		input_dev->id.product = 0x02a1;
> +		/*
> +		 * x360w controllers on windows put the subtype into the product
> +		 * for wheels and gamepads, but it makes sense to do it for all
> +		 * subtypes
> +		 */
> +		input_dev->id.product = 0x02a0 + xpad->sub_type;

Another option is to use version field...

> +		/* If the Link report has provided a vid, it won't be set to 1 */
> +		if (xpad->wireless_vid != 1)
> +			input_dev->id.vendor = xpad->wireless_vid;
> +		switch (xpad->sub_type) {
> +		case SUBTYPE_GAMEPAD:
> +			input_dev->name = "Xbox 360 Wireless Controller";
> +			break;
> +		case SUBTYPE_WHEEL:
> +			input_dev->name = "Xbox 360 Wireless Wheel";
> +			break;
> +		case SUBTYPE_ARCADE_STICK:
> +			input_dev->name = "Xbox 360 Wireless Arcade Stick";
> +			break;
> +		case SUBTYPE_FLIGHT_SICK:
> +			input_dev->name = "Xbox 360 Wireless Flight Stick";
> +			break;
> +		case SUBTYPE_DANCE_PAD:
> +			input_dev->name = "Xbox 360 Wireless Dance Pad";
> +			break;
> +		case SUBTYPE_GUITAR:
> +			input_dev->name = "Xbox 360 Wireless Guitar";
> +			break;
> +		case SUBTYPE_GUITAR_ALTERNATE:
> +			input_dev->name = "Xbox 360 Wireless Alternate Guitar";
> +			break;
> +		case SUBTYPE_GUITAR_BASS:
> +			input_dev->name = "Xbox 360 Wireless Bass Guitar";
> +			break;
> +		case SUBTYPE_DRUM_KIT:
> +			/* Vendors used force feedback flag to differentiate these */
> +			if (xpad->flags & FLAG_FORCE_FEEDBACK)
> +				input_dev->name = "Xbox 360 Wireless Guitar Hero Drum Kit";
> +			else
> +				input_dev->name = "Xbox 360 Wireless Rock Band Drum Kit";
> +			break;
> +		case SUBTYPE_RB_KEYBOARD:
> +			input_dev->name = "Xbox 360 Wireless Rock Band Keyboard";
> +			break;
> +		case SUBTYPE_ARCADE_PAD:
> +			input_dev->name = "Xbox 360 Wireless Arcade Pad";
> +			break;
> +		case SUBTYPE_TURNTABLE:
> +			input_dev->name = "Xbox 360 Wireless DJ Hero Turntable";
> +			break;
> +		case SUBTYPE_PRO_GUITAR:
> +			input_dev->name = "Xbox 360 Wireless Rock Band Pro Guitar";
> +			break;
> +		}

Maybe have an array of

	[type] = "Name"

instead of this switch?

Thanks.

-- 
Dmitry
