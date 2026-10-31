Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793469288;
	b=AdncsGtdxH1qJ1q4DAsyI9Qiy/gU4VI7gBY9gRLYgNeLehlJztIAPeOGtU8qciyk1R2y
	 jfqgvp/DyPJ5gd/VxvVi7XTYdmJxOikhlozfU5XUWUY1psNzj75WJzYYRgdzfZ784pbfR
	 4ND5PIZfjb9vGk3RMWT+93AAdfQ84gPWW7tFONw4/JbRQbGiGMusUgyOU6q0L2AOYTF+K
	 LlHvJFvVwoKVDtnhZmqwdby3QipNN47YWJl3O0aQ/PRDy1qUiOp/Y5fZymazwLGLZzceR
	 sULE8CfePLOm7ZhoH08yhi3LdHWmEyH5uWeiLA8B6+FB0YHZxYucbVw7073GR6Tzt0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469288;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GeHRzP3d/GzbhPaJnSvCnoqHvOTU7hOsGhjgIJmNjbw=;
	b=WL7uWnVfdDRXRHPMf+4/2sM4m5TIKnYyTs1SqEcavMGgOihmEoNmya5zId+hfuxYB8c7
	 B1KLNa2g5pRVGYk9evxpTBHsA58BuHrzIswiNPoRLlWeGXMnRRMaTkC2nDSyy+O2NDxKZ
	 4hcyxHmrjkOKBvh6uFYtP8pQMzG/smaiYCF6NSZxajxzoFlyQSqbWHQBWy+5USwMlCvm4
	 7vCGd7AyNgA+iDH2YBnlJyw02Vnr7BAqMSU7IIYeiDciejasRIhkapW9GC1vHSieWCMdn
	 C0cRJDnJtNOQGCydlkxh/N3ClXaYqZENAqmN+oqLkIqSnk2A2+RTg1rATKqfabCcqaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zd3MEbPA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C92606A31A
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zd3MEbPA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0741F000C1;
	Sat, 31 Oct 2026 17:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793469288;
	bh=GeHRzP3d/GzbhPaJnSvCnoqHvOTU7hOsGhjgIJmNjbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zd3MEbPAOcOaWbnYOg4gT76Cstyr7zTbXGqnTnaM5ya7eqvr9amA3ITxll/LD/VbX
	 Z8iBNpP/Ll6RgQzOoTY0ujvpRbwUwk7+k5pxzI9uNf2UB0+KxCbZtuQsNOZmvSajQN
	 /2TaxaOays70IBKN0BjzIOkyTvcYN0uHTaO4RW7RE1EH7QHBNDaf/hbp2+AP9IKybT
	 q8zoBdBvc49p1ooIDnoKR++lGK504bbqnlhxbbA0fJJyx8cFYv5JSBF4MrdzKegIhO
	 68OE9WaEXrGI6vmaHsE2yc2cW1G0R/OTxZkXNGZCrxl5ZjV445tGcxXr3jBZGQJUKt
	 CEchCyWyHSX7g==
Message-ID: <sashiko-outbox-192079@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 11/17] HID: asus: add support for turbo buttons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261031174130.208240-12-denis.benato@linux.dev>
References: <20261031174130.208240-1-denis.benato@linux.dev>
 <20261031174130.208240-12-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 17:54:47 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] HID: asus: ABBA deadlock between ally_prefs.lock and sysfs removal
- [High] HID: asus: UAF of ally_prefs.button_entries on second device remov=
al
- [Low] HID: asus: mix of cleanup helpers and goto in ally_prefs_setup() an=
d helper
- [Low] HID: asus: malformed kernel-doc comment on ally_set_turbo_params()
- [Low] HID: asus: per-call stack table and manual copy in ally_btn_param()=
 and setter
--

commit d9c271786b208c5b04b58afd3cb388dfc9868ef1
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for turbo buttons

