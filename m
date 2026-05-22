Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047E9347C7
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417232; cv=none; b=NMZv+5wL4XXasj6VBdkBJ0Dz4KwKCZrYRcHPjGH/fX5O9oSA3mqRIwSahdsrQpDigBeES+EoJgTtWDfd6Bbk1UXz9PmJ1IIYg1fkTpBKfqq8tOpXUa6XvMtB6fLEmt7xhelDzCT3+oqQ1D4j3U6rs1LuCE05SchzCmYMnsSC8OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417232; c=relaxed/simple;
	bh=Zp8qifCpRrW+6L40WP680Up1vkcfMoyLZjeNIqv7UBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d0lH4f6jV97DIjfmYku5v7hKh9TcFzY8eOnjyfYLIJ2lAOInLqLkTZdDw2PkV5lYs0U9ZmzdBeWlGZiFyP4GRYa1zFgthWrTwv2Kg5tnwL00lbmCUkrJRYxpv+zHIXDKCxwSi2pdAU23K9Uv7ad3XGOy6FiDN/Zya5Dm0U/+rGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhlA9qhf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhlA9qhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99491F000E9;
	Fri, 22 May 2026 02:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417230;
	bh=XKc7wYqcO9KxCq8Iaj2BK7NRnwPOjcI/pqAAm2M6+Ho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UhlA9qhfrEWEB/qxSSXB3QGXqwRcRIeq/px2xdlDNw5Pni5xh5e0BeD+WFn+WB0lR
	 7E9GkdvidqnBBsQnQlIIRlLzNVDPMMhitm3w9Pu6mzpIYLvxTNF5qfaEl/G3O0YF21
	 EG0ffpbLHmot8x3lcqEVxVjBDg2K1ScTg1OMOJ4KbeS9wD7N8luNrIn/FiWDkwrciw
	 JqSkCxVmsKYafldVzKXM++e54uqLCX0xsKgGbrXlFKBOEBw6YLsQ++mNETsv3txt+n
	 eXv5B1n1GQcWKR88D7nbkFwBudCd16iqxC5pPQEFj2TZxhy+aYgK4wLeEYUGIlc3jP
	 35nDJkuDcCkdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/4] HID: hid-msi: Add MSI Claw configuration driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260522015518.1111290-2-derekjohn.clark@gmail.com>
References: <20260522015518.1111290-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 02:33:50 +0000
Message-Id: <20260522023350.B99491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Sysfs attributes remain active during and after device removal, le=
ading to a Time-of-Check to Time-of-Use (TOCTOU) race condition and Use-Aft=
er-Free of HID transport structures.
- [High] Calling the sleeping function `hid_hw_close()` while holding a spi=
nlock in `claw_remove()`, causing a kernel panic.
- [Low] Mixing `goto` error handling with scope-based cleanups (`__free()` =
and `guard()`) in the same function.
--

commit 76e865e5c59094dfdc13a67a7954da1cc82124bc
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add MSI Claw configuration driver

