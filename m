Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78604C81
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783468068; cv=none; b=qGbl3K/i/gPNgyfYlycxxZV6v7kFxSmCpxM12lnLXwoEQrK9AN4QwprpcK1RGC7iAwl4bAoy8OmGrGCErEAvpX90/QGV8tYvtRIWd3kzqcq3iwKWJjnHsPsQH24P/loHCojuAseNQYdNHNWkUda78ZzGTYwLwGT4NvUZw2e8a5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783468068; c=relaxed/simple;
	bh=7xaDHVqBInhXjYZNlJmo8PSvDB7LwFEhFBQdk3Pw51A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mnJu33A5XiZxrTXNZCTjqkpHm/ozM6TfRYh6LGIYY9XZRCbFSNIsK7lYZi21W9JbQGjIc7/uKDLBw3DybEXw/A8azxq5Es1pUQ1w5CdBbJw4MKTGVUC5wKMt5lr1xopCdpucLwTPJxKNwZ4Sx61rESiMQ+ww4WQ1ZhYf1DD9biM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWmYjeRP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWmYjeRP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA691F000E9;
	Tue,  7 Jul 2026 23:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783468067;
	bh=C5FO1EjELjBZnftmZlM5o2C7ivCxz2NykL7JiRC3w2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HWmYjeRPQQbKR6sa+4q3HCI9kTTfbggf6U7ZRyvqn2vL4ijWXiTYi5N5oQ8OPrHgJ
	 9czbC0Sx1/eUfovcsOcTAHMZ/25BGrCccXybqzTm7N1PO1HlQHPdyOokhvTX66lwNd
	 Q/V1ny6b3vOV0FzvcP0oPCcc95mliGmYbprjDmvS5g6llsZw/llZerQqhtqyjlnLnY
	 JxYUzB4/67cnFK3X/KybmvQp4pixQ36hHV91TWCBdNp3rKMfUQgldgeYBXil9Jw1x0
	 YO0b7e2n60UqHcmkbcShn5OewgZxx+0nCkazBw4VgOjwsQWXN7hN3Wx0MjsOdU1T5b
	 OvFn+oM2OXAdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] HID: steam: Improve logging and other cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260707233241.2644971-9-vi@endrift.com>
References: <20260707233241.2644971-1-vi@endrift.com>
 <20260707233241.2644971-9-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 23:47:46 +0000
Message-Id: <20260707234747.1CA691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Uninitialized kernel stack memory leaked to dmesg via short report=
s in steam_get_serial()
- [High] Use-After-Free due to bypassed workqueue cancellation in steam_pro=
be() error paths

Pre-existing issues:
- [High] Use-After-Free via global steam_devices list due to bypassed unreg=
ister in probe error paths
--

--- Patch [8]: [PATCH v2 08/10] HID: steam: Improve logging and other clean=
up ---
commit 5aa379e88890315b198ed7d8da2c352e3a8ce6a8
Author: Vicki Pfau <vi@endrift.com>

    HID: steam: Improve logging and other cleanup
   =20
    This commit adds more logging where appropriate and reindents an enum to
    match the surrounding coding style. It also cleans up some places where
    guard() can be used for lock management instead of manually calling loc=
king
    and unlocking functions.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 296ced2989a42..1f2cf15d40831 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -481,22 +490,21 @@ static int steam_get_serial(struct steam_device *st=
eam)
>  	u8 cmd[] =3D {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB=
_STR_UNIT_SERIAL};
>  	u8 reply[3 + STEAM_SERIAL_LEN + 1];
> =20
> -	mutex_lock(&steam->report_mutex);
> +	guard(mutex)(&steam->report_mutex);
>  	ret =3D steam_send_report(steam, cmd, sizeof(cmd));
>  	if (ret < 0)
> -		goto out;
> +		return ret;
>  	ret =3D steam_recv_report(steam, reply, sizeof(reply));
>  	if (ret < 0)
> -		goto out;
> +		return ret;
>  	if (reply[0] !=3D ID_GET_STRING_ATTRIBUTE || reply[1] < 1 ||
>  	    reply[1] > sizeof(steam->serial_no) || reply[2] !=3D ATTRIB_STR_UNI=
T_SERIAL) {
> -		ret =3D -EIO;
> -		goto out;
> +		hid_err(steam->hdev, "%s: invalid reply (%*ph)\n", __func__,
> +				(int)sizeof(reply), reply);

[Severity: High]
Does this code risk exposing uninitialized kernel stack memory to the kernel
log?

When steam_recv_report() reads a short report, it might copy fewer bytes th=
an
sizeof(reply) into the uninitialized reply buffer. The new hid_err() call
unconditionally dumps the entire buffer capacity, which could leak stack
memory if the device responds with an invalid or short report.

> +		return -EIO;
>  	}
>  	reply[3 + STEAM_SERIAL_LEN] =3D 0;
>  	strscpy(steam->serial_no, reply + 3, reply[1]);
> -out:
> -	mutex_unlock(&steam->report_mutex);
>  	return ret;
>  }

[ ... ]

While reviewing this series, I also noticed a couple of issues in the
error handling paths of steam_probe() from earlier patches or existing code:

[Severity: High]
This is a pre-existing issue, but does this code leave a dangling pointer in
the global steam_devices list on registration failure?

In steam_probe():

	} else {
		/* A wired connection is always present */
		steam->connected =3D true;
		ret =3D steam_register(steam);
		if (ret) {
			hid_err(hdev,
				"%s:steam_register failed with error %d\n",
				__func__, ret);
			goto err_hw_close;
		}
	}

If steam_register() fails, the device is already added to the global
steam_devices list, but the error path jumps to err_hw_close. This bypasses
err_steam_unregister where it would normally be removed.

Once probe fails, devm frees the steam structure, which can lead to a
use-after-free if the lizard_mode sysfs parameter is subsequently accessed.


[Severity: High]
Does the following sequence result in a use-after-free if probe fails late?

In a previous patch in this series, the cancellation of work_connect was
moved from err_cancel_work to err_steam_unregister:

err_steam_unregister:
	spin_lock_irqsave(&steam->lock, flags);
	steam->client_opened =3D 0;
	spin_unlock_irqrestore(&steam->lock, flags);
	cancel_work_sync(&steam->work_connect);
	if (steam->connected)
		steam_unregister(steam);
err_hw_close:
	hid_hw_close(hdev);
err_hw_stop:
	hid_hw_stop(hdev);
err_cancel_work:
	cancel_delayed_work_sync(&steam->mode_switch);
	cancel_work_sync(&steam->rumble_work);
	cancel_delayed_work_sync(&steam->coalesce_rumble_work);

If an ID_CONTROLLER_WIRELESS event is received early asynchronously,
work_connect could be queued. If hid_hw_open() then fails and jumps to
err_hw_stop, err_steam_unregister is bypassed.

The devm subsystem will free the steam structure, and the still-queued work
item could crash when executed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707233241.2644=
971-1-vi@endrift.com?part=3D8
