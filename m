Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3B3C9EE6;
	Thu, 10 Sep 2026 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024916; cv=none; b=hfqAZlV1IqxMNqw3HPAc7deXppVDyAbVuxtK1IqRWYeAmyqb8SojZt7NB8TZKbHnFyJ/KyXpKIfcbeAMNXGh1/sKZpOhAtTq2tAGQwL69mWna14oVib6pcsCeGA5oxCpsqE18VKbkaK3qY1EHGxhhoRsQMwuMgtH0GrWbUPszuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024916; c=relaxed/simple;
	bh=KZ0hEC+zv967NQsfkjk/YZfF3/ZOVmYL7yTUX3XklRc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W4NQrt8PrWOJSb7mjp89G9vEMkJ/y20X0giacWwB7fdPeniW08rGMTRkzEhTT3TUnx6KQ9RkboDx/x1+dzBOTh260LWzesgvvI3F0YvcgSVnbJ0PAa71Ek35n/rjta8A6UHLbNkdCMt1OlITbxKcf60dNig7rEzNlGjuoBm7hic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbsWI8Fd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbsWI8Fd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7A01F000FF;
	Thu, 10 Sep 2026 07:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789024913;
	bh=lLSKD68l5K3AErOP8cqmW/q4vfjWa9jjrb6AT9oMAZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NbsWI8FdiGdQ+UjM5uqM/y88ivIub37ThZoCRiD4U69fYY1ke6wNRSCK3E3JuFotb
	 /RCJUATr2i9AhxlXDl7X8yuDxE//UYEo2Jc1g13Sl/ifZIgj64l6h/XXIMfyZkcJNg
	 BdSrMX3pY2L35oPi9Hr+y174RzrP7sHAJPIhHSv20KXngz0VdpMecC1gewW2yDz/m8
	 HwrnLXwOtYH7uS1+L7EpjHYsBpH5uCmMQjbKowCovFb6cEWa8SMEeje+7g8bm8VUTt
	 gX6egDZk9a/p6AuhgLlrEH2X6SWZWhbiZCZoJPsE4b1PoM/VBQh4YmQ45klOwp6Ily
	 zHi3tUKKpv8jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Input: synaptics_tcm_i2c - add Synaptics TouchComm
 I2C touchscreen driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vsevolod Nevorotov" <sevanevorotov29@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260910070723.347768-3-sevanevorotov29@gmail.com>
References: <20260910070723.347768-1-sevanevorotov29@gmail.com>
 <20260910070723.347768-3-sevanevorotov29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 07:21:52 +0000
Message-Id: <20260910072153.0D7A01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Flawed chunking logic in `syna_recv_message()` fails to consume th=
e entire I2C message for perfectly aligned payloads and uses incorrect read=
 lengths for non-last chunks.
- [High] Missing upper bound on active object count enables a CPU-spinning =
infinite loop DoS and an out-of-bounds heap read via integer overflow.
- [Medium] Unbalanced regulator disable during device teardown if hardware =
recovery fails in resume.
--

commit 2e193cb965d6a8f43ae428d7f72355547d149239
Author: Vsevolod Nevorotov <sevanevorotov29@gmail.com>

Input: synaptics_tcm_i2c - add Synaptics TouchComm I2C touchscreen driver
   =20
This commit adds an input touchscreen driver for Synaptics TouchComm=20
generation-1 controllers connected over I2C. It supports multi-touch,=20
configurable touch report layouts, low-power wakeup gestures, and deep slee=
p=20
mode during system suspend.

