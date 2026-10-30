Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394599;
	b=GGqdvryCzHrWN1GV+55q3JuMxj7yHE6VRryjomMZ+BUKKgJiqnWstvdfgi90g96/7CkL
	 8KACAsb1XZQdo6rrR/H9eB+gO7dkFJtCICschDbioHHMwV5QKWEFYwKiUqw+mlaRJcPhx
	 JmsOxurZHPlROau3ix/YRRbYA5xw68koUX5L+ycmq5X3+yKADn9NdiYKxshSO088vyLr8
	 pULuu/aAsiWa4ZNDr1Yt4jBOv8bD65TMkMzG1zk69OdguSgcU5L430sHA+ZiWDisPP4qk
	 j4vmurBybs3VjyDZhkghQETuhXVmsmxHGoC2Is/kv7XjsdHEIM2ByPtjc+EImavUj8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394599;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uQvhApu0Mn3zF7jtR4KVLsXUO6S5bbm3vxEsSQ6e7yY=;
	b=4aY00fUP+kBjk9LXMn8Dy9Hr7GVnf0YgqqXE4AD9QMySGQ5raDyK2Km4FMF3NqWYFoFG
	 p7LrE5xfkaIGpZNBKvN2NeLyOdpsxGZZNJE7U2diEY9b288dHcfUAiv3yctb5/BUMj+N8
	 F0KaqpJ25BnUZll9HViQlPt2I+U0N+7R7+cX0D4tQICMtJomnbW0aVnUEDe5WzGRackjI
	 ZODpjXELlbLS/+cwqPoGbf6Ylh422chnc1NKHVn03XEozkbqEJfSenN1Uu9Owkj3VEKyE
	 pNQRHtqsBc8rLIPg9mfkBpjMBxzVY75XFskpKuKeRdN4qcVe5Jx7Yblrp0gKJNGGGDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHXwjYNd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998D606A31C;
	Fri, 30 Oct 2026 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHXwjYNd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6EA1F000C1;
	Fri, 30 Oct 2026 21:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793394599;
	bh=uQvhApu0Mn3zF7jtR4KVLsXUO6S5bbm3vxEsSQ6e7yY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iHXwjYNd+Vfo88gXj0k2bYEt8T0Qumf0lItDGsdK3f1Hu/W3c6g0Dn5zef8RYYLoE
	 bbP/kIsn1Yit2NqEn+gXdK0morMLwRo73hOAkBm6iRDLFrepOuXF6aPRhbzWJrpb01
	 SqyWqH+MwUeZ6CafPi+QqOjXbPLmUG+1G4HIKyQBVAgr2ScZpNYm/YwCfuvRivhkBo
	 YQenhobe/oIum62OR4DWtMKHFd9cGvhboK68NkRxkzAJ4x7Azn4f/USgD0B9aRfSps
	 qsQWeNOSux4/vhkxtts+v/NZ4qTTwnuoxXbTDGiPdSdRWaTIZMgBF/8kV6x5R4xnHc
	 CkiuG/O7z3FKA==
Message-ID: <sashiko-outbox-191513@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] hwmon: (acer-aspire14-ec) Add driver for Acer Aspire
 14 52MT and 52M fan
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ethan Jimmy" <duhxu0@gmail.com>, linux-hwmon@vger.kernel.org
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261030210037.921646-1-duhxu0@gmail.com>
References: <0dee51d4-c153-457a-a3aa-ebf1177df045@roeck-us.net>
 <20261030210037.921646-1-duhxu0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 21:09:58 +0000
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
- [High] hwmon: (acer-aspire14-ec) module_init() fails when driver is built=
-in
--

commit 7f4ea74f303f12662cc63822a17eaf3d1e0e84bf
Author: Ethan Jimmy <duhxu0@gmail.com>

hwmon: (acer-aspire14-ec) Add driver for Acer Aspire 14 52MT and 52M fan

This commit adds a hwmon driver for the Acer Aspire 14 AI (A14-52M and
A14-52MT) fan sensor, which is exposed via an I2C HID embedded controller.

> diff --git a/drivers/hwmon/acer-aspire14-ec.c b/drivers/hwmon/acer-aspire=
14-ec.c
> new file mode 100644
> index 0000000000000..939b048165c5a
> --- /dev/null
> +++ b/drivers/hwmon/acer-aspire14-ec.c

[ ... ]

> +static int __init acer_aspire14_init(void)
> +{
> +	if (!dmi_check_system(acer_aspire14_dmi_table))
> +		return -ENODEV;
> +
> +	return hid_register_driver(&acer_aspire14_driver);
> +}
> +
> +static void __exit acer_aspire14_exit(void)
> +{
> +	hid_unregister_driver(&acer_aspire14_driver);
> +}
> +
> +module_init(acer_aspire14_init);
> +module_exit(acer_aspire14_exit);

[Severity: High]
Does acer_aspire14_init() fail when CONFIG_SENSORS_ACER_ASPIRE14_EC=3Dy and
CONFIG_HID=3Dy are built into the kernel?

In drivers/Makefile, drivers/hwmon/ is linked before drivers/hid/:

  obj-$(CONFIG_HWMON)		+=3D hwmon/
  ...
  obj-$(CONFIG_HID_SUPPORT)	+=3D hid/

Because both acer_aspire14_init() and hid_init() in drivers/hid/hid-core.c
use module_init() (which expands to device_initcall() when built-in),
acer_aspire14_init() runs before hid_init() registers hid_bus_type.

On matching DMI systems, the registration call chain:

  acer_aspire14_init()
    hid_register_driver(&acer_aspire14_driver)
      __hid_register_driver()
        driver_register()

reaches driver_register() in drivers/base/driver.c before the HID bus is
initialized:

	if (!bus_is_registered(drv->bus)) {
		pr_err("Driver '%s' was unable to register with bus_type '%s' because the=
 bus was not initialized.\n",
			   drv->name, drv->bus->name);
		return -EINVAL;
	}

Should this use late_initcall(acer_aspire14_init) like the other HID drivers
in drivers/hwmon/ (such as corsair-psu.c, corsair-cpro.c, and nzxt-kraken2.=
c)
so that driver registration happens after hid_init()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030210037.9216=
46-1-duhxu0@gmail.com?part=3D1
