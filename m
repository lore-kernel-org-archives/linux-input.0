Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB931282F
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 04:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789102468; cv=none; b=ut9EX559Qjq8xxcPUTwuz6Tn/1PouyT6T7PYRR+YSaThgT5S2EyrJ/0+OClxKZipaOwFKQiriKVISjefXglTnLlThOImOFaQ9ISOslwXPjbIoHQx9vUOuBAgE20dWrHh0tPQQknSt2m21SmOAufodrD8691PMeuOzrXSkXRneTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789102468; c=relaxed/simple;
	bh=WY5bY4BH3alMkwZgCvPT8IWgmqIbk4E3qEmfdJU6RqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnGBTbGL0apgnZF0oG4gPpJAhofUDKrtdco9iAhv7p0GN42AhDmVOFqolMay1RoUXLnFr0pL8+vR/bv7tzDO7IbuJJaz1Y3P15ttbYuubTC3K4a6vQUUIYlsPNlmIa+z7GFPOe5oLFWv5r2OEYeiey1l6/oPTFin0Kf29Vt0oec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD+Bn0vD; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD+Bn0vD"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c112aaaf04so422420b6e.1
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 21:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102466; x=1789707266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EvsmNcwc934PZgzPHOzcBHOJAVFXVErbLecWRacl4K0=;
        b=YD+Bn0vDQrVV4QMaZcKLaLIRBZ9rpT9Wfy7guVQu+tt4sVQDc+h4xNFdiTZOlAgi9t
         PWg3SXMKOJRJGPWJ6H2xoMaChtcnnVBJiv5UQ1D3y2Q38fx96z9S3oNLrRooPP23+1/V
         7y665BfEfK6n1MyZG5wDVy2roz1H/p3kTomCQvg5PCQVR93dbAGvSUyGq8lXKeHDc67I
         qWGKns1+yFZjQlots+uFjWR4+jlN/PkjTsj7pQEdbmBlhR6xwidxa0aewjZW2kEh8UoO
         0+eiJtClTucRRWfjI6aX/dnbO7138cskaZ4pU3SKDHmTIgQg9riDdeyHo3HtDTJStDuQ
         MMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102466; x=1789707266;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EvsmNcwc934PZgzPHOzcBHOJAVFXVErbLecWRacl4K0=;
        b=M6RURSjh8/+DypEZgm9q5rZTDUWP3fHQUjdcyRTgnvqfjUkabW60Irhr/92SMzMVvo
         +jARK+AvZbKgY6VVt10RBssDBliQGgQyU32cF5P4yV8vA758YmUGSGP4G67HToqiJkJe
         oHQNrqCWU+ahgsVxTHsTbkdVIly1MQ4OT4MyN3actRPGVbJnqXwE4sROm80NsBrOxfsd
         tE0wltYURFaCXia6gg8MOtew/17ICQD1d2mZpY1Gbo29YOBgOxJGrkqwQTeNbRRa75+m
         XyhTS3JjzLkx0KvQJNwDkD/dzNC+zJQq+hLF1H1GgkM0MrMe8afwOr7KN4j9TWhS3Ell
         Ox3A==
X-Forwarded-Encrypted: i=1; AKwUvBzJ4au98Xo3Uacq+YOXZ6k0T+P3xEox/CRq48uT8X+1XV3KfQdKfRun+ufQiQ4p2aSy9xzenQjCg9DbWQ==@vger.kernel.org
X-Gm-Message-State: AFuF++njLb4u1vOHQpf5hafVBOOxbokjVx2XkGWV3MgfdCRj+Ve2DJbE
	n7Zh1mvvTJfxN89pX3OcG6C2gMsiXR73xBQvxAS4gV6VDsWHVcvHskuW
