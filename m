Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127393446A7;
	Thu, 21 May 2026 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376940; cv=none; b=KgmB8msnkXiRDfJ9xDPX7fd7yvTo6vNPnL0lkMPRrGcXcGVhainhfJNfHe7G297FHsY8BHMvgcDE/rg+VPh7nMJimiGtQimADTlXVw21IbILMtXwuamzWaQwBxHWn04RkjFaSdfyrkd//HizzdiPjTvqsEzsucEtDAFhIEBqarg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376940; c=relaxed/simple;
	bh=+2A6WQ+qOGqgnQSutHyH8DdWAWhelvNyacDqJuVO37Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYLsqUt4uICuKW4B1P7wRab92VloHNs1HucIDQNCywm+8Z7U2Msm7VggB5/aZxgG9/Jb45Io6oY3Zxief4Ubf2feF8CDBm6rttEy351NFpd7uI7krDDuRDlwlkYKVr7+Rac1QXRg+OitJTwuGfOHQEH3DUM5Fgc2ac6ACesSVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOC3F15r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOC3F15r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A081F000E9;
	Thu, 21 May 2026 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376938;
	bh=H78zgcPxEtJJh1l/stWl8ZU7++vvlE8iXYA8ke5vqKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YOC3F15rFAV6OWUY3KID8kpURfJ3G4auRPtsnVXnNxIdrpuJ+XQ9fLjy/EXzWL/AT
	 FlmB1TSMMLlxnvF8tpOeZ24RVdE07RuSR9DC2zLaTp/FSpAdPpMzeKUxD3D5U0poQw
	 yXouajExipPEboqP1m8DT/1o+ehTc85KPWba1tyxF/5r/bACMzbSoPI4o9/A6z3ZLU
	 rw+l8q0ciLO4VLmwboWjkj1iLLxClblvU4PlqG8kSeXad+1FvqPcOqObQ3ix3enH4T
	 EDFNI4o+BBrZI8tUtlNvh/4hJ3NUnGO6oNXvde2fH22yvzRgKtMiUJGibNcbY3nIU0
	 tn9G6ktQKc9gQ==
Date: Thu, 21 May 2026 17:22:15 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Louis Clinckx <clinckx.louis@gmail.com>, linux-input@vger.kernel.org, 
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v2 1/2] HID: lenovo-go: reject non-USB transports in probe
Message-ID: <ag8ixPNLTlEpc9_c@beelink>
References: <e8f92f07a397f39680c72ca69a5ada9882ff7212.1778701376.git.clinckx.louis@gmail.com>
 <20260515152059.D38D6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515152059.D38D6C2BCB0@smtp.kernel.org>

