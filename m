Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F73DDDCB
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786797060; cv=none; b=RhBbRNQplunqLm9Yq60A/WM20ElkL3v0yVPT2hRAYVu0XEs6TV/c29UWv45dzkVE25JKFZsVsPqcSfi/SymdipA+PQ5VLRCwRxjT2729JCRTXKcqcjfg1XCzJt+OE2Orp+opEvMCAD2qAK2+NlDCqhyDebjrX2t65xq1AWY6vZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786797060; c=relaxed/simple;
	bh=Jn3wd9Ecsl6AgonhMbeu+tKI/4iW8XYVdwaQQkg75QM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZRnM7M/42KsMYd9qzOUD8w3fuA3pwMXcwuurrvPmtDKiBmAQH36wgsN+YM2PVw7QYbWJnSFEA4gc9Sin58LRKNNE8N814U01sKuDsWc9236caNnEkolmybZ30wU0Nhjigdq4bPI+dgPgphQwKp1S3KqSTOSezB0LN3TZAyxnouY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpdCPMt8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpdCPMt8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635331F00A3A;
	Sat, 15 Aug 2026 12:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786797058;
	bh=fcuExkjWHCX6CGk6noiFDwsT+xTqU/xcHY/W8YZY7GE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OpdCPMt8zPYjUJtXY9ohciMBxKASr/iYr0SiTD0uJZmhv33uTh9eXD185xYZ6kWu9
	 iVQ7JCbCAw/m5291bXMohMn0KARWpG+EZfC1QWA93PC/D6/gonkiWwigNCGdmrhATC
	 /WqrG/+wN870ukp0qOu9wBVTK2ZkNbGNbXYzLfIhS2WKDVYhf+lPYuWao2ih/DN96y
	 b5mc4JzR1YXASI8c1mx+wZGBl+YXt8vyT+isVM5FDZoHjH5Rz04D7rP2/My9UBXM6A
	 4BmdhsKVyuWgght/ilrCq8XTXSuLUhQ5BUp0OiyzQRVenjlgb0oTptu+sLkuOj0/Hb
	 Q221toQubTKGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: amd_sfh: Validate BAR 2 as memory-mapped I/O in
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Preetam Sundar Das" <daspreetam4@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260815121938.1337631-1-daspreetam4@gmail.com>
References: <20260815121938.1337631-1-daspreetam4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 12:30:57 +0000
Message-Id: <20260815123058.635331F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition in driver teardown allows Use-After-Free of the HID=
 device.
- [High] Missing `list_empty` check in `amd_sfh_work` leads to out-of-bound=
s access.
- [High] Missing BAR length validation leaves the driver vulnerable to out-=
of-bounds MMIO accesses.
- [High] Double Free and Use-After-Free due to dangling pointer on `hid_add=
_device()` failure.
- [Medium] Missing `dev.parent` initialization before registering the HID d=
evice.
- [Medium] Unsafe input reporting API used (`hid_input_report`).
- [Medium] Memory leak of pending `req_list` requests during driver unbind.
--

--- Patch [1]: [PATCH] HID: amd_sfh: Validate BAR 2 as memory-mapped I/O in=
 probe ---
commit 9791ab9939f2a4ad3dfd9fdb427437ececbde787
Author: Preetam Sundar Das <daspreetam4@gmail.com>

HID: amd_sfh: Validate BAR 2 as memory-mapped I/O in probe

Syzbot reported a page fault in amd_mp2_pci_probe(). The fuzzer creates
a malicious PCI device where BAR 2 is defined as an I/O port rather
than a memory-mapped I/O (MMIO) region.

Closes: https://syzkaller.appspot.com/bug?id=3D227a9acbe565367eb7a1277b4711=
5df8706d9a12

> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh=
-hid/amd_sfh_pcie.c
> index 4b81cebdc3359..aef105a815701 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -451,6 +451,9 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *i
>  	if (rc)
>  		return rc;
> =20
> +	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_MEM))
> +		return -EINVAL;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this check also need to
validate the length of the BAR using pci_resource_len()?

If a malicious device advertises a very small MMIO BAR, the driver
unconditionally accesses high register offsets, like AMD_P2C_MSG3 at 0x1068C
inside mp2_select_ops():

    privdata->mp2_acs =3D readl(privdata->mmio + AMD_P2C_MSG3);

Could this still trigger an out-of-bounds access if the length isn't verifi=
ed
before mapping?

>  	rc =3D pcim_iomap_regions(pdev, BIT(2), DRIVER_NAME);
>  	if (rc)
>  		return rc;

