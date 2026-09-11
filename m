Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C771133938B;
	Fri, 11 Sep 2026 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135923; cv=none; b=tbTs4+68PfYxJMfc/Zeic0FWe/AK/cyz7W7X9zzSvluqU4iU0cHypFLozwzotMjkMxx/EqH0tAwpIUNc44mA0Nytu3XDL8xIr7NqzciYksFsSpvxj8/u8S6Dav8JOItKsf1VPJ+l41lC5W2+GSEU3WKJYTN0qs4Qic3ECG+KNXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135923; c=relaxed/simple;
	bh=Jw61qx3UrFw0zQGSgXhZPi46dyNcvRyhKKLIzhhZ0s8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jcNwQmP/603X5W217ZDhohF4iE1KojkpHNUjRyc3dwv2cSji4AJ1EVQXYsTC5UCgyjnZnyy3T78efJ7//35/h0Ut/83mdWmRQGFoW1WUMQaFKTL/VsYoZse5wpohi5zHmQzoxEr39PIy5Ov8g1yqQi/23ezDIpcpFvgEdVH2gqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyowtSCv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyowtSCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F131F008A2;
	Fri, 11 Sep 2026 14:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135922;
	bh=DHRFcYeNh4mZEXakuGMeCXHf6DhvQFtr4S94p/IFarw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=LyowtSCvZCRn58mjbGDt/Mbj1MeqyO/PWhpH5utqRbVcbw4fdTQNCkKoqXmF6GtFS
	 iOso1f0z2tYv2u5nzHNz3Ym1Al7iaDwZTAjcFhpviFUcGzUH4/k/2e9sneofkszmm4
	 LIbA/Mtrr9hcMbUdDpYfIQf2SoDLO2XSx4K1ZQupde962aMhMOYVfsh6zQwm+DJzlk
	 KWp+2CN7XiyUAnBsxS9xjKHrI/P5nvp9WyZxCGjF1pse22gnP+Yd8dB7hRrxLGmfcy
	 69lCfpZYXddzGLSMtvG5TeXtfCLPFrr2HkLCBoQiTctC9SWaqZ04qK1Zu19x1g4VmJ
	 F7PfW9mfpTupw==
Date: Fri, 11 Sep 2026 16:11:59 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Denis Benato <denis.benato@linux.dev>
cc: 'Benjamin Tissoires' <bentiss@kernel.org>, 
    'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, "Derek J. Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v3 2/2] Input: xpad - introduce a static table to ignore
 devices
In-Reply-To: <20260811125856.1692045-3-denis.benato@linux.dev>
Message-ID: <6598sn1p-p330-1r7o-q43p-r1rnr7nn0022@xreary.bet>
References: <20260811125856.1692045-1-denis.benato@linux.dev> <20260811125856.1692045-3-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 11 Aug 2026, Denis Benato wrote:

> Certain devices can work both as HID and as an xpad device: binding both
> would duplicate inputs causing userspace to receive double inputs; at the
> same time if a HID device is available it is to be preferred as it can
> support additional features such as integrated IMU and additional buttons
> and more, depending on the specific driver, therefore allow only the
> best driver available to bind the device.
> 
> Suggested-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Denis Benato <denis.benato@linux.dev>

I'd like to have Dmitry's Ack on this one before taking the Flydigi 
support through the HID tree.

Thanks.

> ---
>  drivers/input/joystick/xpad.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834..545119a4fb36 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -406,6 +406,18 @@ static const struct xpad_device {
>  	{ 0x0000, 0x0000, "Generic X-Box pad", 0, XTYPE_UNKNOWN }
>  };
>  
> +#define XPAD_SUBSTITUTE(_vid, _pid, _enabled) \
> +	{ .vid = (_vid), .pid = (_pid), .enabled = (_enabled) }
> +
> +static const struct xpad_excluded_device {
> +	u16 vid;
> +	u16 pid;
> +	bool enabled;
> +} xpad_excluded_devices[] = {
> +	XPAD_SUBSTITUTE(0x37d7, 0x2401, IS_ENABLED(CONFIG_HID_FLYDIGI)),
> +	{ }
> +};
> +
>  /* buttons shared with xbox and xbox360 */
>  static const signed short xpad_common_btn[] = {
>  	BTN_A, BTN_B, BTN_X, BTN_Y,			/* "analog" buttons */
> @@ -2044,11 +2056,23 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>  	struct usb_device *udev = interface_to_usbdev(intf);
>  	struct usb_xpad *xpad;
>  	struct usb_endpoint_descriptor *ep_irq_in, *ep_irq_out;
> +	const struct xpad_excluded_device *excluded;
>  	int i, error;
>  
>  	if (intf->cur_altsetting->desc.bNumEndpoints != 2)
>  		return -ENODEV;
>  
> +	for (excluded = xpad_excluded_devices;
> +	     excluded->vid || excluded->pid;
> +	     excluded++) {
> +		if (!excluded->enabled)
> +			continue;
> +
> +		if (le16_to_cpu(udev->descriptor.idVendor) == excluded->vid &&
> +		    le16_to_cpu(udev->descriptor.idProduct) == excluded->pid)
> +			return -ENODEV;
> +	}
> +
>  	for (i = 0; xpad_device[i].idVendor; i++) {
>  		if ((le16_to_cpu(udev->descriptor.idVendor) == xpad_device[i].idVendor) &&
>  		    (le16_to_cpu(udev->descriptor.idProduct) == xpad_device[i].idProduct))
> -- 
> 2.47.3
> 

-- 
Jiri Kosina
SUSE Labs

