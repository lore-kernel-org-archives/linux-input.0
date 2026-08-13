Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3598C3D47BC
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633202; cv=none; b=Gs0ZhaLdJDR8N8MhDveGjiBcLNXeXZTs5lLEOGw4sGQjBcTt6iKzUdFwZcmMB0mWiUNh7TQxtSzgk+Id5vpC1fQnDrkR8AY27ZEfKvEA6A4ezfdnOoiwZLnF8SVg6l8Pb9N6lIjN/4jJIMWa7MAALneqe+YysxFHs3At2I0CmEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633202; c=relaxed/simple;
	bh=LdJPScTGvrLRbYshHt2JpGTb8mGY4Hu5xLHwIRaO5h8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BQn94p+GvmKtc/KlI3A+KHCEctyQ5+PENncx3HVpHRW1vwGhxmNP1NjascvV98U+OMj4d7quuc/d4+fDeJ5dcCb3sv89u6yXgDgeAMErlR5NOx05jxdxoWRME2fqfP86CkdHQASuP52Y2TkRgUthjzSS9XK74CB0BqLhltfL3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egm69g9v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egm69g9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BB51F00A3A;
	Thu, 13 Aug 2026 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633196;
	bh=5kEjzXhORAQJDH6Yma/p/8mhjpDQLznOLlLYLX6dZzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=egm69g9v6/HTcyGMJIVEkOsLS37pb2PhsvOiRcEw/9Oy2hxYo/aqBw5NMME9PHEz5
	 IsBlqkA6zGZCeS7M+FgC9JUl+Gi13n9Qb7jQfbFP0Tj68ouk25bJukeHfkcr3cBJfn
	 kpwgcnSCEKnp8Uj9Thbji2/C7+lMrb4Kf6XCJ+OqRZrBx+s+x5NGUJFGDRmhwNCjxv
	 50cpeT4RIiq99hyXYr6eUAldrZtn56cBQMDLB6S2s+c67Hns2lPiIJb4IimzWjPJP1
	 kSh9rLQld7uojMZSq4phQEM8qMjzhB0zrfmHwVruzhhAbeJsrwdq8iA9zNnAziGBnR
	 QdghNq7XueU+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] HID: asus: add gamepad configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260813144736.2477941-4-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
 <20260813144736.2477941-4-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 14:59:55 +0000
Message-Id: <20260813145956.29BB51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Dangling global pointer `ally_drvdata.cfg_hdev` on probe failure.
- [High] Uninitialized mutex `cfg->config_mutex`.
- [High] TOCTOU NULL pointer dereference in sysfs callbacks reading `ally->=
config`.
- [Medium] Missing lock acquisitions in sysfs store callback (`xbox_control=
ler_store`).
- [Low] Mixing `goto`-based error handling with the `__free()` scope-based =
cleanup helper in `ally_check_capability()`.

Pre-existing issues:
- [High] Sleeping in atomic context by acquiring a mutex in HID `raw_event`=
 callback.
--

--- Patch [3]: [PATCH 03/12] HID: asus: add gamepad configuration ---
commit 4090231155d8c981f8463cdfdb5cbc51349b174f
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add gamepad configuration