[Severity: Medium]
This is a pre-existing issue, but is it necessary for amdtp_hid_probe()
to initialize the parent device before registering the HID device?

drivers/hid/amd-sfh-hid/amd_sfh_hid.c:amdtp_hid_probe() {
    hid =3D hid_allocate_device();
    ...
    rc =3D hid_add_device(hid);
}

The HID subsystem requires low-level transport drivers to fully initialize
the hid_device fields, including dev.parent, before calling hid_add_device(=
).
Leaving it uninitialized can break the sysfs device hierarchy and place the
device in the virtual root.

[Severity: Medium]
This is a pre-existing issue, but should amd_sfh_work() be using the safe
input reporting API instead?

drivers/hid/amd-sfh-hid/amd_sfh_client.c:amd_sfh_work() {
    ...
    hid_input_report(cli_data->hid_sensor_hubs[current_index],
                     cli_data->report_type[current_index],
                     cli_data->feature_report[current_index],
                     report_size, 0);
}

The HID subsystem guidelines recommend preferring hid_safe_input_report()
over hid_input_report(). Using hid_input_report() bypasses boundary checks
against the allocated buffer size, which might lead to out-of-bounds reads
if malformed reports are received.

[Severity: High]
This isn't a bug introduced by this patch, but could the driver teardown
sequence allow a use-after-free?

In drivers/hid/amd-sfh-hid/amd_sfh_client.c:amd_sfh_hid_client_deinit():

    cancel_delayed_work_sync(&cl_data->work);
    cancel_delayed_work_sync(&cl_data->work_buffer);
    amdtp_hid_remove(cl_data);

The workers are cancelled before amdtp_hid_remove() unregisters and frees
the hid device. Since the device is still active during the cancellation,
userspace could issue an ioctl triggering amd_sfh_get_report(), which
would re-arm the delayed work:

    schedule_delayed_work(&cli_data->work, 0);

When this work executes later, could it dereference the already freed
cli_data->hid_sensor_hubs array entry? Should the device be unregistered
before the workers are cancelled?

[Severity: High]
This is a pre-existing issue, but might amd_sfh_work() trigger out-of-bounds
accesses by blindly accessing the request list without verifying it is empt=
y?

In drivers/hid/amd-sfh-hid/amd_sfh_client.c:amd_sfh_get_report(), the work
is unconditionally scheduled even if no request was added to the list:

    schedule_delayed_work(&cli_data->work, 0);
    return 0;

Then in amd_sfh_work():

    req_node =3D list_last_entry(&req_list->list, struct request_list, list=
);
    list_del(&req_node->list);

If the work is scheduled but the list is empty, could this lead to list
corruption and invalid memory accesses?

[Severity: High]
This isn't a bug introduced by this patch, but will a failure in
hid_add_device() result in a double free?

In drivers/hid/amd-sfh-hid/amd_sfh_hid.c:amdtp_hid_probe(), the array
entry is populated before registration:

    cli_data->hid_sensor_hubs[cur_hid_dev] =3D hid;
    ...
err_hid_device:
    kfree(hid_data);
err_hid_data:
    hid_destroy_device(hid);

The error path destroys the device and frees hid_data, but does not
clear the pointer from the array. This failure propagates up to
amd_sfh_hid_client_init(), which jumps to cleanup and calls
amd_sfh_hid_client_deinit(). That triggers amdtp_hid_remove():

    if (cli_data->hid_sensor_hubs[i]) {
        hid_data =3D cli_data->hid_sensor_hubs[i]->driver_data;
        hid_destroy_device(cli_data->hid_sensor_hubs[i]);
        kfree(hid_data);
    }

Could this see the non-NULL dangling pointer, read hid->driver_data,
and call hid_destroy_device() and kfree() on already-freed objects?

[Severity: Medium]
This is a pre-existing issue, but what happens to pending requests in
amd_sfh_hid_client_deinit()?

When handling GET_REPORT, amd_sfh_get_report() dynamically allocates
request_list nodes and adds them to req_list->list. If the driver is
unbound while there are unprocessed requests:

drivers/hid/amd-sfh-hid/amd_sfh_client.c:amd_sfh_hid_client_deinit() {
    ...
    cancel_delayed_work_sync(&cl_data->work);
    cancel_delayed_work_sync(&cl_data->work_buffer);
    amdtp_hid_remove(cl_data);
}

The worker threads are cancelled, but the queue is never drained. Will
this permanently leak any orphaned allocations on device teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815121938.1337=
631-1-daspreetam4@gmail.com?part=3D1
