Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1625A1643B
	for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770915646; cv=none; b=s+gYhKZfkDXyCFTKZrlBzx3+KhjalREBJDKTZup5f+P32EEVRhB3xtXviZ1bDJPjGU+2gnfdo7XC5HdazkuO+cs3FS32kAentkXCEO2PpLSmET3IHPYysuCS9JjeCYRjsdSWnRLxrwnBuq3lhEcL3bv9Ot9/7QX6LwpcnZcIShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770915646; c=relaxed/simple;
	bh=tkagtN+Ha0hPGnRQeJmX+TMEY67RVlUFRzkD9okT48s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAtTOjGVIzFO92LN67J2Xwq9bdHcIoJq95l+0BY0OsHfUVm6T4UCrW/xRMWXwxVkNR4w1HLcdlVPU4DNudbXNxmfUTLewPcrRb/YBcfODhjnuD04xq7S/FU7QoW1pKisnSQIlPmc2Nc6tPKbVJ4O/Qaznw5D/G1AI2CYNxXz0a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pm6EvDcD; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm6EvDcD"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b740872a01so31754eec.1
        for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 09:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770915644; x=1771520444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZeOfMJihFk2Pkr4N9v4cABUQOn7003bjsW+FPVxdko=;
        b=Pm6EvDcDHYJgnFRTpCyv0d/sso5oWT8TgLRGQT18xfOZ0gUHxDUnNqqOzpb+THb+q2
         OmHwjkjnnt1Jy/u9M9wlWM2AkMiS0ecQEKPAHfV/iD4bcm91+E7ZE6ogD1n7KcF6wp3R
         8ITf7kJ+I42L2ozFcnBweqAOCtvTxGtimHii3YwHtfJKjU5yr1xW+pD1nrPVo59fnSzj
         0w29JxbFCWXY6jYfc7hD9VWE6ILQa4lQbs/mHfKQkwivwo6ndVjktt70pdmqT1dWPeyT
         Xxm4Bol5vWqTr/Gj+lfiGm8n6/phHKcqJ7FN8gVqhKjq6s1TkMECAQD2FQcsh0TSqXZv
         0g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770915644; x=1771520444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZeOfMJihFk2Pkr4N9v4cABUQOn7003bjsW+FPVxdko=;
        b=H7F5fQGstwSOnKV+w7QRhH/NeloOXPdaJg6PNd/r1tu66UVFbA+XfC0sG0DHU2+JX5
         lQQCgaktq51bsNBA3HDuGyYhPLygiJYq6qYwPCrloItOLdvbRT5XE4Trz0VAmiaSYDXv
         LxlfQVg4vmo01Q65VOdYuvJXRUESkUKqscGUYOBDxu7kWZ+8WFCEQqSlaEeTD6zG5ZbU
         W5QPJ/LEfbEWDOaeF/9Jh+l44UaO2/ay+VAWXL1XEE0PPwxgH6R70ePyViMegNyktqNH
         eHblEJnjl64pX+WxRthRIJub5Ndc3pgCJwz0Ywz1sy3iSkUs8aMXIIMc7mWwgFO7Wh4E
         zMUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcKnR4eH5EfDnncDzl+Yf6HxT79F+Keoz4qh1PJanP/ND7S7+YHUA6PGwSoBiZ4xJ9doN0nKlnlJSauA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+yoW0/xVbPS8gn6xr14ZsFFxGav1EC0NTWIkvVeVqGgJZWlM
	cgIcqefFAfP0yyICdOCAPFREZyMvad1CkEPoNdDanfZ3tbL8eEqJ/+kQ
X-Gm-Gg: AZuq6aJGfhgAo+Lqndysm4sHid36cnIVqVu1kcDh8MtEY3Ld+IbUCUt3jAU2T1Ntkir
	PuJDlCmeUy9ChhL8VhgF4u23eW8tgTFTu074sT+SQdfIpRC+fNdRWLSbk9l7wbUo8Mh5jeZXCIy
	o4I8fLm1eygN904XnSxP4sOSo2D2Lu1B/g2EKfxCSnV+5VTbfnTo0JgB1Y6pr/5lZCAjGeZTdVp
	DYLl36YWb7jOdSvnQAfR9k9b/RP/tocfhyUAgRfR4y3uH0ZRVzodizbV+5L7FZ4x5pauJ9stHBE
	E8OQ1qo+RXkiFcXs/WHd7M3kNgVeKKLs/JLFvpkcOVuJzZeLTWtPBL7/jnorRqnT5buyn31fC2G
	9HDPKdHFkEP12HfOnF0AABLuyOEKCJC7ayKCPFRCA/sSgEvzJyB/u66CDmU32NxFsQbJpiU+0ng
	7sPO1nmjtDoweF3Ru5ur5wySvh09ce0o9SDyz6yJLbpLFNAXfzOEHjciicTF+hTh4=