Add the base configuration structures for the gamepad configuration,
detect capabilities and initialize the device in a known state.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index f4b2c4a616b75..6a15380488efb 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -556,6 +590,219 @@ static u8 *ally_alloc_cmd(u8 cmd, const u8 *payload=
, u8 payload_size)
>  	return hidbuf;
>  }
> =20
> +/**
> + * ally_check_capability - Check if a specific capability is supported
> + * @hdev: HID device
> + * @ally: ally handheld structure
> + * @check_cmd: Capability command code to query
> + *
> + * Returns true if capability is supported, false otherwise
> + */
> +static bool ally_check_capability(struct hid_device *hdev, struct ally_h=
andheld *ally,
> +				  enum ally_command_codes check_cmd)
> +{
> +	u8 payload[] =3D { 0x00 };
> +	bool result =3D false;
> +	int ret;
> +
> +	u8 *buf __free(kfree) =3D ally_alloc_cmd(check_cmd, payload, sizeof(pay=
load));
> +	if (!buf) {
> +		hid_err(hdev, "Failed to allocate buffer for capability check.\n");
> +		goto ally_check_capability_err;

[Severity: Low]
Does this code mix goto-based error handling with the __free() scope-based=
=20
cleanup helper? The cleanup guidelines suggest that goto and cleanup helper=
s=20
should never be mixed in the same function to avoid confusing ownership=20
semantics.

> +	}
> +
> +	ret =3D ally_gamepad_send_receive_packet(ally, hdev, buf, ROG_ALLY_REPO=
RT_SIZE);

[ ... ]

> +static int ally_set_xbox_controller(struct hid_device *hdev,
> +				    struct ally_config *cfg, bool enabled)
> +{
> +	u8 payload[] =3D { enabled ? 0x01 : 0x00 };
> +	int ret;
> +
> +	if (!cfg || !cfg->xbox_controller_support)
> +		return -ENODEV;
> +
> +	u8 *buf __free(kfree) =3D ally_alloc_cmd(CMD_SET_XBOX_CONTROLLER, paylo=
ad, sizeof(payload));
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret =3D ally_dev_set_report(hdev, buf, ROG_ALLY_REPORT_SIZE);
> +	if (ret < 0) {
> +		hid_err(hdev, "Failed to set Xbox controller mode: %d\n", ret);
> +		return ret;
> +	}
> +
> +	cfg->xbox_controller_enabled =3D enabled;

[Severity: Medium]
Are we modifying the configuration state and interacting with the hardware=
=20
without acquiring the required locks? The sysfs handler modifies=20
cfg->xbox_controller_enabled and sends device reports, but neither=20
cfg->config_mutex nor ally->intf_mutex appear to be held here. Could this=20
cause a data race if userspace writes to the xbox_controller sysfs attribut=
e?

> +	return 0;
> +}
> +
> +static ssize_t xbox_controller_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *ally =3D drvdata->rog_ally;
> +	struct ally_config *cfg;
> +
> +	if (!ally || !ally->config)
> +		return -ENODEV;
> +
> +	cfg =3D ally->config;

[Severity: High]
Is it possible for ally->config to be freed between the check and this=20
assignment? If hid_asus_ally_remove() runs concurrently and sets=20
ally->config =3D NULL, could this result in a NULL pointer dereference?

> +	if (!cfg->xbox_controller_support)
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "%d\n", cfg->xbox_controller_enabled ? 1 : 0);
> +}
> +
> +static ssize_t xbox_controller_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *ally =3D drvdata->rog_ally;
> +	struct ally_config *cfg;
> +	bool enabled;
> +	int ret;
> +
> +	if (!ally || !ally->config)
> +		return -ENODEV;
> +
> +	cfg =3D ally->config;

[Severity: High]
Like in xbox_controller_show(), could a concurrent device unbind cause a=20
NULL pointer dereference here if ally->config is cleared after the check?

> +	if (!cfg->xbox_controller_support)
> +		return -ENODEV;

[ ... ]

> +static struct ally_config *ally_config_create(struct hid_device *hdev, s=
truct ally_handheld *ally)
> +{
> +	struct ally_config *cfg;
> +	int ret, sysfs_i;
> +
> +	cfg =3D devm_kzalloc(&hdev->dev, sizeof(*cfg), GFP_KERNEL);
> +	if (!cfg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret =3D ally_detect_capabilities(hdev, ally, cfg);

[Severity: High]
Are we missing an initialization for cfg->config_mutex? The config_mutex in=
=20
struct ally_config is allocated with devm_kzalloc, but it doesn't seem to b=
e=20
initialized with mutex_init() before ally_detect_capabilities() uses=20
scoped_guard() to lock it. Could this lead to a lockdep splat or panic?

> +	if (ret < 0) {
> +		hid_err(hdev, "Failed to detect Ally capabilities: %d\n", ret);
> +		goto ally_config_create_err;
> +	}

[ ... ]

> @@ -838,8 +1079,30 @@ static struct ally_handheld *hid_asus_ally_probe(st=
ruct hid_device *hdev)
>  		switch (ep) {
>  		case HID_ALLY_INTF_CFG_IN:
>  			ally_drvdata.cfg_hdev =3D hdev;
> +
> +			/*
> +			 * This function assumes the asus-specific initialization
> +			 * to have been performed already at this point.
> +			 */
> +			ret =3D ally_gamepad_check_ready(&ally_drvdata, hdev);
> +			if (ret < 0) {
> +				hid_err(hdev, "ROG Ally device is not ready: %d\n", ret);
> +				return ERR_PTR(ret);

[Severity: High]
If ally_gamepad_check_ready() fails, do we leave ally_drvdata.cfg_hdev=20
pointing to the hid_device? Since ally_drvdata is global state and the devi=
ce=20
will be freed on probe failure, could this cause a use-after-free later?

> +			}
> +

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed something concerning in=20
handle_ally_event() when it is called from the raw_event path:

drivers/hid/hid-asus.c:handle_ally_event() {
	...
		scoped_guard(mutex, &ally_data_mutex) {
			keyboard_input =3D ally->keyboard_input;
			if (keyboard_input) {
	...
}

Since handle_ally_event() is called from the HID raw_event callback, it=20
runs in an atomic context where sleeping is prohibited. Could acquiring=20
ally_data_mutex here lead to a kernel panic by sleeping in atomic context?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813144736.2477=
941-1-denis.benato@linux.dev?part=3D3
