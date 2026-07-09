Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351F343F8D2
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622430; cv=none; b=Gp0DruRLfRxna6fTacP+ARXcEdaihHLvWd7z39C6YV9ZMNE2ozxLjpBVgtAtKo7fm4EROExhb7aQj/4JrPLS9potLm3I5GInIgWjKQrVRwHV2ost83Sa8+7HOp0oUjAdLpvtPlYXW0YkVh4WwEgtWjE4CS8Ue8/faRp+E2DMeCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622430; c=relaxed/simple;
	bh=v8rGsSryF4cLcfoqGN5fLf1xFqf5CRpxwwgFE+SpKAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MDjEbtU6OnJQwBk5Hjd0fqUvKYnTZzUwMQ8lYarcnXnhOk2X5/sZWund8gn7kTBCjfI9jmSZdFTEhZk0kisK927JC+wTOvYAxXD6MBK3e625sRGksYNDX7JWmoBXG7+T0wbA8d5euEVlee1yGTeeyPRPisZeHujysMbNQVMGYRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1fvmSHe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1fvmSHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B281F00A3A;
	Thu,  9 Jul 2026 18:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622428;
	bh=T5o106iicgiBJXIXp3d6oCzVCo4tc2m47m6sqHP4i84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g1fvmSHexv+GkiHJ6hZIeRnezIseDcrgE0nD9xH2WfTfS6HEZwz2BFJWQahydIHso
	 jn4BFErUgggddPWvLfU4OJDW57aCvt9JaKdaYXDiU4GQjoBx68udy/P+jbvYUHYNXO
	 nBouWKxF9/mK1U0LFIxX0N2VmluIbOC0w4+wWyWf1DhU/20++FADckhS+VwdVKTX0m
	 r3y816V6ASBUV+ulvvd5UOxOmVK+6VW/ITl+kR80peu7z1ciq08WWMXHtsn/2/enX9
	 qFMEuBjHUQIMpKOtwhI9khh4I/JlGs0GNDweq9VsCRCEYaZYuTYsz3JBjKg6yBL8TA
	 IHF2BGZazYHCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] Input: ilitek_ts: ratelimit unexpected report
 logging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kristian Mide" <kristian@mide.dk>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260709182602.7308-4-kristian@mide.dk>
References: <20260626214248.5563-1-kristian@mide.dk>
 <20260709182602.7308-1-kristian@mide.dk>
 <20260709182602.7308-4-kristian@mide.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:40:28 +0000
Message-Id: <20260709184028.83B281F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Medium] The patch fails to prevent dmesg spam because the caller logs an=
 un-ratelimited error for any negative return value.
- [Low] Direct bit manipulation is used to set single device capabilities i=
nstead of the standard helper function.

Pre-existing issues:
- [High] Unbalanced disable_irq() in suspend and resume error paths leaves =
the device interrupt permanently disabled.
- [High] Multi-touch data parsing accesses incorrect buffer offsets for rep=
orts with more than 10 active touch points, parsing garbage data.
- [High] Returning IRQ_NONE for a serviced hardware interrupt can cause the=
 kernel to permanently disable the IRQ line.
- [High] I2C transfer buffers are allocated on the stack, which can cause a=
rbitrary physical memory corruption when DMA is used with vmapped stacks.
--

--- Patch [3]: [PATCH v2 3/3] Input: ilitek_ts: ratelimit unexpected report=
 logging ---
commit bf03da99321dcdb2c6e97a5d9bbe75d687cccec8
Author: Kristian Mide <kristian@mide.dk>

Input: ilitek_ts: ratelimit unexpected report logging
   =20
Unexpected report IDs can repeat quickly when the controller
emits unknown packets.
   =20
Use dev_err_ratelimited() and include the first 16 bytes of the
raw packet to keep dmesg usable while preserving enough context
for debugging.

> diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/to=
uchscreen/ilitek_ts_i2c.c
> index 6146baa2b6062..e68bc052248ef 100644
> --- a/drivers/input/touchscreen/ilitek_ts_i2c.c
> +++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
> @@ -238,7 +238,9 @@ static int ilitek_process_and_report_v6(struct ilitek=
_ts_data *ts)
>  		return ilitek_process_pen_report(ts, buf);
> =20
>  	if (buf[0] !=3D ILITEK_TP_I2C_REPORT_ID) {
> -		dev_err(dev, "get touch info failed. Wrong id: 0x%02X\n", buf[0]);
> +		dev_err_ratelimited(dev,
> +				    "get touch info failed. Wrong id: 0x%02X raw[0:16]=3D%*ph\n",
> +				    buf[0], 16, buf);
>  		return -EINVAL;
>  	}

[Severity: Medium]
Does this actually prevent dmesg spam?  The caller ilitek_i2c_isr() observes
the -EINVAL return value and unconditionally logs an un-ratelimited error
for any negative return value:

drivers/input/touchscreen/ilitek_ts_i2c.c:ilitek_i2c_isr() {
    ...
    error =3D ilitek_process_and_report_v6(ts);
    if (error < 0) {
        dev_err(&ts->client->dev, "[%s] err:%d\n", __func__, error);
        return IRQ_NONE;
    }
    ...
}

[Severity: High]
This is a pre-existing issue, but returning IRQ_NONE from ilitek_i2c_isr()
after successfully executing I2C reads and clearing the hardware interrupt
can trigger the kernel's spurious interrupt detector.

If the hardware emits a stream of unexpected report IDs, will repeatedly
returning IRQ_NONE permanently disable the IRQ line?

[Severity: High]
This is a pre-existing issue, but does ilitek_process_and_report_v6()
incorrectly parse multi-touch data for reports with more than 10 active
touch points?

For 11+ points, the data is split into multiple 64-byte reads, but the loop
calculates a linear byte offset that completely disregards the 64-byte chunk
boundaries:

drivers/input/touchscreen/ilitek_ts_i2c.c:ilitek_process_and_report_v6() {
    ...
    for (i =3D 0; i < report_max_point; i++) {
        status =3D buf[i * packet_len + 1] & 0x40;
    ...
}

For the 11th point (index 10), this offset calculation (10 * 5 + 1 =3D 51)
reads from the padding of the first 64-byte chunk instead of advancing to
the next chunk.  Does this result in parsing garbage data?

[Severity: High]
This is a pre-existing issue, but does allocating I2C transfer buffers on t=
he
stack cause arbitrary physical memory corruption when DMA is used?

drivers/input/touchscreen/ilitek_ts_i2c.c:ilitek_process_and_report_v6() {
    ...
    u8 buf[512];
    ...
    error =3D ilitek_i2c_write_and_read(ts, NULL, 0, 0, buf, 64);
    ...
}

If CONFIG_VMAP_STACK is enabled, the stack may not be physically contiguous.
Can a DMA transfer crossing a physical page boundary silently overwrite
unrelated physical memory?  (This also happens in ilitek_read_tp_info()
with a 256-byte stack buffer).

[Severity: Low]
Does ilitek_pen_input_dev_init() use direct bit manipulation to set single
device capabilities instead of the standard input_set_capability() helper?

drivers/input/touchscreen/ilitek_ts_i2c.c:ilitek_pen_input_dev_init() {
    ...
    __set_bit(INPUT_PROP_DIRECT, pen_input->propbit);
    __set_bit(EV_KEY, pen_input->evbit);
    __set_bit(EV_ABS, pen_input->evbit);
    ...
}

[Severity: High]
This is a pre-existing issue, but do the suspend and resume error paths lea=
ve
the device interrupt permanently disabled?

drivers/input/touchscreen/ilitek_ts_i2c.c:ilitek_suspend() {
    ...
    disable_irq(client->irq);

    if (!device_may_wakeup(dev)) {
        error =3D api_protocol_set_cmd(ts, SET_IC_SLEEP, NULL, NULL);
        if (error)
            return error;
    }
    ...
}

If api_protocol_set_cmd() fails, it bails out before enable_irq() can be
called to balance the disable_irq().  A similar issue exists in
ilitek_resume().  Does a failure during suspend/resume permanently kill
touchscreen functionality?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709182602.7308=
-1-kristian@mide.dk?part=3D3
