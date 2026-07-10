Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436B2495E5
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650463; cv=none; b=tfRKeE+Z8Tdp36C5blp7b2dypN3L3H31HGvtI8SLewgxChfTRrZlgBvco7KDktVmabtFd+RKpnr34SPqj78fIXGHkIPkV/EIY6C4oYLVRTzJiPTa9w8fddFAr6iDw2WSY+3CqWkmPswK+PoBGoFa+TFyyhlpLp6j+yBeQTnnsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650463; c=relaxed/simple;
	bh=2YsD3YA4h3FR53LTTlw4QrkmbReycGftgN+fTDMFc2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iZqwowVSGEYYVt+8RJbYRd/2EZoo/vr4GxdfnrBvkxRJhEa5qprtG9ZsGZ/4YaRts5aNH/frdudHtbQBFwnS8pcU9IMy6Qw6RD0TNaBsYWaQwHTDPnuuWg5vnIZbrg6WgPRzUv2q5jexrVD3dnphy/Vek4weh18IVogUV7/j9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huNRhelV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huNRhelV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56271F000E9;
	Fri, 10 Jul 2026 02:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783650461;
	bh=Ih4H6eFxFZq7v77PkHeHAzn0KXFvqgBamAbllKVZOLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=huNRhelVAk4HZJWZ9xRbQodtqIvfdgT/qT+lM/R3g5f+BUXcf3Gdgys1sHGtixI0+
	 S5fmuEMmT2vr/uP3zmD+2XGwzRSMUqWt6jfsxMicRJ48uWzLaBSlmLpAaAOFMqIeFS
	 L3mekIIRZ8LaAnFOWxyg+4GK8eFFnVZhl6n5SRHbf6W5Vq4oyF20T4hTCqeQHpi3CQ
	 UPfWeWiMV7yuN6Ra0/OnbNxAWHCIyRcdfuchhi+P1qicSv56ciSmDgHCPyrmGpn/y8
	 FQdJMIaeGTNgl2bQilFhhbaHCwHVX7AcPwyPZRKZtLhH7/FU5CdHuLD3qgy+BFKCtA
	 jIeXA5/V1PvZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/10] HID: steam: Reject short reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260710020048.2337655-10-vi@endrift.com>
References: <20260710020048.2337655-1-vi@endrift.com>
 <20260710020048.2337655-10-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 02:27:41 +0000
Message-Id: <20260710022741.B56271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] If `hid_hw_raw_request` returns 0, the function prints uninitial=
ized caller stack memory to the kernel debug log.

Pre-existing issues:
- [High] The driver enables hardware events via `hid_hw_start()` before ini=
tializing locks and works, leading to TOCTOU and uninitialized lock usage.
- [Medium] The newly added length validation `ret < data[1] + 2` is insuffi=
cient for `steam_get_serial`, leaving an uninitialized stack byte read via =
`strscpy`.
--

--- Patch [9]: [PATCH v3 09/10] HID: steam: Reject short reads ---
commit 9194c57f44b65844dcf5d6df8e1faa2846607590
Author: Vicki Pfau <vi@endrift.com>
Subject: HID: steam: Reject short reads

This commit adds length validation to steam_recv_report() to ensure that the
reported size of a Steam Controller message matches the bytes actually read.
It also addresses stripping the report ID from the buffer more explicitly.

Link: https://syzkaller.appspot.com/bug?extid=3D75f3f9bff8c510602d36

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 298a2c17e1123..a80d54ed9784b 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -380,16 +387,30 @@ static int steam_recv_report(struct steam_device *s=
team,
>  			buf, hid_report_len(r) + 1,
>  			HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
>  	if (ret > 0) {
> -		ret =3D min(size, ret - 1);
> -		memcpy(data, buf + 1, ret);
> +		/* Remove the report ID from the return buffer */
> +		ret--;
> +		size =3D min(size, ret);
> +		memcpy(data, buf + 1, size);
>  	}
>  	kfree(buf);
> =20
>  	if (ret < 0)
>  		hid_err(steam->hdev, "%s: error %d\n", __func__, ret);
>  	else
> -		hid_dbg(steam->hdev, "Received report %*ph\n", ret, data);
> -	return ret;
> +		hid_dbg(steam->hdev, "Received report %*ph\n", size, data);

[Severity: Medium]
If hid_hw_raw_request() returns 0, the if (ret > 0) block is bypassed,
leaving size unmodified.  Will this cause hid_dbg() to print uninitialized
stack memory from the data array?

> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret < 2) {
> +		hid_err(steam->hdev, "%s: reply too short\n", __func__);
> +		return -EPROTO;
> +	}
> +	if (ret < data[1] + 2) {
> +		hid_err(steam->hdev, "%s: expected %u bytes, read %i\n",
> +				__func__, data[1] + 2, ret);
> +		return -EPROTO;
> +	}

[Severity: Medium]
This is a pre-existing issue, but is this length validation sufficient for
steam_get_serial()?

If a device sends a response where the returned length exactly equals
data[1] + 2, steam_recv_report() accepts the packet.

However, steam_get_serial() calls strscpy(..., reply + 3, reply[1]).  This
instructs strscpy() to read up to reply[1] bytes starting from index 3, whi=
ch
accesses indices 3 through 3 + reply[1] - 1 (which is reply[1] + 2).

Since only indices 0 through data[1] + 1 were validated and initialized, do=
es
this result in an uninitialized stack byte read?

> +	return size;
>  }

[Severity: High]
This is a pre-existing issue, but does steam_probe() enable hardware events
before initializing locks and workqueues?

In drivers/hid/hid-steam.c:steam_probe():

	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_HIDRAW);
	if (ret)
		return ret;

	steam->hdev =3D hdev;
	hid_set_drvdata(hdev, steam);
	spin_lock_init(&steam->lock);
	mutex_init(&steam->report_mutex);
	steam->quirks =3D id->driver_data;
	INIT_WORK(&steam->work_connect, steam_work_connect_cb);

If a connection event arrives immediately from the hardware after
hid_set_drvdata() but before spin_lock_init() or INIT_WORK(), could
steam_raw_event() attempt to acquire an uninitialized spinlock or schedule
an uninitialized work struct?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710020048.2337=
655-1-vi@endrift.com?part=3D9