X-Gm-Gg: AYBFou06ZGd56JL2f5/5gRcy/OCFxt/Sdbh1uTD1mFboY8bfF4+mfyIaM+N/VuYvN0f
	8NSvh6eYdp79umHhASTAZmS+MsRH+EuWwq9qlbPSJAqblg7gNbxZAuxspJTm85Ppu0GBzNkSFpj
	9y/eZ0HnuB2zTWsz1FuxrqEP0Nw4WsoRW3IJyycp1quOBv7qQPPoGdNx6ZhDc1lW/qBdHJOTY0N
	AFWTbBJdhrRv02SHaNxwt7ZbytA/gjpeHsXGdzey/+bpcmBMnaYTcCmKNeSbBEyzEgUgDJz98UA
	oUPsocGcbbTE/EcodPlAtW7/eR8u5+swQTLEKFZfCiaxmsnNfu7Pe3oavDD5onx7rOBRGZ8wjAs
	S0Nt7/a06TRM3QSbvV/n5AI7slQ6e8xX31fVoNV+0QhBjdlmOtp25STHdWKJI4F3etyXDQmcwiD
	Fc+XHoIO3GXOpXmFo903jOCJR1HGmCAfT/O9hYGOkBklue3xegzXf/2OGc88aneAAV7vE5/Dg7r
	UpHTJ+uO2DWzd76aqo50jcWFqn9mA==
X-Received: by 2002:a05:6808:6905:b0:4a3:fb6c:9adf with SMTP id 5614622812f47-4c31b6d0361mr3599265b6e.12.1789102465674;
        Thu, 10 Sep 2026 21:54:25 -0700 (PDT)
Received: from dhoja (S01067483c248479d.wp.shawcable.net. [50.72.244.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c3314b5179sm1226015b6e.9.2026.09.10.21.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:54:25 -0700 (PDT)
Date: Thu, 10 Sep 2026 23:54:22 -0500
From: Curtis Vogt <curtis.vogt@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/3] HID: valve-index: Reboot headset on system power
 transitions
Message-ID: <aqOJfj79_NVkU6Db@dhoja>
References: <20260910170254.833871-1-mario.limonciello@amd.com>
 <20260910170254.833871-3-mario.limonciello@amd.com>
 <20260910220421.40356e51.michal.pecio@gmail.com>
 <55918a70-72c9-4f55-934b-81a692d4619b@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55918a70-72c9-4f55-934b-81a692d4619b@amd.com>

On Thu, Sep 10, 2026 at 03:43:18PM -0500, Mario Limonciello wrote:
> 
> 
> On 9/10/26 15:04, Michal Pecio wrote:
> > On Thu, 10 Sep 2026 12:02:53 -0500, Mario Limonciello wrote:
> > > The Valve Index HMD stops serving its EDID after the host disables the
> > > DisplayPort PHY.  The headset remains powered by its breakout box across
> > > suspend and shutdown, so the bad state survives and the next connector
> > > detection reports "No EDID read".  The HMD then appears as a synthesized
> > > 640x480 display until it is power-cycled.
> > > 
> > > The 64-byte HID output report 0x16 with command 0x01 reboots the headset
> > > and restores its EDID service.  Add a device-specific driver which sends
> > > this report for system sleep transitions and orderly shutdown while leaving
> > > runtime autosuspend alone.
> > > 
> > > Resume a runtime-suspended interface for a shutdown request and restrict
> > > the command to the composite interface which declares report 0x16.
> > > 
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4333
> > 
> > Hmm, people say it's a regression, so it looks like at least one
> > alternative solution should, in theory, exist...
> 
> Right.  This bug sat for a very long time hoping someone with the hardware
> would bisect and we could explain what changed.
> 
> My initial suspicion is timing.  But scouring the web you can see it happens
> on NVIDIA hardware too.
> 
> https://forums.developer.nvidia.com/t/valve-index-initialized-in-unusable-state-on-boot/324710
> 
> So 'unlikely' that a DRM change caused it.  Maybe tied to the F/W version on
> the Index and it got updated from initial report to failure?
> 
> I have no idea.  I don't have this hardware so I'm just trying to help these
> people how I can :)
> 
> > 
> > Obligatory question: does it work any better with Windows? :)
> 
> Curtis?
>

