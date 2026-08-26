Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF55372075;
	Wed, 26 Aug 2026 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731354; cv=none; b=MSJs6aboUkUbrBYLJ4xnUB22rOH9RPsJ0mlhKeE4HSJoZFrfNzFIVaTl0E8r8Su7a9vFPB8iAvCb0VmTwp0TOm/bDpVu/dhOL7veW6ccnh5Ps/7nhZHkoUT8hsL8xE2VASTp6dq3zSjUnQQxGItRaHS/B9eNUqs+gAotxObrZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731354; c=relaxed/simple;
	bh=copsQuQ+7LWuePYLQu2DspiCiq4Z8/5egXVPdidzlCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+jWvBEfmbIvuuCBvSSJCN6WTw6FdpKsNd2XslHzljtungnPDDTlmxJeoXWYL57RKTtwqLE9d9CoHAQ8EDvWsLTsqU39fuBkLN+g7NIIT7YkiiqpgYOFwIDcERytwX3YQzshrQ90xWtCFMpZrPHsLWj71cYpvPQMV+uGs6g2Z9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSb6Te3M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSb6Te3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7021F000E9;
	Wed, 26 Aug 2026 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787731352;
	bh=AvJRWH1EHoXHVvwLWaRnoobzlnGUu/Pviz00kCYGYeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kSb6Te3Mrhv+AKVDRB+vzLxn0bgI+yvjo1h5KyFFdiH1L83kApBWw+G4bU9V8zJ+C
	 OTU/KbnxFg8IgK5RTWiYa0pprjfTPAJzf0CKYBLxktSuDdOgyp2dx8YVBfSyMgf63f
	 9ySMDV/IReMqtNUeW1S+OrdJdsP7UWc0rlSOd1hXYbrT6YaU+yyR7hWDsNiH1cSalr
	 9jxOcuYOZZhm3xzILTI8be/uKL5BjmE9GmyTPACfWKPWGZX4VqoPAKUb26/LqVhMso
	 7XIwpulW3qEms81aKcSX3LzP4qKuxAr32Q8jvyNs4jgZmWI/s8Y0RBCQ8zqgVc0Dpb
	 6N0lLa70YkdMg==
Date: Wed, 26 Aug 2026 09:02:28 +0100
From: Lee Jones <lee@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH 2/5] HID: wacom: Advertise SW_MUTE_DEVICE capability
 prior to registration
Message-ID: <20260826080228.GD770273@google.com>
References: <20260825151242.576456-1-lee@kernel.org>
 <20260825151242.576456-2-lee@kernel.org>
 <20260825172520.CE4941F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260825172520.CE4941F00A3A@smtp.kernel.org>

On Tue, 25 Aug 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Infinite probe deferral if sibling interface is a Pad or unsupported HID device
> - [Medium] TOCTOU race condition in shared capabilities advertisement

Looking into this now.

It's frustrating that my local Sashiko didn't flag this.

