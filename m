Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F943F8C4
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247505; cv=none; b=oymaTDf7Ss6V1uevGDOMW+GhbO/bv2+66Go+433dYI3bIcFYUqyRPFghA4F0sqSkKijpbvvTujLdcBdNH8WTfud4rh8KK3lpe0EDDieVc9IWuEmyCluWsl/mTV4fcbWtz93/veNjOLRy5CV2e17gD++jH++xkMJoiiNAc/1fQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247505; c=relaxed/simple;
	bh=2S2fZeXJFn1crIqfpMUcyNd8kG0NwtBdguWHHwiAMI4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZFLntGmN6pBlu98vpPEYxBaM5F4yV6TV9k2uiS41xQ4PuIsRPmVM0SrU3Fljj4LBWX6sXMVR3FMC1WLo1priyUUukncjJYcH0fjtN6XH4vZHPBetX9B4baP2gVhTKrKBDRbgQdOEOcjrlVAm5J/rOPA8h67pq2xx7tY8o0yiBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nm+hlUCY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm+hlUCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D8A1F000E9;
	Tue, 28 Jul 2026 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785247503;
	bh=6TezT/UxNjy5NL9X7qeQ7IasNeryp4tZx4sR1mqkdR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nm+hlUCYIo5GMsB8XtUjh/aXDHKKyWTPML8xjPhlTJEBnx7b9JJ2KEBTFfBvyyHNY
	 K4FHdt79k2a+oe+k2K+RwflDdSWXUhcJL/dxoBO4j3dXvBqKPSpAwx1XucbwRI+G8z
	 E+VYiZxOonDISb+BLcbjAj69jUXuIxgrGsIE3a1F5oh3zT8BVCkWRlJEXTXhwWyFkU
	 vIbgibqbuk1WwPeRKgyHkiHb4YWrKQLtb+hsA9t7A82CJVOnamTBaUaGh5oTMi3UwS
	 jW1MehlR4oJC42wnKkuW74wgZynPihPpE1jFHrq6J7bgA7yC4YgcX3Owqbezajjq2T
	 eO+tHUXVMD7Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: raydium_i2c_ts - propagate device info query
 errors from raydium_i2c_initialize()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Bilal" <meatuni001@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260728135127.48971-1-meatuni001@gmail.com>
References: <20260728135127.48971-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 14:05:03 +0000
Message-Id: <20260728140503.A9D8A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Propagating the error from `raydium_i2c_query_ts_bootloader_info()=
` makes non-fatal HWID read failures fatal, permanently breaking firmware r=
ecovery.

Pre-existing issues:
- [Critical] Firmware update from bootloader mode dereferences ZERO_SIZE_PT=
R due to un-updated buffer size.
- [High] The driver blindly trusts hardware-provided `pkg_size` and `tp_inf=
o_size` without validation, leading to integer underflow, out-of-bounds rea=
ds, and division-by-zero panics.
- [High] The target patch's fix is bypassed because `ts->boot_mode` default=
s to `RAYDIUM_TS_MAIN` (0), breaking the initialization retry loop and allo=
wing ZERO_SIZE_PTR dereference if the I2C bus returns all zeros.
- [High] The `calibrate_store` sysfs function performs a multi-step hardwar=
e command sequence without disabling interrupts, allowing the touchscreen I=
RQ handler to interleave its own I2C transactions.
- [High] The driver extensively passes stack-allocated memory to I2C transf=
er functions, violating DMA mapping rules and risking kernel panics.
--

--- Patch [1]: [PATCH] Input: raydium_i2c_ts - propagate device info query =
errors from raydium_i2c_initialize() ---
commit cc4ec8b45e33c4b58e61efd967f923405f1be4a5
Author: Muhammad Bilal <meatuni001@gmail.com>

Input: raydium_i2c_ts - propagate device info query errors from raydium_i2c=
_initialize()

This patch modifies raydium_i2c_initialize() to return the result of info
queries in both bootloader and main modes. It aims to prevent probe from
succeeding and allocating a zero-sized buffer if the info query fails on all
retries. By aborting probe early, it prevents a subsequent NULL pointer
dereference in the IRQ handler.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221777

> diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/t=
ouchscreen/raydium_i2c_ts.c
> index 0256055abcef3..a0b23772f4c0b 100644
> --- a/drivers/input/touchscreen/raydium_i2c_ts.c
> +++ b/drivers/input/touchscreen/raydium_i2c_ts.c
> @@ -426,9 +426,9 @@ static int raydium_i2c_initialize(struct raydium_data=
 *ts)
>  		ts->boot_mode =3D RAYDIUM_TS_BLDR;
> =20
>  	if (ts->boot_mode =3D=3D RAYDIUM_TS_BLDR)
> -		raydium_i2c_query_ts_bootloader_info(ts);
> +		error =3D raydium_i2c_query_ts_bootloader_info(ts);

[Severity: High]
Does this change unintentionally break firmware recovery for devices with H=
WID
read issues?

Looking at raydium_i2c_query_ts_bootloader_info(), if the HWID read fails, =
it
falls back to setting a dummy hw_ver but does not clear the error code:

raydium_i2c_query_ts_bootloader_info() {
        ...
        error =3D raydium_i2c_read(client, RM_CMD_BOOT_CHK, rbuf, sizeof(rb=
uf));
        if (error) {
                dev_err(&client->dev, "Read HWID command failed: %d (%4ph)\=
n",
                        error, rbuf + 1);
                hw_ver =3D 0xffffffffUL;
        } else {
                hw_ver =3D get_unaligned_be32(rbuf + 1);
        }
        ...
        return error;
}

By propagating this error, probe() will now fail and the device will unbind,
preventing the sysfs node from being created and blocking recovery. Should
the error code be cleared when falling back to the dummy hw_ver?

>  	else
> -		raydium_i2c_query_ts_info(ts);
> +		error =3D raydium_i2c_query_ts_info(ts);
> =20
>  	return error;
>  }

[Severity: High]
This is a pre-existing issue, but does the current driver state bypass the
intended fix of this patch?

Since RAYDIUM_TS_MAIN is 0, which is the default value of ts->boot_mode from
allocation, the retry loop in raydium_i2c_initialize() breaks on the very
first iteration:

raydium_i2c_initialize() {
        for (retry_cnt =3D 0; retry_cnt < RM_MAX_RETRIES; retry_cnt++) {
                ...
                if (ts->boot_mode =3D=3D RAYDIUM_TS_BLDR ||
                    ts->boot_mode =3D=3D RAYDIUM_TS_MAIN) {
                        break;
                }
        }
        ...
}

If the I2C bus is hung and returns all zeros, raydium_i2c_query_ts_info()
will also read 0s, set ts->pkg_size to 0, and return 0 (success). This
completely bypasses the new error propagation check, allowing probe() to
allocate a zero-sized pointer which can still crash the kernel in the IRQ
handler.

[Severity: Critical]
This isn't a bug introduced by this patch, but can a firmware update trigger
a panic due to a zero-sized pointer dereference?

If the device initially probes in bootloader mode, ts->pkg_size remains 0
and probe() allocates a zero-sized pointer for ts->report_data.

During a firmware update, when raydium_i2c_query_ts_info() is called to
switch to MAIN mode, it encounters this check:

raydium_i2c_query_ts_info() {
        ...
        if (ts->report_data && ts->pkg_size !=3D data_info.pkg_size) {
                dev_warn(&client->dev,
                         "report size changes, was: %d, new: %d\n",
                         ts->pkg_size, data_info.pkg_size);
        } else {
                ts->pkg_size =3D data_info.pkg_size;
                ts->report_size =3D ts->pkg_size - RM_PACKET_CRC_SIZE;
        }
        ...
}

Since the pointer is non-NULL (0x10), the condition evaluates to true. The
warning is logged, but ts->pkg_size is left as 0 and the buffer is never
reallocated. When the next touch fires raydium_i2c_irq(), it reads 0 bytes
and dereferences the zero-sized pointer.

[Severity: High]
This is a pre-existing issue, but does the driver validate the hardware
parameters read from the device?

In raydium_i2c_query_ts_info(), data_info.pkg_size and data_info.tp_info_si=
ze
are read directly from I2C.

If a faulty device returns a pkg_size less than 2, the subtraction
ts->pkg_size - RM_PACKET_CRC_SIZE underflows. If tp_info_size is 0,
ts->contact_size becomes 0.

Later in raydium_mt_event():

raydium_mt_event() {
        ...
        for (i =3D 0; i < ts->report_size / ts->contact_size; i++) {
                ...
        }
}

Could a 0 contact_size result in a division-by-zero panic here?

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for I2C
commands to be interleaved during calibration?

raydium_i2c_calibrate_store() initiates a multi-step sequence without
disabling interrupts:

raydium_i2c_calibrate_store() {
        ...
        scoped_guard(mutex_intr, &ts->sysfs_mutex) {
                error =3D raydium_i2c_write_object(client, cal_cmd, ...);
        ...
}

Since the IRQ handler does not acquire ts->sysfs_mutex, if a touch occurs
during this sequence, raydium_i2c_irq() can fire and send RM_CMD_BANK_SWITC=
H,
injecting unexpected commands into the hardware's calibration state machine.

[Severity: High]
This is a pre-existing issue, but does this driver pass stack-allocated mem=
ory
to the I2C core?

In raydium_i2c_read():

raydium_i2c_read() {
        struct raydium_bank_switch_header header =3D {
                .cmd =3D RM_CMD_BANK_SWITCH,
                .be_addr =3D cpu_to_be32(addr),
        };
        struct i2c_msg xfer[] =3D {
                {
                        .addr =3D client->addr,
                        .len =3D sizeof(header),
                        .buf =3D (u8 *)&header,
                },
        ...
}

If the underlying I2C master driver uses DMA, mapping these vmalloc virtual
addresses (when CONFIG_VMAP_STACK=3Dy) will result in a kernel panic. Should
these transfer buffers be heap-allocated instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728135127.4897=
1-1-meatuni001@gmail.com?part=3D1