X-Received: by 2002:a05:7300:3211:b0:2b7:ee0e:e9ba with SMTP id 5a478bee46e88-2baac5939c1mr924343eec.10.1770915642368;
        Thu, 12 Feb 2026 09:00:42 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f5e:c935:ddee:63d0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd01d1sm4616421eec.17.2026.02.12.09.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 09:00:41 -0800 (PST)
Date: Thu, 12 Feb 2026 09:00:39 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Liam Mitchell <mitchell.liam@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcm5974: recover from failed mode switch
Message-ID: <aY4FgAsSYx4niIG3@google.com>
References: <20260207-bcm5974-reset-v1-1-af7163903fa6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207-bcm5974-reset-v1-1-af7163903fa6@gmail.com>

Hi Liam,

On Sat, Feb 07, 2026 at 06:16:26PM +0100, Liam Mitchell wrote:
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
> ---
>  drivers/input/mouse/bcm5974.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> index dfdfb59cc8b5..85ddd65f2603 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -286,6 +286,8 @@ struct bcm5974 {
>  	const struct tp_finger *index[MAX_FINGERS];	/* finger index data */
>  	struct input_mt_pos pos[MAX_FINGERS];		/* position array */
>  	int slots[MAX_FINGERS];				/* slot assignments */
> +	struct work_struct mode_reset_work;
> +	unsigned long last_mode_reset;
>  };
>  
>  /* trackpad finger block data, le16-aligned */
> @@ -696,6 +698,34 @@ static int bcm5974_wellspring_mode(struct bcm5974 *dev, bool on)
>  	return retval;
>  }
>  
> +/*
> + * Mode switches sent before the control response are ignored.
> + * Fixing this state requires switching to normal mode and waiting
> + * 1ms before switching back to wellspring mode.
> + */
> +static void bcm5974_mode_reset_work(struct work_struct *work)
> +{
> +	int error;
> +	struct bcm5974 *dev = container_of(work, struct bcm5974, mode_reset_work);
> +
> +	mutex_lock(&dev->pm_mutex);

	guard(mutex)(&dev->pm_mutex);

> +	dev->last_mode_reset = jiffies;
> +
> +	error = bcm5974_wellspring_mode(dev, false);
> +	if (error) {
> +		dprintk(1, "bcm5974: reset to normal mode failed\n");

		dev_err(...);

> +		goto out;

		return;
> +	}
> +
> +	msleep(1);

This duration is too short for msleep(). Use usleep_range() of fsleep().

> +
> +	error = bcm5974_wellspring_mode(dev, true);
> +	if (error)
> +		dprintk(1, "bcm5974: mode switch after reset failed\n");

		dev_err(...);
> + out:
> +	mutex_unlock(&dev->pm_mutex);

Explicit unlock is not needed with guard().

> +}
> +
>  static void bcm5974_irq_button(struct urb *urb)
>  {
>  	struct bcm5974 *dev = urb->context;
> @@ -752,10 +782,18 @@ static void bcm5974_irq_trackpad(struct urb *urb)
>  	if (dev->tp_urb->actual_length == 2)
>  		goto exit;
>  
> -	if (report_tp_state(dev, dev->tp_urb->actual_length))
> +	if (report_tp_state(dev, dev->tp_urb->actual_length)) {
>  		dprintk(1, "bcm5974: bad trackpad package, length: %d\n",
>  			dev->tp_urb->actual_length);
>  
> +		/* HID packet means we aren't in wellspring mode */
> +		/* If we haven't tried a reset in the last second, try now */
> +		if (dev->tp_urb->actual_length == 8 &&
> +		    time_after(jiffies, dev->last_mode_reset + msecs_to_jiffies(1000))) {
> +			schedule_work(&dev->mode_reset_work);
> +		}
> +	}
> +
>  exit:
>  	error = usb_submit_urb(dev->tp_urb, GFP_ATOMIC);
>  	if (error)
> @@ -906,6 +944,8 @@ static int bcm5974_probe(struct usb_interface *iface,
>  	dev->intf = iface;
>  	dev->input = input_dev;
>  	dev->cfg = *cfg;
> +	dev->last_mode_reset = 0;

No need to initialize with 0, kzalloc() takes care of this.

> +	INIT_WORK(&dev->mode_reset_work, bcm5974_mode_reset_work);
>  	mutex_init(&dev->pm_mutex);
>  
>  	/* setup urbs */
> @@ -998,6 +1038,7 @@ static void bcm5974_disconnect(struct usb_interface *iface)
>  {
>  	struct bcm5974 *dev = usb_get_intfdata(iface);
>  
> +	cancel_work_sync(&dev->mode_reset_work);

Use disable_delayed_work_sync() instead to ensure it will not get
re-triggered.

>  	usb_set_intfdata(iface, NULL);
>  
>  	input_unregister_device(dev->input);

Thanks.

-- 
Dmitry