> Pre-existing issues:
> - [High] Use-After-Free of devm-allocated driver data on probe error path
> --
> 
> commit 4eb131c54fac495d482614e8b0c028a0f23f19f7
> Author: Lee Jones <lee@kernel.org>
> 
> HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
> 
> This patch moves the SW_MUTE_DEVICE capability setup before input device
> registration to comply with input subsystem guidelines. For generic touch
> devices relying on a sibling Pen or Pad interface, it defers registration
> via -EPROBE_DEFER until the shared capabilities are initialized.
> 
> > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > index 0eafa483b7f75..2738d4f515e6a 100644
> > --- a/drivers/hid/wacom_sys.c
> > +++ b/drivers/hid/wacom_sys.c
> 
> [ ... ]
> 
> > @@ -2358,13 +2358,44 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
> >  		if (wacom_wac->is_soft_touch_switch)
> >  			wacom_wac->shared->is_touch_on = true;
> >  	}
> > +}
> > +
> > +static bool wacom_sibling_pending(struct wacom *wacom)
> > +{
> > +	struct hid_device *hdev = wacom->hdev;
> > +	const struct wacom_features *features = &wacom->wacom_wac.features;
> > +	struct usb_host_config *actconfig;
> > +	int i;
> > +
> > +	if (features->type != HID_GENERIC ||
> > +	    !(features->device_type & WACOM_DEVICETYPE_TOUCH))
> > +		return false;
> > +
> > +	if (wacom->wacom_wac.shared &&
> > +	    rcu_access_pointer(wacom->wacom_wac.shared->pen))
> > +		return false;
> > +
> > +	if (!hid_is_usb(hdev) || !wacom->usbdev)
> > +		return false;
> >  
> > -	if (wacom_wac->shared->has_mute_touch_switch &&
> > -	    wacom_wac->shared->touch_input) {
> > -		set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
> > -		input_set_capability(wacom_wac->shared->touch_input, EV_SW,
> > -				     SW_MUTE_DEVICE);
> > +	if (features->oPid != HID_ANY_ID && features->oPid != 0)
> > +		return true;
> > +
> > +	actconfig = wacom->usbdev->actconfig;
> > +	if (actconfig && actconfig->desc.bNumInterfaces > 1) {
> > +		for (i = 0; i < actconfig->desc.bNumInterfaces; i++) {
> > +			struct usb_interface *sibling_intf = actconfig->interface[i];
> > +
> > +			if (!sibling_intf || sibling_intf == wacom->intf)
> > +				continue;
> > +
> > +			if (sibling_intf->cur_altsetting->desc.bInterfaceClass ==
> > +			    USB_INTERFACE_CLASS_HID)
> > +				return true;
> > +		}
> >  	}
> > +
> > +	return false;
> >  }
> 
> [Severity: High]
> Could this lead to infinite probe deferral if the sibling interface is a Pad
> or an unsupported HID device?
> 
> If a composite Wacom device presents a generic Touch interface and a Pad
> interface (without a Pen), or a generic HID interface not handled by this
> driver, this loop will return true indefinitely. The logic requires
> shared->pen to be populated to stop deferring, but wacom_add_shared_data()
> only populates shared->pen for Pen interfaces, leaving the Touch device
> unusable.
> 
> >  static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
> > @@ -2444,6 +2475,11 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
> >  	if (error)
> >  		goto fail;
> >  
> > +	if (wacom_sibling_pending(wacom)) {
> > +		error = -EPROBE_DEFER;
> > +		goto fail;
> > +	}
> > +
> >  	error = wacom_setup_inputs(wacom);
> 
> [Severity: High]
> This is a pre-existing issue, but does the error path in this function fail
> to cancel scheduled asynchronous works, leading to a Use-After-Free?
> 
> If wacom_query_tablet_data() schedules init_work with a delay, and a
> subsequent step like hid_hw_open() fails:
> 
> wacom_parse_and_register() {
>     ...
>     if (!wireless) {
>         wacom_query_tablet_data(wacom); /* schedules init_work */
>     }
>     ...
>     if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
>         error = hid_hw_open(hdev);
>         if (error) {
>             goto fail_hw_stop;
>         }
>     }
>     ...
> fail_hw_stop:
>     hid_hw_stop(hdev);
> fail:
>     wacom_release_resources(wacom);
>     return error;
> }
> 
> The error path returns and the driver core devres cleanup frees the
> struct wacom. When the delayed work later executes, it will access the
> freed memory. Should the error path explicitly cancel pending works?
> 
> > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> > index 4436faf2d2bbd..a7e3817aa2c4f 100644
> > --- a/drivers/hid/wacom_wac.c
> > +++ b/drivers/hid/wacom_wac.c
> 
> [ ... ]
> 
> > @@ -3965,6 +3965,10 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
> >  
> >  	if (features->type == HID_GENERIC) {
> >  		hid_dbg(hdev, "generic touch setup\n");
> > +		if (wacom_wac->shared && wacom_wac->shared->has_mute_touch_switch) {
> > +			input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
> > +			wacom_wac->has_mute_touch_switch = true;
> > +		}
> >  		/* setup has already been done */
> >  		return 0;
> >  	}
> 
> [Severity: Medium]
> Is there a Time-of-Check to Time-of-Use (TOCTOU) race condition here when
> enumerating concurrent USB interfaces?
> 
> In wacom_add_shared_data(), the Pen interface publishes itself to
> shared->pen early. If the Touch device probe concurrently reads shared->pen
> in wacom_sibling_pending(), it will break out of its deferral loop. However,
> it may reach this point and read shared->has_mute_touch_switch before the
> Pen device has finished parsing its descriptors and written to it in
> wacom_set_shared_values(), causing the Touch device to miss advertising
> the capability.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260825151242.576456-1-lee@kernel.org?part=2

-- 
Lee Jones