This commit adds a new HID configuration driver for the MSI Claw handheld P=
C.
It introduces the initial driver structure, including sysfs attributes to
control the gamepad mode, M-key behavior, and device reset commands.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> new file mode 100644
> index 0000000000000..40b16253abbb3
> --- /dev/null
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> +static int claw_hw_output_report(struct hid_device *hdev, u8 index, u8 *=
data,
> +				 size_t len, unsigned int timeout)
> +{
> +	unsigned char *dmabuf __free(kfree) =3D NULL;
> +	u8 header[] =3D { CLAW_OUTPUT_REPORT_ID, 0, 0, 0x3c, index };
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	size_t header_size =3D ARRAY_SIZE(header);
> +	int ret;
> +
> +	if (header_size + len > CLAW_PACKET_SIZE)
> +		return -EINVAL;
> +
> +	/* We can't use a devm_alloc reusable buffer without side effects durin=
g suspend */
> +	dmabuf =3D kzalloc(CLAW_PACKET_SIZE, GFP_KERNEL);
> +	if (!dmabuf)
> +		return -ENOMEM;
> +
> +	memcpy(dmabuf, header, header_size);
> +	if (data && len)
> +		memcpy(dmabuf + header_size, data, len);
> +
> +	guard(mutex)(&drvdata->cfg_mutex);
> +	if (timeout) {
> +		reinit_completion(&drvdata->send_cmd_complete);
> +		scoped_guard(spinlock_irqsave, &drvdata->cmd_lock) {
> +			drvdata->waiting_cmd =3D index;
> +			drvdata->waiting_for_ack =3D true;
> +			drvdata->cmd_status =3D -ETIMEDOUT;
> +		}
> +	}
> +
> +	dev_dbg(&hdev->dev, "Send data as raw output report: [%*ph]\n",
> +		CLAW_PACKET_SIZE, dmabuf);
> +
> +	ret =3D hid_hw_output_report(hdev, dmabuf, CLAW_PACKET_SIZE);
> +	if (ret < 0)
> +		goto err_clear_state;

[Severity: Low]
Is it okay to mix goto error labels with scope-based cleanups in the same
function?

According to the cleanup subsystem guidelines, functions should either fully
rely on scope-based cleanups or use manual cleanups entirely to avoid
confusing ownership semantics.

> +
> +	ret =3D ret =3D=3D CLAW_PACKET_SIZE ? 0 : -EIO;
> +	if (ret)
> +		goto err_clear_state;
> +
> +	if (timeout) {
> +		ret =3D wait_for_completion_interruptible_timeout(&drvdata->send_cmd_c=
omplete,
> +								msecs_to_jiffies(timeout));
> +
> +		dev_dbg(&hdev->dev, "Remaining timeout: %u\n", ret);
> +		ret =3D ret > 0 ? drvdata->cmd_status : ret ?: -EBUSY;
> +	}
> +
> +err_clear_state:
> +	if (timeout) {
> +		guard(spinlock_irqsave)(&drvdata->cmd_lock);
> +		drvdata->waiting_cmd =3D CLAW_COMMAND_TYPE_NONE;
> +		drvdata->waiting_for_ack =3D false;
> +	}
> +
> +	return ret;
> +}

[ ... ]

> +static ssize_t gamepad_mode_store(struct device *dev, struct device_attr=
ibute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	int i, ret =3D -EINVAL;
> +	u8 data[2];
> +
> +	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
> +		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context=
 */
> +		if (!smp_load_acquire(&drvdata->gamepad_registered))
> +			return -ENODEV;
> +	}

[Severity: High]
Can this lead to a use-after-free during device disconnect?

If a sysfs thread calls gamepad_mode_store() and gets preempted right after
releasing registration_lock here, a concurrent device disconnect could
trigger msi_remove() which clears gamepad_registered.

msi_remove() will then call hid_hw_stop(), destroying the HID transport
structures. When the sysfs thread resumes and continues execution here:

> +
> +	for (i =3D 0; i < ARRAY_SIZE(claw_gamepad_mode_text); i++) {
> +		if (claw_gamepad_mode_text[i] && sysfs_streq(buf, claw_gamepad_mode_te=
xt[i])) {
> +			ret =3D i;
> +			break;
> +		}
> +	}
> +	if (ret < 0)
> +		return ret;
> +
> +	data[0] =3D ret;
> +	scoped_guard(spinlock_irqsave, &drvdata->mode_lock)
> +		data[1] =3D drvdata->mkeys_function;
> +
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SWITCH_MODE, data=
, ARRAY_SIZE(data), 0);

It will call claw_hw_output_report() which delegates to hid_hw_output_repor=
t()
and accesses the now-destroyed transport structures.

Since devm_device_add_group() is used to register the sysfs attributes, the
sysfs group remains active until after msi_remove() finishes completely.
Should the sysfs group be removed synchronously before hid_hw_stop() is
called to prevent this race?

> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}

[ ... ]

> +static void claw_remove(struct hid_device *hdev)
> +{
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +
> +	if (!drvdata)
> +		return;
> +
> +	cancel_delayed_work_sync(&drvdata->cfg_resume);
> +	cancel_delayed_work_sync(&drvdata->cfg_setup);
> +
> +	guard(spinlock_irqsave)(&drvdata->registration_lock);
> +	/* Pairs with smp_load_acquire in attribute show/store functions */
> +	smp_store_release(&drvdata->gamepad_registered, false);
> +
> +	hid_hw_close(hdev);

[Severity: High]
Does this call a sleeping function while holding a spinlock?

The guard() macro acquires registration_lock and holds it until the end of
the function. While this spinlock is held and interrupts are disabled,
hid_hw_close() is called, which attempts to acquire the sleeping mutex
ll_open_lock.

I noticed this is fixed in a later patch in the series by changing guard()
to scoped_guard(), but doesn't this break bisectability by introducing a
kernel panic in this commit?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522015518.1111=
290-1-derekjohn.clark@gmail.com?part=3D1
