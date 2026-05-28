Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC538838E
	for <linux-input@vger.kernel.org>; Thu, 28 May 2026 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958140; cv=none; b=anRplk3y8Drf/rdSqu0hLPi1SKoYFDFkl19uF1MCB0WbxkO1PTMdD5fuxDa+rG5FuaiP/91ovzb8FXq6V6tF5W1TaxOXpKZQjyYR0K0mG3JJly120Ctx1WtaarX12mSZqM07cT726d88S1eoaLX30UTZkMGCPWMaLJRHjm660tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958140; c=relaxed/simple;
	bh=CHN2SFJMc0r/crTmcwsJTQcCGCVPosZIPr6xqGQkzlA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RPprMfEWdkL9rfRgpkIqrzMyd85T/dWvgj+xtZeLqnAD9LXbPEOYwsFTvK7MQR3a1fKV60vgDVC1k0XxZLIs2dtg52YykwtewFVGKaiQPB5DI62lot7o1AFZ8Y25+fuAr/P61OYtG03dCfXfzA8ayXQjLotJJyIRUqDIROJv5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF9mEbMJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF9mEbMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BFB1F00A3D;
	Thu, 28 May 2026 08:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779958139;
	bh=59CEkq/j1Itu/TlzJGT3zBygXivDOWBhBGdJRKGOK2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MF9mEbMJQXRhF8PshDSHixiin/AFarhwbk+/PAAzb/lxs40ixJBrmLYc1VBrmBR18
	 ps73T7rf8bakT9PANVRgEN5ExsgiUSIXNY+XrMLg+e0aqyzsStu8wLaf8JomSeHu9Z
	 TEiz+h2kvhYQ1lskQQZFLIuJ83BgfVCr1mHvT4Bkce2fghgF+iS5OCs7VroO98UvwK
	 PXIgz6xGtzCrYbSfrurrYBG6yejmqoEJFs44pzgLxoPpKYrDjfhsDm6SIOFOeWZLOo
	 dtsSxtEbta7Xkqff3LoGrNU2NeHD5cW5tz87hPK2l2OOwoxU7nNBn+vk/3s4eUTQ5a
	 Sb4Pmvc0IZsKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] Input: atmel_mxt_ts: Fix async config
 use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hendrik Noack" <hendrik-noack@gmx.de>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260528074317.9604-1-hendrik-noack@gmx.de>
References: <20260528074317.9604-1-hendrik-noack@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 08:48:44 +0000
Message-Id: <20260528084845.38BFB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] The `shutting_down` flag and `complete_all()` logic introduced to s=
erialize shutdown are completely unreachable dead code and contain misleadi=
ng logging.

Pre-existing issues:
- [High] Concurrent sysfs operations lack synchronization, leading to sever=
e use-after-free and double-free vulnerabilities.
- [High] The `wait_for_completion(&data->config_completion)` in `mxt_initia=
lize()` is placed too late, failing to protect against concurrent execution=
 with the firmware callback when triggered via sysfs.
- [High] Accessing the `update_fw` sysfs attribute before probe completes l=
eads to a NULL pointer dereference.
--

commit f95104521ff6a213450d681f2eb88830307206ae
Author: Hendrik Noack <hendrik-noack@gmx.de>

Input: atmel_mxt_ts: Fix async config use-after-free

The driver starts asynchronous config loading from probe and sysfs. If the
driver is removed while a request is pending, devres frees mxt_data, leading
to a use-after-free in the callback. The patch introduces a completion to
serialize request_firmware_nowait() and remove().

> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/tou=
chscreen/atmel_mxt_ts.c
> index a9e86ad7ed5ef..a88dc7e6827c7 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c

[ ... ]

> @@ -2271,12 +2278,26 @@ static int mxt_initialize(struct mxt_data *data)
>  	if (error)
>  		return error;
> =20
> +	wait_for_completion(&data->config_completion);

[Severity: High]
This is a pre-existing issue, but does wait_for_completion() happen too late
here to protect against concurrent execution with the firmware callback when
triggered via sysfs?

When mxt_update_fw_store() is invoked, it first calls mxt_load_fw(), which
clears data->info via mxt_free_object_table(), before mxt_initialize() is
even called.

It then calls mxt_initialize(), which waits for the completion. However, if
a previously initiated mxt_config_cb() is executing concurrently, it uses
data->info inside mxt_configure_objects().

Since mxt_load_fw() frees and clears this pointer without waiting for the
async callback to finish, mxt_config_cb() will suffer a null pointer
dereference or use-after-free. The wait seems placed too late to prevent
this sysfs race.

[Severity: High]
This is a pre-existing issue, but do concurrent sysfs operations lack
synchronization?

The driver exposes sysfs attributes like update_fw without internal
serialization. The sysfs framework permits multiple threads to write to the
same attribute concurrently.

mxt_update_fw_store() directly invokes mxt_load_fw(), which destructively
modifies device state by calling mxt_free_object_table().

Without a mutex protecting this path, concurrent writes to update_fw will
cause multiple threads to enter these teardown functions simultaneously,
leading to a double free of data->raw_info_block and data->msg_buf.

> +
> +	if (data->shutting_down) {
> +		/* complete() only signals one waiter, signal all waiters once during =
shutdown */
> +		if (!completion_done(&data->config_completion)) {
> +			complete_all(&data->config_completion);
> +			dev_info(&client->dev, "Shutting down, not loading new config: %d\n",
> +				 error);

[Severity: Low]
Is this block actually reachable? mxt_initialize() is only invoked by
mxt_probe() and the sysfs attribute mxt_update_fw_store().

The driver core strictly serializes mxt_probe() and mxt_remove() via the
device lock. For the sysfs path, the driver core drains active sysfs
operations via device_remove_groups() before invoking the bus remove()
callback (which calls mxt_remove()).

Because of this, it seems mxt_initialize() and mxt_remove() can never run
concurrently.

Also, error here is mathematically guaranteed to be 0 since we just passed
if (error) return error, making the log message semantically misleading.

> +		}
> +
> +		return -EBUSY;
> +	}
> +

[ ... ]

> @@ -3237,6 +3258,9 @@ static int mxt_probe(struct i2c_client *client)
>  	init_completion(&data->bl_completion);
>  	init_completion(&data->reset_completion);
>  	init_completion(&data->crc_completion);
> +	init_completion(&data->config_completion);
> +	complete(&data->config_completion);
> +	data->shutting_down =3D false;

[Severity: High]
This is a pre-existing issue, but could accessing the update_fw sysfs
attribute before probe completes lead to a null pointer dereference?

Sysfs attributes defined via mxt_driver.driver.dev_groups are registered by
the driver core (device_add_groups()) before the driver's probe function is
called.

An early write to update_fw during this window executes
mxt_update_fw_store() before i2c_set_clientdata() is called in mxt_probe().
In this scenario, dev_get_drvdata(dev) returns a null pointer, which is then
immediately dereferenced in mxt_load_fw():

drivers/input/touchscreen/atmel_mxt_ts.c:mxt_load_fw() {
    ...
    if (!data->in_bootloader) {
    ...
}

Would this cause a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528074317.9604=
-1-hendrik-noack@gmx.de?part=3D1