When I was using Windows I believe I observed a similiar behavior of the
system booting into a black screen and hanging. I remember this
occurring as far back as 2020 when I was using a 5700XT (RDNA1).

I'm willing to test on Windows again but I'll need to setup a Windows
system since I don't currently have one available.

> > 
> > > Link: https://github.com/ValveSoftware/SteamVR-for-Linux/issues/939
> > > Assisted-by: LLM
> > > Co-developed-by: Curtis Vogt <curtis.vogt@gmail.com>
> > > Signed-off-by: Curtis Vogt <curtis.vogt@gmail.com>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   .../ABI/testing/sysfs-driver-hid-valve-index  |  12 ++
> > >   drivers/hid/Kconfig                           |  11 ++
> > >   drivers/hid/Makefile                          |   1 +
> > >   drivers/hid/hid-ids.h                         |   1 +
> > >   drivers/hid/hid-valve-index.c                 | 142 ++++++++++++++++++
> > >   5 files changed, 167 insertions(+)
> > >   create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-valve-index
> > >   create mode 100644 drivers/hid/hid-valve-index.c
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-driver-hid-valve-index b/Documentation/ABI/testing/sysfs-driver-hid-valve-index
> > > new file mode 100644
> > > index 0000000000000..47d8c26b1eace
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-driver-hid-valve-index
> > > @@ -0,0 +1,12 @@
> > > +What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/reboot
> > > +Date:		October 2026
> > > +Contact:	linux-input@vger.kernel.org
> > > +Description:
> > > +		Writing a boolean true value reboots the Valve Index headset to
> > > +		recover its EDID service. Writing a boolean false value has no
> > > +		effect. This file is write-only.
> > > +
> > > +		The Valve Index is a composite HID device. The reboot command is
> > > +		only supported by the interface that provides the headset's 64-byte
> > > +		output report. Writing true to this file on another interface fails
> > > +		with -ENODEV.
> > > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > > index a81bf51cbcf10..8ea2dd570058f 100644
> > > --- a/drivers/hid/Kconfig
> > > +++ b/drivers/hid/Kconfig
> > > @@ -547,6 +547,17 @@ config HID_WALTOP
> > >   	help
> > >   	Support for Waltop tablets.
> > > +config HID_VALVE_INDEX
> > > +	tristate "Valve Index headset"
> > > +	depends on USB_HID
> > > +	help
> > > +	  Support for the Valve Index headset. This driver works around the
> > > +	  headset failing to provide its EDID after a DisplayPort link shutdown
> > > +	  by rebooting the headset on resume from system suspend and at shutdown.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module will be
> > > +	  called hid-valve-index.
> > > +
> > >   config HID_VIEWSONIC
> > >   	tristate "ViewSonic/Signotec"
> > >   	help
> > > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > > index 48a863b245eed..21f512cab6250 100644
> > > --- a/drivers/hid/Makefile
> > > +++ b/drivers/hid/Makefile
> > > @@ -156,6 +156,7 @@ obj-$(CONFIG_HID_XIAOMI)	+= hid-xiaomi.o
> > >   obj-$(CONFIG_HID_XINMO)		+= hid-xinmo.o
> > >   obj-$(CONFIG_HID_ZEROPLUS)	+= hid-zpff.o
> > >   obj-$(CONFIG_HID_ZYDACRON)	+= hid-zydacron.o
> > > +obj-$(CONFIG_HID_VALVE_INDEX)	+= hid-valve-index.o
> > >   obj-$(CONFIG_HID_VIEWSONIC)	+= hid-viewsonic.o
> > >   obj-$(CONFIG_HID_VRC2)		+= hid-vrc2.o
> > >   obj-$(CONFIG_HID_HUAWEI)	+= hid-huawei.o
> > > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > > index b3aca5aa91767..15cd29a338a8d 100644
> > > --- a/drivers/hid/hid-ids.h
> > > +++ b/drivers/hid/hid-ids.h
> > > @@ -1391,6 +1391,7 @@
> > >   #define USB_DEVICE_ID_STEAM_CONTROLLER_IBEX_BLE	0x1303
> > >   #define USB_DEVICE_ID_STEAM_CONTROLLER_PROTEUS	0x1304
> > >   #define USB_DEVICE_ID_STEAM_CONTROLLER_NEREID	0x1305
> > > +#define USB_DEVICE_ID_VALVE_INDEX_HEADSET	0x2300
> > >   #define USB_VENDOR_ID_STEELSERIES	0x1038
> > >   #define USB_DEVICE_ID_STEELSERIES_SRWS1	0x1410
> > > diff --git a/drivers/hid/hid-valve-index.c b/drivers/hid/hid-valve-index.c
> > > new file mode 100644
> > > index 0000000000000..43c1142b7215b
> > > --- /dev/null
> > > +++ b/drivers/hid/hid-valve-index.c
> > > @@ -0,0 +1,142 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * HID driver for the Valve Index headset
> > > + */
> > > +
> > > +#include <linux/hid.h>
> > > +#include <linux/module.h>
> > > +
> > > +#include "hid-ids.h"
> > > +
> > > +#define VALVE_INDEX_REBOOT_REPORT_ID	0x16
> > > +#define VALVE_INDEX_REBOOT_CMD		0x01
> > > +#define VALVE_INDEX_REPORT_SIZE		64
> > > +
> > > +static bool valve_index_has_reboot_report(struct hid_device *hdev)
> > > +{
> > > +	struct hid_report *report;
> > > +
> > > +	/*
> > > +	 * The reboot command is a vendor protocol carried in the unnumbered
> > > +	 * 64-byte output report of the headset's third interface; the first
> > > +	 * data byte is the command id.  Report 0x16 is only declared as a
> > > +	 * feature report and is not what the command is sent as.
> > > +	 */
> > > +	report = hdev->report_enum[HID_OUTPUT_REPORT].report_id_hash[0];
> > > +
> > > +	return report && hid_report_len(report) == VALVE_INDEX_REPORT_SIZE;
> > > +}
> > > +
> > > +static void valve_index_reboot(struct hid_device *hdev, bool wake)
> > > +{
> > > +	u8 *report;
> > > +	int ret;
> > > +
> > > +	if (!valve_index_has_reboot_report(hdev))
> > > +		return;
> > > +
> > > +	/* USB transfer buffers must be DMA-able, so not on the stack. */
> > > +	report = kzalloc(VALVE_INDEX_REPORT_SIZE, GFP_KERNEL);
> > > +	if (!report)
> > > +		return;
> > > +	report[0] = VALVE_INDEX_REBOOT_REPORT_ID;
> > > +	report[1] = VALVE_INDEX_REBOOT_CMD;
> > > +
> > > +	if (wake) {
> > > +		ret = hid_hw_power(hdev, PM_HINT_FULLON);
> > > +		if (ret < 0) {
> > > +			hid_warn(hdev, "failed to resume headset for reboot: %d\n",
> > > +				 ret);
> > > +			goto out;
> > > +		}
> > > +	}
> > > +
> > > +	/* Use the same interrupt-out then SET_REPORT fallback as hidraw. */
> > > +	ret = hid_hw_output_report(hdev, report, VALVE_INDEX_REPORT_SIZE);
> > > +	if (ret == -ENOSYS)
> > > +		ret = hid_hw_raw_request(hdev, report[0], report,
> > > +					 VALVE_INDEX_REPORT_SIZE,
> > > +					 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
> > > +	if (ret < 0)
> > > +		hid_warn(hdev, "failed to reboot headset: %d\n", ret);
> > > +	else if (ret != VALVE_INDEX_REPORT_SIZE)
> > > +		hid_warn(hdev, "short headset reboot report: %d\n", ret);
> > > +
> > > +	if (wake)
> > > +		hid_hw_power(hdev, PM_HINT_NORMAL);
> > > +out:
> > > +	kfree(report);
> > > +}
> > > +
> > > +/*
> > > + * The suspend and shutdown hooks only cover orderly power transitions.  After
> > > + * a crash, a hard reset or a power cut the headset is left in the state where
> > > + * its EDID no longer reads, and nothing recovers it until the next orderly
> > > + * transition.  Expose the reboot command as a write-only "reboot" attribute
> > > + * on the HID device so userspace can recover it, for instance from a udev
> > > + * rule that fires only when the connector reports no EDID.  Writing to an
> > > + * interface that does not carry the reboot report returns -ENODEV.
> > > + */
> > > +static ssize_t reboot_store(struct device *dev, struct device_attribute *attr,
> > > +			    const char *buf, size_t count)
> > > +{
> > > +	struct hid_device *hdev = to_hid_device(dev);
> > > +	bool val;
> > > +
> > > +	if (kstrtobool(buf, &val))
> > > +		return -EINVAL;
> > > +	if (!val)
> > > +		return count;
> > > +	if (!valve_index_has_reboot_report(hdev))
> > > +		return -ENODEV;
> > > +
> > > +	valve_index_reboot(hdev, true);
> > > +
> > > +	return count;
> > > +}
> > > +static DEVICE_ATTR_WO(reboot);
> > > +
> > > +static struct attribute *valve_index_attrs[] = {
> > > +	&dev_attr_reboot.attr,
> > > +	NULL
> > > +};
> > > +ATTRIBUTE_GROUPS(valve_index);
> > > +
> > > +/*
> > > + * The headset's EDID service is lost when the host disables the DisplayPort
> > > + * PHY during system suspend, so it needs the reboot on the way out of
> > > + * suspend.  Doing it on the way in does not work: the headset dropping off
> > > + * USB is a remote-wakeup event from its hub and aborts the suspend.
> > > + */
> > 
> > The internal hub which will be quirked by the next patch, or its parent?
> 
> It has to be the internal hub if quirking it works, no?
> 
> I guess it's easy to check this by looking up wakeup count from all the
> applicable devices in sysfs while toggling the sysfs file introduced by this
> patch?
> 

I can try to look into this.

> > 
> > > +static int valve_index_resume(struct hid_device *hdev)
> > > +{
> > > +	valve_index_reboot(hdev, false);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void valve_index_shutdown(struct hid_device *hdev)
> > > +{
> > > +	valve_index_reboot(hdev, true);
> > > +}
> > > +
> > > +static const struct hid_device_id valve_index_devices[] = {
> > > +	{ HID_USB_DEVICE(USB_VENDOR_ID_VALVE,
> > > +			 USB_DEVICE_ID_VALVE_INDEX_HEADSET) },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(hid, valve_index_devices);
> > > +
> > > +static struct hid_driver valve_index_driver = {
> > > +	.name = "valve-index",
> > > +	.id_table = valve_index_devices,
> > > +	.resume = valve_index_resume,
> > > +	.reset_resume = valve_index_resume,
> > > +	.shutdown = valve_index_shutdown,
> > > +	.driver.dev_groups = valve_index_groups,
> > > +};
> > > +module_hid_driver(valve_index_driver);
> > > +
> > > +MODULE_AUTHOR("Mario Limonciello <mario.limonciello@amd.com>");
> > > +MODULE_DESCRIPTION("HID driver for Valve Index headset");
> > > +MODULE_LICENSE("GPL");
> > > -- 
> > > 2.43.0
> > > 
> 
