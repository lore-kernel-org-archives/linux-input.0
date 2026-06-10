Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E97406801
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093853; cv=none; b=iPbbMVfjR23HByfFnPUJDvkdiWOHDOxLxx2weHi4niFtgricFGKyRJ969rWhgoLFJeVJ2+ArDgBsKqyCaJhjlsMbXnxRI1QV8ZT/iqJ7TuEPmG37GNvqKdLkxsrzs6AYaiNnFQ+Zolu1DBSGQ73B6mvY/tDZ3FC2KFNGlc+P8yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093853; c=relaxed/simple;
	bh=XuzlJzea0ljc/jqoW126n32MFzM3nHqUf6qFta1entA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rio5hZ7iZ0ZZyvQTGKU2dBLAy+VAgQBfIOhMB9IqqQ0kzBt6kRkaZL7Y4x7XtLr0xRCoViXYT37LzTcRINIt8y+D1a2ZJLuDMYBXtzeQ+RaIpgryT8SU/Ea8MCwVLZ2x4dKsolr60GBIbSR4pTtiB9SEmJfvqBjGmlyIlZwFzkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EodzewW5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EodzewW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5091F00893;
	Wed, 10 Jun 2026 12:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781093852;
	bh=e5tvtoPFLcBdNVNLf+lLT+fLfpswuOpjxu1YQ577PRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EodzewW57btil1zaS/FU8TOQPMAju8gVmTYbLKJSh0HhsIDcHjG9zQOiP5OM/jabU
	 w/SV7WKe7ms0RZvUtKkO8H5u388didT8g4rD7EfDIJKzK2VpcaMAqdzdDOVKt1o2Un
	 NUH2H/DQZfw64kpEHjEB7nEBVEMDZdPlVwHph/QGejTDxbX1iAa3t5DvKBrSZHfmpJ
	 tR9cKVcPfv0JOp8N8q5Qn+NDQzqDrdc4DKV6zzGUP6q9IkZ395E7e2kyoNa9YQ8U+J
	 RPweHz6yUCCg671bpCX+Ec7hBHSO5p+mRbNAXSnJ5mQLQJkgGdyRWpRwl7tysosMKV
	 P105/+O05XaRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: hid-steam: fix uninit-value access in
 steam_get_serial
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pei Xiao" <xiaopei01@kylinos.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <0c5f5bcd3d01776615a97d7f23b5c1bff6a2acce.1781092734.git.xiaopei01@kylinos.cn>
References: <0c5f5bcd3d01776615a97d7f23b5c1bff6a2acce.1781092734.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 12:17:31 +0000
Message-Id: <20260610121731.8E5091F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing payload length validation in `steam_get_serial()` allows a=
 short report to produce an empty serial number, leading to list corruption=
 (Use-After-Free) during device unregistration.
- [High] Probe error path leaves a freed object in the global `steam_device=
s` list, causing a Use-After-Free.
- [Medium] Incorrect size argument passed to `strscpy()` causes truncation =
of the last character of the device's serial number.
--

commit ecebdbfdb0a084297c080f3d3ad65a720d3b9ec6
Author: Pei Xiao <xiaopei01@kylinos.cn>

HID: hid-steam: fix uninit-value access in steam_get_serial

The reply buffer in steam_get_serial() is zero-initialized to prevent KMSAN
uninit-value warnings. These warnings occur when steam_recv_report()
returns a short read or an error.

Reported-by: syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/6a27d055.39669fcc.33b062.008d.GAE@goog=
le.com/
Fixes: c164d6abf384 ("HID: add driver for Valve Steam Controller")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 197126d6e0810..f65ad1a21c018 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -445,7 +445,7 @@ static int steam_get_serial(struct steam_device *stea=
m)
>  	 */
>  	int ret =3D 0;
>  	u8 cmd[] =3D {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB=
_STR_UNIT_SERIAL};
> -	u8 reply[3 + STEAM_SERIAL_LEN + 1];
> +	u8 reply[3 + STEAM_SERIAL_LEN + 1] =3D { 0 };
> =20
>  	mutex_lock(&steam->report_mutex);
>  	ret =3D steam_send_report(steam, cmd, sizeof(cmd));

[Severity: High]
This is a pre-existing issue, but does steam_get_serial() properly validate
the payload length before copying the serial number?

If a device returns a short report (e.g., 4 bytes), steam_recv_report()
returns 4. The buffer validation checks reply[0] through reply[2], and if
they match, execution reaches the copy:

drivers/hid/hid-steam.c:steam_get_serial() {
    ...
    strscpy(steam->serial_no, reply + 3, reply[1]);
    ...
}

If reply[1] is 1, strscpy() will copy 0 characters and write a null
terminator at steam->serial_no[0]. steam_get_serial() then returns 4
(success), bypassing the fallback assignment in steam_register().

Later, during device unregistration:

drivers/hid/hid-steam.c:steam_unregister() {
    if (steam->serial_no[0]) {
        ...
        list_del_init(&steam->list);
        ...
    }
}

Could this skip list removal because steam->serial_no[0] is null, leaving a
freed object on the global steam_devices list and causing a use-after-free?

[Severity: Medium]
This isn't a bug introduced by this patch, but does the strscpy() call insi=
de
steam_get_serial() pass the correct size argument?

drivers/hid/hid-steam.c:steam_get_serial() {
    ...
    strscpy(steam->serial_no, reply + 3, reply[1]);
    ...
}

Since strscpy() reserves one byte for the null terminator, passing the exact
string length (reply[1]) as the size will cause it to copy only reply[1] - 1
characters. Will this truncate the last character of a valid serial number =
if
the device specifies its exact length in reply[1]?

[Severity: High]
This is a pre-existing issue, but does steam_register() properly clean up
the global steam_devices list on failure?

During registration, the device is added to the global list:

drivers/hid/hid-steam.c:steam_register() {
    ...
    mutex_lock(&steam_devices_lock);
    if (list_empty(&steam->list))
        list_add(&steam->list, &steam_devices);
    mutex_unlock(&steam_devices_lock);
    ...
    ret =3D steam_input_register(steam);
    if (ret !=3D 0)
        goto steam_register_input_fail;
    ...
steam_register_input_fail:
    return ret;
}

If steam_input_register() fails, steam_register() returns an error without
removing the object from the steam_devices list.

In the probe function:

drivers/hid/hid-steam.c:steam_probe() {
    ...
    ret =3D steam_register(steam);
    if (ret) {
        hid_err(hdev,
            "%s:steam_register failed with error %d\n",
            __func__, ret);
        goto err_hw_close;
    }
    ...
}

If steam_register() fails, the driver core will free the devres-managed
steam_device struct. Could this leave a dangling pointer in the global
steam_devices list and lead to a use-after-free upon later list traversal?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0c5f5bcd3d01776615a=
97d7f23b5c1bff6a2acce.1781092734.git.xiaopei01@kylinos.cn?part=3D1
