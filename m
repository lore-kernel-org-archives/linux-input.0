Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95F3D4118
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278254; cv=none; b=QnPnGOvMVh37X4glPQX6pYpBwRBVeFWn4b2SCw9+c91L3ITv+RIzvlVtZo5sAaTzvFzJuaBbjJI0KyUfISDTETBz65GzkuaePHGgljsxq9dhLYPbt2k4ssJ5ke7MO27GaUFcU0nQL6sDj8DdZuPqvy/PZkzSCs1pO+SnArA47XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278254; c=relaxed/simple;
	bh=lZEERfEwolTAVisZILbs3bzOM2se3hF2rVjbAm9rt1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qux8/+5A+OfzzsDlM08XGqtTaEMP2kLJVDNt2eQxUf3CV7aKIUim0dsZZdOD3eYMFgNdvWZuipUiDhT1qAX3AQPpTd3cibBZx8VrkLMds/FwC4iLtCHplfzC8b+UoC/JbAyM0ldphs2EgRh6Jqio2eXE5REMeOV9wd0sVHUD7xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d40zYvtb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d40zYvtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68291F00893;
	Wed, 20 May 2026 11:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779278252;
	bh=6YduZVOber5XT62b2CiJPTSzKbZ7a/jbK+Zt3VKz6YI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d40zYvtbZicKKRw/KTEsp+xGEnqhGhhuEQVWEC5kFeEVi8icqjtRxndlli8v0gCCu
	 sDh3c4uKxery2I7PEvxUbB8bg9FZcHoL2KuWUiQ1pruUpgyanhqE5VufDG7lmUqkYE
	 dkLKu8RC3UwNkzBYOcIQdymL78xqB3YxHqMOdj70cI0P/VRYKQBWsMAmTKWVNtlLW8
	 QYMHC0s9SlUuupXAZH+J9A1nKgpvp1cxmEZo+PCmztcWES461dNKq7a96vj9bDNH9v
	 +rEZrNMWEFBYJED8HnJR0vkj+cQ9pu5hvjFLTEvBV8DCMD5XVS2e5EyKPjISv9abHf
	 p+IPHw/W1rq1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 7.0-5.15] HID: ft260: validate i2c input report
 length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260520111944.3424570-54-sashal@kernel.org>
References: <20260520111944.3424570-54-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 11:57:32 +0000
Message-Id: <20260520115732.A68291F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] memcpy reads beyond the bounds of the statically sized array 'data=
[2]', which will trigger a FORTIFY_SOURCE panic for payloads > 2 bytes.
- [High] A race condition in the probe function leads to a NULL pointer der=
eference in `ft260_raw_event` if an input report is received early.
- [High] A race condition exists between the HID raw event handler and the =
I2C read timeout path, leading to a Use-After-Free or kernel stack corrupti=
on.
- [High] The probe function incorrectly returns 0 (success) when intentiona=
lly rejecting the UART interface, rendering it unusable.
--

commit 4ff190a6df13fab19cc5a93ba01ca6de278d20bd
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: validate i2c input report length

This commit adds checks to ft260_raw_event to prevent out-of-bounds reads
from malicious or malfunctioning devices. It rejects reports shorter than t=
he
2-byte header and validates the length field against the actual HID report
capacity.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 333341e80b0ec..70e2eedb465af 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -1068,10 +1068,22 @@ static int ft260_raw_event(struct hid_device *hde=
v, struct hid_report *report,
>  	struct ft260_device *dev =3D hid_get_drvdata(hdev);

[Severity: High]
This is a pre-existing issue, but can this result in a NULL pointer
dereference during device initialization?

If hid_hw_start() is called in ft260_probe() before hid_set_drvdata() is
initialized, the device might send an input report immediately (e.g., from
a pending interrupt). This would trigger ft260_raw_event(), leaving dev as
NULL and causing a panic when dev->read_buf is accessed below.

>  	struct ft260_i2c_input_report *xfer =3D (void *)data;
> =20
> +	if (size < offsetof(struct ft260_i2c_input_report, data)) {
> +		hid_err(hdev, "short report %d\n", size);
> +		return -1;
> +	}
> +
>  	if (xfer->report >=3D FT260_I2C_REPORT_MIN &&
>  	    xfer->report <=3D FT260_I2C_REPORT_MAX) {
> -		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
> -			  xfer->length);
> +		ft260_dbg("i2c resp: rep %#02x len %d size %d\n",
> +			  xfer->report, xfer->length, size);
> +
> +		if (xfer->length > size -
> +		    offsetof(struct ft260_i2c_input_report, data)) {
> +			hid_err(hdev, "report %#02x: length %d exceeds HID report size\n",
> +				xfer->report, xfer->length);
> +			return -1;
> +		}
> =20
>  		if ((dev->read_buf =3D=3D NULL) ||

[Severity: High]
This is a pre-existing issue, but does this check safely prevent a
use-after-free or stack corruption?

In ft260_i2c_read(), the driver blocks on wait_for_completion_timeout(). If=
 a
timeout occurs, it sets dev->read_buf =3D NULL and returns, destroying the
caller-provided buffer which may be a stack frame.

If ft260_raw_event() checks dev->read_buf !=3D NULL and is preempted while =
the
timeout path returns, wouldn't the subsequent memcpy() write hardware paylo=
ad
data into freed memory or a popped stack frame?

>  		    (xfer->length > dev->read_len - dev->read_idx)) {


There is another pre-existing issue right below the diff in ft260_raw_event=
():

drivers/hid/hid-ft260.c:ft260_raw_event() {
	[ ... ]
		if ((dev->read_buf =3D=3D NULL) ||
		    (xfer->length > dev->read_len - dev->read_idx)) {
			hid_err(hdev, "unexpected report %#02x, length %d\n",
				xfer->report, xfer->length);
			return -1;
		}

		memcpy(&dev->read_buf[dev->read_idx], &xfer->data,
		       xfer->length);
	[ ... ]
}

[Severity: High]
This isn't a bug introduced by this patch, but will this memcpy() trigger a
FORTIFY_SOURCE panic for payloads larger than 2 bytes?

The ft260_i2c_input_report structure defines the data payload as a fixed-si=
ze
array:

struct ft260_i2c_input_report {
	u8 report;
	u8 length;
	u8 data[2];
} __packed;

If xfer->length is greater than 2, the compiler statically knows the source
object size is exactly 2 bytes. Under CONFIG_FORTIFY_SOURCE=3Dy, wouldn't t=
his
trigger a mandatory kernel panic at runtime for a buffer overread? Could the
data field be changed to a flexible array member?


There is also a pre-existing issue in the probe function:

drivers/hid/hid-ft260.c:ft260_probe() {
	[ ... ]
	ret =3D ft260_is_interface_enabled(hdev);
	if (ret <=3D 0)
		goto err_hid_close;
	[ ... ]
err_hid_close:
	hid_hw_close(hdev);
err_hid_stop:
	hid_hw_stop(hdev);
	return ret;
}

[Severity: High]
This isn't a bug introduced by this patch, but does the probe function
incorrectly handle a rejected UART interface?

When ft260_is_interface_enabled() encounters the UART interface, it leaves
the return code as 0. The driver jumps to the error path, stops the hardwar=
e,
and returns 0 instead of an error code like -ENODEV.

Returning 0 informs the kernel driver core that hid-ft260 successfully bound
to the device interface. Doesn't this hijack the UART interface and leave it
in a disabled state, permanently preventing generic HID drivers (like
hid-generic) from claiming it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520111944.3424=
570-54-sashal@kernel.org?part=3D1