> diff --git a/drivers/input/touchscreen/synaptics_tcm_i2c.c b/drivers/inpu=
t/touchscreen/synaptics_tcm_i2c.c
> new file mode 100644
> index 0000000000000..2553dabd39258
> --- /dev/null
> +++ b/drivers/input/touchscreen/synaptics_tcm_i2c.c
[ ... ]
> @@ -0,0 +1,1033 @@
[ ... ]
> +static int syna_recv_message(struct syna_tcm *ts)
> +{
[ ... ]
> +	/*
> +	 * Continued read: the rest arrives in chunks that repeat the marker and
> +	 * carry code 0x03, so only SYNA_RD_CHUNK_SIZE - 2 bytes of each one are
> +	 * payload. The trailing padding byte (0x5a) is read and verified in the
> +	 * final chunk.
> +	 */
> +	remaining =3D ts->payload_len - copied;
> +	while (remaining) {

[Severity: High]
If ts->payload_len is exactly 60 bytes, copied is 60 and remaining evaluates
to 0. Does this cause the loop to terminate prematurely and fail to read the
final chunk containing the required 0x5a padding byte?=20

This could leave unread bytes in the device's TX buffer, desynchronizing the
I2C protocol and causing subsequent reads to retrieve stale bytes.

> +		bool last =3D (remaining <=3D SYNA_RD_CHUNK_SIZE - 3);
> +		unsigned int chunk =3D last ? remaining :
> +					    min(remaining - 1,
> +						(unsigned int)(SYNA_RD_CHUNK_SIZE - 3));
> +		unsigned int read_len =3D chunk + 2 + (last ? 1 : 0);

[Severity: High]
Does this logic compute incorrect read lengths for non-last chunks? It appe=
ars
to cap chunk at 61 bytes (SYNA_RD_CHUNK_SIZE - 3). This results in a read_l=
en
of 63 bytes (61 + 2 + 0) rather than the expected 64-byte chunk limit.

[ ... ]
> +/* Extract a big field of @bits from the report's bit stream at @offset.=
 */
> +static u32 syna_get_bits(const u8 *buf, unsigned int buf_len,
> +			 unsigned int offset, unsigned int bits)
> +{
> +	unsigned int byte =3D offset / 8;
> +	unsigned int bit =3D offset % 8;
> +	unsigned int done =3D 0;
> +	u32 out =3D 0;
> +
> +	if (!bits || bits > 32 || offset + bits > buf_len * 8)
> +		return 0;

[Severity: High]
Is it possible for offset + bits to overflow a 32-bit integer here? If offs=
et
grows large enough, the overflow could bypass this bounds check and cause an
out-of-bounds heap read using the calculated byte index.

[ ... ]
> +static int syna_parse_touch_report(struct syna_tcm *ts)
> +{
[ ... ]
> +		case SYNA_TOUCH_FOREACH_END:
> +			if (!active_only) {
> +				if (++obj < ts->max_objects)
> +					idx =3D loop_start;
> +			} else if (have_active_count) {
> +				if (++seen < active)
> +					idx =3D loop_start;
> +			} else if (++seen < ts->max_objects &&

[Severity: High]
Since active acts as the loop bound here, a massive unvalidated value could
lock up the CPU in an IRQ handler, continuously incrementing offset until t=
he
integer overflow in syna_get_bits() triggers the out-of-bounds memory read.

[ ... ]
> +		case SYNA_TOUCH_NUM_OF_ACTIVE_OBJECTS:
> +			active =3D data;
> +			have_active_count =3D true;
> +			if (!active)
> +				done =3D true;
> +			break;

[Severity: High]
The active variable receives a value directly from the hardware payload wit=
hout
validation. If a faulty or malicious device provides a huge value, could th=
is
lead to an unbounded loop in syna_parse_touch_report()?

[ ... ]
> +static int syna_reinit_hw(struct syna_tcm *ts)
> +{
> +	struct device *dev =3D &ts->client->dev;
> +	u8 report =3D SYNA_REPORT_TOUCH;
> +	int ret;
> +
> +	syna_power_down(ts);
> +	ret =3D syna_power_up(ts);
> +	if (ret)
> +		return ret;

[Severity: Medium]
If syna_power_up() fails, the regulators are left disabled.

[ ... ]
> +static int syna_resume(struct device *dev)
> +{
[ ... ]
> +		/* Wake up controller from deep sleep */
> +		ret =3D syna_exec_command(ts, SYNA_CMD_EXIT_DEEP_SLEEP, NULL, 0);
> +		if (ret) {
> +			dev_warn(dev, "failed to exit deep sleep (%d), recovering...\n", ret);
> +			ret =3D syna_reinit_hw(ts);
> +			if (ret)
> +				dev_err(dev, "failed to recover controller: %d\n", ret);
> +		}
> +
> +		ts->suspended =3D false;
> +		enable_irq(client->irq);

[Severity: Medium]
Does this swallow the error if syna_reinit_hw() fails? The error is logged,
but the function returns 0 and leaves the device bound.=20

Since syna_power_up() failed earlier in the recovery path, the regulators a=
re
left disabled. When the device is eventually unbound and devres triggers
syna_power_down(), will this result in an unbalanced regulator disable and a
kernel warning?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910070723.3477=
68-1-sevanevorotov29@gmail.com?part=3D2
