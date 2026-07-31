Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC7A4446F4
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514504; cv=none; b=SEXQM8XcCJsw4ue16OJ16DIjrqXbJJ6/TdZ8Dk4pNEraAH/LaIUXmciXdoPZUsXK/gWBK+ZZc0ou2JGFRQddhpvy3H5O3+bsHhEDZcgsrcKYDiNPsaRx0e/PBGa/nXHzCu3Tb8p8yxyTrwpeLBBSbYZEX0x5F+73gpYAtGKDDw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514504; c=relaxed/simple;
	bh=ynRunjgWFyw3/rYHTXVp+wDmXvweuLXPNiXB81RJ0rE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=poUv6c+XRV6Dt6CKzyl1p4S7G4zWEEXsfQkwyZGEZpeCr67UTUTp9stVdwVgqcY12NAoZHQzZmJFv7+dZt2KcdAV31fvpTQiiNoZOcA/b2ceqy+V9eXeTaAcRpOZNcTwzMWP/gluZ3fqc6lOxVS06SOHu+f8rK+eHAW/bnhp00o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zbm8+ZCb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zbm8+ZCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD391F00AC4;
	Fri, 31 Jul 2026 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785514499;
	bh=LMZLsN4/4iGU1JrvxKM3OGaRuBycF7JnvNfxvt7ZHy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zbm8+ZCblLZ4VQqgZ32BMAWMY15jHYBUPQpicHGP7kBO8eD1qyKWOBx7ckc9SduHm
	 panckgubs52fJGsDOyJc7zDxTfpjpG0vYf6eucjnLeBE1X8wqNUjoNQFJ8/IiLG4O6
	 hapuDeUg6qwcb8vk8OHwJ6Q1NjuULgD9cUPwCMftR6xOkJOdDUarFXkk8L8vJT/nGx
	 /3IowRSmGQ5xD3GWzEP8qd8xicg9SnEdPCihZv5Uh2Wpd9XpeFh2+cQIKynthLUlDC
	 REoHiskmV6SwkPblknK/T6X2jUM6d90VF7OO1zzUUdCa9OKRHzlfAftRPqXbTKMFIl
	 zaUc+tHn2QSXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: intel-ish-hid: clamp HID device count to
 MAX_HID_DEVICES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shen Yongchao" <grayhat@foxmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <tencent_130404E5ABECE66E8D0E70D8E6892C751C0A@qq.com>
References: <tencent_130404E5ABECE66E8D0E70D8E6892C751C0A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:14:58 +0000
Message-Id: <20260731161459.0CD391F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cancellation of work items in driver removal leads to a Us=
e-After-Free when the devres-allocated client data is freed.
- [High] Dynamic arrays are not reallocated on subsequent firmware response=
s or device resets, causing heap buffer overflows when larger payloads bypa=
ss the reallocation logic.
- [High] Flawed bounds checking and missing loop termination when parsing `=
HOSTIF_DM_ENUM_DEVICES` allow reading past the end of `recv_buf`.
- [High] Pointer arithmetic on a typed `report` pointer implicitly scales b=
y the structure size in `HOSTIF_PUBLISH_INPUT_REPORT_LIST`, causing massive=
 out-of-bounds memory reads.
- [High] If `ishtp_hid_probe()` fails for a device during initialization, p=
reviously registered HID devices are left stranded and active, leading to a=
 Use-After-Free.
--

--- Patch [1]: [PATCH v3] HID: intel-ish-hid: clamp HID device count to MAX=
_HID_DEVICES ---
commit 559bcab8783934e29e559180566c360b1aa54115
Author: Shen Yongchao <grayhat@foxmail.com>
Subject: HID: intel-ish-hid: clamp HID device count to MAX_HID_DEVICES

This commit clamps the HID device count received from the ISH firmware to
MAX_HID_DEVICES. This prevents potential out-of-bounds array writes during
initialization when the firmware reports more devices than supported.

> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/i=
ntel-ish-hid/ishtp-hid-client.c
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -123,6 +123,8 @@ static void process_recv(struct ishtp_cl *hid_ishtp_c=
l, void *recv_buf,
>  				break;
>  			}
>  			client_data->hid_dev_count =3D (unsigned int)*payload;

[Severity: High]
This is a pre-existing issue, but is it possible for the firmware to send a
message where the payload length is zero?

If payload_len is zero, dereferencing the payload here could lead to an
out-of-bounds read.

Additionally, does the parsing loop properly bounds check the device_info
payload?

drivers/hid/intel-ish-hid/ishtp-hid-client.c:process_recv() {
    ...
    for (i =3D 0; i < client_data->hid_dev_count; ++i) {
        if (1 + sizeof(struct device_info) * i >=3D payload_len) {
            dev_err(...);
        }
        if (1 + sizeof(struct device_info) * i >=3D data_len)
            break;
        ...
        memcpy(client_data->hid_devices + i, dev_info,
               sizeof(struct device_info));
    }
}

The loop only checks the start offset against data_len. If the end of the
device_info structure straddles the boundary, could this memcpy() read past
the end of the buffer? It also appears the loop does not break if the
payload_len bounds check fails.

> +			if (client_data->hid_dev_count > MAX_HID_DEVICES)
> +				client_data->hid_dev_count =3D MAX_HID_DEVICES;
>  			if (!client_data->hid_devices)
>  				client_data->hid_devices =3D devm_kcalloc(
>  						cl_data_to_dev(client_data),

[Severity: High]
This is a pre-existing issue, but how does this handle sequential firmware
responses with varying device counts?

If a subsequent HOSTIF_DM_ENUM_DEVICES response arrives with a larger count,
the allocation is skipped. Could the parsing loop then copy up to the new,
larger count and write past the end of the previously allocated array?

This same pattern appears in the HOSTIF_GET_HID_DESCRIPTOR and
HOSTIF_GET_REPORT_DESCRIPTOR handlers, where a larger subsequent payload
might bypass reallocation and overflow the buffers.


While reviewing the rest of the file, I noticed a few other pre-existing
issues that might need attention:

[Severity: High]
This is a pre-existing issue, but does the pointer arithmetic in the
HOSTIF_PUBLISH_INPUT_REPORT_LIST handler scale correctly?

drivers/hid/intel-ish-hid/ishtp-hid-client.c:process_recv() {
    ...
    report +=3D sizeof(*report) + payload_len;
    ...
}

Since report is a pointer to struct report, C pointer arithmetic will
implicitly multiply the added value by the size of the structure. Could this
cause the loop to advance by (6 + payload_len) * 6 bytes instead of the
intended size, leading to an out-of-bounds memory read?


[Severity: High]
This is a pre-existing issue, but does the device removal path properly
cancel pending work items?

drivers/hid/intel-ish-hid/ishtp-hid-client.c:hid_ishtp_cl_remove() {
    ...
    ishtp_put_device(cl_device);
    ishtp_hid_remove(client_data);
    hid_ishtp_cl_deinit(hid_ishtp_cl);

    hid_ishtp_cl =3D NULL;
}

If a reset or resume event queues work concurrently with or immediately pri=
or
to unbind, could client_data be freed by devres while the workqueue still
references it, leading to a use-after-free?


[Severity: High]
This is a pre-existing issue, but does the initialization failure path leave
previously registered HID devices stranded?

drivers/hid/intel-ish-hid/ishtp-hid-client.c:hid_ishtp_cl_init() {
    ...
    rv =3D ishtp_hid_probe(i, client_data);
    if (rv) {
        dev_err(cl_data_to_dev(client_data),
                "[hid-ish]: HID probe for #%u failed: %d\n", i, rv);
        goto err_cl_disconnect;
    }
    ...
}

If ishtp_hid_probe() fails for a subsequent device (e.g., index 1), the
function returns an error without unregistering the previously successful
device (index 0). Could this leave the first device fully registered in the
HID subsystem while client_data is freed by devres, leading to a
use-after-free upon interaction?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_130404E5ABE=
CE66E8D0E70D8E6892C751C0A@qq.com?part=3D1
