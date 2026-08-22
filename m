Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37581175A9C
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787401477; cv=none; b=YWxmlIa70NtJTwQj9z1TTGSy2mx60R4l6WtWH+mzXh3taq+OiMAY79av4cZC+YSb7qnPcn2I8OIPdqiQjt7y67fxdnz5dEyZJjf3FP3php/HjtdBxwCQQfvHIvnoV7nY2dbgLn0L3ZLkXzsfQ0eV+sHiKwKVXcW9L/iL/iWNVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787401477; c=relaxed/simple;
	bh=rk6mMFqWR5P3ToNsRH3T7SekTeMwWzwt0Fh4tjtIzvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WFGM7g4Flsc2Z4h2sjIaVdiEyCwICJYnaCMgaKGjaIGTThGhIMWFMIQHeWOCxVhZPd1IisFy7s+8cEgnF8DmZVf1aiXE+6ueBr/ibkLUU3ipsuXmdaEXj3tsE2b/O1AyWLFcV/6IGWAN7moiuX3vpiDLbh+zmIS5VL3yEVzTLoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYe4Lvmp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYe4Lvmp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5B21F000E9;
	Sat, 22 Aug 2026 12:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787401475;
	bh=aFs15C0khpXwjCGqNlOoO/wZ/3JFAEPxTrVAdT5q/tI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eYe4Lvmpi6KzUfeIilfnSGFSiD8OSvj0BO5JFAS/BLSYuMXDz6kwRpeVSHkUhDv87
	 6Mcvx/tVBd7PouH9U9UX98pyxqaqw9LOs28JMOTqeG0mYRPD/QSSga3694k/zkk0/p
	 2IwkADmstvnKUCa7in+H837RK/Wj608xQsDB4oXS3PxYoKHoE2zUvR8emd9AQt4mIY
	 ZZjmjyJyMYAGP6vgz8kNneSKF8Ny168+gsJJkVPjJIL7aBHIum+qOIFEGOqBToA6pR
	 BJXRALi5unurVt2GvKZSbtTYIHXCMyP4AyRks+pklz0668Gs4Q/IuGmCbfskJ8uUrI
	 cEZQrc3a7qXjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: rmi: fix OOB access with undersized RMI reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260822121007.153988-1-98lawweijie@gmail.com>
References: <20260822121007.153988-1-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 12:24:35 +0000
Message-Id: <20260822122435.BC5B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing report field count validation before access.
- [High] Use-After-Free of `data->reset_work` on `probe` error path.
- [High] Data Race and missed wakeups in `rmi_hid_read_block`.
--

--- Patch [1]: [PATCH] HID: rmi: fix OOB access with undersized RMI reports=
 ---
commit 723e0f956aac9b958efffab91d1bca6e5f8025a4
Author: Wei Jie Law <98lawweijie@gmail.com>

HID: rmi: fix OOB access with undersized RMI reports

This patch adds minimum bound checks for the read/write report buffers
in hid-rmi.c to prevent out-of-bounds access. It rejects reports that
are too small at probe time.

> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index d4af17fdba467..a0780087d413f 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -235,7 +235,8 @@ static int rmi_hid_read_block(struct rmi_transport_de=
v *xport, u16 addr,
>  				break;
>  			}
> =20
> -			read_input_count =3D data->readReport[1];
> +			read_input_count =3D min_t(int, data->readReport[1],
> +						 data->input_report_size - 2);
>  			memcpy(buf + bytes_read, &data->readReport[2],
>  				min(read_input_count, bytes_needed));
> =20
>  			bytes_read +=3D read_input_count;
>  			bytes_needed -=3D read_input_count;
>  			clear_bit(RMI_READ_DATA_PENDING, &data->flags);

[Severity: High]
This isn't a bug introduced by this patch, but does this read path have a d=
ata
race and missed wakeups?

The data->readReport buffer is read here by process context, but it appears=
 to
be written concurrently from interrupt context without synchronization:

drivers/hid/hid-rmi.c:rmi_read_data_event() {
    ...
    memcpy(hdata->readReport, data, min((u32)size, hdata->input_report_size=
));
    set_bit(RMI_READ_DATA_PENDING, &hdata->flags);
}

If the device streams multiple input reports consecutively, can the softirq
overwrite data->readReport while it is being copied in rmi_hid_read_block()?

Furthermore, since clear_bit(RMI_READ_DATA_PENDING) runs after the copy,
could it erroneously clear the flag for a new chunk if the softirq sets it
just before clear_bit executes, causing the process context to wait and
timeout?

[ ... ]

> @@ -696,6 +702,17 @@ static int rmi_probe(struct hid_device *hdev, const =
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
> +
>  	data->device_flags |=3D RMI_DEVICE;
>  	alloc_size =3D data->output_report_size + data->input_report_size;
> =20

[Severity: High]
This is a pre-existing issue, but does the probe error path contain a
use-after-free of data->reset_work?

Down at the start label, the driver calls hid_hw_start():

start:
    ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
    if (ret) {
        hid_err(hdev, "hw start failed\n");
        return ret;
    }

During hid_hw_start(), the core allows incoming reports. If a subsequent st=
ep
fails (e.g., rmi_set_mode()), hid_hw_start() returns an error.

If incoming reports have already triggered rmi_event() and scheduled
data->reset_work, returning this error will cause devres to free the data
structure. Could the workqueue then execute rmi_reset_work() on freed memory
since the pending work is not cancelled before returning?

[Severity: High]
Additionally, there is another pre-existing issue in rmi_report(). Does it
access the field array without verifying the report field count?

drivers/hid/hid-rmi.c:rmi_report() {
    ...
    struct hid_field *field =3D report->field[0];
    ...
}

The code accesses report->field[0] by index. If a malicious or buggy device
provides a report descriptor with no fields (making report->maxfield 0),
would this lead to an out-of-bounds access?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822121007.1539=
88-1-98lawweijie@gmail.com?part=3D1
