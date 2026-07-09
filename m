Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB181386423
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622162; cv=none; b=YYStFrr0fewo2bWS4hUACGqxOZo0ssoewdxdcjCzG9K1/BdcP4l2CIyu5h7WfRN5uL/YzDUKp/wMAuEb900nPbShwkdaJMDMby64YDT1S6x9WilFcd1g+OW12/5FIpcP/ndh5ZpBvsKQeNC2JLi/O+bUmFdR0kDwtKMQbL1Crzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622162; c=relaxed/simple;
	bh=sec+DDLvtINY8D0Ujt2U1DHVN5nh/3+/UrM1G1TiNGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X7ARYe4rD29FJYgxlxn0Xl5G8yrSwxfNzAJI0Hvd8JG6JjAonCIY1AYVxvBUokbwlsKmEuC6QC2k/fWGv+ng4l+Bqvk2eEafKBNOrPIIQnqVtcelZRoA2MBxu6yPkRsWJ0lqk58HhZKAS89iaAaTRw2DtLMa+qHGhGv4/3EQ4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsfOPD2x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsfOPD2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C9E1F000E9;
	Thu,  9 Jul 2026 18:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622161;
	bh=bjnIvNufa50YvxnC/z/t3vJpUClqU8M2FuF5kJiTK0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bsfOPD2xyfL0OJ177njgrxv3QVybI9VOvgLMvu2cTOk8UPH6BubjRVv7Ni9q/25aD
	 MFUVIBnliOTZweeNozS7no048enInEOqNtSkskb6rzR+La0oe/AejyEN9UUKGAWm4v
	 zXfQpSWs8vCzohfXvuC3vtClKOBcUWP0D6h8h6uF0CiPBus2LkeCv02FdYmCFC2/k5
	 JrRPiN4ZPJAhWt79cluDVgIxj8roRKEuTPTTOhvd7GAfEB4RFhFeamOW0HJ73C7Svu
	 QC5WAaX1RN2jw81oEkyp/oH+Zx0YbMX992Sso/zx2KE+ACn3D9QTUmp76yaX72OYbv
	 wUMyw7Ue9nk0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] Input: ilitek_ts: add stylus input support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kristian Mide" <kristian@mide.dk>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260709182602.7308-2-kristian@mide.dk>
References: <20260626214248.5563-1-kristian@mide.dk>
 <20260709182602.7308-1-kristian@mide.dk>
 <20260709182602.7308-2-kristian@mide.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:36:00 +0000
Message-Id: <20260709183601.48C9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `api_protocol_set_cmd` fails during `ilitek_suspend`, the funct=
ion returns an error without re-enabling the IRQ.
--

--- Patch [1]: [PATCH v2 1/3] Input: ilitek_ts: add stylus input support ---
commit 93b3664194ad6413b8e1020fb08120b8f1d2a174
Author: Kristian Mide <kristian@mide.dk>

Input: ilitek_ts: add stylus input support
   =20
Add a separate stylus input device for report ID 0x0c packets,
with pressure, hover, and side-button support.

> diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/to=
uchscreen/ilitek_ts_i2c.c
> index 3de0fbf8da386..54e39721f2473 100644
> --- a/drivers/input/touchscreen/ilitek_ts_i2c.c
> +++ b/drivers/input/touchscreen/ilitek_ts_i2c.c

[ ... ]

> @@ -600,6 +720,18 @@ static int ilitek_ts_i2c_probe(struct i2c_client *cl=
ient)
>  	return 0;
>  }
> =20
> +static void ilitek_ts_i2c_remove(struct i2c_client *client)
> +{
[ ... ]
> +}
> +
>  static int ilitek_suspend(struct device *dev)
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev);

[Severity: High]
This isn't a bug introduced by this patch, but looking at ilitek_suspend():

drivers/input/touchscreen/ilitek_ts_i2c.c:ilitek_suspend() {
	...
	disable_irq(client->irq);

	if (!device_may_wakeup(dev)) {
		error =3D api_protocol_set_cmd(ts, SET_IC_SLEEP, NULL, NULL);
		if (error)
			return error;
	...
}

If api_protocol_set_cmd() fails, does returning the error directly leave
the IRQ permanently disabled?

If an error is returned during suspend, the PM core aborts the system suspe=
nd
and will not invoke the resume callback for this device. As a result,
enable_irq() would never be called, which could leave the touchscreen
unresponsive. Should this error path re-enable the IRQ before returning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709182602.7308=
-1-kristian@mide.dk?part=3D1