On May 15 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [High] This problem wasn't introduced by this patch, but both drivers use a static global variable (`drvdata`) to store device state rather than allocating it per-device.
> - [High] This problem wasn't introduced by this patch, but multicolor LED configuration structs (`go_cdev_rgb` and `gos_cdev_rgb`) are declared as static global variables but are passed to `devm_led_classdev_multicolor_register()`.
> - [High] This problem wasn't introduced by this patch, but in `hid-lenovo-go.c`, the removal function `hid_go_cfg_remove()` fails to cancel the delayed workqueue `go_cfg_setup`.
> - [High] This problem wasn't introduced by this patch, but probe failures do not correctly unwind started hardware states and sysfs groups.
> - [High] This problem wasn't introduced by this patch, but a NULL pointer is passed to `memcpy` in `mcu_property_out()` when performing `GET_*` property requests.
> - [High] This problem wasn't introduced by this patch, but completion synchronization is broken in `mcu_property_out()` due to incorrect placement of `reinit_completion()`.
> --
> 
> commit 7a455849d3633575795dff10836095e31a4bbca3
> Author: Louis Clinckx <clinckx.louis@gmail.com>
> 
> HID: lenovo-go: reject non-USB transports in probe
> 
> These drivers only match HID_USB_DEVICE() entries and assume the
> underlying bus is USB. Make that explicit at probe by rejecting any
> non-USB hdev.
> 
> > diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
> > index 01c7bdd4fbe04..abf477e680428 100644
> > --- a/drivers/hid/hid-lenovo-go-s.c
> > +++ b/drivers/hid/hid-lenovo-go-s.c
> > @@ -1432,6 +1432,9 @@ static int hid_gos_probe(struct hid_device *hdev,
> >  {
> >  	int ret, ep;
> >  
> > +	if (!hid_is_usb(hdev))
> > +		return -EINVAL;
> > +
> 
> [ ... ]
> 
> >  	ret = hid_gos_cfg_probe(hdev, id);
> >  	if (ret)
> >  		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interface");
> 
> This isn't a regression from this patch, but do these probe failures
> leave the hardware state active?
> 
> If hid_gos_cfg_probe() fails, the code returns the error immediately without
> calling hid_hw_close(hdev) and hid_hw_stop(hdev).
> 
> Additionally, does sysfs_create_groups() need to be rolled back if later
> steps in the config probe fail?
> 
> >  	dev_dbg(&hdev->dev, "Started interface %x as Go S configuration interface\n", ep);
> >  	return ret;
> >  }
> 
> [ ... ]
> 
> > diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> > index d4d26c7833563..3fa1fe83f7e5e 100644
> > --- a/drivers/hid/hid-lenovo-go.c
> > +++ b/drivers/hid/hid-lenovo-go.c
> > @@ -2419,6 +2419,9 @@ static int hid_go_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  {
> >  	int ret, ep;
> >  
> > +	if (!hid_is_usb(hdev))
> > +		return -EINVAL;
> > +
> 
> [ ... ]
> 
> >  	ret = hid_go_cfg_probe(hdev, id);
> >  	if (ret)
> >  		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interface\n");
> 
> This isn't a regression from this patch, but does this early return
> bypass hid_hw_close(hdev) and hid_hw_stop(hdev) as well?
> 
> >  	dev_dbg(&hdev->dev, "Started Legion Go HID Device: %x\n", ep);
> >  
> >  	return ret;
> >  }
> 
> [ ... ]
> 
> This isn't a regression from this patch, but does the use of a static
> global drvdata struct cause data races when multiple devices are connected?

I suspect this is relatively safe because of the nature of the device: a
handled one so the chances that 2 USB devices using the same driver are
low, but it would be nice to address sashiko's comments in a followup
series. Derek, could you have a depper look, please?

Cheers,
Benjamin

> 
> Since drvdata is shared, functions like mutex_init() and init_completion()
> called during probe() would re-execute on the same memory space. Could this
> cause type confusion over drvdata.hdev and memory corruption from concurrent
> sysfs accesses or input events?
> 
> This isn't a regression from this patch, but do the static global
> go_cdev_rgb and gos_cdev_rgb structs corrupt the kernel's global leds_list?
> 
> The led framework embeds a struct list_head into the led_classdev structure.
> If devm_led_classdev_multicolor_register() is called for multiple devices
> using the same static struct, it would double-add the list node.
> 
> Would unbinding one device then unlink the shared struct, leading to a
> use-after-free when the other device is later accessed or removed?
> 
> This isn't a regression from this patch, but does hid_go_cfg_remove()
> need to cancel the go_cfg_setup delayed workqueue?
> 
> If the controller is rapidly unplugged after hid_go_cfg_probe() schedules
> drvdata.go_cfg_setup, hid_go_cfg_remove() will tear down the device.
> Without calling cancel_delayed_work_sync(), could the workqueue execute
> and dereference the freed hdev pointer in mcu_property_out()?
> 
> This isn't a regression from this patch, but does mcu_property_out() pass
> a NULL pointer to memcpy() during get property commands?
> 
> Callers intentionally pass NULL as the data pointer and 0 as len for these
> commands. Since passing NULL to memcpy() is undefined behavior even when
> len is 0, could this trigger sanitizer violations?
> 
> This isn't a regression from this patch, but is the completion
> synchronization in mcu_property_out() susceptible to spontaneous hardware
> events?
> 
> Because reinit_completion() is called at the end of mcu_property_out(), if
> hid_go_raw_event() invokes complete() due to spontaneous events or multiple
> responses, the completion object could be left in a signaled state.
> 
> Would the next call to wait_for_completion_interruptible_timeout() then
> return instantly and provide stale or uninitialized memory to user-space?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1778701376.git.clinckx.louis@gmail.com?part=1
> 
