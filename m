Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7783CEBB7
	for <linux-input@vger.kernel.org>; Sat,  8 Aug 2026 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786192352; cv=none; b=WVh31ylvnAHRW2aTKb7Dc/nM0o9Ai49BL4TvY7WSanIA3h9sgH16Am53beBKUK2iIX6JIXThYplYlmV4aUop0iH+Q5mRZvXBDlQF/s987NxkWJM44OxZjENjPFkIb5GJL6Q4kVhyqunZGZX9S5Ui/DY53ShziT/rPmRpL0f1cKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786192352; c=relaxed/simple;
	bh=XTNIPpZqUrPmOmW1+Ak1wlfI+Y9j3fqjhk5uEaknCxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F3k6Qu4VFnybmExmky+/dbIK1+XAbc4xp55SH5nOl53YUJ+9z3NGQnh2FPHE34JLTaRnGKJx+Ik09CaQzsrZU+qu+3wQp3234VEhgt+cNURYUSLC1S4MfpmpcGDJi1W/3bdb1TPUr0Zl8RbALiEdbhdmwD95NVoELWusW5/KN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjcZEqVR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjcZEqVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587011F000E9;
	Sat,  8 Aug 2026 12:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786192344;
	bh=L8GpKRoncdPZnxoYYSCvX4lrOziQPcEH/zrwNU9RNpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XjcZEqVRyr0MlBlVu3eZ8EVQS/oksuUXqXopVw+JBj8YeDFRpurUOnmvoPwI0nFTK
	 77Q/LWrvN3hXIKLoK3zAbwbBe7OD1NX0KRkamjsJCpVF/XIvISZYvKppy4fwE98Pfo
	 Vi3zHEP/EL5RXf7o4Q5Yw1WEYMjib44SLl2231hIB0TEFazFi/IMDAJdDnI0T8nqgZ
	 rHSmuSz6Owtncx/6yuYatoZVpFl2mx+7Ei9RAfk1HV7nXs24hb38Vu5KGrPUXUOnKq
	 DbTOmbsbCPZ4egPbcKgwDL0OytPwewHrds5B4F7ifCr4N2xiJK2YVLFpgonqyuydu0
	 WUrt6hI4D2q5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] HID: flydigi: add support for vader 5 pro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260808122439.69159-2-denis.benato@linux.dev>
References: <20260808122439.69159-1-denis.benato@linux.dev>
 <20260808122439.69159-2-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 12:32:23 +0000
Message-Id: <20260808123224.587011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Probe error path fails to set `fd->removed =3D true`, leading to U=
AF and destroyed mutex usage via devres unregistration and input callbacks.
--

--- Patch [1]: [PATCH v2 1/2] HID: flydigi: add support for vader 5 pro ---
commit 0a66486909a61950a8b4745db38b10508fd08b5c
Author: Denis Benato <denis.benato@linux.dev>

HID: flydigi: add support for vader 5 pro

This commit adds support for the Flydigi Vader 5 Pro gamepad. It introduces
a driver that creates two evdev nodes (gamepad and sensors) sharing the
same uniqid.

> diff --git a/drivers/hid/hid-flydigi.c b/drivers/hid/hid-flydigi.c
> new file mode 100644
> index 0000000000000..ee95ade7d127b
> --- /dev/null
> +++ b/drivers/hid/hid-flydigi.c
[ ... ]
> +static void flydigi_gamepad_close(struct input_dev *dev)
> +{
> +	struct flydigi_device *fd =3D input_get_drvdata(dev);
> +	bool removed;
> +
> +	scoped_guard(spinlock_irqsave, &fd->lock) {
> +		fd->gamepad_open =3D false;
> +		fd->strong =3D 0;
> +		fd->weak =3D 0;
> +	}
> +
> +	cancel_delayed_work_sync(&fd->acquire_work);
> +
> +	scoped_guard(spinlock_irqsave, &fd->lock)
> +		removed =3D fd->removed;
> +
> +	if (!removed)
> +		schedule_work(&fd->rumble_work);
> +}
[ ... ]
> +static int flydigi_probe(struct hid_device *hdev, const struct hid_devic=
e_id *id)
> +{
[ ... ]
> +	ret =3D flydigi_register_gamepad(fd);
> +	if (ret)
> +		goto err_stop;
> +
> +	ret =3D flydigi_register_sensors(fd);
> +	if (ret)
> +		goto err_stop;
> +
> +	ret =3D hid_hw_open(hdev);
> +	if (ret) {
> +		hid_err(hdev, "hw open failed: %d\n", ret);
> +		goto err_stop;
> +	}
[ ... ]
> +err_stop:
> +	hid_hw_stop(hdev);
> +	cancel_delayed_work_sync(&fd->acquire_work);
> +	cancel_work_sync(&fd->rumble_work);
> +	mutex_destroy(&fd->output_mutex);
> +	return ret;

[Severity: High]
Can a probe failure after gamepad registration cause a use-after-free?

If flydigi_probe() fails after flydigi_register_gamepad() completes (for
example, if hid_hw_open() fails), the err_stop path is taken. However,
fd->removed is not set to true.

When probe returns an error, devres will unregister the input device. If
userspace had already opened the device, the unregistration will trigger
flydigi_gamepad_close(). Because fd->removed is still false, it will
schedule fd->rumble_work:

	if (!removed)
		schedule_work(&fd->rumble_work);

After devres frees the fd structure, the workqueue could execute
flydigi_rumble_worker(), resulting in a use-after-free and an attempt to
lock the destroyed output_mutex.

Should fd->removed be set to true in the err_stop path, similar to what is
done in flydigi_remove()?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122439.6915=
9-1-denis.benato@linux.dev?part=3D1