This commit adds support for configuring ROG Ally turbo button parameters
by exposing turbo_period and toggle_period sysfs attributes for each
gamepad button and restoring the settings during device initialization.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 3e58c5ca0cbd8..d20e433af5740 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -812,6 +812,80 @@ struct ally_joystick_resp_curve {

[ ... ]

> +/* Payload order. Not the same order as enum ally_button_id. */
> +struct ally_turbo_config {
> +	struct ally_btn_turbo_params btn_du;
> +	struct ally_btn_turbo_params btn_dd;
> +	struct ally_btn_turbo_params btn_dl;
> +	struct ally_btn_turbo_params btn_dr;
> +	struct ally_btn_turbo_params btn_j0b;
> +	struct ally_btn_turbo_params btn_j1b;
> +	struct ally_btn_turbo_params btn_lb;
> +	struct ally_btn_turbo_params btn_rb;
> +	struct ally_btn_turbo_params btn_a;
> +	struct ally_btn_turbo_params btn_b;
> +	struct ally_btn_turbo_params btn_x;
> +	struct ally_btn_turbo_params btn_y;
> +	struct ally_btn_turbo_params btn_view;
> +	struct ally_btn_turbo_params btn_menu;
> +	struct ally_btn_turbo_params btn_m2;
> +	struct ally_btn_turbo_params btn_m1;
> +};

[ ... ]

> @@ -2120,9 +2197,297 @@ static const struct attribute_group ally_attr_gro=
ups[] =3D {
>  	},
>  };
> =20
> +static struct ally_btn_turbo_params *ally_btn_param(enum ally_button_id =
btn)
> +{
> +	struct ally_btn_turbo_params *table[ALLY_BTN_MAX] =3D {
> +		[ALLY_BTN_A] =3D &ally_prefs.turbo.btn_a,
> +		[ALLY_BTN_B] =3D &ally_prefs.turbo.btn_b,
> +		[ALLY_BTN_X] =3D &ally_prefs.turbo.btn_x,
> +		[ALLY_BTN_Y] =3D &ally_prefs.turbo.btn_y,
> +		[ALLY_BTN_LB] =3D &ally_prefs.turbo.btn_lb,
> +		[ALLY_BTN_RB] =3D &ally_prefs.turbo.btn_rb,
> +		[ALLY_BTN_DU] =3D &ally_prefs.turbo.btn_du,
> +		[ALLY_BTN_DD] =3D &ally_prefs.turbo.btn_dd,
> +		[ALLY_BTN_DL] =3D &ally_prefs.turbo.btn_dl,
> +		[ALLY_BTN_DR] =3D &ally_prefs.turbo.btn_dr,
> +		[ALLY_BTN_J0B] =3D &ally_prefs.turbo.btn_j0b,
> +		[ALLY_BTN_J1B] =3D &ally_prefs.turbo.btn_j1b,
> +		[ALLY_BTN_MENU] =3D &ally_prefs.turbo.btn_menu,
> +		[ALLY_BTN_VIEW] =3D &ally_prefs.turbo.btn_view,
> +		[ALLY_BTN_M1] =3D &ally_prefs.turbo.btn_m1,
> +		[ALLY_BTN_M2] =3D &ally_prefs.turbo.btn_m2,
> +	};
> +
> +	if (btn >=3D ALLY_BTN_MAX)
> +		return NULL;
> +
> +	return table[btn];
> +}
> +
> +/** ally_set_turbo_params() - Set the turbo parameters
> + *
> + * Caller holds ally_prefs.lock.
> + *
> + * @hdev: The HID device to send the packet to.
> + * Return: 0 on success, negative error code on failure.
> + */

