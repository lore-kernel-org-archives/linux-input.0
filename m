Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C33C4B88
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031803; cv=none; b=r5xZe8SzKFYd402UVjXXqaKvxSbDUdeLS7gXebklDWxyMZgjnnHWnxzeQMyIm7g+RD5zAu+dXZf6GB0mvsjyEhSartunqLnT3fqeFyxMo5GBMElfQ0TT3CoCfLEjidMH9MTz2XBrw+vXa/kwGR5G4OQmxdrQ/Q7e1IQ/SMoyolM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031803; c=relaxed/simple;
	bh=A6ZQL0rjbnYLPDwCfwF+2B+5H3nGnPJuf6dwV0yJ5vM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FlwsCyKjK1NCWjtB81QILI55lJ7qPi5UX0LOnyk+z56VYUWXBszQ9HZfNjz4ycU+34xzBYIY6FYNvyj4TOGBhZ3a0dbT/tW0j0IaiLhpWNyBmkjzVlrOovTKqMFp1I9hIXq5TbuJRKk6SDWLkFswjuJxMYLFBUVEDKILS6QY2DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEfAzYh+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEfAzYh+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C481F00A3A;
	Thu,  2 Jul 2026 22:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783031800;
	bh=cKdz31zY+E4MZm7OkwqW8DUkqoLSCnvlpvLT3K5MrMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FEfAzYh+Txqn4q49UjnQrtWrcNiaICvIXqn125lk6CvTlp3aOBFA3S53zZZaUyhtV
	 yGmfBPapd257nW/9dr65GNKHxSg+sMwajKUR+HEgKkYB/MnDlWDWShau2bKh69Maos
	 W6U7tMUqx6OyLBipXpEELgesrYV7CfTUsa+OI61Xvn309AiacL+Jr9lWgtfFiFys09
	 ey4t6jboWgcpCcH1KEhbJPixaKb8MT6zr14RuG6C7fmKcqxgzsWgmiyC2SWPdAnWzQ
	 iEmhV7h0gfLriN1B/QtyKIAIei568Kt3ReFTo6cESBbXCXj8njQwXCgnZSshP4r/85
	 w5oVuLK4mwgMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] HID: steam: Improve logging and other cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260702222145.1863104-8-vi@endrift.com>
References: <20260702222145.1863104-1-vi@endrift.com>
 <20260702222145.1863104-8-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 22:36:39 +0000
Message-Id: <20260702223640.A4C481F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Self-deadlock in rumble callbacks due to nested acquisition of `st=
eam->report_mutex`.
- [Medium] The newly added error path in `steam_get_serial()` unconditional=
ly prints the uninitialized stack buffer `reply`, leading to a kernel stack=
 information leak.

Pre-existing issues:
- [High] Race condition in `steam_probe` error path with `work_connect` lea=
ds to UAF and dangling input devices.
--

commit 8cdb505892ea25a09ef1370038b435985daea2fb
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Improve logging and other cleanup

This commit adds debug logging to report sending and receiving, re-indents
input report identifiers for consistent styling, and converts several mutex
lock/unlock sequences to use the guard(mutex) scoped cleanup pattern.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 9d1fe97921011..593151709cf1d 100644
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

[Severity: Medium]
Could this unconditionally print the uninitialized reply stack buffer?

steam_get_serial() allocates reply on the stack without initializing it.
steam_recv_report() reads data into reply, but if the device returns a
short response, only part of reply is written.

In this error path, hid_err() uses %*ph to print the entire sizeof(reply)
bytes. Could this expose uninitialized kernel stack memory to dmesg if the
device malfunctions or returns a short response?

> +		return -EIO;
>  	}
>  	reply[3 + STEAM_SERIAL_LEN] =3D 0;
>  	strscpy(steam->serial_no, reply + 3, reply[1]);
> -out:
> -	mutex_unlock(&steam->report_mutex);
>  	return ret;
>  }

I also noticed a couple of other issues in this file while reviewing this
patch.

drivers/hid/hid-steam.c:
static void steam_haptic_rumble_cb(struct work_struct *work)
{
	struct steam_device *steam =3D container_of(work, struct steam_device,
							rumble_work);

	guard(mutex)(&steam->report_mutex);
	steam_haptic_rumble(steam, 0, steam->rumble_left,
		steam->rumble_right, 2, 0);
}

[Severity: High]
I noticed an issue introduced by the "Coalesce rumble packets" patch earlie=
r in
this same series. Does this callback cause a self-deadlock?

Both steam_haptic_rumble_cb() and steam_coalesce_rumble_cb() acquire=20
steam->report_mutex via guard(mutex)(&steam->report_mutex) and then immedia=
tely
invoke steam_haptic_rumble().

Since steam_haptic_rumble() unconditionally calls=20
mutex_lock(&steam->report_mutex) and Linux mutexes are not recursive, won't
this result in a guaranteed self-deadlock of the workqueue thread the first
time a rumble effect is played?


drivers/hid/hid-steam.c:steam_probe() {
    ...
err_steam_unregister:
	if (steam->connected)
		steam_unregister(steam);
err_hw_close:
	hid_hw_close(hdev);
err_hw_stop:
	hid_hw_stop(hdev);
err_cancel_work:
	cancel_work_sync(&steam->work_connect);
    ...
}

[Severity: High]
This is a pre-existing issue, but is there a race condition in this teardown
order?

If steam_probe() fails after requesting wireless connection status, the dev=
ice
may have already triggered steam_do_connect_event(), which schedules
steam->work_connect.

In the error path above, steam_unregister() is called before the worker is
cancelled with cancel_work_sync(&steam->work_connect).

If the worker is executing concurrently, steam_unregister() may do nothing
because serial_no isn't set yet. The worker would then complete
steam_register() and register the input devices.

After cancel_work_sync() waits for the worker to finish, steam_probe()
returns, freeing the steam struct. Could this leave dangling input devices
that will trigger a use-after-free when accessed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702222145.1863=
104-1-vi@endrift.com?part=3D8
