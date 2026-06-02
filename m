Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77A3B9929;
	Tue,  2 Jun 2026 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387168; cv=none; b=UmFabxH7w+DvRBW6Fwp2l4lxTfUmxfp8gHwa+Oe+2rcicF0b9s+nBvebG5CHukyDdKc3IdZ+1efiNbM3VaLOFsjs2GyHgGf3nQ0KpOovkZo4alhzXrnL5ZQ/2ov7H9IksGtmHTms8z6C6SfxUc/NJJugPhgFewhoHmBwRt6QTVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387168; c=relaxed/simple;
	bh=1fInf/0Iu2rHA+I9iTiBQFUepJR8fl3xSJczy3BIwo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t64hVVS7nUtigY4JysUNsdpuCR18h+7p0lx6x2AwGTRR2lpA3zgodDH0X1bKn7Kog1jH9VwXwbkh1ergGCL90JakfpchgDK/sNl2c7k2ntS7tO5MBfazkLGx6IkICDYizUEL5s00bSeqE2WramGLJDQ0QJs5CzGPfh7LRe2gs0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX/ZzL7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX/ZzL7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3631F00893;
	Tue,  2 Jun 2026 07:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780387167;
	bh=XJ34OUFMY/bD4gOylrim+7n96gnMhVnq5U6A3Pfm7y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PX/ZzL7YH+MBHh+kX1zYV/v1fkdXyqwo34GEe/hZb9bCOYml+E0eaOF9smO5sGdl7
	 qgJ5MfeIQL34ceDpbnIi13nZS09FKrLmBafVz6OpA6qwwU9t6g9Mt4lcxmAryfLh7B
	 USaMVOdYwi/Vcf7Bp3v++UePW3ZW/wrf+J2XMFWSJ/fY6ZTLPPXnSqUyPW5iO+DAX/
	 wRbiaD2w+GEfYuX2wk5iofXacyqZ4l9g+Bdg6XjoEluwM6MTr9K8XewQDQaBHJvfqb
	 rkhi2+Ou74az0JVCVlEut0ZWtx9/Fogqio8CuZTHctucfzAPYBifEsSMJ99DH5iLv5
	 gudMdefRJqs5g==
Date: Tue, 2 Jun 2026 09:59:23 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Danny Kaehn <danny.kaehn@plexus.com>, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH v14 2/2] HID: cp2112: Configure I2C bus speed from
 firmware
Message-ID: <ah6MeSb-NlzniiCA@beelink>
References: <20260520-cp2112-dt-v14-2-b1b4b6734b6f@plexus.com>
 <20260520174401.BDE571F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520174401.BDE571F00893@smtp.kernel.org>

On May 20 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Medium] The driver silently overwrites custom hardware I2C clock speeds with a 100kHz default for devices without firmware nodes.
> 
> Pre-existing issues:
> - [High] Firmware nodes are attached to device structures without holding a reference, leading to a dangling pointer and use-after-free.
> - [High] The delayed work `gpio_poll_worker` is not canceled in the probe error path, leading to a use-after-free if the probe fails.
> --
> 
> commit 07ff467e4d8df706a7a27476591cd82570fb8287
> Author: Danny Kaehn <danny.kaehn@plexus.com>
> 
>     HID: cp2112: Configure I2C bus speed from firmware
>     
>     Now that the I2C adapter on the CP2112 can have an associated firmware
>     node, set the bus speed based on firmware configuration.
> 
> > diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> > index e960fc988058f..04379db93571b 100644
> > --- a/drivers/hid/hid-cp2112.c
> > +++ b/drivers/hid/hid-cp2112.c
> [ ... ]
> > @@ -1308,6 +1309,9 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  		goto err_power_normal;
> >  	}
> >  
> > +	i2c_parse_fw_timings(&dev->adap.dev, &timings, true);
> > +
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this new call dereference
> a dangling pointer?

Cleaning up the refcounting in the previous patch would solve this
(false positive, admitedly).

> 
> Earlier in cp2112_probe(), the reference to the child firmware node is
> dropped either explicitly via fwnode_handle_put(child) in the OF path, or
> implicitly when the fwnode_for_each_child_node loop iterates or completes
> in the ACPI path:
> 
> 	} else if (is_of_node(cp2112_fwnode)) {
> 		child = fwnode_get_named_child_node(cp2112_fwnode, "i2c");
> 		device_set_node(&dev->adap.dev, child);
> 		fwnode_handle_put(child);
> 	}
> 
> device_set_node(&dev->adap.dev, child) assigns the pointer without taking
> its own reference, leaving dev->adap.dev.fwnode as a dangling pointer.
> 
> This newly added i2c_parse_fw_timings() call dereferences this released
> fwnode via device_property_read_u32().
> 
> Could this lead to a use-after-free?
> 
> > +	config.clock_speed = cpu_to_be32(timings.bus_freq_hz);
> 
> [Severity: Medium]
> Since use_defaults is set to true, does this overwrite custom hardware I2C
> clock speeds with a 100kHz default for devices without firmware nodes?
> 
> Before this patch, it looks like cp2112_probe() read the current SMBus
> configuration from the device, only modified retry_time, and wrote it back.
> This preserved the device's original configured clock speed (which might be
> set to 400kHz in the EEPROM).
> 
> By calling i2c_parse_fw_timings() with an uninitialized local timings
> struct and use_defaults = true, timings.bus_freq_hz will be
> unconditionally set to 100kHz if the device lacks a firmware property.
> 
> Is it intended to silently downgrade the speed and override user-configured
> EEPROM settings?

I think we should fix this:
i2c_parse_fw_timings(&dev->adap.dev, &timings, false);
if (timings.bus_freq_hz)
    config.clock_speed = cpu_to_be32(timings.bus_freq_hz);

> 
> [Severity: High]
> This is a pre-existing issue, but is there a missing cancellation of the
> delayed work in the probe error path?

This one would be nice to fix in a follow up patch.

> 
> If sysfs_create_group() fails during probe, the code jumps to the
> err_gpiochip_remove label, which calls gpiochip_remove(&dev->gc) and
> returns:
> 
> 	ret = sysfs_create_group(&hdev->dev.kobj, &cp2112_attr_group);
> 	if (ret < 0) {
> 		...
> 		goto err_gpiochip_remove;
> 	}
> 	...
> err_gpiochip_remove:
> 	gpiochip_remove(&dev->gc);
> err_free_i2c:
> 
> Because gpiochip_add_data() was already called, an IRQ consumer could have
> concurrently requested a GPIO line, triggering cp2112_gpio_irq_startup()
> and queuing dev->gpio_poll_worker.
> 
> Unlike cp2112_remove(), the error path lacks a call to
> cancel_delayed_work_sync(&dev->gpio_poll_worker).
> 
> Could this mean the queued work will execute on freed memory?
> 
> >  	config.retry_time = cpu_to_be16(1);
> >  
> >  	ret = cp2112_hid_output(hdev, (u8 *)&config, sizeof(config),
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com?part=2
> 

Cheers,
Benjamin
