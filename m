Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56EE3382CB
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435569; cv=none; b=tG33XM50FuQE2wj1rxaWFe13CJ7uDf560ihwUtsGe2MPCCe24Hi/N5dDzWLiQtTC3rJH2HwdjrRLv3qKBBwHHVppi39LIXaTRJFowNYURjmoyd6ULJ3hfr8Z7za9rNhPaB4DFMg/bWNLh4VDxEJ8LCDJ0h8wtkuuJyRR2svtG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435569; c=relaxed/simple;
	bh=6FrFqo4+EVzHF0feTv3Tqgai1/WA51mVDpnBGrko+lU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qSkwupF5mnUAUmF/tu7zI0S/L8tRaPioRse3VFoLKIHHkkRj3gHCwHDVJBuyUNT5Tlvw99x7IM+qa1pW2u292l60gkSQIe/byNOZvRDydjTr/MoqQF0Zjhq8XS6YCqEtZfnTB2Alt2hUTleSjsgqsgOdyYkNs2HfcBrwUYsW4zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQn3YlmE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQn3YlmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232161F000E9;
	Sat, 22 Aug 2026 21:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787435567;
	bh=+fXhC2nVV3fdjlYGKWgJ5NH30ZY7t9HYUdFIzXf1xbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YQn3YlmEfegEq3CtgIrKHC3xAnwa55rLDJp2zCITiI6D8B+1wwZgBv2R242aVi6us
	 8dp8/Uh98wxWkX7HDa4/8BM0l6nhejllySTNwOoMNOR2txAopfjdSuMWkgHGZlwj/2
	 3qSEy/JPm45GWZOANpqBDta5SwAJPENvSlkNVIlE6BSd/vnMjMYItuyxezPhPgY0YB
	 dtQws8pd7h253iIahEeS7ZVox8HMvwSCLanezGTj+ZSebn/zkHGDo8OXWkW3cCDefY
	 D1XGhCP321sXqe3sp+EKODvGtAh1P8/L18sfgdNAXGyk2HZk2iUwVcqm36FDOEhIeZ
	 zr2BHIzgOuwIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/13] HID: ft260: uart: enable flow control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260822213941.98882-8-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
 <20260822213941.98882-8-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 21:52:46 +0000
Message-Id: <20260822215247.232161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The device structure `dev` is freed prematurely during probe f=
ailure and device removal, causing a double-free and use-after-free.
- [Critical] `ft260_remove()` tears down driver data structures before stop=
ping the HID transport, violating safe cleanup order.
- [High] Mismanaged asynchronous worker cleanup causes race conditions and =
Use-After-Free.
- [High] The shared `uart_wr_buf` buffer is used without locking, leading t=
o data corruption.
- [High] The UART baud rate is double-swapped on big-endian architectures, =
causing astronomically incorrect values.
--

--- Patch [7]: [PATCH 07/13] HID: ft260: uart: enable flow control ---
commit e6afc26d742478ffb1a839b17d94e5df01b28507
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: uart: enable flow control

This patch updates the FT260 driver to honor CRTSCTS and IXON/IXOFF flow
control settings during termios setup. It ensures flow control is not
forced off, which improves reliability for large transfers at high baud rat=
es.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 1ed3701eaaf75..1da42b8756d8c 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -1868,8 +1868,12 @@ static int ft260_uart_change_speed(struct ft260_de=
vice *port,
> =20
>  	if (termios->c_cflag & CRTSCTS)
>  		req.flow_ctrl =3D FT260_UART_CFG_FLOW_CTRL_RTS_CTS;
> +	else if (termios->c_iflag & (IXON | IXOFF))
> +		req.flow_ctrl =3D FT260_UART_CFG_FLOW_CTRL_XON_XOFF;
>  	else
> -		req.flow_ctrl =3D FT260_UART_CFG_FLOW_CTRL_OFF;
> +		req.flow_ctrl =3D FT260_UART_CFG_FLOW_CTRL_NONE;
> +
> +	req.breaking =3D FT260_UART_CFG_BREAKING_NO;

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this functio=
n,
does the baud rate configuration perform an incorrect byte swap?

Earlier in ft260_uart_change_speed():

    put_unaligned_le32(cpu_to_le32(baud), &req.baudrate);
   =20
Since put_unaligned_le32() already handles the conversion from CPU-endian to
little-endian natively, does wrapping it in cpu_to_le32() cause a double-sw=
ap
on big-endian architectures, resulting in astronomically incorrect baud rat=
es?

>  	ft260_dbg("configured termios: flow control: %d, baudrate: %d, ",
>  		  req.flow_ctrl, baud);
[ ... ]

[Severity: High]
This is a pre-existing issue, but does the UART transmit path have a data
corruption vulnerability when used concurrently?

Looking at ft260_uart_transmit_chars(), the code writes directly to the sha=
red
buffer without a lock:

    rep =3D (struct ft260_uart_write_request_report *)port->uart_wr_buf;
    ...
    rep->report =3D FT260_UART_DATA_REPORT_ID(len);

Since ft260_uart_transmit_chars() is called by the TTY write callback
(ft260_uart_write), and the TTY layer can invoke this concurrently from
multiple contexts, will concurrent executions overwrite each other's report
payloads before ft260_hid_output_report() sends them?

[Severity: Critical]
This isn't a bug introduced by this patch, but does the device lifecycle
management contain a double-free and use-after-free vulnerability?

In ft260_probe(), if ft260_uart_probe() fails, it triggers the cleanup:

ft260_probe()
    ...
    ret =3D ft260_uart_probe(hdev, dev);
    if (ret)
        goto hid_fail;
    ...
hid_fail:
    kfree(dev);

Inside the ft260_uart_probe() failure path or during ft260_remove(),
ft260_uart_port_remove(dev) drops the TTY port reference to 0, triggering
ft260_uart_port_destroy() which frees dev via kfree(port). When execution
reaches hid_fail, does kfree(dev) cause a double-free?

Similarly, in ft260_remove():

ft260_remove()
    ...
    ft260_uart_port_remove(dev);
    /* dev is still needed, so we will free it in _destroy func */
    if (dev->chip_mode & FT260_MODE_UART || ...)

Does evaluating dev->chip_mode immediately after ft260_uart_port_remove()
dereference the already freed dev pointer?

[Severity: High]
This is a pre-existing issue, but is there a race condition with the
asynchronous worker cleanup during device removal?

Looking at ft260_remove():

ft260_remove()
    ...
    cancel_work_sync(&dev->wakeup_work);
    ...
    ft260_uart_port_remove(dev);

The cancel_work_sync() is called before timer_delete_sync() which is execut=
ed
downstream inside ft260_uart_port_remove().

If the wakeup_timer fires immediately after cancel_work_sync() completes,
could its callback ft260_uart_start_wakeup() re-schedule the worker? The
subsequent timer_delete_sync() would cancel the timer but not the newly que=
ued
work, allowing the pending worker to access the device structure after it h=
as
been freed.

[Severity: Critical]
This isn't a bug introduced by this patch, but does ft260_remove() tear
down driver data structures before stopping the HID transport?

In ft260_remove():

ft260_remove()
    ...
    ft260_uart_port_remove(dev);
    ...
    hid_hw_stop(hdev);

By freeing the dev structure before calling hid_hw_stop(hdev), the USB
interrupt endpoint remains active. If incoming HID reports arrive
concurrently, will the HID core dispatch these to ft260_raw_event()
which dereferences dev =3D hid_get_drvdata(hdev), accessing memory that
has already been freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213941.9888=
2-1-michael.zaidman@gmail.com?part=3D7
