Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559313B8139
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 06:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220567; cv=none; b=tqmFjZf9Jpoazh0z23ac/IGZNuiK5dknAGFAJEikur+kEM5kUnsuhXVTlQLbg23QvwZd84E00bR2taP3QAMvgmdtHe3Qg3sVz1oL/lQHswNtE8f5gdkgcBYTSedbSqSZ5L/RS1o05jkG8mQeyiezMRoDap962qFhGsfh1w4q3dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220567; c=relaxed/simple;
	bh=EPTVSEx4nv4q3PQ5aUN1IBEGPBArwTFizIcmktrdmgY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YTBpNmSA+df4VJ7q87FnXly5otWggB5Vu2bLC0E6c09IMX4f5Ks2YVt5J31mEXJIWN2Y+P311cANHSQSNIGP4PGHBPA/rtEJqrDqcpfYkWQS1K+7tseAeACXksQ5zExZgqULbnnCvzLAQU2zF8D03V0G0d7RAg5763r/jtDmyq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2otLy8K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2otLy8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15311F000E9;
	Tue, 28 Jul 2026 06:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785220564;
	bh=wWiZx8idQPlLp7PSjN3xbM8Mk4QtsDvide6umonWGxQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N2otLy8KUQ3vMQ4j8DZTco5a2BwU6yrWOxxu2ZO3pHif4zluogIHa4fDSmhJcK6TD
	 QNdL+GxZhbAp8+4Hrod61lZ9BOfhix6bofQFnErCX4/TNM08I/H3BJd4HPs+b9eUNG
	 ERXkQlufMamk+sDLgkqDloJ2mMigWlzXnMyk0mfvFMKolThbdPU3QiFPpaZoWSTcTM
	 ehf2MY4yWzLm8mzJ7Q/kfMTBn93leS/FlNep/1qM5DbKXgnzzuNFjeNNWRENM4LI0F
	 NOjxdEiXPws/GwPKbeiTzJauFNZUe9o8KMtfZ5gjFn2IfqAGfkVIRfnVSffAdlW9r6
	 ZLMUh05cGGiqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: mcp2221: stop device IO before hid_hw_stop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiangshan Yi" <yijiangshan@kylinos.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260728061919.310367-1-yijiangshan@kylinos.cn>
References: <20260728061919.310367-1-yijiangshan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 06:36:03 +0000
Message-Id: <20260728063604.A15311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Unconditional call to `hid_device_io_stop()` causes spurious "io=
 already stopped" kernel warnings on normal device removal.

Pre-existing issues:
- [High] The driver leaves `mcp->rxbuf` pointing to freed memory after an I=
2C/SMBus transfer completes or times out, leading to a write use-after-free=
 on spurious USB reports.
- [High] The `mcp2221_raw_event` function fails to validate the `size` para=
meter of incoming HID reports, causing an out-of-bounds read and kernel inf=
ormation leak.
--

--- Patch [1]: [PATCH] HID: mcp2221: stop device IO before hid_hw_stop ---
commit 17aa5ce1c914b6c625bef7c6ef52e3e63205f24d
Author: Jiangshan Yi <yijiangshan@kylinos.cn>

HID: mcp2221: stop device IO before hid_hw_stop
   =20
This commit adds a call to hid_device_io_stop() at the start of the devm
cleanup callback mcp2221_hid_unregister(). This ensures device IO is
quiesced before the hardware is stopped, addressing a potential
use-after-free during probe failure or device removal.

> diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> index e4ddd8e9293b6..83857ec1d61ca 100644
> --- a/drivers/hid/hid-mcp2221.c
> +++ b/drivers/hid/hid-mcp2221.c
> @@ -1049,6 +1049,7 @@ static void mcp2221_hid_unregister(void *ptr)
>  {
>  	struct hid_device *hdev =3D ptr;
> =20
> +	hid_device_io_stop(hdev);
[Severity: Medium]
Will this unconditional call trigger a spurious "io already stopped" kernel
warning on normal device removal?

During normal device removal, hid_device_remove() sets hdev->io_started =3D=
 false
before tearing down the devres group. When devres subsequently invokes
mcp2221_hid_unregister(), hid_device_io_stop() will hit the !io_started
condition and print a dev_warn.

>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);
>  }

[Severity: High]
This is a pre-existing issue, but does this driver leave mcp->rxbuf pointing
to freed memory if an I2C/SMBus transfer times out?

In drivers/hid/hid-mcp2221.c:mcp_i2c_smbus_read(), the buffer pointer is se=
t:

    mcp->rxbuf =3D smbus_buf;
    mcp->rxbuf_size =3D smbus_len;

If the transfer times out, the function returns without clearing mcp->rxbuf.
The caller may then free or pop the buffer. If a delayed or spurious report
later arrives, mcp2221_raw_event() will blindly copy data into the stale
pointer:

    buf =3D mcp->rxbuf;
    memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);

Can a malicious or slow USB device send a delayed MCP2221_I2C_GET_DATA pack=
et
and cause a write use-after-free here?


[Severity: High]
This is a pre-existing issue, but does mcp2221_raw_event() fail to validate
the size of incoming HID reports?

When processing raw USB input reports, the function trusts data[3] for the
copy length without validating it against the actual received report size:

    buf =3D mcp->rxbuf;
    memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);

If a malicious USB device sends a short report (e.g., 4 bytes) but specifies
a payload length of 60 in data[3], will this cause an out-of-bounds read
from the HID core's transfer_buffer and leak uninitialized memory to
userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728061919.3103=
67-1-yijiangshan@kylinos.cn?part=3D1
