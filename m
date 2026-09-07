Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E9F3FD137
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788807615; cv=none; b=ITVJxDgdx0ZaIrj/rJjdO0s4aa7qIQptazbD3endmXsXt8zCaBBZPhPLtOWBQpYnNLCSAGeKm13ncg9PaAYeJtt2yvILzKmmRSilFb6ntiY1081N5ecJdfU1wawVJZmGsa4LVZx5HsXVj58XYhFO0VoK6qFWrhVSd9oTWna/Mf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788807615; c=relaxed/simple;
	bh=6VxZ07Hm3PxJWJxBMOTIrlmHwHlF7HjQL0wHHZMR+UE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A8d2ACsa1T4JXvwt6HUGdal4AkkVgYxT5LEK1k9vuolfdgNs6jKoAq9WtKs/qUw0XEt4XHOs6EH1kYu2y4jirj2UX6R5xyAbNsVTEUbjlBRoCzDe2NXNMb70Cz8xqI/QFF28kCCstyu1SPI7JhsiOXSBqoCPA8azGQZZS4YI6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyQgmKJk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyQgmKJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D191F00A3D;
	Mon,  7 Sep 2026 19:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788807614;
	bh=/JHElxgwSKVjrwhIrQhfoCKFm98ypSXpJNtNjemcMYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HyQgmKJk7+qCxx1wJ4LNL5bSZEn5PnWYCFv3KWUop3ZhxIE7mWI0tCHMjOF10aHsk
	 Hpl6iYxqXbXsChtwNZhgoeYLBccHLwp0nFYc1N4o/S0T5wquFwAzq3+XsrUw8Sm0MT
	 Crr50PwUxbqIdIT+7ySzg4e52jdaZbOiSqjuscGFeBnh7rN4VFxhlIUII38Rnko+GA
	 YBS1Kl6Yiir7t5bNEwq5m6455ohbYpXUtf0YC2zTzfXtI/2emmZhKq8XFT1PhgQJfv
	 wieaRVTYG1qkI2Nx5aEZoti7u600SPYOqJG+ZQmB0f8V8XMD1b7jhdaGzHZmifsHTw
	 nqEVhimC8t6Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y] Input: aiptek - validate raw macro indices
 before updating state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Miguel Garcia" <miguelgarciaroman8@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260907184956.1567815-1-miguelgarciaroman8@gmail.com>
References: <20260907184956.1567815-1-miguelgarciaroman8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 19:00:13 +0000
Message-Id: <20260907190013.D2D191F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A race condition between sysfs attribute accesses and `aiptek_disc=
onnect()` can lead to a NULL pointer dereference, causing an unprivileged l=
ocal Denial of Service.
--

commit a32cea658c5c9deb2bbaf0f172438e8f70443904
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

Input: aiptek - validate raw macro indices before updating state
   =20
aiptek_irq() derives macro key indices directly from tablet reports and
then uses them to index macroKeyEvents[]. Report types 4 and 5 also save
the derived value in aiptek->lastMacro and later use that state to
release the previous key.

Validate the raw macro index once before it enters that state machine, so
lastMacro only ever stores an in-range macro key. Keep direct bounds
checks for report type 6, which reads the macro number from the packet
body and uses it immediately.

Link: https://patch.msgid.link/20260329001711.88076-1-pengpeng@iscas.ac.cn

> diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
> index 1581f6ef09279..64113810e16dc 100644
> --- a/drivers/input/tablet/aiptek.c
> +++ b/drivers/input/tablet/aiptek.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the driver I
noticed a pre-existing issue in the sysfs removal path during disconnect:

drivers/input/tablet/aiptek.c:aiptek_disconnect() {
	...
	usb_set_intfdata(intf, NULL);
	if (aiptek !=3D NULL) {
		/* Free & unhook everything from the system.
		 */
		usb_kill_urb(aiptek->urb);
		input_unregister_device(aiptek->inputdev);
		sysfs_remove_group(&intf->dev.kobj, &aiptek_attribute_group);
	...
}

Does clearing the driver data with usb_set_intfdata() before removing the
sysfs group create a race window?

If a concurrent read accesses the sysfs file during this window:

drivers/input/tablet/aiptek.c:show_tabletSize() {
	struct aiptek *aiptek =3D dev_get_drvdata(dev);

	return sysfs_emit(buf, "%dx%d\n",
			  input_abs_get_max(aiptek->inputdev, ABS_X) + 1,
			  input_abs_get_max(aiptek->inputdev, ABS_Y) + 1);
}

Could dev_get_drvdata() return NULL here and cause a kernel panic when
aiptek is dereferenced?

Similarly, if a sysfs write occurs in the same window:

drivers/input/tablet/aiptek.c:store_tabletExecute() {
	struct aiptek *aiptek =3D dev_get_drvdata(dev);

	/* We do not care what you write to this file. Merely the action
	 * of writing to this file triggers a tablet reprogramming.
	 */
	memcpy(&aiptek->curSetting, &aiptek->newSetting,
	       sizeof(struct aiptek_settings));
	...
}

Can a concurrent sysfs write also fetch a NULL pointer and use it as the
destination for the memcpy()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907184956.1567=
815-1-miguelgarciaroman8@gmail.com?part=3D1
