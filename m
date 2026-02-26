Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF4319605;
	Thu, 26 Feb 2026 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772146385; cv=none; b=mWCt6ZEvVgGgLM6j7mGDN9edv6Vm7+MDtaX1C1XxlhmaxlTd7Z3QjyDx5ypTwvtkXms1/zwIFKOG/ubZhf+y38a+nvnY+fAkQjYQ5Cwu59+G+Hf3FP8TQBuHoQxMIS9Oic8BH53m2hm0n+JJD6OKxXY0zFDew7VjHyGf65NMqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772146385; c=relaxed/simple;
	bh=ypZSQ6W0HwbVo8oJo+Ok9nykDWW9BfgyHR9nwioCPPo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l9vBESz5vkspEhK5EQ1c/s8E0zMr3snakmCis+GETs/F75zk46hVAY84K6VI2jf2LmMHEXNhuqtDBmEOwTofY47yg08eMGJENraZ+MSduLZS7U3H36u202RgWDsTWzr16gull4eQfG/aaEC0SFD6FHd36kk1rSXQOprP/ykQ8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKEj4BX5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKEj4BX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37496C116C6;
	Thu, 26 Feb 2026 22:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772146384;
	bh=ypZSQ6W0HwbVo8oJo+Ok9nykDWW9BfgyHR9nwioCPPo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=AKEj4BX5ZTVp6/tFni3Sl6z0g3dNt5hmA0ghe0yrYh2fP0rz4zBWvyYUIeHub3iro
	 +zYyBXBwXA4y1iPGPdsMBSGiPnX+qvOqm1HRDgPjNXTxmvX5tk/q6bKgzVDR3TJ+qj
	 g/cvQV0i+pg+LkCi3TWmPBiTm2tsK6wibyRQxttrzDa4OW2JKlRw76U8RB6bHDJYZV
	 PpnnMvB5sfQGVIBqmSjC0svctS+0OhxJrds++XabmRb0dLTUHcqoLMsntT26RtNWFW
	 NcAoBuLwnPUKQTOLxjBbUpMDjez743FsypgYQiLRnRm2GXzyHNBG7NUPqvffCP2QdJ
	 FeflF8eerAHTA==
Date: Thu, 26 Feb 2026 23:53:01 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Richard Hughes <hughsient@gmail.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/16] HID: Add Legion Go and Go S Drivers
In-Reply-To: <20260224013217.1363996-1-derekjohn.clark@gmail.com>
Message-ID: <743pr247-95p3-1q37-s084-ors2p7q5689r@xreary.bet>
References: <20260224013217.1363996-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Feb 2026, Derek J. Clark wrote:

> This series adds configuration driver support for the Legion Go S,
> Legion Go, and Legion Go 2 built-in controller HID interfaces. This
> allows for configuring hardware specific attributes such as the auso
> sleep timeout, rumble intensity, etc. non-configuration reports are
> forwarded to the HID subsystem to ensure no loss of functionality in
> userspace. Basic gamepad functionality is provided through xpad, while
> advanced features are currently only implemented in userspace daemons
> such as InputPlumber[1]. I plan to move this functionality into the
> kernel in a later patch series.
> 
> Three new device.h macros are added that solve a fairly specific
> problem. Many of the attributes need to have the same name as other
> attributes when they are in separate attribute subdirectories. The
> previous version of this series, along with the upcoming his-asus-ally
> driver[2] use this macro to simplify the sysfs by removing redundancy.
> An upcoming out of tree driver for the Zotac Zone [3] also found this
> macro to be useful. This greatly reduces the path length and term
> redundancy of file paths in the sysfs, while also allowing for cleaner
> subdirectories that are grouped by functionality. Rather than carry the
> same macro in four drivers, it seems beneficial to me that we include the
> macro with the other device macros.
> 
> A new HID uevent property is also added, HID_FIRMWARE_VERSION, so as to
> permit fwupd to read the firmware version of the Go S HID interface without
> detaching the kernel driver.
> 
> Finally, there are some checkpatch warnings that will need to be supressed:
> WARNING: ENOSYS means 'invalid syscall nr' and nothing else
> 1292: FILE: drivers/hid/lenovo-legos-hid/lenovo-legos-hid-config.c:1085:
> +       case -ENOSYS: /* during rmmod -ENOSYS is expected */
> 
> This error handling case was added as it is experienced in the real world
> when the driver is rmmod. The LED subsystem produces this error code in
> its legacy code and this is not a new novel use of -ENOSYS, we are simply
> catching the case to avoid spurious errors in dmesg when the drivers are
> removed.
> 
> [1]: https://github.com/ShadowBlip/InputPlumber/tree/main/src/drivers/lego
> [2]: https://lore.kernel.org/all/20240806081212.56860-1-luke@ljones.dev/
> [3]: https://github.com/flukejones/linux/tree/wip/zotac-zone-6.15/drivers/hid/zotac-zone-hid
> 
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
> Change Log
> v5:
>   - Make all RO attributes cache the data during probe using delayed
>     work for both drivers. All RW attributes are read in realtime to
>     ensure they match the device current state in the event of firmware
>     reset or a userspace application.
>   - Fix endianness of version strings and print as hex for Go driver.
>   - Remove reset__esume function. It was not being hit as the MCU of
>     both devices disconnects of suspend, forcing a reinit of the driver.
>     Udev or userpsace will need to set the OS Mode upon resume.
> v4: https://lore.kernel.org/linux-input/20260220070533.4083667-1-derekjohn.clark@gmail.com/
>   - Use dmabuf allocated per request for both drivers instead of a devm
>     preallocated buffer that is reused. This solves a bug where some
>     attributes couldn't be restored without manual writing after resume.
>   - Reduce the number of quirks and flags in the Go S init to only those
>     necessary. Previously they were duplicated from the Go driver but
>     everything except HID_CONNECT_HIDRAW was found to be unnessary
>     during operational testing.
>   - Clean up formatting for debug prints in Go S driver.
>   - Fix bugs in RGB driver for Go that caused the effect to switch to
>     solid when the speed or brightness was changed.
>   - Remove extraneous setting of os_mode member of drvdata when setting
>     os_mode. It will be read from the hardware in _show.
> v3: https://lore.kernel.org/linux-input/20260124014907.991265-1-derekjohn.clark@gmail.com/
>   - Fix Documentation formatting by removing extra + characters.
>   - Fix bugs in hid-lenovo-go-s IMU & TP RO attributes being tied to the
>     wrong _show function.
>   - Rename enume os_mode_index to os_mode_types_index to fix collision
>     with os_mode_index attribute.
>   - Remove accidental rename for enabled->enable attributes in patch 4
>   - Add SOB for Mario in patch 10 as Co-Developer.
> v2: https://lore.kernel.org/linux-input/20251229031753.581664-1-derekjohn.clark@gmail.com/
>   - Break up adding the Go S driver into feature specific patches.
>   - Rename Go S driver from lenovo-legos-hid to hid-lenovo-go-s and move
>     it out of a subdirectory.
>   - Drop the arbitrary uevent properties patch.
>   - Add Go series driver.
>   - Move DEVICE_ATTR_NAMED macros to device.h.
> v1: https://lore.kernel.org/linux-input/20250703004943.515919-1-derekjohn.clark@gmail.com/

This is now queued in hid.git#for-7.1/lenovo.

Thanks,

-- 
Jiri Kosina
SUSE Labs

