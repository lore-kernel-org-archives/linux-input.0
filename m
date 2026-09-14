Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB9471416
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390424; cv=none; b=VQSKFfV3uNeF+FXMuEXk3O4qO/jzobmtDq2mHSTa7Mb2LSk/j/qfVRIs7+jm7mhA7UU94sCiE1u7hfs0LCBak87QONPwKOY+Gp8yQqtx070JUgft7xcUqNuDsUpi1sYD6bjt0lLsq7mDFdQJQ5KLr7ukOAbUVWgEkgbtsYx+ZnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390424; c=relaxed/simple;
	bh=6Q+jQeBws2llHHpFt/Mq6JlKlRGPIZM1qs/gYsesFjU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U7DZ03+YT290nTwfuCsaigKq63OrG9QS7HP4jiMiyI1xYk+cZizsGtyGWkidCnSA3lSNPc7LPMmzroNTZvJAoCN0EQ2l1wHfi9uH4TnZN2bWkXIExNs9GeRRJ66lCI4TYwnUsdxJdSp7PFDNxMDYhr2IPxjDdOIr4ICqWWNIw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB2xdSj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB2xdSj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE741F00893;
	Mon, 14 Sep 2026 12:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390422;
	bh=KbUlJQ5d+s63fqDv5t2mIMyu3ENkZ1A+nCGyrHFXT5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WB2xdSj2jTOlHpIu7nVYjMEAuF5A0HndrpI4WQZ51utJ8PcLzhuEZobc4LkvOxe0S
	 8EhM5mafGLQwrspHBLJEUsxgoud2SiiEX+sBpGMwWeHYIWXgBGdWio7NzBHPZpMEbO
	 6dE3JgKBV/zRFgmCvJVf84nLNFAxxBHAH72KN/2qnWxcRPV6s8c4zaGoAyVn6WoE3v
	 oUBSFpLepo+DuemdCCE8rXzOvPJkWFPIWx70SRtN69nw7yrGEG/bu6WXx1B/9nCzTq
	 0tKyi1QFWsT++zFhpoKG2ObN7qnTnjhAHqSe6ujEY0Z+7wQut+yWu/M/lDRLgG+liz
	 5vqphAMtu8gyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] HID: roccat: examine readers to check whether
 the device is opened
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260914120240.1625442-3-dmantipov@yandex.ru>
References: <20260914120240.1625442-1-dmantipov@yandex.ru>
 <20260914120240.1625442-3-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:53:42 +0000
Message-Id: <20260914125342.9AE741F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Caching `list_empty()` state outside `devices_lock` in `roccat_rel=
ease()` creates a TOCTOU race with `roccat_open()` and `roccat_disconnect()=
`, leading to device state corruption and leaked hardware open counts.
--

commit 8f711f83c5a599f7dd523be3cd4112f138217007
Author: Dmitry Antipov <dmantipov@yandex.ru>

HID: roccat: examine readers to check whether the device is opened

This patch replaces the explicit open counter in struct roccat_device with
a check against list_empty(&device->readers). The goal is to determine if
active readers exist without maintaining a separate integer count.

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 007778922c21a..d1df4ec34a1e6 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
[ ... ]
> @@ -213,18 +209,20 @@ static int roccat_release(struct inode *inode, stru=
ct file *file)
>  {
>  	struct roccat_reader *reader =3D file->private_data;
>  	struct roccat_device *device =3D reader->device;
> +	bool open;
> =20
>  	if (WARN_ON_ONCE(!device))
>  		return -ENODEV;
> =20
>  	mutex_lock(&device->readers_lock);
>  	list_del(&reader->node);
> +	open =3D !list_empty(&device->readers);
>  	mutex_unlock(&device->readers_lock);

[Severity: High]
Does evaluating the list state here and dropping the lock introduce a race
condition?

If another thread calls roccat_open() before devices_lock is acquired below,
it will observe an empty list, power on the device, and add a new reader.

>  	kfree(reader);
> =20
>  	mutex_lock(&devices_lock);
> =20
> -	if (!--device->open) {
> +	if (!open) {
>  		/* removing last reader */
>  		if (device->exist) {
>  			hid_hw_power(device->hid, PM_HINT_NORMAL);
>  			hid_hw_close(device->hid);
>  		}

[Severity: High]
Since this uses the cached open flag, could it unconditionally power down a=
nd
close the hardware here, cutting off the newly added reader from the
concurrent roccat_open() call?

[ ... ]
> @@ -370,7 +369,11 @@ void roccat_disconnect(int minor)
> =20
>  	devices[minor] =3D NULL;
> =20
> -	if (device->open) {
> +	mutex_lock(&device->readers_lock);
> +	open =3D !list_empty(&device->readers);
> +	mutex_unlock(&device->readers_lock);
> +
> +	if (open) {
>  		hid_hw_close(device->hid);
>  		wake_up_interruptible(&device->wait);
>  	} else {

[Severity: High]
Can a concurrent roccat_disconnect() and roccat_release() race here,
resulting in neither function closing the hardware?

If roccat_release() removes the last reader, it evaluates the local open
variable to false. If roccat_disconnect() then acquires readers_lock, it wi=
ll
also evaluate open to false since the list is already empty, and it will sk=
ip
calling hid_hw_close().

When roccat_release() subsequently acquires devices_lock, it observes that
device->exist is 0 (set earlier by roccat_disconnect()) and also skips call=
ing
hid_hw_close().

Will this result in a permanent leak of the HID hardware open count?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914120240.1625=
442-1-dmantipov@yandex.ru?part=3D3
