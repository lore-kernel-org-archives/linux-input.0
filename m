Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0203478E4A
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037127; cv=none; b=dACJ9MYSnKWiv/f9suc98/vyO6DaCm6eGXtATcDSxpG0Jp4g2XZDpTdyril91vmKQS7n0hT5AYzXm0u6sI9pcv9iseM1lde4ONqo5WtkTAKXhBQE6TC81YwlC5uvTXfj7dAIDe0p2l2qCieWscntPsudxvyw4zvxw6JaDa5CZbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037127; c=relaxed/simple;
	bh=ZJSvVDoOxYQLVlIxCGhS4xOY+TPLAuyEd5Dv9iXJr/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HSXjXZBIKXcDrfyZFJ7KuM9HnzvuWhk2Ro0v3NFcaJV5yK6hLLJJrcwEsg8hyWOcV8ZDJVvfIjf5867pqmVEnHcBEX0Y4O3kfOrtL55sNiGaStl4tEMkcXLu+8Snq4wUqrYt06/0Lfv515gDbVIpAZfbGmEroH6AG0fx7TeW/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLBruBYt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLBruBYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433161F00A3D;
	Tue, 14 Jul 2026 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037125;
	bh=dloDVjoPhbEeACoZK8dOgu+vSJbPHzF3dp8mVEmQH14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SLBruBYtK2MrdXlcrzeoWs9pNQigc45BaiWb9rUzxzusTeWEd26fz0lJoawQL9+70
	 YhCqTDCgAwy8tk9To+j0hg9WSb7EV4s1dBoyrr3z/hsY/8iB/5Owv9+2KzUoW7O948
	 DAanUEZ+m4Pv6GIrk9i+zmkiSygBrb9inBJEoKP8eff4LGO0izJ3fW+VU/ZgB18wAu
	 AveocTTazEDNOPdfgrTt2W56x5LuYL2qDkXXZyySVlVkyH/auzXuQylsVIS9riYz8q
	 tJkrbzjyc2rtNFiw8liEAQeQGzvPGJa8DWOtz04LtYiDj2yrEpj3yDvmoY4SEd9EIx
	 S/F/mGs1UfppA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] HID: mcp2221: fix out-of-bounds read in
 mcp2221_raw_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiale Yao" <yaojiale02@163.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260714131611.269929-3-yaojiale02@163.com>
References: <20260714131611.269929-1-yaojiale02@163.com>
 <20260714131611.269929-3-yaojiale02@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 13:52:04 +0000
Message-Id: <20260714135205.433161F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Stale mcp->rxbuf pointer leads to Use-After-Free or Stack Buff=
er Overflow when receiving delayed MCP2221_I2C_GET_DATA input reports.
- [High] An out-of-bounds read occurs in mcp2221_raw_event due to uninitial=
ized or shared mcp->gp_idx state.
- [High] Shared transfer state variables such as mcp->rxbuf_idx are modifie=
d concurrently by process context and the HID raw event handler without loc=
king.
- [High] The `retries` counter in `mcp_init_work` is declared as a `static =
int`, leading to data races and logic bugs when multiple mcp2221 devices ar=
e probed or a single device is replugged.
--

--- Patch [3]: [PATCH 3/4] HID: mcp2221: fix out-of-bounds read in mcp2221_=
raw_event ---
commit 8bc8521d47c1c74b70fcc5afb281169b37669d79
Author: Jiale Yao <yaojiale02@163.com>

HID: mcp2221: fix out-of-bounds read in mcp2221_raw_event

This commit adds bounds checking to the mcp2221_raw_event handler to
prevent out-of-bounds reads when processing HID reports. It introduces a
top-level size check and specific size constraints for different I2C and
GPIO operations.

> diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> index e4ddd8e9293b6..0423b5affe8f6 100644
> --- a/drivers/hid/hid-mcp2221.c
> +++ b/drivers/hid/hid-mcp2221.c
[ ... ]
> @@ -918,7 +931,8 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>  			}
>  			if (data[2] =3D=3D MCP2221_I2C_READ_COMPL ||
>  			    data[2] =3D=3D MCP2221_I2C_READ_PARTIAL) {
> -				if (!mcp->rxbuf || mcp->rxbuf_idx < 0 || data[3] > 60) {
> +				if (!mcp->rxbuf || mcp->rxbuf_idx < 0 ||
> +				    data[3] > 60 || size < 4 + data[3]) {
>  					mcp->status =3D -EINVAL;
>  					break;
>  				}

[Severity: Critical]
This is a pre-existing issue, but does this code write to a dangling
stack pointer if a delayed input report arrives?

Looking at mcp_i2c_smbus_read(), mcp->rxbuf is pointed to a local stack
buffer. If the I2C request times out after 5 retries, mcp_i2c_smbus_read()
returns without clearing mcp->rxbuf:

mcp_i2c_smbus_read() {
    ...
    retries++;
    if (retries =3D=3D 5)
        return -ETIMEDOUT;
    ...
}

Could a malicious USB device send a delayed MCP2221_I2C_GET_DATA report
after the timeout, causing mcp2221_raw_event() to locklessly copy up to
60 bytes into the now-freed stack frame?

[Severity: High]
This is also a pre-existing issue, but is it safe to modify mcp->rxbuf_idx
here without a lock?

The I2C process thread holds mcp->lock while initializing mcp->rxbuf_idx
in mcp_i2c_smbus_read():

mcp_i2c_smbus_read() {
    ...
    mcp->rxbuf_idx =3D 0;
    ...
}

However, mcp2221_raw_event() runs asynchronously in softirq context. Can a
spurious input report race with the process-context operations, corrupting
the buffer bounds or indices?

[ ... ]
> @@ -958,6 +974,8 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>  		break;
> =20
>  	case MCP2221_GPIO_SET:
> +		if (size < sizeof(struct mcp_set_gpio))
> +			return 1;
>  		switch (data[1]) {
>  		case MCP2221_SUCCESS:
>  			if ((data[mcp->gp_idx] =3D=3D MCP2221_ALT_F_NOT_GPIOV) ||

[Severity: High]
This is a pre-existing issue, but does this code perform an out-of-bounds
access if a device sends an unsolicited report before any GPIO operations
occur?

If mcp->gp_idx is still 0, evaluating data[mcp->gp_idx - 1] in the
MCP2221_GPIO_SET handler will read from data[-1].

Similarly, if mcp->gp_idx is legitimately set to a high value like 17,
could an unsolicited MCP2221_GPIO_GET report with a valid size of 10
access data[18], reading past the bounds of the short packet? The newly
added check for the overall packet size does not prevent this since it
doesn't validate the independently modified mcp->gp_idx.

[ ... ]

[Severity: High]
This is a pre-existing issue outside the modified hunks, but is the
retries counter in mcp_init_work() susceptible to data races across
multiple devices?

mcp_init_work() defines retries as a static variable:

mcp_init_work() {
    static int retries =3D 5;
    ...
    if (!retries--)
        return;
    ...
    schedule_delayed_work(&mcp->init_work, msecs_to_jiffies(100));
}

If a device fails IIO initialization multiple times, the static counter
drops to -1. Once negative, !retries-- evaluates to false, causing an
infinite rescheduling loop for any subsequent devices or replugs that
fail. Should this retry state be tracked per-device in the mcp2221
struct instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714131611.2699=
29-1-yaojiale02@163.com?part=3D3
