Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B632C8B
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245457; cv=none; b=sg61xfcGm0BaZUjyCfZjXE+d1RsrJBoYESOY+WhU4H3+wd+W+okOmW8QOP5ZN1qn8VPHzAcbquUfRriev+V7ywDHYdq6SEYS13qcaIxBnfjv3iHD76RexaQkyv45eceuGpkzXSjm90ptt6+cLYzbrWxb6v8RPTTMZ+hJ1iSiAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245457; c=relaxed/simple;
	bh=/17MUeFikd6JE82L1Ux9D8rCdh5bhMLQ6GlkZw4RCkA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i3uKfvhh1sooD/yENhxMVoxqz4uXl1fmZm/8rCumdehkyDPfi1hXwohhL+6UHcFNlDSadCnWcYDWMTzfUaLAZH+1EK9Z623w3yOQwgqk0lV2AfRQ0X/L6LZRG2aSHigHf+xuTdY3dgbAftV65dYOZxwEyHu4eDImYkFumKXHvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMaFlL6W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMaFlL6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61111F00A3D;
	Tue,  1 Sep 2026 06:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788245454;
	bh=Yu4aBjy0XMX8kxLA/iPQUM2gCvW/9T4eOlxgrpxilK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TMaFlL6WFgQk1Pk06uheSUN8H7nZ/EjdZd9SQ9yU21IL6urge4Kb8jWf/uv1FCAi4
	 cRQ87y7swrP+uXe8aganCQ8xZ9imb6fFP8N8FOxrH+h/9XpGt3CQroA1RLTOkWc71o
	 V1NC4twcUuJ9W61dUoJPPH5vchbDnFJuS/KXPdx0DnPgHTCNBceVw0pACQLSYYncaE
	 brFcWBU/1ZFosQoRSmLmb96k3OT+tzLUMcpca2lNRKGLKSOrjbunQrkPuvZUbbVgXQ
	 EdNJZhyEpZaTIi61WuTA52Bp6gqypFpJbn/Mbij7bfZpG2zz/nHHy9nMn8uzagszhS
	 f0WlWo8QJAksA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] HID: hid-lenovo-go: return configuration request
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <28ecf20c7406e9416d38bac1e7b89ac796b39a59.1788222001.git.mradityadash@gmail.com>
References: <cover.1788222001.git.mradityadash@gmail.com>
 <28ecf20c7406e9416d38bac1e7b89ac796b39a59.1788222001.git.mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 06:50:54 +0000
Message-Id: <20260901065054.C61111F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver uses a static global `drvdata` structure for per-device=
 state, causing state corruption across multiple devices.
- [High] AB-BA deadlock between `hid_go_cfg_remove()` and sysfs attributes =
due to inverse lock ordering with `cfg_mutex`.
- [High] Missing cleanup on `hid_go_probe()` and `hid_go_cfg_probe()` error=
 paths leaks hardware state and sysfs groups.
- [High] Missing hardware stop and close in `hid_go_remove()` if the device=
 has no valid endpoints.
--

commit 8f2d8679bb969b5284e4834a5d944cc1e08f97e3
Author: Aditya Dash <mradityadash@gmail.com>

HID: hid-lenovo-go: return configuration request errors

This patch adds pending command state tracking to the driver data to match
replies by command ID, subcommand, and device. It also returns request erro=
rs
to the caller and clears pending requests on interruption or timeout.

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index 51e3112780e18..deed7acd2dc4b 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c

[ ... ]

> @@ -2362,9 +2426,9 @@ static int hid_go_cfg_probe(struct hid_device *hdev,
>  	if (!buf)
>  		return -ENOMEM;
> =20
> +	mutex_init(&drvdata.cfg_mutex);
>  	hid_set_drvdata(hdev, &drvdata);
>  	drvdata.hdev =3D hdev;
> -	mutex_init(&drvdata.cfg_mutex);

[Severity: High]
This isn't a bug introduced by this patch, but does the use of cfg_mutex cr=
eate
an AB-BA deadlock between hid_go_cfg_remove() and sysfs attributes?

hid_go_cfg_remove() acquires drvdata.cfg_mutex and then calls
sysfs_remove_groups(), which blocks until all active sysfs callbacks drain =
via
the kernfs active reference.

Concurrently, if a sysfs write occurs, it acquires an active reference to t=
he
sysfs node and then calls mcu_property_out(), which waits to acquire
drvdata.cfg_mutex. This forms an unresolvable circular dependency:
cfg_mutex -> kernfs ref vs kernfs ref -> cfg_mutex.

[ ... ]

> @@ -2435,8 +2499,11 @@ static int hid_go_probe(struct hid_device *hdev, c=
onst struct hid_device_id *id)
>  	}
> =20
>  	ep =3D get_endpoint_address(hdev);
> -	if (ep =3D=3D GO_GP_INTF_IN)
> -		init_completion(&drvdata.send_cmd_complete);
> +	if (ep =3D=3D GO_GP_INTF_IN) {
> +		init_completion(&drvdata.cmd.done);
> +		spin_lock_init(&drvdata.cmd.lock);
> +		drvdata.cmd.pending =3D false;
> +	}

[Severity: High]
This is a pre-existing issue, but does using a static global drvdata struct=
ure
for per-device state cause state corruption across multiple devices?

If a user connects multiple Lenovo Go gamepads, or the device exposes multi=
ple
interfaces that match the driver's IDs and have the 0x83 endpoint, the probe
function unconditionally executes hid_set_drvdata(hdev, &drvdata) and
drvdata.hdev =3D hdev, overwriting the global pointer.

Furthermore, does unconditionally re-initializing drvdata.cmd.lock and
drvdata.cmd.done during hid_go_probe() silently destroy the active lock and
waitqueue if another device is currently processing a command, leading to l=
ist
corruption and kernel panics?

> =20
>  	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>  	if (ret) {

[Severity: High]
This is a pre-existing issue, but does hid_go_probe() fail to clean up
hardware state on error paths?

If hid_go_cfg_probe() fails (e.g., LED registration failure), it returns an
error. hid_go_probe() propagates this error directly without calling
hid_hw_stop() and hid_hw_close() to undo the previously successful
hid_hw_start() and hid_hw_open().

Additionally, error paths within hid_go_cfg_probe() return without calling
sysfs_remove_groups() to clean up previously created sysfs groups. While the
devres group is released, the active hardware and leaked sysfs nodes will s=
till
invoke callbacks that dereference the freed memory.


[Severity: High]
This is a pre-existing issue, but does hid_go_remove() fail to stop the
hardware if the device has no valid endpoints?

During hid_go_probe(), if the interface has no valid endpoints,
get_endpoint_address() returns an error. The driver still successfully star=
ts
the device via hid_hw_start() and returns 0 because it falls back to a gene=
ric
HID device path.

When the device is later unbound, hid_go_remove() checks
get_endpoint_address(hdev) again, sees it is <=3D 0, and immediately returns
without calling hid_hw_close() or hid_hw_stop(). The devres group is freed,
but the device remains active, causing a use-after-free on subsequent
interactions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222001.gi=
t.mradityadash@gmail.com?part=3D4
