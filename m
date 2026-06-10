Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0646405C41
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100482; cv=none; b=ugmYr/4wLbMw6TlVXPNCpBWwFpBVmxeISAQ2smPXtOjyEpej+19nlIz/CIqUge3e9fEEBDLxAAfecqPsbDVW61svkO7WPqifIrRlvEdpEKxmynZTVsSiPVLgS3NyFYduVDKYA7oGfNnN9u83vV9LNBvcMQrFmPf9AWgtKw5aa1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100482; c=relaxed/simple;
	bh=Baz9k7CUeK0MrzkK3Wa7cncJmH3Vp5QPoI8HSYjSHkg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NoDaLstqY8PTqLNX92Y9pmKFyBb3iPpo+4x7JY70jVxad4qXyun7cisVPhECqoIXw//tdWM193XEOP25yuWp9Z2ofuVm/2aQGw/+W6SaS09rgTdKPgqX/pBTqBaNk235iBAmYzqsK5+JlvbXiFQlOf4dOceyevecmoyk7f870IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE7ZhA/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE7ZhA/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0771F00893;
	Wed, 10 Jun 2026 14:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781100481;
	bh=ryL6hRupVIWS7g/2zlqf7jOUYe1zFu6DUlx7ficEvQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YE7ZhA/7wHSOLZwKl5p55stT6cVKK2Jih6oP/A80qb0AP8VlCJ0gRoOUhKNUhATNz
	 d1+XUzGWtdS9D/rZNwFsdj/MWRgWwWC1Vhw5qCRKAKWX416F0yTUoeMrsDEB5YCMqK
	 sJi9y7aQ7bGPyu5eX8Rt41yVhp1K9OS3WONDm0HKkwgHh4oxo+KuP4s+yd9MKs5z39
	 Us5oX+HyF655dFsb28xzhnsFxX9Y7wh+JL0cVjk+wmn1ReaRFZMOuK4dcs6e+NUgr6
	 1ToWwSc2+ruMoLSCpVxRs6OtJ8CXpwzvpV6DUaldA4OTgT6l3XdctQ9LEblsMbuD7v
	 knFcVofuMzqZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: ft260: fix SMBus block read protocol handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Raman Varabets" <kernel-linux-20260610-80b7ab08@raman.v1.sg>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260610134119.3313484-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
References: <20260610134119.3313484-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 14:08:00 +0000
Message-Id: <20260610140801.5F0771F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A Time-of-Check to Time-of-Use (TOCTOU) race condition in the =
I2C read timeout handling allows a malicious USB device to execute a Use-Af=
ter-Free write on the kernel stack. This problem wasn't introduced by this =
patch, but it is a critical pre-existing flaw. `ft260_i2c_read` sets `dev->=
read_buf` to point to a stack variable and waits for completion. If the dev=
ice delays the response causing a timeout, the function clears `dev->read_b=
uf` to NULL and returns, popping the stack frame. Concurrently, `ft260_raw_=
event` checks `dev->read_buf !=3D NULL` without locking and then performs a=
 `memcpy`. A properly timed malicious device response can pass the NULL che=
ck before the timeout clears it, resulting in the `memcpy` writing device-c=
ontrolled payload data into freed kernel stack memory, potentially hijackin=
g control flow.
--

commit b044839cc37c642e14b8d9de071b491bae721de9
Author: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>

HID: ft260: fix SMBus block read protocol handling

For I2C_SMBUS_BLOCK_DATA reads, ft260_smbus_xfer() passed
data->block[0] + 1 as the read length. But on a block read the byte
count is supplied by the slave as the first byte of the response;
data->block[0] is not initialized by the caller, so the transfer
length was taken from stale buffer contents, and the count byte the
slave did return was stored without any validation.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 70e2eedb465af..946ed0c6fc39f 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -502,15 +502,23 @@ static int ft260_i2c_read(struct ft260_device *dev,=
 u8 addr, u8 *data,
>  	struct ft260_i2c_read_request_report rep;
>  	struct hid_device *hdev =3D dev->hdev;
>  	u8 bus_busy =3D 0;
> +	/*
> +	 * STOP terminates the last chunk; clear means hold the bus so a
> +	 * follow-up call continues the same I2C transaction.
> +	 */
> +	bool want_stop =3D !!(flag & FT260_FLAG_STOP);

[Severity: Critical]
This is a pre-existing issue, but is there a TOCTOU race condition in the I=
2C
read timeout handling that allows a malicious USB device to execute a
use-after-free write on the kernel stack?

Looking at ft260_i2c_read(), it sets dev->read_buf to point to the provided
data pointer and waits for completion. If the device delays the response
causing a timeout, the function clears dev->read_buf to NULL and returns,
popping the stack frame:

drivers/hid/hid-ft260.c:ft260_i2c_read() {
        ...
		if (!wait_for_completion_timeout(&dev->wait, timeout)) {
			ret =3D -ETIMEDOUT;
			ft260_i2c_reset(hdev);
			goto ft260_i2c_read_exit;
		}
        ...
ft260_i2c_read_exit:
	dev->read_buf =3D NULL;
	return ret;
}

Concurrently, ft260_raw_event() checks dev->read_buf !=3D NULL without taki=
ng
any locks and then performs a memcpy():

drivers/hid/hid-ft260.c:ft260_raw_event() {
        ...
		if ((dev->read_buf =3D=3D NULL) ||
		    (xfer->length > dev->read_len - dev->read_idx)) {
        ...
		}

		memcpy(&dev->read_buf[dev->read_idx], &xfer->data,
		       xfer->length);
        ...
}

Could a properly timed malicious device response pass the NULL check before=
 the
timeout clears it, resulting in the memcpy() writing device-controlled payl=
oad
data into freed kernel stack memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610134119.3313=
484-1-kernel-linux-20260610-80b7ab08@raman.v1.sg?part=3D1
