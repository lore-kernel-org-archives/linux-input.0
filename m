Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F983F5BE3
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654744; cv=none; b=uVDo8qEUQOHvMr5bEvyRvzGLlKKyoccOVdbLVs3VsKDRrsSZkMkenBbuvu1W8U8LFdWdP9Ki3qKLCuBO1//ksWdqA8pdh21L452vuvaUu1i96rBx81CFVGXcLaOIAu8TMPj+ye8uI28KUS4fGFVicXuKel3e+dteDpp+C10rJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654744; c=relaxed/simple;
	bh=/8H39ZkwgPkAA09oPexFbbU8Myt5oJfBh1PctM19pZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yss31kqwCHEflGvN0adp964e0kXX+A7cfzuPj8uhizd6E/4LfQwU91ZUY6O97T5T/ap1ma0vwtscdq7Ux7gC6LJyONxw0UJh0p8RZwh5cbgUE4ZaZG4iBBCxVBzXkTKauRpOeJY/vVFJ8gJQedknqMf5CZBe3JwmZA1jF39m3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXzKV98K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXzKV98K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8340E1F00A3A;
	Tue, 25 Aug 2026 10:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787654742;
	bh=hVwm+PIJ1UhHarum8ytQO9VfseteiXP63iRpV5zaBpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iXzKV98KwquDI7rQai8Yqtaw0aZpEbeU+eNDsb3/WA7XxoMHgK7hxc9GEllqmEE8U
	 KDZ1wpX5NGegtw+eyqHVoM8Ax5sIwPKnYVPjaX5vXZG1mM8UqYXLaQNYQgbU0W9lV+
	 aHy/sL6j6KIwKDU9hdnEC0AgMKG+YvcyEDv+iq/EZXZy3Y99rVMLE1HOhLG3RQxLaC
	 pU/Mc5pK5wQFlBoXp4wI9/K4s3UftCL+fRf8jWUu91zMVKHeA4Ny1/OVnL081BAozA
	 zncskrfJKQ7lvS9VYqgWjeGgeA0mOC7ZHjNPnmYv19P5RX/gehLi9oKNGpgxugOWjN
	 OprkJ81w8b7Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] HID: rmi: fix OOB access with undersized RMI reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260825103117.12180-1-98lawweijie@gmail.com>
References: <20260825103117.12180-1-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:45:42 +0000
Message-Id: <20260825104542.8340E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cancellation of `reset_work` in `rmi_probe()` error paths =
and incorrectly ordered cancellation in `rmi_remove()` leads to a Use-After=
-Free.
- [High] The timeout path in `rmi_hid_read_block()` fails to clear `RMI_REA=
D_DATA_PENDING`, allowing a late reply to permanently desynchronize the req=
uest-retry state machine.
- [High] The `hdata->readReport` buffer and state flags are subject to a da=
ta race because `rmi_read_data_event()` writes to them concurrently without=
 holding any locks that synchronize with `rmi_hid_read_block()`.
--

--- Patch [1]: [PATCH v5] HID: rmi: fix OOB access with undersized RMI repo=
rts ---
commit d795162d47703f2e01823d86b5a96b131c5a598a
Author: Wei Jie Law <98lawweijie@gmail.com>

HID: rmi: fix OOB access with undersized RMI reports

The patch fixes out-of-bounds reads and writes in hid-rmi by enforcing
minimum bounds on report sizes and handling zero-length replies correctly.
It also prevents the RMI_DEVICE flag from bypassing allocation on the error
paths.

Link: https://lore.kernel.org/linux-input/20260822121007.153988-1-98lawweij=
ie@gmail.com/
Link: https://lore.kernel.org/linux-input/00a489f38b240624dcb5a4bae36a53fcb=
a9cfb47.1787549195.git.98lawweijie@gmail.com/
Link: https://lore.kernel.org/linux-input/20260824122708.76168-1-98lawweiji=
e@gmail.com/
Link: https://lore.kernel.org/linux-input/20260825060954.104890-1-98lawweij=
ie@gmail.com/

> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 2bd781f1e0f53..ecc19387f6b05 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -235,7 +235,23 @@ static int rmi_hid_read_block(struct rmi_transport_d=
ev *xport, u16 addr,
>  				break;
>  			}

[Severity: High]
This is a pre-existing issue, but does the wait_event_timeout path just
above this hunk leave the RMI_READ_DATA_PENDING flag set?

If the timeout expires and the loop breaks, the exit block later clears
RMI_READ_REQUEST_PENDING but leaves RMI_READ_DATA_PENDING untouched. If a
late reply arrives from the device and triggers rmi_read_data_event(), it
will set RMI_READ_DATA_PENDING.

Would the next call to rmi_hid_read_block() immediately fall through
wait_event_timeout() and consume stale data?

> -			read_input_count =3D data->readReport[1];
> +			read_input_count =3D min_t(int, data->readReport[1],
> +						 data->input_report_size - 2);
[ ... ]
> +			}
>  			memcpy(buf + bytes_read, &data->readReport[2],
>  				min(read_input_count, bytes_needed));
> =20
>  			bytes_read +=3D read_input_count;
>  			bytes_needed -=3D read_input_count;
>  			clear_bit(RMI_READ_DATA_PENDING, &data->flags);

[Severity: High]
This isn't a bug introduced by this patch, but is there a data race between
this memcpy and rmi_read_data_event()?

While rmi_hid_read_block() is actively reading from data->readReport,
what happens if a glitchy device sends an unsolicited second reply?

Because RMI_READ_REQUEST_PENDING is still set for the duration of the
transaction, rmi_read_data_event() could concurrently overwrite
data->readReport. Also, clearing RMI_READ_DATA_PENDING here at the end of
the loop might erase the presence flag of that second reply. Is additional
synchronization needed between these paths?

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
This is a pre-existing issue, but does the error path in rmi_probe() fail to
clean up the queued reset_work?

If hid_hw_start() fails (which is where this goto jumps to), and an event
has already arrived scheduling data->reset_work via rmi_event(), returning
an error here could cause a use-after-free when the un-cancelled work later
executes and accesses the freed hdata.

Similarly, in rmi_remove(), cancel_work_sync(&hdata->reset_work) is called
before hid_hw_stop(hdev). Could an incoming event schedule the work again
right after it is cancelled, since the hardware is still running?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825103117.1218=
0-1-98lawweijie@gmail.com?part=3D1
