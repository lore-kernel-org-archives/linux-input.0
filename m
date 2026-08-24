Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0686F377AB7
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575457; cv=none; b=sOHZOAloWr6i4Vh/sno7U4H3mV7wscWLSXXAyPyd+KwDdmgOCiKHnm/4MDU3cR3ukyrEzycnkTJtWobF1pr6tqRtK9xfj0trN3HyJfsEeu9MTt4UN0rAY/MypWjHkAa007K9n5XNAFQfRNz6uKwTprWg5vdTbmfKdwTxgxBkPLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575457; c=relaxed/simple;
	bh=SEczNwgNo0bUGGG0i42YgFPBovK9UuHI4TLWMbrpEMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TyfYrx0sfaFzztUaWmT2ZNVaICcLm7EUpcJZQ/vDv2a4NFynpL48hwJA4R0JXo3/auejAKK/zVsS6JBE2vPbnAvqK486M2p3/oIiSMuyArb2iFLnRv3gWrPPA1O402r018fEPJpLoeMurMyOPTnj42wsKZh/yOdKKxPvlPVTy84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVQ4PTyO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVQ4PTyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF0A1F000E9;
	Mon, 24 Aug 2026 12:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787575455;
	bh=B++A5kM6OrxYXqIX84dFF8ey7LOtyQjhAsUvf9nnxUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SVQ4PTyOhYdRKtAw3nJ/IHZLpU9ZgIo/0RCeAfdWhAHMSgbCfEy+kzlRMUgr2sbUF
	 XmmL+99DH254M6aPKSCpG3/14/QvH3fVrsk51YqgtGd5a8BR/t8MJm65Ns9rYvQugO
	 wzdEcfDyPfHkLTKY/yG3ZuZXJ8kSCtb6X6ljPvsa4nH8yXAjWDLF/8jqXX636VsB5C
	 iStNeKXc/royR6EMPFVlvd+UWgBzrQOLI2W1ijMdAHUWktnFZIjsDdb8iet8TttFPI
	 RcBsSGrAPl7hIK1J65yVEa9ljvKJSh/4GlbotJPOJqoS3gaATTX/Rp26LfMYAMylNQ
	 vhVBPxPWMxAKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: rmi: fix OOB access with undersized RMI reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260824122708.76168-1-98lawweijie@gmail.com>
References: <20260824122708.76168-1-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 12:44:15 +0000
Message-Id: <20260824124415.7CF0A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] NULL pointer dereference introduced by the patch in rmi_probe().

Pre-existing issues:
- [High] Use-After-Free due to improper teardown order in rmi_remove().
- [High] Resource leak and Use-After-Free in rmi_probe error path.
- [High] TOCTOU race condition in chunked reads causes data corruption.
- [High] Global state pollution of rmi_hid_pdata in rmi_probe.
--

--- Patch [1]: [PATCH v3] HID: rmi: fix OOB access with undersized RMI repo=
rts ---
commit f98155b3d4bb0b8765a10c106b1cf4d13fb70009
Author: Wei Jie Law <98lawweijie@gmail.com>

HID: rmi: fix OOB access with undersized RMI reports

The hid-rmi driver sizes its writeReport/readReport buffer purely from
the report descriptor supplied by the device, with no minimum bound.
This patch adds bounds checking to prevent out-of-bounds accesses during
reads and writes.

Link: https://lore.kernel.org/linux-input/20260822121007.153988-1-98lawweij=
ie@gmail.com/
Link: https://lore.kernel.org/linux-input/00a489f38b240624dcb5a4bae36a53fcb=
a9cfb47.1787549195.git.98lawweijie@gmail.com/

> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 2bd781f1e0f53..21076521e35e7 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c

[ ... ]

