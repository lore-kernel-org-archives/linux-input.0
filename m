Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CC73D9674;
	Fri,  9 Oct 2026 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791585412; cv=none; b=LSMEGbkgXW2MDeysIjqhThmbaZrrkBgzzdMY8YxaxMF9eDUKKo/iBXHjcSvonOxeP04Zg3yEfiJ/aNjB/WYmDZcrtcIAOV0c7RDBUiNYx29UuJK8bYr3UweQM7rqy03RJfd0hHJoP/toHsPLS/zuxF5m/CCaKUI0OxQS1QdnI/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791585412; c=relaxed/simple;
	bh=dFum9+v9baFw73xBVY+ui262WinfvW06V2r9KGd0ADA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GzVS5sL/quUApRombozcF5lXGTbLkD7kcxWdCqPicu6SIMmgBZaCUx4b1U2U5YJdTACItkriPJp/Ow9VpjZgfCEnkJ+uCXCXDZx38d1LLpQVSci/rDB1NuWxOBKGJi//+5iwqJm2Hyz5CFLraEL6IonoLK3jQobUziGS5fl3DoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQPVj2ie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQPVj2ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FA11F000FF;
	Fri,  9 Oct 2026 22:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791585410;
	bh=fprAEFd0nspdnH7l7zs3d09WGplFQp59cFwuT04zPoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EQPVj2ieeMtOvRfXbKzN4JiZswXm41dOl8kxkJkNqR+csTeGnsdX9CBZ93gGK8Gbv
	 xwbCSq2Oav2hz0OMbG9Tp2aAhUom+we8ILYiOkWluPIYavc60cnApcmg6KeKFMqkVm
	 DRiSgQSHe3C0pCJO/wGraZmN6bep+6Yjb8dGQ0OWoyKCowkMzD8CDJ04vajkKsDvv+
	 vMHQnB3a1Y0tKtIfT80587cWUMy7onmtcaxmuZmzqrVorTJp7lSYJ/nO3vpmNO211g
	 3TDHN3R/7eXZBAZQPh63nfooUY3ddmyZ140FnOWRXmf9TZL0fNSh1xSPTV+6WcmvID
	 cK3gWfOTFBi+A==
Message-ID: <sashiko-outbox-166150@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/11] HID: spi-hid: add panel follower support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: conor+dt@kernel.org, linux-trace-kernel@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261009-send-upstream-v5-11-384af01da3ee@chromium.org>
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-11-384af01da3ee@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 22:36:49 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] spi-hid: Inconsistent wake IRQ configuration for panel followers
--

commit 4c8d0ec463c5dbd300c392f3f924992096f8ebc1
Author: Jingyuan Liang <jingyliang@chromium.org>

HID: spi-hid: add panel follower support
   =20
This commit adds support to the spi-hid transport driver to act as a
panel follower, allowing its power state to be sequenced with a display
panel.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c
[ ... ]
> @@ -1577,21 +1676,17 @@ int spi_hid_core_probe(struct spi_device *spi, st=
ruct spihid_ops *ops,
>  		}
>  	}
> =20
> -	error =3D shid->ops->power_up(shid->ops);
> -	if (error) {
> -		dev_err(dev, "%s: could not power up\n", __func__);
> -		return error;
> -	}
> -
> -	error =3D shid->ops->deassert_reset(shid->ops);
> -	if (error) {
> -		dev_err(dev, "%s: failed to deassert reset: %d\n", __func__, error);
> -		shid->ops->power_down(shid->ops);
> -		return error;
> +	if (shid->is_panel_follower) {
> +		error =3D spi_hid_register_panel_follower(shid);
> +		if (error)
> +			return dev_err_probe(dev, error,
> +					     "Failed to register panel follower\n");

[Severity: Low]
Does this sequence leave a dangling, inactive wake IRQ attached to the
device when it is a panel follower?

In spi_hid_core_probe() just prior to this block, the code checks
device_can_wakeup(dev) and unconditionally allocates the wake IRQ via
devm_pm_set_wake_irq().

However, if the device is a panel follower, it calls
spi_hid_register_panel_follower() here. Inside that function, it checks
device_can_wakeup(dev) again, warns the user, and forcibly disables the
capability:

    if (device_can_wakeup(dev)) {
        dev_warn(dev, "Can't wakeup if following panel\n");
        device_set_wakeup_capable(dev, false);
    }

Because the capability is disabled after the IRQ is already requested, it
appears to waste resources by allocating an IRQ that is immediately rendered
unusable. Should the panel follower check and the potential clearing of the
wakeup capability occur before the wake IRQ is requested?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-upstr=
eam-v5-0-384af01da3ee@chromium.org?part=3D11