[Severity: Low]
This isn't a bug, but in drivers/hid/hid-asus.c above ally_set_turbo_params=
(),
the kernel-doc comment has the function identifier on the opening /** line
and places the locking note before the @hdev parameter description.

Could the opening /** be placed on its own line and the description text
moved after the parameter list so scripts/kernel-doc can parse it cleanly?

> +static int ally_set_turbo_params(struct hid_device *hdev)
> +{
> +	struct ally_turbo_config *turbo =3D &ally_prefs.turbo;
> +	const u8 payload[] =3D {
> +		turbo->btn_du.turbo, turbo->btn_du.toggle,
> +		turbo->btn_dd.turbo, turbo->btn_dd.toggle,
> +		turbo->btn_dl.turbo, turbo->btn_dl.toggle,
> +		turbo->btn_dr.turbo, turbo->btn_dr.toggle,
> +		turbo->btn_j0b.turbo, turbo->btn_j0b.toggle,
> +		turbo->btn_j1b.turbo, turbo->btn_j1b.toggle,
> +		turbo->btn_lb.turbo, turbo->btn_lb.toggle,
> +		turbo->btn_rb.turbo, turbo->btn_rb.toggle,
> +		turbo->btn_a.turbo, turbo->btn_a.toggle,
> +		turbo->btn_b.turbo, turbo->btn_b.toggle,
> +		turbo->btn_x.turbo, turbo->btn_x.toggle,
> +		turbo->btn_y.turbo, turbo->btn_y.toggle,
> +		turbo->btn_view.turbo, turbo->btn_view.toggle,
> +		turbo->btn_menu.turbo, turbo->btn_menu.toggle,
> +		turbo->btn_m2.turbo, turbo->btn_m2.toggle,
> +		turbo->btn_m1.turbo, turbo->btn_m1.toggle,
> +	};

[Severity: Low]
This isn't a bug, but in drivers/hid/hid-asus.c, ally_btn_param() rebuilds
table[ALLY_BTN_MAX] on the stack on every call instead of marking it static
const (like ally_trigger_limits, ally_anti_deadzones, and ally_resp_curves
earlier in the file), and ally_set_turbo_params() manually copies all 32
bytes into payload[] even though struct ally_turbo_config is already laid
out in hardware payload order.

Could table[] in ally_btn_param() be marked static const (or replaced with
an indexed array), and could struct ally_turbo_config be marked __packed and
passed directly to ally_alloc_cmd()?

[ ... ]

> +static ssize_t btn_turbo_period_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct ally_btn_sysfs_entry *entry;
> +	struct ally_btn_turbo_params *params;
> +
> +	entry =3D container_of(attr, struct ally_btn_sysfs_entry, attr_turbo_pe=
riod);
> +
> +	guard(mutex)(&ally_prefs.lock);
> +
> +	if (!ally_prefs.turbo_support)
> +		return -EOPNOTSUPP;
> +
> +	params =3D ally_btn_param(entry->btn);
> +	if (!params)
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "%hhu\n", params->turbo);
> +}
> +
> +static ssize_t btn_turbo_period_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct ally_btn_sysfs_entry *entry;
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct ally_btn_turbo_params *params;
> +	u8 old_value, value;
> +	int ret;
> +
> +	entry =3D container_of(attr, struct ally_btn_sysfs_entry, attr_turbo_pe=
riod);
> +
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret || value > ALLY_TURBO_PERIOD_MAX)
> +		return ret ? ret : -EINVAL;
> +
> +	scoped_guard(mutex, &ally_prefs.lock) {

[ ... ]

> +static struct ally_btn_sysfs_entry *ally_create_button_attributes(struct=
 hid_device *hdev)
> +{
> +	int i, ret;
> +
> +	if (!ally_prefs.turbo_support)
> +		return NULL;
> +
> +	struct ally_btn_sysfs_entry *entries __free(kfree) =3D kzalloc_objs(*en=
tries, ALLY_BTN_MAX);
> +	if (!entries)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i =3D 0; i < ALLY_BTN_MAX; i++) {
> +		entries[i].btn =3D i;
> +
> +		if (!ally_btn_param(i)) {
> +			hid_err(hdev, "Invalid button id %d for turbo attributes\n", i);
> +			ret =3D -EINVAL;
> +			goto ally_btn_err_cleanup;
> +		}
> +
> +		ally_btn_turbo_init_attrs(&entries[i]);
> +		entries[i].group.name =3D ally_button_names[i];
> +		entries[i].group.attrs =3D entries[i].attrs;
> +
> +		ret =3D sysfs_create_group(&hdev->dev.kobj, &entries[i].group);
> +		if (ret < 0) {
> +			hid_err(hdev, "Failed to create sysfs group for %s: %d\n",
> +				ally_button_names[i], ret);
> +			goto ally_btn_err_cleanup;
> +		}
> +	}
> +
> +	return no_free_ptr(entries);
> +
> +ally_btn_err_cleanup:
> +	while (i--)
> +		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
> +
> +	return ERR_PTR(ret);
> +}
> +
> +static void ally_remove_button_attributes(struct hid_device *hdev)
> +{
> +	struct ally_btn_sysfs_entry *entries;
> +	int i;
> +
> +	entries =3D ally_prefs.button_entries;
> +	if (!entries)
> +		return;
> +
> +	for (i =3D 0; i < ALLY_BTN_MAX; i++)
> +		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
> +
> +	kfree(entries);
> +	ally_prefs.button_entries =3D NULL;
> +}
> +
>  static int ally_prefs_setup(struct hid_device *hdev)
>  {
> -	int ret, i;
> +	struct ally_btn_sysfs_entry *entries =3D NULL;
> +	int ret, i, cal_n =3D 0;
> =20
>  	ret =3D ally_detect_capabilities(hdev);
>  	if (ret)
> @@ -2158,27 +2523,38 @@ static int ally_prefs_setup(struct hid_device *hd=
ev)
>  	/* Skip the calibration groups when the capability is missing. */
>  	if (ally_prefs.user_cal_support || ally_prefs.anti_deadzone_support ||
>  	    ally_prefs.resp_curve_support) {
> -		int cal_i;
> -
> -		for (cal_i =3D 0; cal_i < ARRAY_SIZE(ally_cal_attr_groups); cal_i++) {
> +		for (; cal_n < ARRAY_SIZE(ally_cal_attr_groups); cal_n++) {
>  			ret =3D sysfs_create_group(&hdev->dev.kobj,
> -						 ally_cal_attr_groups[cal_i]);
> +						ally_cal_attr_groups[cal_n]);
>  			if (ret) {
>  				hid_err(hdev, "Failed to create Ally sysfs group '%s': %d\n",
> -					ally_cal_attr_groups[cal_i]->name, ret);
> -				while (cal_i--)
> -					sysfs_remove_group(&hdev->dev.kobj,
> -							   ally_cal_attr_groups[cal_i]);
> -				for (i =3D 0; i < ARRAY_SIZE(ally_attr_groups); i++)
> -					sysfs_remove_group(&hdev->dev.kobj,
> -							   &ally_attr_groups[i]);
> -				return ret;
> +					ally_cal_attr_groups[cal_n]->name, ret);
> +				goto err_cal_groups;
>  			}
>  		}
>  	}
> =20
> +	if (ally_prefs.turbo_support) {
> +		entries =3D ally_create_button_attributes(hdev);
> +		if (IS_ERR(entries)) {
> +			ret =3D PTR_ERR(entries);
> +			hid_err(hdev, "Failed to create button attributes: %d\n", ret);
> +			goto err_cal_groups;
> +		}
> +	}
> +
> +	ally_prefs.button_entries =3D entries;
>  	ally_prefs.sysfs_live =3D true;
>  	return 0;
> +
> +err_cal_groups:
> +	while (cal_n--)
> +		sysfs_remove_group(&hdev->dev.kobj, ally_cal_attr_groups[cal_n]);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ally_attr_groups); i++)
> +		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
> +
> +	return ret;
>  }

