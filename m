Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3359474271
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953563; cv=none; b=UIsVk9to+BGiM1lLUFlop/7F2hicEFv/IUn9w1h6747lP/cz4TWWErfT06MwzyCKiAqpXZtAVu71cPC2ZmBLSxaan4YaigDIjn9MRJRePA770QLPNVLCTuL0s5cb4+vIJw4KliHE/w7aiTRFvgkz1lHyPYykj+6Go8EQZX6luIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953563; c=relaxed/simple;
	bh=iMTkRE1dgNq2bUnXjqu8h6ghTsWteze0CxO7Ubiam6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mjJ+vDTv967mmqGaImOJPR/fZ94spXIig9cj6GkudCUtKi7UHwrOLF7VRDE/7wR5Puld4hwcCHcHs+4I5nNtGJ5x2MIpsgQIGOQW7MsRhHMEiKrFoGH5n3nXvJgvT0aWjZDvfG+/kxUZYYJxYTQgsnDLZLWc5h1E4WCRFa4hK90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3yfn9w8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3yfn9w8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB321F00A3D;
	Wed,  9 Sep 2026 11:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953561;
	bh=rMb5Yr5l7c5VlcUSRD0eAD2EifljF7j7XhenC58M+mM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V3yfn9w8vJthD1ltgftD3XwWHusJ+G4JJuxd5sM7+y6X//s9EmpvpZxREyCMc6TZH
	 owoFAiCz1BoFKFUHgaiDEzLDJ76o5qAbOSW44eFseB3wxRbnJ2ifIgPu09VEJe5Ubw
	 6oqhO6GZwkkEz33j+Wo2OPd4wmIS1ce/gl9CidjQVNRRGfTlV45QZ0a7oiIRAWvl9S
	 XjYkKOzIa8gecVDN6Gk+I8Xp6UDhaz6rW7rwpuwn3vy02UsbiXyDm+z6nZ6+afBYE7
	 /bSfGyQzA0McE1jOux5ey1I2JvixS6DwIzpUhoq9xVMe1l5WWUCUeDQMms46u5X9IU
	 XtA/UXzhMRINQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/5] HID: wacom: Fix Use-After-Free in
 wacom_intuos_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <c861d21f863c023ac89878c170a00fe8c80405d9.1788868602.git.lee@kernel.org>
References: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
 <c861d21f863c023ac89878c170a00fe8c80405d9.1788868602.git.lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 11:32:41 +0000
Message-Id: <20260909113241.7EB321F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to `shared->pen` and `shared->touch` leaves siblin=
g `hid_device` pointers vulnerable to Use-After-Free during concurrent hot-=
unplug.
- [High] Sysfs callbacks access `wacom->led.groups` without NULL checks, ra=
cing with `wacom_remove()` cleanup.
--

commit f9df2fb1ac73b67929633c2e25c6e475a7abd240
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix Use-After-Free in wacom_intuos_pad

wacom_intuos_pad() accesses wacom->shared->touch_input locklessly
inside the interrupt handler context. If the Touch sibling device
is disconnected, wacom_remove_shared_data() clears 'touch_input'
outside any lock, creating a Time-of-Check to Time-of-Use (TOCTOU)
race condition where a preempted reader in interrupt context
dereferences the freed pointer, leading to a Use-After-Free.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 4eed2c189017d..10f7de515ea28 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -875,10 +875,16 @@ static void wacom_remove_shared_data(void *res)
>  		data =3D container_of(wacom_wac->shared, struct wacom_hdev_data,
>  				    shared);
> =20
> -		if (wacom_wac->shared->touch =3D=3D wacom->hdev)
> -			wacom_wac->shared->touch =3D NULL;
> -		else if (wacom_wac->shared->pen =3D=3D wacom->hdev)
> -			wacom_wac->shared->pen =3D NULL;
> +		scoped_guard(mutex, &wacom_udev_list_lock) {
> +			if (wacom_wac->shared->touch =3D=3D wacom->hdev) {
> +				wacom_wac->shared->touch =3D NULL;
> +				rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
> +			} else if (wacom_wac->shared->pen =3D=3D wacom->hdev) {
> +				wacom_wac->shared->pen =3D NULL;
> +			}
> +		}
> +
> +		synchronize_rcu();
> =20
>  		kref_put(&data->kref, wacom_release_shared_data);
>  		wacom_wac->shared =3D NULL;

[Severity: High]
This is a pre-existing issue, but since this patch introduces RCU protection
for touch_input, is it possible that lockless access to shared->pen and
shared->touch in wacom_mode_change_work() is still vulnerable to a
Use-After-Free during concurrent hot-unplug?

When a sibling interface is unbound, devres automatically frees its driver
data. If a WACOM_HID_WD_MODE_CHANGE event concurrently schedules
wacom_mode_change_work(), it accesses these pointers locklessly:

drivers/hid/wacom_sys.c:wacom_mode_change_work() {
    ...
	if (shared->pen) {
		wacom1 =3D hid_get_drvdata(shared->pen);
		wacom_release_resources(wacom1);
		hid_hw_stop(wacom1->hdev);
    ...
	if (shared->touch) {
		wacom2 =3D hid_get_drvdata(shared->touch);
		wacom_release_resources(wacom2);
		hid_hw_stop(wacom2->hdev);
    ...
}

While Patch 5/5 in this series attempts to fix this by replacing the raw
accesses with rcu_access_pointer(), it appears to omit wrapping the worker
in an RCU read-side critical section and doesn't use rcu_dereference().

Because of this, would the synchronize_rcu() call in the unbind path fail to
wait for this worker, leaving the Use-After-Free vulnerability unresolved
at the end of the series?

[ ... ]

[Severity: High]
This is a pre-existing issue, but could wacom_show_remote_mode() race with
wacom_remove() and cause a NULL pointer dereference?

During unbind, wacom_remove() explicitly nullifies the groups pointer before
devres removes the sysfs attributes:

drivers/hid/wacom_sys.c:wacom_remove() {
    ...
	/* make sure we don't trigger the LEDs */
	wacom_led_groups_release(wacom);

	if (wacom->wacom_wac.features.type !=3D REMOTE)
		wacom_release_resources(wacom);
}

If an unprivileged local user continuously reads the world-readable sysfs
files during a hot-unplug, the sysfs callback dereferences wacom->led.groups
without a NULL check:

drivers/hid/wacom_sys.c:wacom_show_remote_mode() {
    ...
	mode =3D wacom->led.groups[index].select;
	return sprintf(buf, "%d\n", mode < 3 ? mode : -1);
}

Could this crash the kernel if the sysfs read callback executes after
wacom_led_groups_release() clears the pointer, but before devres cleanup
finishes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/fa3cb42f7b58c1b3022=
d8208969a81882783a5ec.1788868602.git.lee@kernel.org?part=3D3
