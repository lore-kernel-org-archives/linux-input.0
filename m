Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C381EB5E1
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967458; cv=none; b=kU9ng05iKq0rH5pA3ipfAcatTSkbbFRC960g8/uGzRLZD5909db8zFyksU27E7NYTgs6om1O2COOovZoJSg3NUzl0leMcXtaoZ2Pw6NTIgQdyHQ+iPEvwGDWAMcmSJR32zpk9U41+zjedOvGzXKj26Oe92qEOHLkhalBVpxxPWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967458; c=relaxed/simple;
	bh=C+YKbMIg+dCWCiO5+yHLe3GBpe8roAq2g62ABCRHIKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ot8M77hO3ne7z2vXa1bXkP2U7Y/huCtMcN6ho2ICAGLs3Gb5T17GcWPMzUL3OcL/SasuuHCnpIDNuNmJrMruUy2UnAfXserNnVGa5oDXSs4M/Z206uJkUFRaLoAnLvztOEFYUWvph1hGlr9cCMy3c+VdqJu/CLTjE0DP1JMBkmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6sHPJj4; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6sHPJj4"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bdbd13ca01so773308eec.0
        for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 13:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771967456; x=1772572256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMXb01L8QgoCBtEDBRsVtf1TuUoR4a0hS1+b6eQlnTk=;
        b=e6sHPJj413kRgR5U5yiu97GOpjJp5vyTYF+6VTXYpa/TOwj9mJ5Gk97Fm5uLr5cXbd
         niS1JsHPXzScZLl7sygLiu0NRjiC1Go+RDnpqFtO+M1qsdVzwCKGD4fSbfFs9IHsOAAR
         ut2fFZPk4IK27PDrkORgVai9HxoEIj7RbMB7lUv2j/Y2/3ruu2L/GguZ++JQP8iIEQrk
         jRrjhtWzxepzq+n5kPLPEj8PBKQjmVHtqaIHRp9EEyqva20SBqmjQerh6NIgJO69rNpr
         2fs5vVrq8hcbWP1LKD2d6/UDT4WwFnPRuZ3uYveM3RHztj/9ZAZ3lWiRuLYwANniXCCJ
         K2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771967456; x=1772572256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sMXb01L8QgoCBtEDBRsVtf1TuUoR4a0hS1+b6eQlnTk=;
        b=gMU/o+oz+9VdEVoax4waQKYUp/eVifnqnUVj4jcL1QkmFzNBnm3s4ot50Ngkm5MBmI
         9SmEgkfg+bZTXNLWc32PJHFXWGPuzIn2t0TTu2aB3jr46l4WmaNBPjsr1N0scbkZ/RZw
         ENoTt0KNaQH8s+/KOpqgdjs5jTrLwCXJxZNlXne5SJwuSW8nlHFB3jFCo0X+ppakXVCx
         wGKXmv7yOErVRT56D+sA0VUFxo6ISSflX2pMIFg/rAtQ/IB0/RamRAB7MU5bGuq0olaF
         bmcMakFlcSmhvGzj56ScYu8R99mgJ7hFnR3CfqJ3SWBbqq79cXDsPG4OVDMLhvnfniWY
         /oNg==
X-Forwarded-Encrypted: i=1; AJvYcCVa63gNJCjIvIm1yeKo0KbJb2i1qLNtT531iWknRs/tdF5bJkxLoT3NLEE0zpEep08qj+2OjoI24o59dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfBpp2t3cV0EM2t9nIhPUV9+ca/SUA7c8+MYXmZInt7VKJkR/r
	iSquyuMKkCjrq+V0s+aoePKvOIYEY5/7koi85vU5Ze6OmYCWsH2dIIstwsQEB2MR
