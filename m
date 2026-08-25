Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAE53BAD88
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787638964; cv=none; b=ECy906O0KjJCZAXRBm4i4hsoOutpVz1ulXaudH4S+pLi8MVTO5SM9OpQUucdumvIpBOA452IYTAAmVUWgTP4hlTGUngsB1r5PnrjS4bgVgfDw2TSvgNI5oEWsDBDPbCeoibZNKV0MAf5jMLcgH9qUgaiZn0KIzCpb1+0dWgL9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787638964; c=relaxed/simple;
	bh=qtMKggXLK5sfFMykMiBI5Qs9HywyvNlzf1qKmySZcz8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ln2BNG7L6tQNBP6mpwcY5iPP5Gdhd80G/71xofliUYdqlOFR1Z2TMCjaI1LTPTnI0BqaBGs2BBM8XWfiF5ahoEq6aZqDGP9Cnm7y4GQPiGws3FE1MwOFJiEjQfgKg/1orh096g+fuMSSZAb/Gn7Gpy3hr3mfbAShOhwdMVKoMsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juIABYwO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juIABYwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488D31F000E9;
	Tue, 25 Aug 2026 06:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787638962;
	bh=T1Z0w73OClBMn6WuB9a4bVbKkbemQbrxZxshtFr206M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=juIABYwO4ZXU4l8Pgre+l5MTa/NE1CFelFpLEUBopfpqyKNCDcIBohms25+T8MJTl
	 IdyBWngrst6QwTXd8Fr/iaF9h57Wok3m9OK/1FiXSQpANw38Nkik0IF5tybzRfYz2r
	 souYPgsqUKzkmYfVv8xXyaIwd6x3vgogZW0l4b/Ned/xYrm8KBasaITpwE1r1bJGoG
	 zLP1dTJlAYqjl/R5KnEaJF9pkQL1ofrWTkD3Ym4DdwDeXVAhcTgEyxCGBquOTRknWM
	 /MuaYOLoHUFlyunaqzJ8mFSoAhBWvBn3FJDu1lt0g2APZwyDCSGZLeaMJf5KwGhAc1
	 8+pL3v9jNJzqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] HID: rmi: fix OOB access with undersized RMI reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie LAW" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260825060954.104890-1-98lawweijie@gmail.com>
References: <20260825060954.104890-1-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 06:22:41 +0000
Message-Id: <20260825062242.488D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cancellation of `data->reset_work` in the `probe()` error =
path can lead to a Use-After-Free.
- [High] Incorrect cleanup order in `rmi_remove()` allows `reset_work` to b=
e re-queued after cancellation, leading to a Use-After-Free.
- [High] Missing report field validation in `rmi_report()`, violating HID s=
ubsystem safety guidelines.
- [High] The probe error path leaks the registered RMI transport device if =
`hid_hw_start()` fails, leading to a Use-After-Free.
- [High] Data corruption and lost wakeups due to concurrent access to the `=
readReport` buffer.
--

--- Patch [1]: [PATCH v4] HID: rmi: fix OOB access with undersized RMI repo=
rts ---
commit f2ebad7618b9c961116f2eb07a112d17c778bfa0
Author: Wei Jie Law <98lawweijie@gmail.com>

HID: rmi: fix OOB access with undersized RMI reports

This commit fixes out-of-bounds accesses in the hid-rmi driver caused by
undersized report descriptors. It bounds the read and write operations by t=
he
device's declared report sizes, treats a zero-length reply as an error, and
rejects reports that are too small during probe.

Link: https://lore.kernel.org/linux-input/20260822121007.153988-1-98lawweij=
ie@gmail.com/
Link: https://lore.kernel.org/linux-input/00a489f38b240624dcb5a4bae36a53fcb=
a9cfb47.1787549195.git.98lawweijie@gmail.com/
Link: https://lore.kernel.org/linux-input/20260824122708.76168-1-98lawweiji=
e@gmail.com/

> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 2bd781f1e0f53..ecc19387f6b05 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -235,7 +235,23 @@ static int rmi_hid_read_block(struct rmi_transport_d=
ev *xport, u16 addr,
>  				break;
>  			}
> =20
> -			read_input_count =3D data->readReport[1];
> +			read_input_count =3D min_t(int, data->readReport[1],
> +						 data->input_report_size - 2);
> +			if (!read_input_count) {
> +				/*
> +				 * A zero length reply advances neither
> +				 * bytes_read nor bytes_needed, and because a
> +				 * reply did arrive the wait above does not
> +				 * time out either, so a device answering 0
> +				 * forever would spin here indefinitely with
> +				 * page_mutex held.
> +				 */
> +				hid_warn(hdev, "%s: zero-length read reply\n",
> +					 __func__);
> +				clear_bit(RMI_READ_DATA_PENDING, &data->flags);
> +				ret =3D -EIO;
> +				break;
> +			}
>  			memcpy(buf + bytes_read, &data->readReport[2],
>  				min(read_input_count, bytes_needed));
> =20
> @@ -271,6 +287,11 @@ static int rmi_hid_write_block(struct rmi_transport_=
dev *xport, u16 addr,

[Severity: High]
This is a pre-existing issue, but can the readReport buffer be corrupted
by concurrent access?

In rmi_hid_read_block(), we read from data->readReport and clear the
RMI_READ_DATA_PENDING flag without locking. Concurrently, the interrupt
handler rmi_read_data_event() unconditionally writes incoming packet data to
the same buffer and sets the pending flag.

If a new packet arrives while rmi_hid_read_block() is copying data,
couldn't it corrupt the buffer?

Also, if the new packet arrives just before
clear_bit(RMI_READ_DATA_PENDING) is executed, could the flag for the new
packet be erroneously cleared, causing the loop to block forever and fail
with -EAGAIN?

[ ... ]

> @@ -696,6 +725,17 @@ static int rmi_probe(struct hid_device *hdev, const =
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
This isn't a bug introduced by this patch, but does the rmi_probe() error
path leak resources if hid_hw_start() fails?

The goto start; jump leads to hid_hw_start(). If hid_hw_start() fails,
it returns an error and devres cleans up the allocated memory. However,
this error path skips cancelling the asynchronous work:

drivers/hid/hid-rmi.c:rmi_probe() {
    ...
    ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
    if (ret) {
        hid_err(hdev, "hw start failed\n");
        return ret;
    }
}

During hid_hw_start(), rmi_input_configured() is invoked synchronously,
which enables hardware reports. An incoming report can then trigger
rmi_event() and schedule data->reset_work. If hid_hw_start()
subsequently fails, returning without calling
cancel_work_sync(&data->reset_work) would leave the queued work item with
a dangling pointer when devres frees the data.

[Severity: High]
This is another pre-existing issue, but does this same error path also leak
the registered RMI transport device?

rmi_input_configured() registers the transport device:

drivers/hid/hid-rmi.c:rmi_input_configured() {
    ...
    ret =3D rmi_register_transport_device(&data->xport);
    if (ret < 0) {
    ...
}

If hid_hw_start() fails after this point,
rmi_unregister_transport_device() is never called. This leaves the RMI
core with an active transport device pointing to the freed rmi_data
memory, which could lead to a use-after-free.

[Severity: High]
This is a pre-existing issue, but could the cleanup order in rmi_remove()
allow reset_work to be re-queued after cancellation?

drivers/hid/hid-rmi.c:rmi_remove() {
    ...
    cancel_work_sync(&hdata->reset_work);
    rmi_unregister_transport_device(&hdata->xport);
    ...
    hid_hw_stop(hdev);
}

Since cancel_work_sync() is called before hid_hw_stop(), the hardware
remains active. Incoming HID reports can still trigger rmi_event(), which
unconditionally schedules work because it checks RMI_DEVICE instead of
an RMI_STARTED flag:

drivers/hid/hid-rmi.c:rmi_event() {
    ...
    schedule_work(&data->reset_work);
    return 1;
}

Could this lead to a use-after-free when devres frees the data after
rmi_remove() finishes, as the HID subsystem requires hid_hw_stop() to
execute before cancelling asynchronous resources?

[Severity: High]
This is a pre-existing issue, but does rmi_report() need to validate the
report fields before accessing them?

drivers/hid/hid-rmi.c:rmi_report() {
    struct hid_field *field =3D report->field[0];
    ...
}

The callback accesses report->field[0] by index without first checking if
report->maxfield > 0. A device declaring a report with zero fields could
trigger an out-of-bounds access or NULL pointer dereference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825060954.1048=
90-1-98lawweijie@gmail.com?part=3D1
