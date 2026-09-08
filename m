Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774C049CF37
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890252; cv=none; b=Pl47yoQAphbi9g3+5RF8AiEc4cJ+gBNx2t/Cbwdqf2KMBieqCdWWjgVk0Gq23oL3shauC+2uysm7u27q5lN65hdE5zzbtCd2uGQasnAc+YwNqai6GAUdrZcR6A+seKvJUYeYSMz0sg4Qh51rel3jcq55NRStDl92psiVyhTZ/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890252; c=relaxed/simple;
	bh=uRu/yTE7Q28y0T/8Y2mw7r9ZfzDi74vY0/yq72fm/Ek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JoTHviCsi0aWQ9ckfyVJK6FVZcbbMYzLyQ90NdIUiv+Bt41ru/dyqoY+7Zv663wcYqIDbIBrR77rseu8w6/rRn1KekcMYtZZnPxb3BnwdqYyp32NOLY1V7j/6JARrqOdqQWL8jqZmSKH9zIDAosAg8/+9mM+/fmNXCk56yiCpTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOm0iTlu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOm0iTlu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66DA1F00A3E;
	Tue,  8 Sep 2026 17:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890250;
	bh=tRKPbXW0wbJFUgqyX9aa1I9qlFSmm4fCsIdpA8YZ1n0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aOm0iTluzz4DNDlXZR2rdeHzQMColDYHaUpeXfGxXnH9QyRMDwmPl3P8iFnlX9Ds0
	 nNlU7w3EGbSD9EpvQEyC6B1P5+Zj3zYMWcVJemCU+oWOKqWvLDJ2mYBMUKMIilAjBD
	 nt8U7WOrYobCI/wXhV9yIw47nWRdWe3Cg6wNYN2tOTVRgnl53dlOOFNWqbFR6hlp+L
	 vpb5j0jCp3Ka647HA3BAAiuL4354C4sVn0rd+acrb3c89LkRbHqK3zOzDStCj6BEkr
	 i690jVmyFsmLhmREEl+n5IliV1qS8inrnqCsHPeRaKPsFYxnNmsq71kjds440z42qj
	 5NAs8IiP9+tkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/13] HID: asus: add support for ROG Ally handhelds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260908174433.74260-4-denis.benato@linux.dev>
References: <20260908174433.74260-1-denis.benato@linux.dev>
 <20260908174433.74260-4-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 17:57:29 +0000
Message-Id: <20260908175729.D66DA1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Race condition during concurrent interface probing allows duplic=
ate or malicious USB interfaces to bypass the shared state guard, corruptin=
g global static state.
--

commit 3d735f3f44f1f1940a53b7227c0f6a85b111f6f3
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for ROG Ally handhelds

This commit introduces support for Asus ROG Ally handhelds by extending
the hid-asus driver. It manages a shared global state across multiple USB
interfaces (gamepad, keyboard, configuration) and handles specific input
mapping and initialization sequences for these devices.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 2125680c7effc..11dea2aec80b1 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> +static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
> +{
[ ... ]
> +	spin_lock_irqsave(&ally_data_lock, flags);
> +	if (ally_drvdata.udev && ally_drvdata.udev !=3D udev) {
> +		spin_unlock_irqrestore(&ally_data_lock, flags);
> +		hid_err(hdev, "A ROG Ally controller is already connected\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	/*
> +	 * Interfaces of an already connected controller are equally
> +	 * untrusted: a crafted descriptor could present the same
> +	 * endpoint twice, and a second probe of one role would evict
> +	 * the state recorded by the first one, whose input_dev would
> +	 * then never be unregistered.
> +	 */
> +	if ((ep =3D=3D HID_ALLY_INTF_CFG_IN && ally_drvdata.cfg_hdev) ||
> +	    (ep =3D=3D HID_ALLY_X_INTF_IN && ally_drvdata.ally_x_hdev) ||
> +	    (ep =3D=3D HID_ALLY_INTF_KEYBOARD_IN && ally_drvdata.keyboard_hdev)=
) {
> +		spin_unlock_irqrestore(&ally_data_lock, flags);
> +		hid_err(hdev,
> +			"An interface of a ROG Ally controller is already connected\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	if (!ally_drvdata.udev) {
> +		usb_get_dev(udev);
> +		ally_drvdata.udev =3D udev;
> +	}
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> +
> +	/*
> +	 * The interface initialization sleeps (it performs USB transfers),
> +	 * so it must run before taking the spinlock guarding the shared
> +	 * state; pointers are published only once it succeeded.
> +	 */
> +	switch (ep) {
> +	case HID_ALLY_INTF_CFG_IN:
> +		/*
> +		 * This function assumes the asus-specific initialization
> +		 * to have been performed already at this point.
> +		 */
> +		ret =3D ally_gamepad_check_ready(&ally_drvdata, hdev);
> +		if (ret < 0) {
> +			hid_err(hdev, "ROG Ally device is not ready: %d\n", ret);
> +			ally_put_udev_if_orphaned();
> +			return ERR_PTR(ret);
> +		}
> +
> +		ret =3D hid_asus_ally_init(hdev, &ally_drvdata);
> +		if (ret < 0) {
> +			ally_put_udev_if_orphaned();
> +			return ERR_PTR(ret);
> +		}
> +
> +		spin_lock_irqsave(&ally_data_lock, flags);
> +		ally_drvdata.cfg_hdev =3D hdev;
> +		spin_unlock_irqrestore(&ally_data_lock, flags);

[Severity: Medium]
Is there a race condition during concurrent interface probing here?

The ally_data_lock is dropped after validating that the interface hasn't
been probed yet (e.g., ally_drvdata.cfg_hdev is NULL), allowing the thread
to perform sleepable USB I/O.

During this window, a concurrent probe from a duplicate or malicious USB
interface could also acquire ally_data_lock, see that ally_drvdata.cfg_hdev
is still NULL, and proceed with its own sleepable setup.

If multiple threads bypass this check and one fails during initialization,
it might call ally_put_udev_if_orphaned() and drop the udev reference
prematurely because the other thread has not yet set ally_drvdata.cfg_hdev.

If multiple succeed, they could sequentially overwrite the shared pointer,
leaking resources and corrupting the shared global state.

Could we reserve the interface slot or track a probe-in-progress state
under the lock before dropping it to wait on the sleepable setup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908174433.7426=
0-1-denis.benato@linux.dev?part=3D3