[Severity: Low]
This isn't a bug, but in drivers/hid/hid-asus.c,
ally_create_button_attributes() mixes __free(kfree) on entries with goto
ally_btn_err_cleanup, and ally_prefs_setup() mixes
guard(mutex)(&ally_prefs.lock) with goto err_cal_groups.

Since include/linux/cleanup.h advises against mixing scope-based cleanup
helpers and goto error labels within the same function, could these
functions use either pure goto-based cleanup or pure scope-based cleanup?

>  static void ally_sysfs_remove(struct hid_device *hdev)
> @@ -2195,6 +2571,8 @@ static void ally_sysfs_remove(struct hid_device *hd=
ev)
> =20
>  	ally_prefs.sysfs_live =3D false;
> =20
> +	ally_remove_button_attributes(hdev);

[Severity: High]
Can this trigger an ABBA deadlock between ally_prefs.lock and kernfs active
node draining?

In drivers/hid/hid-asus.c, when userspace reads or writes any of the turbo
button sysfs attributes (btn_turbo_period_show(), btn_turbo_period_store(),
btn_toggle_period_show(), or btn_toggle_period_store()), kernfs holds an
active reference on the attribute kernfs_node and the callback then acquires
ally_prefs.lock:

  kernfs_fop_read_iter() / kernfs_fop_write_iter()
    kernfs_get_active_of()          /* acquires kn->active */
    btn_turbo_period_show() / btn_turbo_period_store()
      guard(mutex)(&ally_prefs.lock)

