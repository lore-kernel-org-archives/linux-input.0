Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400783;
	b=J9D25JPfemkgzIPmaWvC+604w219z7kcb1/2O/BYOT+kRbY7KJ/dfQ7Q6YQR5TufkCXw
	 SafS9YeEdFhu3771BbIBs8aNH/I6alvlu1NBCI0p/yGXBhUVZPKcJXrdZfFkwPRSvYD/J
	 W074dS5wK8QAQ7xUDL3MwHQHtatWX0xUGaMNC06/p2MOVkbqSJJK/VxYctRr5ahpRV3Fe
	 JK5vzjfy3xbmVbfVT+1ZB8PlVg1CibClbqH+ZjPIiQ9AZgsvPROEw2Et8j7Y643S9hUFW
	 uG8MQc+JvRLCsGoAVaN6iNytG+yQeXD6q7Cgya5GKZrTai7yZ6cHdqlO37OWmTo3TFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400783;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PKP4PV7uLFEeUuqaAatNUVGkd7EiCbfk4NAI+bq6zjQ=;
	b=pKs2C3cgjHnPQC8tXoPQQ2K8MGWJJ9oykiUlXNGRQA4wUYL93BnHRLNrX7PbtSWB3m54
	 nPWdBIfIIHBYDh75/M91P9wKfvI1nymn9d79S+7wlFqv4ncPKfz2hdzV3wErkUhK+K7Qn
	 h8DP3f4ep31W2roCe2NM5Oo1EhVkzkWjEW5dvtpOVtf6udVpMCjgHzjXpRSzpMm3Ok3F/
	 ZamRJMgVfOqGTzZ2Jxqhua9W/zxdQtWABf92fWoW15X+yG8q2q34sg3oxf79iIU/v+rhg
	 NPWmhHeK3IYDzmwsy0VbbtNqNVyt2Ka743a9ezjcopb+vUSg9P3ebIV+yQUsuYxVJzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EjRL8/u4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199F606A31A;
	Fri, 30 Oct 2026 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EjRL8/u4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5CC1F000C1;
	Fri, 30 Oct 2026 22:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400782;
	bh=PKP4PV7uLFEeUuqaAatNUVGkd7EiCbfk4NAI+bq6zjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EjRL8/u4u1Mm8TGkTev/dRm3uqyaLTeLWPLTJmoVBhNO2WRIq90ZQwjQp1E24Dj02
	 hotrwhfApeTr6e41nPdoqwOGb64/I3OoiiULxBUTIdo44spjE8H1YdkOqwMaVqgNFe
	 St09KAJatTXlD4HkURO1Qz+4jeKpHaNo8BD9AEEn1NNspW2Sa05JxHLbl7ZYOSxNwR
	 13SjhlSCY5NXN3OHoxAiydzN0n1TVSXV7h8bmF0OJ858IiVoH6G+fDqq31MlBWFbUy
	 jxdRNQoHr+Hvk5h4afqK+/b5NlcNh9GSZa3SI1e8zLoT8leQLEjFSq4bO7/W2frPJa
	 RvEOUVB0dt29w==
Message-ID: <sashiko-outbox-191603@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/15] HID: ft260: add GPIO support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261030223637.86907-4-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-4-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:53:02 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HID: ft260: use-after-free from devm_gpiochip_add_data() outliving=
 dev
--

commit 0ee92e34686aff73d8b504af1979dbbb02897cf0
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: add GPIO support

This commit adds gpiochip support for the FT260 multifunctional pins, expos=
es
pin function selection attributes via sysfs, and tracks enabled GPIO pins
based on the active I2C and UART configuration.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index c859486cb28c8..e24f3151fdaf3 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c

[ ... ]

> @@ -919,6 +1033,347 @@ static const struct i2c_algorithm ft260_i2c_algo =
=3D {

[ ... ]

> +static int ft260_gpio_init(struct ft260_device *dev,
> +			   struct ft260_get_system_status_report *cfg)
> +{

[ ... ]

> +	ret =3D devm_gpiochip_add_data(&hdev->dev, dev->gc, dev);
> +	if (ret < 0)
> +		hid_err(hdev, "cannot add GPIO chip %d\n", ret);
> +exit:
> +	return ret;
> +}

[Severity: High]
Can registering dev->gc with devm_gpiochip_add_data() in ft260_gpio_init() =
in
drivers/hid/hid-ft260.c cause a use-after-free on dev during device removal=
 or
probe error rollback?

In drivers/hid/hid-core.c, hid_device_remove() calls hdrv->remove(hdev) bef=
ore
releasing the device's devres group:

  hid_device_remove()
    ft260_remove()
      hid_hw_close(hdev);
      hid_hw_stop(hdev);
      if (dev->iface_type =3D=3D FT260_IFACE_UART)
          ft260_uart_port_put(dev);
      else
          kfree(dev);
    devres_release_group(&hdev->dev, hdev->devres_group_id)
      devm_gpio_chip_release()
        gpiochip_remove(dev->gc)

Similarly, if sysfs_create_group() fails after ft260_gpio_init() succeeds in
ft260_i2c_probe() or ft260_uart_probe(), ft260_probe() closes and stops hdev
and frees dev (via kfree(dev) in err_hid_close, or via tty_port_put(&dev->p=
ort)
in err_uart) before __hid_device_probe() calls devres_release_group().

Until gpiochip_remove() runs, the GPIO chip remains live and registered with
dev as its private data pointer. If a gpiolib consumer or /dev/gpiochip
userspace ioctl invokes ft260_gpio_get(), ft260_gpio_set(),
ft260_gpio_direction_set(), or ft260_gpio_get_direction() during that windo=
w,
gpiochip_get_data(gc) will return the freed dev pointer, dereferencing freed
memory (such as dev->lock, dev->hdev, and dev->gpio_en) and issuing HID
transfers on a stopped hid_device.

Would it be safer to manage the gpio_chip registration explicitly with
gpiochip_add_data() and gpiochip_remove() before stopping hdev and freeing =
dev
in ft260_remove() and the probe error paths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030223637.8690=
7-1-michael.zaidman@gmail.com?part=3D3
