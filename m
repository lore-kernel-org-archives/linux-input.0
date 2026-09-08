Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B20599A42
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890470; cv=none; b=r5ltB0Md/8GIJqDeblCl1ZvcBMnOK4pdPdFKTzX3xWzwmflONhyC0GMV/rOfoaMfv9V+b6O+oEqB04upfpBi6e3Oatvf/8NBHFZhecXtAD6hQvYorb/W3ZvC/oJPkEoEumi730sgz6JcMVgZroZUq/QNkYyFzG1OjG2JlBiUank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890470; c=relaxed/simple;
	bh=O6QCl+1iZBlOpCXLGLNrYnKWYQJXHA8P+Twc2KLkFnU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HcWMhoBbniA05R/8wTyCY+1z56IGn3Z4IMR8znXA43yDB4O+4JHXriXmoDw63rx2zDbryRZfnpdNg5XxYyCdqPMxrnYmwkPROWrPneTagiVQkWZ75jyF2ChZPTZFEHtgh0SBCUu7uqIj6fyPjwV+zXR8PdF/GoTqf98n4D1HXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knG8VYAU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knG8VYAU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FCE1F00A3F;
	Tue,  8 Sep 2026 18:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890468;
	bh=nX5esfx4fQMp2lNf/aoLIP0egd9KxKe1YZejX0Ngstw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=knG8VYAUwfewfQrqAvHxPf350kW5RGiS+Vmpi9npZ1KAPFeBkf/i91wL7EA9PaPbH
	 wu4GoQSY39OhR+lnRVIb7hMgFg8il0JPWuvXpfPe7mB7S7CBfA9MOxaZWDVVMRoKAv
	 oh1WZ/sgavNpzf5vNSp7x3uP2WmyZtvV0StyoMU84VKizKy9caVSZ5f52JZh7DK0ca
	 sgJHx6nzrNpcRbBX4L2Ulzx8EDrdbUt2y269do1T7fyrVZjstUREQ3ybs6AKZZCCtO
	 9bKq5dzdgzZOOUpa/UIrTOI3XhSLStetobCYh35rVVPwLWUnNv/DSq0DjFfZH2BkCq
	 CqVruHYRoeM2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/13] HID: asus: add gamepad configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260908174433.74260-5-denis.benato@linux.dev>
References: <20260908174433.74260-1-denis.benato@linux.dev>
 <20260908174433.74260-5-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 18:01:07 +0000
Message-Id: <20260908180108.17FCE1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Time-of-check to time-of-use race condition in probe allows spoofe=
d USB devices to bypass singleton checks, leading to memory corruption and =
UAF.
- [Medium] Sysfs attribute becomes visible before device initialization is =
complete, causing transient -ENODEV errors.
--

commit 40a018a18704e85c526230c53db4138c9ec858c7
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add gamepad configuration

Add the base configuration structures for the gamepad configuration,
detect capabilities and initialize the device in a known state.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 11dea2aec80b1..ac0c0a176857e 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -617,6 +660,274 @@ static u8 *ally_alloc_cmd(u8 cmd, const u8 *payload=
, u8 payload_size)
>  	return hidbuf;
>  }

[ ... ]

> +static ssize_t xbox_controller_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *ally =3D drvdata->rog_ally;
> +	struct ally_config *cfg;
> +
> +	if (!ally)
> +		return -ENODEV;

[Severity: Medium]
Will userspace configuration scripts encounter transient errors when trying
to read or configure the controller immediately upon detection?

In ally_config_create(), sysfs_create_group() is called, which immediately
exposes attributes like xbox_controller to userspace.

If a read or write occurs immediately, xbox_controller_show() retrieves
drvdata->rog_ally. However, this pointer is only assigned later in
asus_probe() after hid_asus_ally_probe() returns. During this window,
this callback will return -ENODEV.

While this race is handled later in the series for button mapping attributes
by explicitly carrying the ally pointer in a custom attribute structure,
do these base attributes need similar protection?

> +
> +	cfg =3D ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;

[ ... ]

> @@ -1025,6 +1356,14 @@ static struct ally_handheld *hid_asus_ally_probe(s=
truct hid_device *hdev)
>  			return ERR_PTR(ret);
>  		}
> =20
> +		ally_cfg =3D ally_config_create(hdev, &ally_drvdata);

[Severity: High]
Can this code allow a time-of-check to time-of-use race if multiple USB
interfaces are probed concurrently?

The singleton check earlier in hid_asus_ally_probe() checks
ally_drvdata.cfg_hdev under ally_data_lock, but the lock is released
before reaching this point.

If two threads probe concurrently, both will pass the initial check. They
would then both execute ally_config_create() concurrently without a lock,
leading to a memory leak of the static ally_config pointer and a double
initialization of its mutex.

Finally, if both threads re-acquire the lock and overwrite
ally_drvdata.cfg_hdev, the device that loses the race would have its sysfs
groups permanently leaked. If the driver is later unloaded, ally_config is
freed, but the leaked sysfs attributes would remain, leading to a
use-after-free on subsequent accesses.

> +		if (IS_ERR(ally_cfg)) {
> +			hid_err(hdev, "Failed to create Ally cfg: %ld\n",
> +				PTR_ERR(ally_cfg));
> +			ally_put_udev_if_orphaned();
> +			return ERR_PTR(PTR_ERR(ally_cfg));
> +		}
> +
>  		ret =3D hid_asus_ally_init(hdev, &ally_drvdata);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908174433.7426=
0-1-denis.benato@linux.dev?part=3D4
