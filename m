Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286189;
	b=xs8GgbFV4YAa7odH7TDn0pOxs0hhGIkp8bzEsleFWtVAPFaKgYnntNmZiVp9YDPbXhOP
	 StPLdNk6InCT1Y55UlFEnHbv/9D2Qzj/DoIlUF0ElraUJHTwQ4sL2FOZLPR7tdp8CK84D
	 SUrvPsEzelfN4+z+WKJoq0TNlEzRXxD6xz6/4ZLju32W48HCItsG+lcsmwdPcijIXPxmI
	 FcK5QwduEi6LaQAaTg4uz0CpLF8I209GBZdFFaKqI+v0mwe8rvtCPTDmLb9zEI9ReLRWl
	 +XC2MjMx/qHhFEjN7p8HYzOCGY4kNGKUicGpqlNSOYN+x0SKl1h0VUr799RNPgVQlyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286189;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+a8xJqaZ2FrloWoI5/p9kiGgRLtDGADq3jrqIbjmYO8=;
	b=NzNu9c42RzGK6x0i3/Qct9/l9i+H7RqnBXgLW32SAUbMtOQMBFwOGw28KdFyh89cCgFn
	 9P8jeY2TaKfT6QX8jJvq9jfJUGjZd3n3hSOutxAKrO6Vyoa4jKrb6kBsVgu2CiZcvpdgs
	 MRBaaiO6yim8Ei7aYEfY3csBcIzyaRch/xmrkBeP17SEk74jGxfrXhO3XBX2exQYJEVoQ
	 xzVuWbrqESL14fkzWZ1pF2Xg/JL7OPiChcDfX+76LGV/84B6wLAtW7hYSuAYUOv9nhVGn
	 bTYyQ1xlW2iCI8QBjTBQZIqT/lToV1EzJBJ5xNVUgcd6sb2Oo2pKae9ClyNRakYdOzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMXJvyOI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9AA606A321
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 04:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMXJvyOI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DB61F0089F;
	Tue, 10 Nov 2026 04:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286188;
	bh=+a8xJqaZ2FrloWoI5/p9kiGgRLtDGADq3jrqIbjmYO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VMXJvyOIusvRDPCVtM0BkYv5QQx2AGzF+tAzfq7GRtnoHlwNQ4q3w6aaajan6S80p
	 GKvJxnfOyM3RUN+j/QHOD+KwkGfr04/Yu+PftkFDrZf8AgDq924RLvMzlLKbw13Tah
	 fjdyHb6hUStaYF6g2wEB75Dd8fcOO7UXvz/TDE2H+BzLmZQ7C1fktxiUWO9uU1tID3
	 aclCEKS3oFPxiYt1hewkCXH3YGMErjOWJ/n/zMdb7bU+hB6ZbukIEMWp7pgsbog3BI
	 XgY1QwW8Kn8zcRnzhbMf619c/lcniWDl15xurRZQBhm9/4mA4/d6/hfJWhTlKovw3S
	 9JRr3xoqQWpnQ==
Message-ID: <sashiko-outbox-206244@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: magicmouse: disable the multitouch work on removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261110043001.56615-1-mhun512@gmail.com>
References: <20261110043001.56615-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:49:47 +0000
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
- [Medium] HID: magicmouse: UAF on msc in magicmouse_reset_resume()
  during unbind
--

commit 6b44c69f3cb297be7e3753fa8262ad83f2724078
Author: Myeonghun Pak <mhun512@gmail.com>

HID: magicmouse: disable the multitouch work on removal

This commit replaces cancel_delayed_work_sync() with
disable_delayed_work_sync() in magicmouse_remove() to prevent
magicmouse_reset_resume() from queueing msc->work during unbind.

> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index a01e84a18dede..525ffc64a2f02 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -1032,7 +1032,7 @@ static void magicmouse_remove(struct hid_device *hd=
ev)
>  	struct magicmouse_sc *msc =3D hid_get_drvdata(hdev);
> =20
>  	if (msc) {
> -		cancel_delayed_work_sync(&msc->work);
> +		disable_delayed_work_sync(&msc->work);
>  		if (is_usb_magicmouse2(hdev->vendor, hdev->product) ||
>  		    is_usb_magictrackpad2(hdev->vendor, hdev->product))
>  			timer_delete_sync(&msc->battery_timer);

[Severity: Medium]
Can magicmouse_reset_resume() still cause a use-after-free on msc after
magicmouse_remove() returns?

disable_delayed_work_sync() records the disabled state in
msc->work.work.data, which lives inside the devm-allocated msc.  In
hid_device_remove(), devres_release_group() frees msc right after
hdrv->remove() returns, before hdev->driver or driver_data is cleared:

drivers/hid/hid-core.c:hid_device_remove() {
	...
		if (hdrv->remove)
			hdrv->remove(hdev);
		else /* default remove */
			hid_hw_stop(hdev);

		/* Release all devres resources allocated by the driver */
		devres_release_group(&hdev->dev, hdev->devres_group_id);

		hid_close_report(hdev);
		hdev->driver =3D NULL;
	...
}

Because hid_driver_reset_resume() does not serialize against
hid_device_remove(), a concurrent reset-resume can still touch msc->work
after msc is freed:

CPU0                                  CPU1
hid_device_remove()
  magicmouse_remove()
    disable_delayed_work_sync(&msc->work)
                                      hid_driver_reset_resume()
                                        magicmouse_reset_resume()
                                          msc =3D hid_get_drvdata(hdev)
  devres_release_group() -> frees msc
                                          schedule_delayed_work(&msc->work,=
 ...)
                                            <-- use-after-free on msc->work

queue_delayed_work_on() performs atomic bit operations on
msc->work.work.data to test and clear the pending bit when disabled,
modifying freed or reallocated slab memory (or queueing the work if
reallocation cleared the disable count).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110043001.5661=
5-1-mhun512@gmail.com?part=3D1