> @@ -696,6 +717,17 @@ static int rmi_probe(struct hid_device *hdev, const =
struct hid_device_id *id)
> =20
>  	data->output_report_size =3D hid_report_len(output_report);
> =20
> +	/*
> +	 * The write reports built by this driver occupy 6 bytes and the read
> +	 * handshake looks at the first 3 bytes of an input report, so refuse
> +	 * to drive a device whose reports cannot hold them.
> +	 */
> +	if (data->output_report_size < 6 || data->input_report_size < 3) {
> +		hid_err(hdev, "rmi reports too small (out=3D%u in=3D%u)\n",
> +			data->output_report_size, data->input_report_size);
> +		goto start;
> +	}

[Severity: High]
Does this goto bypass the allocation of data->writeReport?

If a device is dynamically bound using the new_id sysfs interface, and the
driver_data provided has BIT(0) (RMI_DEVICE) set, data->device_flags will
already have RMI_DEVICE set from id->driver_data earlier in rmi_probe().

When this jumps to the start label, hid_hw_start() will call
rmi_input_configured() which checks the RMI_DEVICE flag. Since it is set,
it will proceed to call rmi_set_page(), which dereferences
data->writeReport[0].

Since data->writeReport was never allocated, could this cause a NULL pointer
dereference?

>  	data->device_flags |=3D RMI_DEVICE;
>  	alloc_size =3D data->output_report_size + data->input_report_size;
> =20


[Severity: High]
This is a pre-existing issue, but is there a use-after-free in rmi_remove()
due to the teardown order?

In rmi_remove(), cancel_work_sync(&hdata->reset_work) is called before
hid_hw_stop(hdev). Since hid_hw_stop() is what ultimately stops incoming
hardware events, a hardware interrupt could still occur after the worker is
cancelled.

This incoming event invokes rmi_event(), which unconditionally calls:

    schedule_work(&data->reset_work);
    return 1;

Once rmi_remove() returns, devres cleanup frees the hdata structure. The
newly scheduled work item could then execute rmi_reset_work() and
dereference the freed hdata memory.


[Severity: High]
This is a pre-existing issue, but does the rmi_probe() error path leak the
transport device?

During rmi_probe(), hid_hw_start() is called, which invokes the driver's
rmi_input_configured() callback. This callback registers the transport
device:

    ret =3D rmi_register_transport_device(&data->xport);

If hid_hw_start() subsequently fails (for example, during hidraw
registration), rmi_probe() returns the error without unregistering the
transport device:

    ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
    if (ret) {
        hid_err(hdev, "hw start failed\n");
        return ret;
    }

Devres will free the hdata structure, but the RMI core still retains a
pointer to the now-freed hdata->xport device, which could lead to a
use-after-free.


[Severity: High]
This is a pre-existing issue, but is there a race condition in chunked reads
that could cause data corruption?

When rmi_hid_read_block() requests a read larger than what fits in a single
input report, the device responds with multiple consecutive reports. Each
report triggers rmi_read_data_event() in interrupt context, which executes:

    memcpy(hdata->readReport, data,
           min((u32)size, hdata->input_report_size));
    set_bit(RMI_READ_DATA_PENDING, &hdata->flags);
    wake_up(&hdata->wait);

There appears to be no synchronization to prevent a subsequent report from
overwriting hdata->readReport before the consumer thread in
rmi_hid_read_block() wakes up to consume the previous chunk:

    while (bytes_read < len) {
        if (!wait_event_timeout(data->wait,
            test_bit(RMI_READ_DATA_PENDING, &data->flags),

If the device sends reports faster than the thread gets scheduled, could
data be overwritten and silently lost?


[Severity: High]
This is a pre-existing issue, but does rmi_probe() modify global state
instead of device-specific state?

rmi_hid_pdata is defined as a static global template structure. However,
in rmi_probe(), if the device has physical buttons, it modifies the global
template directly:

    if (data->device_flags & RMI_DEVICE_HAS_PHYS_BUTTONS)
        rmi_hid_pdata.gpio_data.disable =3D true;

    data->xport.dev =3D hdev->dev.parent;
    data->xport.pdata =3D rmi_hid_pdata;

This permanently mutates the global template. Could all subsequently probed
devices erroneously inherit gpio_data.disable =3D true, even if they do not
have physical buttons?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824122708.7616=
8-1-98lawweijie@gmail.com?part=3D1
