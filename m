Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420F3DA5DE
	for <linux-input@vger.kernel.org>; Thu, 16 Jul 2026 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193974; cv=none; b=b0Vo5ej7GycYUw6RE7KwiuCsKiKILZ8jmWXCeXxZtBLpXj8bVPO6XJ4WfHBFexL81kbXkwAddJqac+FK1XXWbAKExlP9Ea1Ryb6SPYmsUNdoNPwCcpSHOv53KV3cPzUUUYNRZRjkKTQDu2PbMo8UytfPphauJyO7O9RJxEXkWmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193974; c=relaxed/simple;
	bh=04JIqszGRbP1MM01k/3wng4psVbwkXHbfUkRGtRDIBA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cMZBtLi46PqHQndohI1OXkVoI8aT/2a26wOAzmj0N4f0rBNzrx2OXvORdxZ7L6rmcCb7YA9QWc3iAO6kJBV/eZsX+UwIFGX/TvoLIkAaepFGoWcjxsp/Zsg0XlkdwNMVK1GUiJWHyS663aeYYLu70Ns24hZ3lRarDSZnR/tE2aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRc/5Oht; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRc/5Oht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A1B1F000E9;
	Thu, 16 Jul 2026 09:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784193970;
	bh=B21xdH5nCkH1MUkuNnjmQ+KYzCBzMi57C07Cyy6N6MA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XRc/5OhtmIlXIb9Uff0ls9B+JVK4wtHUrTdT+hG2rT7Xm4WUL/cGMAn49UuGrbPVt
	 qYhhTGWHP1Qe88Gq3BEe/syRQfIwBK3XCIsFMyaZX32Slee6IypCjx1OECctukJCAh
	 KfaEDZEGxxtmJVZJQymQdbXE0X9Fv5M7unLhbds7S271ppVbvRKUVTUvp0SgbRz8Jj
	 Rm9E6PqlR8DRk7Bt+bKEIg755IK7pEihgOZFP+hun4xJu08BhgrXPx/7BcXiYsb85k
	 Ejcru0Y08EDDxQsz03DHaetpwVMSBpMJZ5412Xz2ccEsMApSzSZP0I8OFK+84M4xlV
	 nRKWyPyGyaGpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] HID: wacom: Fix Use-After-Free in
 wacom_intuos_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260716090726.2711293-2-lee@kernel.org>
References: <20260716090726.2711293-1-lee@kernel.org>
 <20260716090726.2711293-2-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 09:26:10 +0000
Message-Id: <20260716092610.B6A1B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to sibling device pointers in wacom_mode_change_wo=
rk() leads to concurrent double-free and Use-After-Free.
- [High] wacom_remove_shared_data() calls kref_put() outside of the list lo=
ck, creating a race condition that leads to refcount corruption and Use-Aft=
er-Free.
- [High] The patch protects touch_input with RCU but fails to protect share=
d->pen and shared->touch, leaving a Use-After-Free vulnerability in IRQ pat=
hs.
--

--- Patch [2]: [PATCH v6 2/4] HID: wacom: Fix Use-After-Free in wacom_intuo=
s_pad ---
commit db13f6a5a689d086da00c273947930e39aedbb61
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix Use-After-Free in wacom_intuos_pad

This patch attempts to fix a TOCTOU Use-After-Free race condition by
introducing RCU protection for the touch_input pointer in the wacom_shared
struct, wrapping readers in RCU guards, updating writers, and calling
synchronize_rcu().

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 6c2a3ddfe366a..c6b37931d02d1 100644
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

[Severity: High]
This is a pre-existing issue, but does shared->pen (and shared->touch) need
the same RCU protection that is being added here for touch_input?

For instance, in wacom_bamboo_pad_pen_event(), shared->pen is accessed
locklessly in an interrupt handler:

drivers/hid/wacom_wac.c:wacom_bamboo_pad_pen_event() {
    ...
    hid_input_report(wacom->shared->pen, HID_INPUT_REPORT, data,
                     WACOM_PKGLEN_PENABLED, 1);
    ...
}

If the Pen sibling device is disconnected concurrently,
wacom_remove_shared_data() clears shared->pen here. Could a preempted or
concurrent IRQ read the non-NULL shared->pen pointer before it is cleared,
and pass the dangling pointer to hid_input_report() once the Pen device is
unbound and freed?

Additionally, in wacom_mode_change_work(), there is lockless access to
these sibling device pointers:

drivers/hid/wacom_sys.c:wacom_mode_change_work() {
    ...
    wacom1 =3D hid_get_drvdata(shared->pen);
    wacom_release_resources(wacom1);
    hid_hw_stop(wacom1->hdev);
    ...
}

Could the asynchronous worker on a Touch device read shared->pen concurrent=
ly
with the Pen device being unbound, leading to a concurrent double-free or
Use-After-Free of the device memory?

> +
> +		synchronize_rcu();
> =20
>  		kref_put(&data->kref, wacom_release_shared_data);

[Severity: High]
This isn't a bug introduced by this patch, but since kref_put() is called
here outside of the wacom_udev_list_lock, can this create a race condition
that leads to refcount corruption?

If the refcount drops to 0, it calls the release function which waits for
the lock to remove the object from wacom_udev_list. Concurrently, couldn't a
probe on another device acquire the lock and iterate the list:

drivers/hid/wacom_sys.c:wacom_get_hdev_data() {
    ...
    kref_get(&data->kref);
    return data;
    ...
}

Could this result in incrementing a 0-refcount object, causing a
Use-After-Free when the original thread proceeds to unlink and free the
structure?

>  		wacom_wac->shared =3D NULL;
>  	}
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716090726.2711=
293-1-lee@kernel.org?part=3D2
