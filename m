Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D33334F259
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782510969; cv=none; b=qnaTLYUyeX07YzyzvQAgdF/v8e4Lfw+obnvl/DqVDQukVFLcEMi2FU5ISyP9RS7Svwg2ZiheXgA7IUUfPjWhbqDsCjLR9IZ7nQ4MCikJKf82lClfyJrtqA738kygsW5QegrJjCCIEMLK9D5oJic2UVtq2eqkk0rXq0iue2jkLFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782510969; c=relaxed/simple;
	bh=ozU9pyJO5ypb4Ofh+Ym7BkNEkPH8iEd/UCmcyHaAFbc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ay6umXCmT/Y//9M/kkR8giOWvBF0e1HRpRK2ct1OP1Up7y+mTS3Rj3Lqee+hqxaRLOG5o0U5WA+sU1M5o4pnwpVbB2FHW2V+05UZONvvPrZ2QBF+JpHD6OSeb9PwGZ4QYCi+UOb9y6Y/wq8cOl3Jf6vYlOTw5GujJ7m0muKm0qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKFt26ov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKFt26ov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0037E1F000E9;
	Fri, 26 Jun 2026 21:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782510968;
	bh=qSTh+rEXcViTJRAPk+/2S/+9Pyo+48iROgA3DGx9Zvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AKFt26ovx0VLknNyAA3vzrA281AKRXtmLO0clkeL7+STZLQaOV8Y6Kbw0sUiNBJt9
	 QWfbKdqh0rh8ss6wgWa7pLMn6eiQK7elRClU9nQzVBDOwulV7SLrvl3IRGVIJGc+M1
	 slICon2q0+kQ0Nm/0VE1oiHmuZaK0PC45Ylkv8DTMq6Cxuq5z7K/7HMVSdbDPtBDWp
	 tFBo9v2cJyy194s+ywNeX8kPksU8pT53QOmpu+HEy+fpRtIMZrj+UV0yU/URT6340g
	 mwJMMM2nzA/m3fBWIekEdbN/e8RIRYA1eU0MJVLFp5/K6D3dmv3ddZJVyg7KzLxU+h
	 KyN/3zjUdh4lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Input: ilitek_ts: ratelimit unexpected report
 logging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kristian Mide" <kristian@mide.dk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260626214248.5563-3-kristian@mide.dk>
References: <20260626214248.5563-1-kristian@mide.dk>
 <20260626214248.5563-3-kristian@mide.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 21:56:07 +0000
Message-Id: <20260626215608.0037E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The I2C read/write wrapper does not properly check for short trans=
fers, and this patch leaks the resulting uninitialized stack memory to dmes=
g.

Pre-existing issues:
- [High] The patch fails to prevent dmesg flooding and causes the interrupt=
 handler to incorrectly signal a spurious interrupt, which can permanently =
disable the touchscreen.
- [High] Dynamically adding a devres action in a threaded IRQ handler creat=
es an inverted teardown order during device unbind, leading to a memory lea=
k and Use-After-Free.
- [High] If the I2C sleep command fails during suspend, the function return=
s an error without re-enabling the IRQ, rendering the touchscreen permanent=
ly unresponsive.
- [High] The driver passes stack-allocated arrays to i2c_transfer(), violat=
ing DMA mapping rules and risking memory corruption.
--

commit ec332d9cd1c7923c04e4eec0684513387a92348d
Author: Kristian Mide <kristian@mide.dk>

Input: ilitek_ts: ratelimit unexpected report logging

Unexpected report IDs can repeat quickly when the controller emits unknown
packets. This commit uses dev_err_ratelimited() and includes the first 16
bytes of the raw packet for context.

> diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/to=
uchscreen/ilitek_ts_i2c.c
> index f0721af02adf2..8886bd39bc0b6 100644
> --- a/drivers/input/touchscreen/ilitek_ts_i2c.c
> +++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
> @@ -241,7 +241,9 @@ static int ilitek_process_and_report_v6(struct ilitek=
_ts_data *ts)

[Severity: High]
This is a pre-existing issue, but does ilitek_process_and_report_v6() pass a
stack-allocated array to i2c_transfer()?

