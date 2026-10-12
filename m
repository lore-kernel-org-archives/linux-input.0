Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBF24DE711
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836616; cv=none; b=tNvqmgomPeQJ05P7L3B+8B5yajIaYTmXyPBwhowtlNk2ucmIrdKqRb8lkWJTnhgcLNPs5CbhKLqdUJ8qYiSEDoRtgiwMIx9mJthuEKKvqWrbhqG6GGMMEgX+e1Jut6MOqZHZbwIoqjDAxmkTdtVQSRrpDzL+jkPz0OAdgcbSVOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836616; c=relaxed/simple;
	bh=trdPJMVgieyTw6RVfJDzvsbK1F6fvCa2QjshG3+Iyok=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=s8s674HaRgt8Q2iC1rP4Tvdc+p277E8ziHtItxHFrAazWKdqUvOi1Sn/5mEuaV5+fsSW7IAfXCG8IDPDhoQGpOsUMoYGREgX9dnTKEFvu5K5axOOUzB9upTh98XXKvm+h6KHRBa7oh2066KHjjAxyc+FR5c0t864U36fMB/p/Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b08sWv4J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b08sWv4J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6681F0089B;
	Mon, 12 Oct 2026 20:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791836614;
	bh=2lFFBZ0fjua83DlzoSZ+L/QfmnrxRSqVIlKkXw4H8Bg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b08sWv4Jt9JPOIl1YMxGfH0EcYnLtqHC1E2rGr4FzSPtUBPSTOIBMqwhvhLG7oAh6
	 1Id7mBL13gWIQXDg1acEwujxHmrISwKiEE7oBbLBa42nZb1vADLLoJCr9fqMepV+ro
	 40WTUfFn2w9z0ZL87cCENj68sKd5ajK2VFOSux8ntWk/ViAF+HfgrcIRS/ZcA94zMN
	 GMprqYcuVB86x6UD7lEh2fxuP7FvPdn5EBZEjrn4hFAL2TSz+4TwoK4jHaFfLvizf1
	 qCO6Rq6rzrJI5AeTYFT3sMnAqYPQnYW7qyRCoC4+fDwVfqJn1CzfHQDEJhqLIhLZ/B
	 rgkpYOF+m8Rfw==
Message-ID: <sashiko-outbox-168592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] HID: UNCTRL: add basic battery reporting for UNCTRL
 RAGE Mouse
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bishwa Bhusan Saha" <contact@bishwasaha.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261013-b4-unctrl-m1-battery-v1-2-4a50203b7177@bishwasaha.com>
References: <20261013-b4-unctrl-m1-battery-v1-0-4a50203b7177@bishwasaha.com>
 <20261013-b4-unctrl-m1-battery-v1-2-4a50203b7177@bishwasaha.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 20:23:33 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] hid: unctrl: initial battery query response may be dropped in probe
--

commit 6b35740bb80be8312a87135a9844c03a48dc1cca
Author: Bishwa Bhusan Saha <contact@bishwasaha.com>

HID: UNCTRL: add basic battery reporting for UNCTRL RAGE Mouse

This commit adds basic battery reporting for the UNCTRL RAGE Wireless Mouse
over both 2.4 GHz and wired connections. It queries the battery once during
device probe by sending an output report to the hardware.

> diff --git a/drivers/hid/hid-unctrl-m1.c b/drivers/hid/hid-unctrl-m1.c
> new file mode 100644
> index 0000000000000..59259dee7e429
> --- /dev/null
> +++ b/drivers/hid/hid-unctrl-m1.c
[ ... ]
> +static void unctrl_fetch_battery(struct hid_device *hdev)
> +{
> +	u8 *write_buf;
> +	int ret;
> +
> +	/* buf[0] is the report number, and hid_hw_output_report() sends the
> +	 * buffer verbatim.
> +	 */
> +	write_buf =3D kmemdup(unctrl_battery_query, sizeof(unctrl_battery_query=
),
> +			    GFP_KERNEL);
> +	if (!write_buf)
> +		return;
> +
> +	ret =3D hid_hw_output_report(hdev, write_buf,
> +				   sizeof(unctrl_battery_query));
[ ... ]
> +static int unctrl_probe(struct hid_device *hdev, const struct hid_device=
_id *id)
> +{
[ ... ]
> +	/* usbhid polls the interrupt in endpoint only while it is open */
> +	ret =3D hid_hw_open(hdev);
> +	if (ret) {
> +		hid_err(hdev, "%s:open failed with error %d\n", __func__, ret);
> +		hid_hw_stop(hdev);
> +		kfree(dev);
> +		return ret;
> +	}
> +
> +	hid_set_drvdata(hdev, dev);
> +
> +	ret =3D unctrl_battery_register(dev);

[Severity: Low]
Since hid_device_io_start() has not been called in unctrl_probe(), will the
HID core's driver_input_lock block the incoming battery report reply?

If the device responds to the output report sent by unctrl_fetch_battery()
before the probe function returns, it appears __hid_input_report() might dr=
op
the reply because the IO path is still gated.

Does this mean the initial battery level will remain incorrectly reported as
100% until a subsequent poll occurs?

> +	if (ret)
> +		goto err_del;
> +
> +	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-unctrl-=
m1-battery-v1-0-4a50203b7177@bishwasaha.com?part=3D2
