Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059F45FFB1;
	Mon,  7 Sep 2026 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779206; cv=none; b=NM6z01d5Bl6J8L5K2fFPmBlVSSaFYWTrl7f/4tSLTZJvgpKPBeeCUSrcy5zjZTKawW1cyP538uCPgl1cUpSZHv5jFUzicL9/18atMq5z3kXyKjCtGgaZKjlCv2hH5UHVArgBiU9FxPHOzaD3cjSvvlIko94V5bHJzW1lx5ODBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779206; c=relaxed/simple;
	bh=54JTb8/eMEvnsKTX04M/wtEJCLgNW8dn1kWtQc/OW7g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=THL0Y+Ms0oSPOpkxKymGUSKwzD+FpVJ3D5euq56fvm184mRV0KMeiGKO389OgegF+n69QrJK16zOETXUaWzUTiVi9cgZ9NgIYC4EWQZh0uFzJPjMN4i9uxX3MOnWSfQC4GXwbQa42+DrlCsNStqYJ4ce9+dh5TZnZSqqTSASUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqMTD0H0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqMTD0H0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941161F00A3A;
	Mon,  7 Sep 2026 11:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788779204;
	bh=Dbkicljb3VyWC6LbXIiFWxT1oy5hveAtpAfNwTRSlZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SqMTD0H04Df3qhkqjy2tewI+7mVbdvbDlqZd7Q+SUH6UatKMY9WHDlreGntDtOpdg
	 p4qOoWkgrncFv9wDft8iem7Ovva8IVLaZDKF446OJsuJn166VoceVE5VvU3/1B6YN1
	 RqXrHz8Eet95rshhJPqPGSSj9Pm3JNf621y8s3/43DfN+ckptSFBVfEeBJb12BQ4A+
	 3/02TDFj0DgRFEq8PhfJxdkTup1PicVmCmwE+z1+yaBNQ7hMwCMlt3KEOdWWIpCAuo
	 6Nvdfh9Fjr54utCj5zEOW50i4Fp1AsQ1N3g9Px+dBIQQMZgkB9xPbZz4I9W4FPmUaT
	 cRzSpaim+PF/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] Input: stmfts - wait for controller ready after
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260907-stmfts5-v7-1-4a53381cd038@ixit.cz>
References: <20260907-stmfts5-v7-0-4a53381cd038@ixit.cz>
 <20260907-stmfts5-v7-1-4a53381cd038@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:06:43 +0000
Message-Id: <20260907110644.941161F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbalanced disable_irq() and regulator_bulk_disable() on consecuti=
ve suspend/resume failures.
- [High] System resume fails to restore the touchscreen's active state, lea=
ving the hardware locked in SLEEP_IN mode if it was in use prior to suspend.
- [High] The driver fragments multi-touch frames by calling `input_sync()` =
after parsing every individual contact event.
- [High] Information leak of uninitialized kernel stack memory via the 'sta=
tus' sysfs attribute, and functional bug where valid status reads return un=
initialized buffer data.
--

commit 1a68dcc09b6690980cb8297285fc328a7de4c568
Author: David Heidelberg <david@ixit.cz>

Input: stmfts - wait for controller ready after reset

After releasing the reset line stmfts_reset() sleeps a fixed 50 ms and
stmfts_power_on() another 50 ms before the first I2C access.  That is
enough for a warm reset, but when both supplies were really cut during
system suspend the controller boots from cold and can need longer.  If
it does, the first read fails, stmfts_resume() returns an error and the
touchscreen is left powered off with its interrupt disabled.

> diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscre=
en/stmfts.c
> index 972687797f826..711e3ad8587a0 100644
> --- a/drivers/input/touchscreen/stmfts.c
> +++ b/drivers/input/touchscreen/stmfts.c

[ ... ]

> @@ -598,16 +607,21 @@ static int stmfts_power_on(struct stmfts_data *sdat=
a)
>  	 */
>  	msleep(20);
> =20
> -	if (sdata->reset_gpio)
> -		stmfts_reset(sdata);
> +	if (sdata->reset_gpio) {
> +		err =3D stmfts_reset(sdata);
> +		if (err) {
> +			dev_err(&sdata->client->dev,
> +				"controller not ready after reset: %d\n", err);
> +			goto err_disable_irq;
> +		}
> +	} else {
> +		enable_irq(sdata->client->irq);
> +		msleep(50);
> +	}

[Severity: High]
This is a pre-existing issue, but if system resume fails here in
stmfts_reset(), stmfts_power_on() cleans up and returns an error. On the ne=
xt
suspend cycle, won't stmfts_suspend() unconditionally call stmfts_power_off=
()
again?

drivers/input/touchscreen/stmfts.c:stmfts_suspend() {
    ...
	stmfts_power_off(sdata);
    ...
}

And won't this increment the IRQ disable depth to 2 and unbalanced regulator
usage counts, eventually causing the touchscreen to become permanently
unresponsive?


[Severity: High]
This is a pre-existing issue, but stmfts_power_on() ends with a command to =
put
the controller to sleep:

drivers/input/touchscreen/stmfts.c:stmfts_power_on() {
    ...
	/*
	 * At this point no one is using the touchscreen
	 * and I don't really care about the return value
	 */
	(void)i2c_smbus_write_byte(sdata->client, STMFTS_SLEEP_IN);

	return 0;
    ...
}

If the touchscreen was held open by userspace (sdata->running) prior to
suspend, won't this leave the hardware asleep upon system resume? Since the=
 PM
core does not automatically invoke runtime_resume, does the driver need to
check sdata->running and manually wake the device here?


[Severity: High]
This is a pre-existing issue, but is it intentional to call input_sync() for
every individual contact event here?

drivers/input/touchscreen/stmfts.c:stmfts_report_contact_event() {
    ...
	input_mt_report_slot_state(sdata->input, MT_TOOL_FINGER, true);
	input_report_abs(sdata->input, ABS_MT_POSITION_X, x);
    ...
	input_sync(sdata->input);
}

Since this is called for each finger during multi-finger touch frames, does=
n't
this fragment multi-touch frames by emitting a sync after each finger rather
than grouping them at the end of the event parsing loop?


[Severity: High]
This is a pre-existing issue, but is the return value of
i2c_smbus_read_i2c_block_data() handled correctly here?

drivers/input/touchscreen/stmfts.c:stmfts_sysfs_read_status() {
    ...
	err =3D i2c_smbus_read_i2c_block_data(sdata->client, STMFTS_READ_STATUS,
					    sizeof(status), status);
	if (err)
		return err;

	return sysfs_emit(buf, "%#02x\n", status[0]);
}

Since i2c_smbus_read_i2c_block_data() returns the number of bytes read on
success (e.g. 4), won't "if (err)" evaluate to true and return the byte cou=
nt
directly, bypassing sysfs_emit()?=20

Additionally, if it were to return 0, wouldn't sysfs_emit() leak uninitiali=
zed
kernel stack memory (status[0]) to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-stmfts5-v7=
-0-4a53381cd038@ixit.cz?part=3D1