drivers/input/touchscreen/ilitek_ts_i2c.c:ilitek_process_and_report_v6() {
    ...
    u8 buf[512];
    ...
    error =3D ilitek_i2c_write_and_read(ts, NULL, 0, 0, buf, 64);

If the underlying I2C host controller driver maps the buffer for DMA, it mi=
ght
attempt to map a stack address. On modern kernels where VMAP_STACK is enabl=
ed,
can this cause an immediate panic because stack memory is not physically
contiguous, or lead to cacheline sharing corruption otherwise?

>  		return ilitek_process_pen_report(ts, buf);

[Severity: High]
This is a pre-existing issue, but does dynamically adding a devres action
in the threaded IRQ handler create an inverted teardown order?

The IRQ is registered via devm_request_threaded_irq() in probe. Later, the
ISR dynamically calls devm_add_action_or_reset() to register the pen cleanu=
p:

drivers/input/touchscreen/ilitek_ts_i2c.c:ilitek_process_pen_report() {
    ...
    if (!input) {
        error =3D ilitek_pen_input_dev_init(dev, ts);

which calls devm_add_action_or_reset(dev, ilitek_unregister_pen_input, ts).

Because devm is a LIFO stack, the pen cleanup is placed above the IRQ relea=
se
action. During device unbind, devres_release_all() will run the pen cleanup
first, freeing the device, while the IRQ remains active. If an interrupt fi=
res
before the IRQ is finally freed, could the ISR access the freed device and
cause a use-after-free, or attempt to append a new devres action while the
stack is being torn down?

> =20
>  	if (buf[0] !=3D ILITEK_TP_I2C_REPORT_ID) {
> -		dev_err(dev, "get touch info failed. Wrong id: 0x%02X\n", buf[0]);
> +		dev_err_ratelimited(dev,
> +				    "get touch info failed. Wrong id: 0x%02X raw[0:16]=3D%*ph\n",
> +				    buf[0], 16, buf);

[Severity: High]
Does this new logging leak uninitialized kernel stack memory to dmesg?

Looking at ilitek_i2c_write_and_read(), it checks if error < 0, but
i2c_transfer() returns the number of successfully transferred messages:

drivers/input/touchscreen/ilitek_ts_i2c.c:ilitek_i2c_write_and_read() {
    ...
    error =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
    if (error < 0)
        return error;

If a short transfer occurs, this evaluates to false, so the wrapper returns=
 0
(success) despite the read buffer not being populated. When that happens,
won't this new log message directly print 16 bytes of uninitialized kernel
stack memory to the dmesg buffer?

>  		return -EINVAL;

[Severity: High]
This is a pre-existing issue, but does returning -EINVAL here cause the
interrupt handler to incorrectly signal a spurious interrupt?

When an unknown packet is received, ilitek_process_and_report_v6() returns
-EINVAL to the ISR, which then handles the error like this:

drivers/input/touchscreen/ilitek_ts_i2c.c:ilitek_i2c_isr() {
    ...
    error =3D ilitek_process_and_report_v6(ts);
    if (error < 0) {
        dev_err(&ts->client->dev, "[%s] err:%d\n", __func__, error);
        return IRQ_NONE;
    }

First, the ISR unconditionally logs the error, which defeats the ratelimiti=
ng
added in this patch. Second, could repeatedly returning IRQ_NONE when the
hardware interrupt was actually serviced (cleared by the I2C read) cause the
kernel's spurious interrupt detection to eventually disable the IRQ line
permanently?

>  	}
> =20

[ ... ]

[Severity: High]
This is a pre-existing issue, but does ilitek_suspend() return an error
without re-enabling the previously disabled IRQ?

drivers/input/touchscreen/ilitek_ts_i2c.c:ilitek_suspend() {
    ...
    disable_irq(client->irq);

    if (!device_may_wakeup(dev)) {
        error =3D api_protocol_set_cmd(ts, SET_IC_SLEEP, NULL, NULL);
        if (error)
            return error;
    }

If the I2C sleep command fails during suspend, the function returns an error
while the device IRQ is disabled. The PM core will abort the suspend
transition and resume previously suspended devices, but it will not call the
resume callback for the device that returned the error. Could this render t=
he
touchscreen permanently unresponsive until reboot or module reload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626214248.5563=
-1-kristian@mide.dk?part=3D2
