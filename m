Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F391449B0B;
	Tue, 21 Jul 2026 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621239; cv=none; b=M0YvEgE/qqBl+ke6nyWpgPmsVlziLladui88StoV7Fs+Qmpq2tKOQV5LmPpBTlV2HIvarozOZXw0deGfEPDNndfj1e/b8sRCYMaySJecaCF4fWk/6vOSB8JvGAsbnTgeof/JjqmuANA4BNawX4wUnFbKNUvyf6l5v6I1VAQ7lhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621239; c=relaxed/simple;
	bh=3//wgt4R8vcXxkZYDgxlNeZOgsy1LVqgwBof0hbQjtI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qr07u9ZkMqeN8n0h1GExAcrdS78o5LhL+QzocK7E2XwhUZj66J7e7ZaFjxygKNfKr0h1pPY3sEqRevhlTJdjiZOPJfkzZT2gQvX2Yizxs5lQe7Ck1eHESJ6WvoYHQHZ74DSvt9KPjE0e+OAjz8mCQTWJ2LhTm2WQ2aS6vhBNujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+IKph4I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+IKph4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FD41F000E9;
	Tue, 21 Jul 2026 08:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784621237;
	bh=RhsH2NzVuHQuHEsCtbOk+PrM9VzRsacXtFStdLu5a9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J+IKph4IL1zLO1XDGKDGYdPnZTxbO26lwelgR73ViTvM3AjmfOoM1RVOXMTLNSLEh
	 O3cGjwCcpC5UuaSuuQikgslE8tGpMXz1Llizg9C4e3EbV2g7M2YvuY1XuiBZ2Ua/B1
	 rMICJGZG8DFZJhnW+02n0vpPLIPHpSyPmY6EslQg3eFVz0ee5BfJsGic1Ze27wih85
	 IrBMnvMh2XlKru053AChb5UXTM4/1sK+jGfXbd8+m0z9PhSkPptf7s5dt4IDGaKCuZ
	 JY9YYJLKx0/M6r6ZAGWiwIXa9mdL+pjhUpNbJPkGrT7VAh+MUmIfDVDlDLIWnuMpTN
	 FdssaiCwSyzmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] Input: elan_i2c - Wait for initialization after
 enabling regulator supply
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org
In-Reply-To: <20260721075226.2347933-4-wenst@chromium.org>
References: <20260721075226.2347933-1-wenst@chromium.org>
 <20260721075226.2347933-4-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 08:07:16 +0000
Message-Id: <20260721080717.59FD41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `regulator_enable_and_wait` sleeps for the specified duration whil=
e holding the WW mutexes for the regulator and all of its suppliers, degrad=
ing system concurrency.
--

--- Patch [3]: [PATCH v3 3/9] Input: elan_i2c - Wait for initialization aft=
er enabling regulator supply ---
commit 3e5bcc07a47c73771197519603fee461c8ac8685
Author: Chen-Yu Tsai <wenst@chromium.org>

Input: elan_i2c - Wait for initialization after enabling regulator supply

This commit switches the Elan trackpad driver to use the new
regulator_enable_and_wait() API. This ensures the required hardware and
firmware initialization delays are respected after the trackpad regulator
is enabled during probe and resume.

Link: https://lore.kernel.org/all/20241001093815.2481899-1-wenst@chromium.o=
rg/

> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/el=
an_i2c_core.c
> index 9f024a435dbf1..77885930bf9e6 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
[ ... ]
> @@ -1250,7 +1253,7 @@ static int elan_probe(struct i2c_client *client)
>  	if (IS_ERR(data->vcc))
>  		return dev_err_probe(dev, PTR_ERR(data->vcc), "Failed to get 'vcc' reg=
ulator\n");
> =20
> -	error =3D regulator_enable(data->vcc);
> +	error =3D regulator_enable_and_wait(data->vcc, ETP_POWER_ON_DELAY_US);

[Severity: High]
Will using regulator_enable_and_wait() here cause a 110ms sleep while holdi=
ng
the regulator's WW mutexes?

Looking at _regulator_enable_and_wait() in drivers/regulator/core.c, the sl=
eep
happens while the dependent locks for the regulator and all of its suppliers
are still held:

drivers/regulator/core.c:_regulator_enable_and_wait() {
    ...
    if (wait_us) {
        ktime_t end =3D ktime_add_us(rdev->last_on, wait_us);
        s64 remaining =3D ktime_us_delta(end, ktime_get_boottime());

        if (remaining > 0)
            fsleep(remaining);
    }
    ...
}

Could this serialize all operations on the shared PMIC/supply during probe
and resume?=20

If multiple consumers share a parent supply, wouldn't they block on the
parent's mutex and execute sequentially, potentially causing boot and resume
time regressions?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721075226.2347=
933-1-wenst@chromium.org?part=3D3