X-Gm-Gg: ATEYQzxQfj0YWHrDPPmLrPW0PcpaV7fbtKHDfbY2fnRUtTHHb2IbEGnO3FZuSeQh97X
	9rZcXIcP26zmxH3DRDnEUHBIIeHWgVDQnHadtB7kYhUgh3qS1v5wFgRRidN4tK3BaYnB2Psy+6H
	P66JfnQPOcxr8+MK9d1IXe8HV/UQuu+FSncUi6Cn2wKYiSs+Y/dSzrOU0Hx2W4jyrffS3wWd38h
	yGgmn/jae+yYTYB58AZrtgtnTuKh4d2VVmk0a6zmAyypN07t5M846sQOyRXK676xUcNCcQTt00X
	2LMwg3JDc8nmqgGcsrBdNzZUgkJImZbMRiTMVeBq565ejULKV5H0rPZaghREXOi/UzLyhCdkZzn
	pczI5maQjB4JHxqx5hVoYG/70QBwIUhus88o3USdcdfcjLs5lHnc8VXUKivJ5vWX0VNHSLdcoCf
	Exds38e1S5ZkL2FS121NTk6coTNtnU4D1GBSI1ayv559AHMvw=
X-Received: by 2002:a05:7300:cd43:b0:2b7:f28d:c8c1 with SMTP id 5a478bee46e88-2bd7b906d62mr5595398eec.0.1771967455969;
        Tue, 24 Feb 2026 13:10:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe8304sm7540824eec.17.2026.02.24.13.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 13:10:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 24 Feb 2026 13:10:53 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Siarhei Vishniakou <svv@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Roderick Colenbrander <roderick.colenbrander@sony.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: playstation: Center initial joystick axes to
 prevent spurious events
Message-ID: <fcaa494a-43ba-410e-ac2b-162f5b4814bc@roeck-us.net>
References: <20251111234519.369652-1-svv@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111234519.369652-1-svv@google.com>

On Tue, Nov 11, 2025 at 03:45:19PM -0800, Siarhei Vishniakou wrote:
> When a new PlayStation gamepad (DualShock 4 or DualSense) is initialized,
> the input subsystem sets the default value for its absolute axes (e.g.,
> ABS_X, ABS_Y) to 0.
> 
> However, the hardware's actual neutral/resting state for these joysticks
> is 128 (0x80). This creates a mismatch.
> 
> When the first HID report arrives from the device, the driver sees the
> resting value of 128. The kernel compares this to its initial state of 0
> and incorrectly interprets this as a delta (0 -> 128). Consequently, it
> generates EV_ABS events for this initial, non-existent movement.
> 
> This behavior can fail userspace 'sanity check' tests (e.g., in
> Android CTS) that correctly assert no motion events should be generated
> from a device that is already at rest.
> 
> This patch fixes the issue by explicitly setting the initial value of the
> main joystick axes (e.g., ABS_X, ABS_Y, ABS_RX, ABS_RY) to 128 (0x80)
> in the common ps_gamepad_create() function.
> 
> This aligns the kernel's initial state with the hardware's expected
> neutral state, ensuring that the first report (at 128) produces no
> delta and thus, no spurious event.
> 
> Signed-off-by: Siarhei Vishniakou <svv@google.com>
> Reviewed-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  drivers/hid/hid-playstation.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
> index 1468fb11e39d..a145b5ea4405 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
> @@ -718,11 +718,16 @@ static struct input_dev *ps_gamepad_create(struct hid_device *hdev,
>  	if (IS_ERR(gamepad))
>  		return ERR_CAST(gamepad);
>  
> +	/* Set initial resting state for joysticks to 128 (center) */
>  	input_set_abs_params(gamepad, ABS_X, 0, 255, 0, 0);
> +	gamepad->absinfo[ABS_X].value = 128;

input_set_abs_params() can fail to allocate absinfo. If that happens,
this will crash. AI suggests setting the value with input_abs_set_val()
to ensure that the value is checked before dereferencing.

Guenter

>  	input_set_abs_params(gamepad, ABS_Y, 0, 255, 0, 0);
> +	gamepad->absinfo[ABS_Y].value = 128;
>  	input_set_abs_params(gamepad, ABS_Z, 0, 255, 0, 0);
>  	input_set_abs_params(gamepad, ABS_RX, 0, 255, 0, 0);
> +	gamepad->absinfo[ABS_RX].value = 128;
>  	input_set_abs_params(gamepad, ABS_RY, 0, 255, 0, 0);
> +	gamepad->absinfo[ABS_RY].value = 128;
>  	input_set_abs_params(gamepad, ABS_RZ, 0, 255, 0, 0);
>  
>  	input_set_abs_params(gamepad, ABS_HAT0X, -1, 1, 0, 0);
> -- 
> 2.51.2.1041.gc1ab5b90ca-goo
