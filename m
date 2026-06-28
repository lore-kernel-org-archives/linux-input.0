Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9C25B081
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665991; cv=none; b=q8rNxCs4JuijczC6laIn2Trb0yXBVTnIyWkkIWSqXbQ2qTHG0F91dE+8xvRHq8j4+9zZDJW8H7xTtyTzmRd/UrIjizr661jMv2r+c6PkoXmCzIP+FaQ8iHdFijN++kxiCw/wkkMfYca+R7lurZ/OxrIs/6/ha9qLsbm+jkvOLcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665991; c=relaxed/simple;
	bh=LpI0JB/frZK8W0tp+tXvUtw6AYA/XVb6LmxR5Ys8HtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hx8BYxozbDJ7vEEHhuNw5eMlC/FwqyfRnZOGfdmtsoqcaqAJ63hoKn70p4MdmK8bbqyoAxrr0YGkbJ3WcnJbmg1xGlFPLZfSw0NQv1XdQNSWsAb83DmoABGAoys2UB7+5d6Y5XqJEM2L6XNT1eLou6L3FFhdUrt74ZmuOi7NXiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6ZVo0iv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6ZVo0iv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818081F000E9;
	Sun, 28 Jun 2026 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782665990;
	bh=zX0vnRtYvTuRouM04nOgl/AwToCeteXVYchoMSZGfIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j6ZVo0ivqExNVj/9qoGrVIawBTHNckR107SuW97B9tf9XOYzWlTb2yUUelLBp3eBQ
	 f6Bx7jDI22uT3/bORciql19cwEJDQHDe2g4L6h0VSz5jTMBXqLNRn6IPnK+HLC2if/
	 6eQvT/31ixFiW8XoAROk2KXJQhs2tC4wuMaj+28ucSJFi5f5+mDgbCLmmy7JGa5A03
	 CqFp1P4NIc1FFzmM3YtY62X7KmH/rruzFgK2qk8nWwgb00NacqCdDF33M746oECelJ
	 kwsdUDOjryD2zRwgngN6U2hOyI5UednT1lSuaW8tTzo5FMKOj778Jipp4/pK48GNkf
	 zkn3Go9/oo47w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] HID: roccat-pyra: reject short button reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260628164611.17467-3-alhouseenyousef@gmail.com>
References: <20260628164611.17467-1-alhouseenyousef@gmail.com>
 <20260628164611.17467-3-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 16:59:49 +0000
Message-Id: <20260628165950.818081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free (UAF) in `pyra_raw_event` and `roccat_report_event`=
 due to freeing device data before stopping the hardware.
- [Medium] Data race on `pyra->actual_profile` and `pyra->actual_cpi` betwe=
en process context and atomic context.
- [Medium] Missing lock serialization across the multi-step device control =
sequence in sysfs read handlers.
- [Medium] The identical out-of-bounds read vulnerability fixed in `pyra` a=
nd other drivers in this series is still present in `savu`.
--

commit c58b9d043952189d7a69bf9c149768907653644a
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

HID: roccat-pyra: reject short button reports

The Pyra raw-event path treats every button report as a complete
five-byte structure. A malformed USB device can send a shorter report
and make profile tracking or character-device event construction read
beyond the received input buffer.

> diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
> index 0d515995bb9d6..df8949c17ce3c 100644
> --- a/drivers/hid/hid-roccat-pyra.c
> +++ b/drivers/hid/hid-roccat-pyra.c
> @@ -557,6 +557,10 @@ static int pyra_raw_event(struct hid_device *hdev, s=
truct hid_report *report,
>  	if (pyra =3D=3D NULL)
>  		return 0;

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for a
use-after-free to occur here during device removal?

In pyra_remove(), pyra_remove_specials() frees the device data via kfree()
before hid_hw_stop(hdev) is called. Because the hardware isn't stopped yet,
the USB interrupt endpoint remains active.

If an event is received in this narrow window, pyra_raw_event() fetches the
freed pointer locklessly. Since the pointer was never cleared, it passes
the NULL check and dereferences freed memory. Can we reorder the cleanup in
pyra_remove() to stop the hardware before freeing the data?

> +	if (data[0] =3D=3D PYRA_MOUSE_REPORT_NUMBER_BUTTON &&
> +	    size < sizeof(struct pyra_mouse_event_button))
> +		return 0;
> +
>  	pyra_keep_values_up_to_date(pyra, data);

[Severity: Medium]
This is a pre-existing issue, but does pyra_keep_values_up_to_date() have a
data race with sysfs handlers?

The function pyra_sysfs_write_settings() runs in process context and modifi=
es
shared state like pyra->actual_profile and pyra->actual_cpi under the
pyra->pyra_lock mutex. Meanwhile, pyra_raw_event() runs in atomic context a=
nd
modifies these same variables locklessly via pyra_keep_values_up_to_date().

An interrupt firing during a sysfs write could cause concurrent modificatio=
ns,
leaving the variables in an inconsistent state.

>  	if (pyra->roccat_claimed)
>  		pyra_report_to_chrdev(pyra, data);
>=20
>  	return 0;
>  }

[Severity: Medium]
This is also a pre-existing issue, but are the sysfs read handlers missing
lock serialization across multi-step device control sequences?

To read profile settings, handlers like pyra_sysfs_read_profilex_settings()
in drivers/hid/hid-roccat-pyra.c first send a control command via
pyra_send_control(), then read the data via pyra_sysfs_read(). The
pyra_send_control() call is unprotected, and pyra_sysfs_read() only acquires
pyra->pyra_lock for the receive operation.

If two threads read from different profiles concurrently, the send/receive
sequences can interleave (e.g., Thread 1 requests Profile 1, Thread 2 reque=
sts
Profile 2, Thread 1 receives data meant for Profile 2). Does the lock need =
to
cover the entire request-response transaction?

[Severity: Medium]
Finally, this is a pre-existing issue outside of the pyra driver, but does
the savu driver suffer from the same out-of-bounds read vulnerability being
fixed here?

While this patch adds size checks to pyra, savu_raw_event() in
drivers/hid/hid-roccat-savu.c still passes the unverified data buffer direc=
tly
to savu_report_to_chrdev(). The data is cast to struct
savu_mouse_report_special without ensuring it contains enough bytes.

If a malformed USB device sends a short report, it looks like this will leak
stale data from previous USB packets into the character device event stream.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628164611.1746=
7-1-alhouseenyousef@gmail.com?part=3D3
