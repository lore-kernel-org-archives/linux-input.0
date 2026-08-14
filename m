Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD46033D4FD
	for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692207; cv=none; b=Yh30hOgamIPuB5MayjITtj9QabjJw0mI4OBztXRJScvJ7nwZdiVf5iWJn7Ac5MLeGKoG11tOpHNwvYLi0Jef3/w45h+kIm65D47w1Wzkco0UIX3hEusNr3Bq5zYOw07Tx047H6sd1fJlUXatyt1IuZd0pc0rPCONKiRxFQZu2vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692207; c=relaxed/simple;
	bh=bKwxUdQj4BD08/J5P+8eJaeXRcV4jrbDiwuXM9kP3cM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UKlT1Lk7oMCZvDqaF0TGfjmblTkkpyWmzAIgfJW90o0BdSxzEkpgrFMhnFZk0RpDzET32KNoa6dH9pcC+jIsygSRqLjb7iobf/rvkyLn53OpR6AKjA4ZY9NTpCWcxcCGyHsL96WErQ+75pqZajOkckUZnNYKC+OBXAuqvsQxpA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amlv9ABn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amlv9ABn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD0E1F000E9;
	Fri, 14 Aug 2026 07:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786692206;
	bh=GBvCzTi+JHZf8BdakgC7OpbphiWaKM0tXg2Csry5esA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=amlv9ABngFczMKvoQFLdJEuhhHohgQXQDyKvI5cAn+Sm10WgS8V6pKdDPk+Unboua
	 B3ugvPIYSe40q6X5VoBiVtoqGOnWE+ilh2qr1DNQYLdDkRSEypehnY7jSe9DH6kdsI
	 tz+7B1uXxwsUNjnUOEFixxPENvtLxHCcnIY3KFITNx4Dnhlg/+6AqWhvOclUCJX0SV
	 YKhoq4TDv7kZZS0eJ0NtDhTxYtUyC78iNjv2KVLAdJedfPrFW9b6RO6ixaHTveKub2
	 7/oL1RG2OqfV0PFflGnweWUgvN3SpbQ33ASboU36vk3XRUcx4MhD7yW2dvt7bAFOfg
	 IoPAIp/IrDToA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: alps: unregister DualPoint Stick input device
 on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Changcheng" <chenchangcheng@kylinos.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260814070621.68557-2-chenchangcheng@kylinos.cn>
References: <20260814070621.68557-1-chenchangcheng@kylinos.cn>
 <20260814070621.68557-2-chenchangcheng@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 07:23:25 +0000
Message-Id: <20260814072326.1FD0E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] If `input_register_device()` fails for `data->input2` in `alps_inp=
ut_configured()`, the driver frees `input2` but leaves `data->input2` as a =
dangling pointer. The newly added `alps_remove()` unconditionally uses this=
 dangling pointer, causing a Use-After-Free.

Pre-existing issues:
- [High] Untrusted USB devices can trigger a NULL pointer dereference in `u=
1_raw_event()` by sending a StickPointer report when the device was not ini=
tialized with one.
--

--- Patch [1]: [PATCH 1/2] HID: alps: unregister DualPoint Stick input devi=
ce on remove ---
commit 93188845b9160c2ea2789c012e11b634ca66357c
Author: Chen Changcheng <chenchangcheng@kylinos.cn>

HID: alps: unregister DualPoint Stick input device on remove

alps_input_configured() allocates a second input device ("DualPoint
Stick") with input_allocate_device() and registers it, but the
alps_driver struct has no .remove handler and input2 is not tracked in
hdev->inputs. The default remove path only iterates hdev->inputs, so
input2 is never unregistered and leaks on every device removal.
This patch adds a .remove handler that stops the device first and then
unregisters input2.

> diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
> index 67179e3fe39b7..370635f5b7043 100644
> --- a/drivers/hid/hid-alps.c
> +++ b/drivers/hid/hid-alps.c

[ ... ]

> @@ -823,6 +823,24 @@ static int alps_probe(struct hid_device *hdev, const=
 struct hid_device_id *id)
>  	return 0;
>  }
> =20
> +static void alps_remove(struct hid_device *hdev)
> +{
> +	struct alps_dev *data =3D hid_get_drvdata(hdev);
> +
> +	/*
> +	 * input2 ("DualPoint Stick") is allocated separately and is not
> +	 * tracked in hdev->inputs, so the default remove path
> +	 * (hid_hw_stop -> hidinput_disconnect) does not unregister it.
> +	 *
> +	 * Stop the device first so that no URB callback can touch input2
> +	 * while it is being unregistered, then drop it explicitly.
> +	 */
> +	hid_hw_stop(hdev);
> +
> +	if (data->input2)
> +		input_unregister_device(data->input2);

[Severity: High]
If input_register_device() fails in alps_input_configured(), input2 is freed
but data->input2 is not set to NULL:

drivers/hid/hid-alps.c:alps_input_configured() {
    ...
		if (input_register_device(data->input2)) {
			input_free_device(input2);
			ret =3D -ENOENT;
			goto exit;
		}
    ...
}

Because the driver has a .raw_event handler, hid_connect() considers
the device bound and ignores the failure in hidinput_connect(), allowing
probe to succeed.

When the device is later removed, could this result in a use-after-free
when alps_remove() attempts to unregister the dangling data->input2
pointer?

[Severity: High]
This isn't a bug introduced by this patch, but if a malicious or
malfunctioning device indicates it doesn't support the StickPointer
(has_sp =3D=3D 0), data->input2 is never allocated.

If that device then sends a raw report with U1_SP_ABSOLUTE_REPORT_ID (0x06),
would this trigger a NULL pointer dereference in u1_raw_event()?

drivers/hid/hid-alps.c:u1_raw_event() {
    ...
	case U1_SP_ABSOLUTE_REPORT_ID:
		sp_x =3D get_unaligned_le16(data+2);
		sp_y =3D get_unaligned_le16(data+4);

		sp_x =3D sp_x / 8;
		sp_y =3D sp_y / 8;

		input_report_rel(hdata->input2, REL_X, sp_x);
    ...
}

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814070621.6855=
7-1-chenchangcheng@kylinos.cn?part=3D1
