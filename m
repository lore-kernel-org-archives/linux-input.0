Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578CD38D411;
	Thu, 28 May 2026 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958690; cv=none; b=i8yhw+h8lhevnhuWIBzgqtFY8a6jd3TFWG7CmN709bS/Tcw3NPpV2JORsHKg6QDRiyJpcKP2CN4unDfo4iNi260meb1cqpYUyWJTBhepZ27DYx5DWsVh23MXpLyT49AnbSM84tSQz5eZtQAnolUT3ji983B7vJKT1eqhYZ+YMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958690; c=relaxed/simple;
	bh=M4ud8nqkmcdfv/7EMVLmGGhByg/WoWOYFp8Sxswp1m8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SAzivhy5CFR7q+VYIeNfHknxRQmBQnEiRfm4nePyqItdLOZ/5wZ0BOfuTIuRzDVyAKhvz8sEgW4tJg64K1UDH6NMIK0+DyKbZyvyGcc4OYKcSFEBrqPLfx2DUnTz3MPlHrpR5x2fqarSkg7YkQcRUYwi3uA4boZ48mgWw0WQE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isKFcXyX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isKFcXyX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB601F000E9;
	Thu, 28 May 2026 08:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779958687;
	bh=8T8woJbbi3NNsEe3nlXUbIygofrJLaWrhX0VE2ysUqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=isKFcXyXQUiH91tA0qIZy1Fww7H7UVKE/TUI0FioffnQnz3ZSKG0nNRj0C5sD3dr0
	 JzpwEuVnWRinyxeRHBWePkBbfPmrFb6Fd++WLYQGWCzibxVxCBaIRY6KckKrD5uXD4
	 XU8CWxOJQMpFVwX6GZc1vRxtJBKmkxXV4ZRPzWVydXj6GAUGG4UX8nCPFMk5fUiFGR
	 swADhB/UrAfqk9egNhBBFjDVw1tms6aKwd9UNEuoNO3MaptZIYP97wkivArT33k5zS
	 CA7yUs9391eqiNFl3QMoEFNsmyvsh6bjeNHSqYtzzgsfHFZAfN07ZEvzfl6fvS3FoH
	 hvmFRGwz45P0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/7] power: supply: Add charger driver for Asus
 Transformers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260528053203.9339-8-clamor95@gmail.com>
References: <20260528053203.9339-8-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 08:58:07 +0000
Message-Id: <20260528085807.6FB601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Strict equality check on `action` bitmask may cause dropped even=
ts.
--

commit 55ed27a4bfa91a64727ac41721ebdb9163ebef2a
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

power: supply: Add charger driver for Asus Transformers

This commit adds a new driver to support charger detection capabilities
provided by the embedded controller on ASUS Transformer devices. It
reports properties like USB type, charging behaviour, and online status.

> diff --git a/drivers/power/supply/asus-transformer-ec-charger.c b/drivers=
/power/supply/asus-transformer-ec-charger.c
> new file mode 100644
> index 0000000000000..c7a6bd2ba533f
> --- /dev/null
> +++ b/drivers/power/supply/asus-transformer-ec-charger.c
[ ... ]
> +static int asus_ec_charger_notify(struct notifier_block *nb,
> +				  unsigned long action, void *data)
> +{
> +	struct asus_ec_charger_data *priv =3D
> +		container_of(nb, struct asus_ec_charger_data, nb);
> +
> +	switch (action) {
> +	case ASUSEC_SMI_ACTION(POWER_NOTIFY):
> +	case ASUSEC_SMI_ACTION(ADAPTER_EVENT):

[Severity: Medium]
Will this strict equality check cause charger events to be dropped if multi=
ple
interrupt flags are set simultaneously?

The action parameter appears to be constructed by the parent MFD driver by
taking the raw ASUSEC_IRQ_STATUS byte and OR'ing it with the SMI code shift=
ed
by 8 bits. Since ASUSEC_IRQ_STATUS is a bitmask, if an SMI event occurs
concurrently with another event (such as a keyboard press), the action bitm=
ask
will contain additional bits.

Could this strict switch check be replaced by checking the ASUSEC_SMI_MASK =
with
a bitwise AND operation, and then evaluating the SMI code separately?

> +		power_supply_changed(priv->psy);
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528053203.9339=
-1-clamor95@gmail.com?part=3D7
