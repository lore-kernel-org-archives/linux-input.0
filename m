Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A447081E
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583470; cv=none; b=OxRKFHDD05xNiUUjh7zR6IhiCVolDGMGp79ANObDvsoWt2siFVQT5M18CmtRbTSW/RQ89HDzCq5EYObOmmwpii4kxjukVn9wYRoCTKJijps0Wmho9fcQzvIXUjnVtUvjFnfKbkQduRwlJGj/w5jCjH+KWD+aK2TLMaNAj980A8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583470; c=relaxed/simple;
	bh=3cEc+T51QCNo3QZehpewDCEAQmPnxKB3ptyW/qD5WCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pjvlW7NTXgI3FMjr0v8nAI0WTCnpuxsXoXTNlV1DfmFW0BAnxorNvzAx1pnZvTYP2rzXVTwwn/Vh8oDEDbp0CYkhZ44JAxc09CtqX14cVDMnh5Lb68KnvZn3qJv+RXtSi0s61Q28BkzVXu2vQfz04ffSe94HJj2KhfK2fockly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+UNl3rk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+UNl3rk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6121F000E9;
	Thu,  9 Jul 2026 07:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783583469;
	bh=OtFmIWrIKLMIpK1i6Bv1ymRvyehGJPEbBLa356jcU1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N+UNl3rkEPv146IziDPXux+fPtNictU5hlB/cPgxEu0I6i8ktqhBeHF4uNHx9kEaM
	 l6OwQtWmxSh+AhdQQAO0b9OHWM1QorXzRYOqWdpSnnluaL3i7xAK5Y6VdwnpsOPM37
	 ZC4afm1yXxC3wf3N5Z1drBs+WDRrVacqh3N37oAf6Bs1vSzBjvI5jxaqX+uKRonAAf
	 SMrI6s0MgQHBIBRiVwtYNZ+MrO95cGyXrqZWSYb0Fp/0DIUjRRqsg0Qm5bwZfY/Fly
	 AyJIVkOlNQtePZUgaypNWDolrfGjoRcbwkCq6V/8TslPXzq1w7tUR3wSIZhnWn6dTu
	 EWieJorqEqHqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: cm109 - fix URB double-submit due to missing
 open check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xue Lei" <Xue.Lei@windriver.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260709073133.373657-1-Xue.Lei@windriver.com>
References: <20260709073133.373657-1-Xue.Lei@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 07:51:08 +0000
Message-Id: <20260709075108.CF6121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] TOCTOU Race leading to Use-After-Free during device disconnect
- [High] State Machine Stall due to unhandled URB submission failure
- [High] DMA API Violation from passing coherent buffer to streaming DMA ma=
pping
--

--- Patch [1]: [PATCH] Input: cm109 - fix URB double-submit due to missing =
open check ---
commit 8242b0347566c678c3b0f2e9b93934d136b010bb
Author: Xue Lei <Xue.Lei@windriver.com>

Input: cm109 - fix URB double-submit due to missing open check

This commit adds a dev->open check in cm109_input_ev() to reject input
events when the device is not fully initialized, preventing a double-submit
of urb_ctl.

Closes: https://syzkaller.appspot.com/bug?extid=3De69c25cf38a53d0cf64c

> diff --git a/drivers/input/misc/cm109.c b/drivers/input/misc/cm109.c
> index 353d3c1d347d5..558cb73d5c6df 100644
> --- a/drivers/input/misc/cm109.c
> +++ b/drivers/input/misc/cm109.c
> @@ -601,6 +601,9 @@ static int cm109_input_ev(struct input_dev *idev, uns=
igned int type,
>  {
>  	struct cm109_dev *dev =3D input_get_drvdata(idev);
> =20
> +	if (!dev->open)
> +		return -ENODEV;
> +

[Severity: High]
This is a pre-existing issue, but does this lockless check introduce a TOCT=
OU
race during device disconnect?

Looking at cm109_input_close(), dev->open is cleared after traffic is
stopped:

cm109_input_close()
    cm109_stop_traffic(dev);
    dev->open =3D 0;

If a concurrent event injection happens simultaneously, couldn't
cm109_input_ev() see dev->open =3D=3D 1 just before cm109_input_close() sets
it to 0?

Since cm109_usb_cleanup() frees the dev structure without explicitly calling
usb_kill_urb(), could this allow an asynchronously submitted URB to complete
and access the freed dev structure?

>  	dev_dbg(&dev->intf->dev,
>  		"input_ev: type=3D%u code=3D%u value=3D%d\n", type, code, value);
> =20

[Severity: High]
This is a pre-existing issue, but can the URB submission loop stall
permanently on failure?

Looking at cm109_submit_buzz_toggle(), if usb_submit_urb() fails due to
memory pressure or bus errors, it logs the error but does not clear
dev->ctl_urb_pending:

cm109_submit_buzz_toggle()
    error =3D usb_submit_urb(dev->urb_ctl, GFP_ATOMIC);
    if (error)
        dev_err(&dev->intf->dev, ...);

If ctl_urb_pending remains 1, wouldn't subsequent calls to
cm109_toggle_buzzer_async() always take this path:

cm109_toggle_buzzer_async()
    if (dev->ctl_urb_pending) {
        dev->buzzer_pending =3D 1;
        return;
    }

Since the URB was never actually submitted, its completion callback won't
run to submit urb_irq, meaning the device would permanently stop receiving
input events and buzzer updates until re-plugged?

[Severity: High]
This is a pre-existing issue, but does the synchronous buzzer toggle violate
DMA mapping rules?

In cm109_usb_probe(), dev->ctl_data is allocated using usb_alloc_coherent().
Later, cm109_toggle_buzzer_sync() passes this coherent buffer directly to
usb_control_msg():

cm109_toggle_buzzer_sync()
    error =3D usb_control_msg(dev->udev,
                            usb_sndctrlpipe(dev->udev, 0),
                            ...
                            dev->ctl_data,
                            USB_PKT_LEN, USB_CTRL_SET_TIMEOUT);

Since usb_control_msg() uses streaming DMA mapping via dma_map_single()
without the URB_NO_TRANSFER_DMA_MAP flag, could passing a buffer allocated
with a coherent API trigger mapping errors on architectures with
CONFIG_DMA_API_DEBUG enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709073133.3736=
57-1-Xue.Lei@windriver.com?part=3D1
