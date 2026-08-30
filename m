Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21641242D9B
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788134171; cv=none; b=rgn3pYBoELs75+INjqJVY2q15OYdUR9L99f8xask7p/y1Y3POKaZQY9vqJaH2F7V/djlyZ2b5q79ZazZsEsT6TWosClCubM5x83AXf0B1/Rw8oUkwysp6RBE0vg+vou5qgZAlkXzjKRyXDB/q+Or31JKd2MfGAcpD2YjbzI+xjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788134171; c=relaxed/simple;
	bh=3fLsXQD7lEEvcB2aOKdqs4pC5I6dkluuvT9HFLeN6EY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SkRvo3wjQARm0kSsp9h5rHEDNZ5R3jB4XXTp+b2nUNBtjpQYXKBzYC87N4Ru/OGXnby89it5fzgTh4BUuwZ4cBKGMVbB++saKJdi9zImFniD5NdMt9EQiNyuNtcM83MKIIrRO60M2dUMPhrTrw1bCoNcgvKY20oU2eiCTFmcOzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwGowQgV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwGowQgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB091F000E9;
	Sun, 30 Aug 2026 23:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788134169;
	bh=zcZdIYY1PiVFWOoDR7wvIibdyywqTr5sE+nNiiMbA9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bwGowQgVL9Y4wqLvhhudW1n5TTnC6PY7whcnez1TGS1qQUBc+xyxwSZZvYGEt0cdy
	 T5IrrmYpG6jVCuWAK060HU9HOrIh8R60aD7V9jqEuJd/Tbz9lxHq/tQjD5scwMgdVT
	 Vcq94nnYoNMHaYpSCq2ecyYS7xN7TpRIMJJ+1j47kyzKfMtv9kqpB3ceiwCbut5qNL
	 8EAtVUe/5soLSPGbwaHIHAuMMwCBpMNk/mKCkXaZhpqJDjGRR4uCsJryRg13Td83b3
	 iGlUVIKGYUiGmx4BA81egs6XFkEdZ+Ey3qYMGR7EhkFERggKi7aA0mRkdj7bVCLcbQ
	 GGKdWjRoeWQzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/13] HID: asus: add support for ROG Ally handhelds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260830234320.114356-4-denis.benato@linux.dev>
References: <20260830234320.114356-1-denis.benato@linux.dev>
 <20260830234320.114356-4-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 23:56:09 +0000
Message-Id: <20260830235609.8CB091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Devres LIFO ordering violation causing a use-after-free during dev=
ice removal.
--

commit 6c026e410beeb5bf25ebf0d772fc59dc024dc875
Author: Denis Benato <denis.benato@linux.dev>

    HID: asus: add support for ROG Ally handhelds

    Implement the core functionality for ASUS handhelds, extending the func=
tionality
    of hid-asus if the driver is enabled. This initializes the device, impl=
ements=20
    Ally X input mapping, and emits a single proper event for AC button lon=
g press.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> +static void ally_x_input_close(struct input_dev *dev)
> +{
> +	hid_hw_close(input_get_drvdata(dev));
> +}
> +
> +static struct input_dev *ally_x_alloc_input_dev(struct hid_device *hdev)
> +{
> +	struct input_dev *input_dev =3D devm_input_allocate_device(&hdev->dev);
[ ... ]
> +	input_dev->open =3D ally_x_input_open;
> +	input_dev->close =3D ally_x_input_close;
> +
> +	return input_dev;
> +}
[ ... ]
> @@ -1570,6 +2481,9 @@ static void asus_remove(struct hid_device *hdev)
>  	if (drvdata->listener.brightness_set)
>  		asus_hid_unregister_listener(&drvdata->listener);
> =20
> +	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD)
> +		hid_asus_ally_remove(hdev, drvdata->rog_ally);
> +
>  	asus_worker_stop(drvdata->worker);
>  	hid_hw_stop(hdev);
>  }

[Severity: High]
Does this manual call to hid_hw_stop() conflict with the devres-managed inp=
ut=20
device teardown?

Since ally_x_alloc_input_dev() allocates the input device using=20
devm_input_allocate_device(), its unregistration is deferred until after=20
this remove() callback finishes.=20

If userspace has an open file descriptor on the gamepad device when the=20
device is unplugged or unbound, the devres-triggered input_unregister_devic=
e()=20
will call the input device's .close callback, which was set to=20
ally_x_input_close():

ally_x_input_close()
    hid_hw_close(input_get_drvdata(dev));

Because hid_hw_stop() has already been executed here in asus_remove(), the=
=20
transport resources have been destroyed. When ally_x_input_close() drops in=
to=20
the transport driver via hid_hw_close(), it will try to access those freed=
=20
resources, leading to a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830234320.1143=
56-1-denis.benato@linux.dev?part=3D3
