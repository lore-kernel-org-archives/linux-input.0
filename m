Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D23F3CAA53
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052629; cv=none; b=Yw2/hnQAhMBgejEJDMLIfEfy6PtPS/0+PU/hgkK0rHnUtPI7yIWLvo1efUeSQy3Vo9rlXfyT4jmYX0oowvI+CnT7KcK5osIIqUvwYZQGrGTg86Rfy6ffeaFpOVd+YDOnSLQsNU8EWNJN76Ny2lgsjMXw2g6bBkRNw3bJsFS+DV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052629; c=relaxed/simple;
	bh=HaKfpSXEqyGWvFL3QGomiTfqVC54N2/13cbGLF7MpCI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c8HqziMeXxibg/FcJ8geaX8VQbHOQ9FZCp5aTeDlTAvljrGFjedNWjKhGPRfWU9K+jTeq+2MlUe+dC+lZ4x3+4l13oggNy2kxdiBj23E5zT8ePXQUxGwbP+73yqVj8kJkFKgoo4G+g51h83IBP4jdjeOio2cjD7+oUBitAHBijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIYuFav+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIYuFav+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064C61F000E9;
	Tue, 14 Jul 2026 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784052628;
	bh=1L+fScMGtUn1S8EhTfBNO9FQSY+ShLYxe54LN8Kyj4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iIYuFav+VuJr1W5G8S+hdVNGTgey4Hgo54XUFKidz67Chxi1t0Memv4CZ56erMc4+
	 FiJuk3AQmc/he2Pe9xVz1TrdCfxiNXcfLJYN4S0zOOSAJkESjhSf717M23534bSvyv
	 o5DeRyUDurU+6c7q/vVgiVf2xDdo927viShewzsjVQT2tgPb7Wvxj+XeY40XhPOdgm
	 eo4/YqfPiGuoRaTHfVPHMxQGD1WHeSss5njsnfHWA6E3SMsjQv44didn/9AzNhAgXj
	 P3mKpfZja8zOHXhtza/cYzjKi4jF/cFqNp+8i6uL1/b5+Z76pGN+8PpP6yqRxQnCHm
	 H4un22UnUQjRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: uclogic: fix use-after-free of inrange_timer on
 remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ibrahim Hashimov" <security@auditcode.ai>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260714173946.73773-1-security@auditcode.ai>
References: <20260713121042.2321-1-security@auditcode.ai>
 <20260714173946.73773-1-security@auditcode.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:10:27 +0000
Message-Id: <20260714181028.064C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Multiple HID drivers suffer from race conditions during device rem=
oval due to incorrect or missing timer teardown.
- [High] In `hid-sony.c`, `sony_remove()` fails to synchronously kill the `=
ghl_urb` before freeing it, leading to a Use-After-Free in the URB callback.
--

--- Patch [1]: [PATCH v2] HID: uclogic: fix use-after-free of inrange_timer=
 on remove ---
commit b8f98aaaf048d9d412a83d45b98e8c080f6ef05c
Author: Ibrahim Hashimov <security@auditcode.ai>

HID: uclogic: fix use-after-free of inrange_timer on remove

uclogic_remove() cancels the pen in-range timer and then stops the
device. A report landing between the timer_delete_sync() call and the trans=
port
teardown in hid_hw_stop() re-arms inrange_timer after it was cancelled.

> diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-cor=
e.c
> index b73f09d26688a..0b8a83fa6c5be 100644
> --- a/drivers/hid/hid-uclogic-core.c
> +++ b/drivers/hid/hid-uclogic-core.c
> @@ -548,7 +548,17 @@ static void uclogic_remove(struct hid_device *hdev)
>  {
>  	struct uclogic_drvdata *drvdata =3D hid_get_drvdata(hdev);
> =20
> -	timer_delete_sync(&drvdata->inrange_timer);
> +	/*
> +	 * Shut the in-range timer down before stopping the device.
> +	 * uclogic_raw_event_pen() re-arms inrange_timer on every pen report
> +	 * and keeps running until hid_hw_stop() stops the transport, so a
> +	 * plain timer_delete_sync() here can be undone by a report landing in
> +	 * the window before hid_hw_stop().  timer_shutdown_sync() cancels the
> +	 * timer and makes any later re-arm a no-op, so it is provably dead
> +	 * before hid_hw_stop() frees the input device drvdata->pen_input
> +	 * points at.
> +	 */
> +	timer_shutdown_sync(&drvdata->inrange_timer);
>  	hid_hw_stop(hdev);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this
fix for the teardown race in uclogic, I noticed multiple other HID drivers
suffer from similar pre-existing race conditions during device removal.

For instance, drivers/hid/hid-letsketch.c lacks a .remove callback entirely
in letsketch_driver:

static struct hid_driver letsketch_driver =3D {
	.name =3D "letsketch",
	.id_table =3D letsketch_devices,
	.probe =3D letsketch_probe,
	.raw_event =3D letsketch_raw_event,
};

This means the inrange_timer is never explicitly canceled and can outlive
the driver's devres cleanup.

In drivers/hid/hid-multitouch.c mt_remove() and drivers/hid/hid-prodikeys.c
pk_remove(), the code calls timer_delete_sync() before hid_hw_stop(), leavi=
ng
the exact same window where incoming reports can re-arm the timer.

Additionally, in drivers/hid/hid-appleir.c appleir_remove() calls
hid_hw_stop() before timer_delete_sync(). Because hid_hw_stop() frees the
hid-input device, this can cause a use-after-free if the timer fires in this
window.

Would it make sense to apply this same timer_shutdown_sync() pattern and
add the missing remove callbacks to these other HID drivers as well?

[Severity: High]
This is also a pre-existing issue, but while looking at these removal paths,
I spotted another teardown race in drivers/hid/hid-sony.c during sony_remov=
e().

The cleanup sequence is:

    timer_delete_sync(&sc->ghl_poke_timer);
    usb_free_urb(sc->ghl_urb);

If ghl_poke_timer fires right before it is canceled, it submits ghl_urb.
The usb_free_urb() call only decrements the reference count; it does not
cancel an in-flight transfer.

When the URB later completes, ghl_magic_poke_cb() will dereference the
freed sc pointer to re-arm the timer, leading to a use-after-free.

Should this code be using usb_kill_urb() prior to freeing the URB to
ensure any in-flight transfers are synchronously terminated?

>  	kfree(drvdata->desc_ptr);
>  	uclogic_params_cleanup(&drvdata->params);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714173946.7377=
3-1-security@auditcode.ai?part=3D1
