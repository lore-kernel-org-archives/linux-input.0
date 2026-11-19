Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116828;
	b=cLSAa7NOyNTAepq9em/pQ3CKAY/H6XjwCl8d4NIS/WzWqnKzQ1RxAjvmakwaaAhlNOGS
	 W+fNW/7Y/f1S5V52uwv1lqFbFPyv+onmn0sKlHqspUb8c5ZEvo8WhcjTgNxVRHBKlE7W6
	 ZfFprlpHFp1uY0phVa7rU+0GXgmlee9R/iHfF/biV86Cq8Sf1O6hXJOVr5n4pjoE4qm+T
	 m2e0V6xhCg4PsMF6o9H98F6DN55HEfkzly3K53rM6EizWnSQYJ0mVY1JPMs2mfkiS5B/7
	 RJeHtMM6zZFnvTy0vEEnL9hpiRy7hZ5MCiP/miAlLJzV8jC6HzZRKPZ1ZOHi3HVaUAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116828;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SMuo016MqWDtxdIP7ecIuybjrcAfl8rNzwBJXUnH9g8=;
	b=2kHu5gDgN4CME/3yj2uMzlL5R7KYHtoGiTliKPNbnczKwZBhvU28Zf6TsWMibZFfOT6W
	 QDxcFpFQ5QZydRGeJKSATbjbEtVSBqlIG+us+vQG6+vnpFAhLZTb42QJHw6zjVCGnuOWj
	 cdJ6DbANETz0oj0ceQgRTtaD1ybwq99iH0IK1qDtdPnm2cc1MTW2Ko3wU6SuSuCj0gsWt
	 egt6ZdjfEOcUbTDetX+4wp+xgWW/VIn1s7pD8w2Sx/sQz3xbjfA0rHjTmsEMTIQpG2W76
	 q4bIkT/5LT1zPyWvc+REbyZl2dsaLCoYlvdp+dyLmuwEhZy++B/dXjprmd3iIorI6XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aby5i6Sd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC3606A320
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aby5i6Sd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6711A1F000C4;
	Thu, 19 Nov 2026 19:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116827;
	bh=SMuo016MqWDtxdIP7ecIuybjrcAfl8rNzwBJXUnH9g8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aby5i6SdiDZcen+HeArd93jLEJHwJP+oZpijdeLnmx0pr5EJ1eiWM0smHqaIRj4ja
	 H7Xhr7ndMEf67Zt+sjDpYJSN2qjEFUJFH3E86PZhiAK/joAuq46kNoryM4TvZ+w+Dv
	 Sl9Kr4ciXy0SLZf3e/voi/L/OnfEUfB8YFHaidiZEbPT02PebR1gqufmy0Y/opdyx7
	 wK7TEePWkchKxgS+Fwehkzf2J5+Q/87t6CAR7kbEmZ6woYlQbz1z46B4DKwsJTNW6P
	 pnZauVlsKHRJT+k5p6CRumD02wc/J3OzyrF8KLzUGdNJVJuYt9VxqpjlA/EN0waxuM
	 iDFfKKOoMytYg==
Message-ID: <sashiko-outbox-223935@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: hid-sensor-hub: avoid lock inversion in
 sensor_hub_remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ayaan Mirza Baig" <ayaanmirzabaig85@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261119192046.1015750-1-ayaanmirzabaig85@gmail.com>
References: <20261119192046.1015750-1-ayaanmirzabaig85@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:33:46 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] HID: hid-sensor-hub: NULL dereference in
  sensor_hub_finalize_pending_fn()
--

commit 1ba2998091dc7a9d09c7bc99c333bc23a67a24d5
Author: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>

HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()

This commit moves the acquisition of &data->lock from sensor_hub_remove()
into sensor_hub_finalize_pending_fn() to avoid holding the spinlock across
device_for_each_child().

> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 028e70ec7bace..4ade5b5ece565 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -836,9 +836,13 @@ static int sensor_hub_probe(struct hid_device *hdev,
>  static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
>  {
>  	struct hid_sensor_hub_device *hsdev =3D dev->platform_data;
> +	struct sensor_hub_data *sd =3D data;
> +	unsigned long flags;
> =20
> +	spin_lock_irqsave(&sd->lock, flags);
>  	if (hsdev->pending.status)
>  		complete(&hsdev->pending.ready);
> +	spin_unlock_irqrestore(&sd->lock, flags);
> =20
>  	return 0;
>  }
> @@ -846,16 +850,13 @@ static int sensor_hub_finalize_pending_fn(struct de=
vice *dev, void *data)
>  static void sensor_hub_remove(struct hid_device *hdev)
>  {
>  	struct sensor_hub_data *data =3D hid_get_drvdata(hdev);
> -	unsigned long flags;
> =20
>  	hid_dbg(hdev, " hardware removed\n");
>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);
> =20
> -	spin_lock_irqsave(&data->lock, flags);
>  	device_for_each_child(&hdev->dev, NULL,
>  			      sensor_hub_finalize_pending_fn);
> -	spin_unlock_irqrestore(&data->lock, flags);

[Severity: High]
Does sensor_hub_remove() need to pass data instead of NULL to
device_for_each_child()?  Passing NULL causes a NULL pointer dereference
on &sd->lock in sensor_hub_finalize_pending_fn() when removing a sensor
hub with any child device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119192046.1015=
750-1-ayaanmirzabaig85@gmail.com?part=3D1