Conversely, during device removal in ally_sysfs_remove() (and on the error
unwind paths in ally_prefs_setup() and ally_create_button_attributes()),
ally_prefs.lock is held while calling ally_remove_button_attributes() and
sysfs_remove_group(), which calls kernfs_drain() to wait synchronously for
kn->active to drain:

  ally_sysfs_remove()
    guard(mutex)(&ally_prefs.lock)
    ally_remove_button_attributes()
      sysfs_remove_group()
        kernfs_remove_by_name_ns()
          __kernfs_remove()
            kernfs_drain()          /* waits on kn->active */

If a sysfs read or write is waiting to acquire ally_prefs.lock while
ally_sysfs_remove() or ally_prefs_setup() calls sysfs_remove_group() under
ally_prefs.lock, won't both tasks deadlock waiting on each other?

[Severity: High]
Can removing a second HID_ALLY_INTF_CFG_IN device cause a use-after-free of
ally_prefs.button_entries?

In drivers/hid/hid-asus.c, when the first device (hdev1) probes,
ally_prefs_setup(hdev1) allocates ally_prefs.button_entries via
ally_create_button_attributes(hdev1), registers the attribute groups (which
embed struct device_attribute attr_turbo_period and attr_toggle_period) on
hdev1->dev.kobj, and sets ally_prefs.sysfs_live =3D true.

If a second matching HID_ALLY_INTF_CFG_IN interface (hdev2) is probed,
ally_prefs_setup(hdev2) first calls ally_detect_capabilities(hdev2)
(overwriting ally_prefs.turbo_support and other global capability flags),
and then sees ally_prefs.sysfs_live =3D=3D true and returns 0 without
registering sysfs groups on hdev2->dev.kobj:

  ally_prefs_setup(hdev2)
    ally_detect_capabilities(hdev2)
    ...
    guard(mutex)(&ally_prefs.lock);
    ...
    if (ally_prefs.sysfs_live)
        return 0;

When hdev2 is subsequently unbound, asus_remove(hdev2) calls
ally_sysfs_remove(hdev2) -> ally_remove_button_attributes(hdev2):

  ally_remove_button_attributes(hdev2)
    entries =3D ally_prefs.button_entries;
    for (i =3D 0; i < ALLY_BTN_MAX; i++)
        sysfs_remove_group(&hdev2->dev.kobj, &entries[i].group);
    kfree(entries);
    ally_prefs.button_entries =3D NULL;

Because ally_prefs does not track which hid_device owns the live sysfs
groups, sysfs_remove_group() looks for the groups on hdev2->dev.kobj (leavi=
ng
them registered on hdev1->dev.kobj) and kfree(entries) frees the backing
struct ally_btn_sysfs_entry memory while hdev1's sysfs attributes are still
active. Wouldn't any subsequent sysfs access on hdev1 (or unbinding hdev1)
dereference freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031174130.2082=
40-1-denis.benato@linux.dev?part=3D11
