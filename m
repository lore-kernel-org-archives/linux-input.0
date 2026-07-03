Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F03955F9;
	Fri,  3 Jul 2026 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080644; cv=none; b=BtUhUj4kpmu6KqElKGorhwDG5CD+Ra8hSca16LzvzHgpJw03q+/z135x4/ClQWOnymEAS6Nhnkg/l7TSUHQ4gGCXcJwjHHH7hNgrStclNTquZ4h24T/+0idCkdUR/7+i2yUnBOfUJ1llIzVSXy7hK0iydmXdtpr6+MZG06BqCKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080644; c=relaxed/simple;
	bh=05w48OdmyT6aT8SkPADwqc9GJXkiDPWGIlJlo2nf6Q8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DeDd/5wxeF81geKZo515CT6ghKjzc5zb1a4xYsSnwFgEbvQ1uBmspKlUawP2iaRz04z/P860Fh4z6o2NoOF9JxYRaGaTQFBpaPGZaIN0JOcWg6Q6snipaaKfNdsJAdsAQW0XOkbxUNpDlXdrxLV9d6BrGIkFw/NALckA4m7CV50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ew+9AZCT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew+9AZCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BEB1F000E9;
	Fri,  3 Jul 2026 12:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783080642;
	bh=DDrOJLqcO7wf4m8tsaCi7d432X3VFvOhT7r93Eh18gk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ew+9AZCTp0/SnMiQJWjWZ03UdQAzjLu3BOpCe90Fl0dVGkqgXV9CTb0tPRL9JTCV6
	 Bb23fbRiMs/GwDVIqQDqYrXBKt/I3Snzle9Pe8JY0ODHxSKRBCU6TGOImkb8ljPLhq
	 dXk4nBl/+/D5EoHTfEySqqyFfs3XJOTncaJrI5mTs8QVm+tLznGc8Qu3aBhnSn8xaQ
	 tm3LDKPpNwHGxPDhcm48Nczt8osYXfAvq5dp6FzRbNXvsD/R3WmXCV+5Mklr3smOI0
	 BxCh2nFD0Dy7QnFMGO4vkhrgUX6ZEI2sIuTo3kbe18LSYGKm2kF2M2DWW0lDyUqJ2q
	 Uwlukpqb7MqLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] platform/chrome: of_hw_prober: Add delay for
 hana trackpads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org
In-Reply-To: <20260703115601.1323491-6-wenst@chromium.org>
References: <20260703115601.1323491-1-wenst@chromium.org>
 <20260703115601.1323491-6-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:10:41 +0000
Message-Id: <20260703121042.46BEB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The result of regulator_is_enabled() is assigned to or bitwise-AND=
ed with a boolean variable, causing negative error codes to incorrectly eva=
luate to true and skip required hardware initialization delays.
--

commit 1aa1abec8abc658e89bd1583fb36c5b23bda7cf8
Author: Chen-Yu Tsai <wenst@chromium.org>

platform/chrome: of_hw_prober: Add delay for hana trackpads

Up until now, the MT8173 elm/hana device tree has set the dedicated
regulator supplying the trackpad as always-on, simply because the Elan
driver was missing proper delays. As a result the delay for the
Synaptics trackpad was also omitted, as it was not strictly required
under such a model and delayed the availability of the trackpad to the
user.

> The Elan driver recently gained proper delays after power-up, with
> adaptive skipping of the delay if the regulator was originally
> on. The I2C HID driver and I2C OF component prober library gained
> similar adaptive delay skipping. The device tree will be fixed to have
> the regulator not be always on, and proper post-power-on delay time
> added to the I2C HID device.

[Severity: High]
Does the adaptive skipping logic mentioned here safely handle negative error
codes from regulator_is_enabled()?

Looking at the implementations of this adaptive skipping,
regulator_is_enabled() can return a negative error code (e.g., -EIO, -EBUSY)
on failure, but this result is being directly assigned to or bitwise-ANDed
with a boolean.

For example, in drivers/hid/i2c-hid/i2c-hid-of.c:i2c_hid_of_power_up():

    for (unsigned int i =3D 0; i < ARRAY_SIZE(ihid_of->supplies); i++)
        supply_was_enabled &=3D regulator_is_enabled(ihid_of->supplies[i].c=
onsumer);

Since supply_was_enabled is promoted to int for the bitwise AND, does this
outcome depend on the parity of the error code? It looks like odd errors
(like -EIO) will yield true (skipping the delay), while even errors (like
-EBUSY) will yield false.

Similarly, in drivers/i2c/i2c-core-of-prober.c:
i2c_of_probe_simple_enable_regulator():

    supply_was_on =3D regulator_is_enabled(ctx->supply);

And in drivers/input/mouse/elan_i2c_core.c:elan_probe() and elan_resume():

    supply_was_enabled =3D regulator_is_enabled(data->vcc);

Since any non-zero integer evaluates to true in C, assigning a negative err=
or
code directly to a bool means all errors will incorrectly signal that the
regulator was already on.

Could this cause a regression where a transient I2C or hardware error when
querying the regulator state makes the driver incorrectly skip required
hardware initialization delays and fail the device probe?

> Also add the post-power-on delay to the ChromeOS OF component prober,
> so that if the regulator is off at the time of probing, the prober knows
> to wait for the hardware to initialize.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703115601.1323=
491-1-wenst@chromium.org?part=3D5
