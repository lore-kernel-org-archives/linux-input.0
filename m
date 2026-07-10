Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3668136358
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650706; cv=none; b=AY1HqOtxxAzqmdv0Y4LPSb41NPTxFeU+U1Lo3hDCJFPN332c/qnm12qdYR1ZyEDgXqhVICd2nvgltBB94FyIbkrwOuUMX02W5FLuPDrMVF61Hr2RTCsdj/q8/2kcdr626BaGmoyyXFccPDfz5QKaVenj2UIw/NteK1jqfzcfrG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650706; c=relaxed/simple;
	bh=KFEHUi+7oqRjvg7/t88GYQbq3SgXMbo68WWElOLmNGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u95548k4yJoF2DAjoyfUWzP47m/qlrbPrIk8u29jcSrjXKbG9Csy3C7MnSCv8aXLqVOYYxIX0l4viczFdTTGs8E22tte9SY3yZZ6JQIOt4w08sdwnKtI9CRJFOVgKoDZVZXY9s5RNe12BdLRZN8bJ8vdiaH7pD7XJYONpoIfiIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIijbYEI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIijbYEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5955E1F000E9;
	Fri, 10 Jul 2026 02:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783650704;
	bh=j6BQIqg5TYkn9b+ou+84rjxbZebWZivs+JFtjWKVMc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CIijbYEISzQDUgVAt1G8oZ+ZpA49euzylld/w/n7KH582FMFJeGcjFYprWeZJwkdU
	 TPfcc8HyE/offxZvu/93i7Sq6KMKID7Frqnr2UaFIJu4H+fZ0ZNsdUR4WGjFP8Zwaz
	 eoLbnpr3DssF0XXZY3s8f4PUiylAY7ORB8yMgTVGg8sfcq53YoZ5fvqnEEZmIwvEBz
	 2OVVOIoyYY5j1kIDUs7MSKDjPp47VEXxKY4nUA2EGE32y7DRW6BSE350xPcrXlM8qP
	 uvkoosfd7pZjH7x8dPurToa5gqjTTGQ6gCf8yFxCyBSf4wcVqCQ6j1HjpQdW0E69U5
	 7uMzdoH9C/4jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] HID: steam: Retry send/recv reports if stale
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260710020048.2337655-11-vi@endrift.com>
References: <20260710020048.2337655-1-vi@endrift.com>
 <20260710020048.2337655-11-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 02:31:43 +0000
Message-Id: <20260710023144.5955E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Uninitialized kernel stack memory leaked to dmesg on invalid USB r=
eplies or short reads.
- [High] Missing cancellation of workqueues in the `steam_probe` error path=
 leads to a Use-After-Free if probe fails.
--

--- Patch [10]: [PATCH v3 10/10] HID: steam: Retry send/recv reports if sta=
le ---
commit 2a2fc2d99039c81756476abdde17aa7642c354be
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Retry send/recv reports if stale

Sometimes recv report will reply with a stale result from a previous send
report. Instead of failing out, we should retry them, as they generally
reply correctly after three tries, give or take.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index a80d54ed9784b..3f5d4a88b8649 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> +static int steam_exchange_report(struct steam_device *steam, u8 *cmd, in=
t csize,
> +		u8 *reply, int rsize)
> +{
> +	unsigned int retries =3D 5;
> +	int ret;
> +
> +	guard(mutex)(&steam->report_mutex);
> +	do {
> +		ret =3D steam_send_report(steam, cmd, csize);
> +		if (ret < 0)
> +			return ret;
> +		ret =3D steam_recv_report(steam, reply, rsize);
[ ... ]
> +		if (reply[0] =3D=3D cmd[0] && reply[1] >=3D 1)
> +			break;
> +		if (retries > 0)
> +			continue;
> +		hid_err(steam->hdev, "%s: invalid reply (%*ph)\n", __func__,
> +				rsize, reply);

[Severity: High]
Does this code leak uninitialized kernel stack memory to dmesg?

If the USB device returns a short reply, steam_recv_report() will only
copy the received bytes into the reply buffer. The remaining bytes in
the buffer remain uninitialized.

Since reply is allocated on the stack in callers like steam_get_serial(),
this hid_err() call will log the full rsize bytes, potentially leaking
sensitive kernel stack memory to dmesg on an invalid or short reply.

> +		return -EPROTO;
> +	} while (retries--);
> +
> +	return ret;
> +}
> +
>  static int steam_get_serial(struct steam_device *steam)
>  {
>  	/*
> @@ -511,15 +548,10 @@ static int steam_get_serial(struct steam_device *st=
eam)
>  	u8 cmd[] =3D {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB=
_STR_UNIT_SERIAL};
>  	u8 reply[3 + STEAM_SERIAL_LEN + 1];
> =20
> -	guard(mutex)(&steam->report_mutex);
> -	ret =3D steam_send_report(steam, cmd, sizeof(cmd));
> +	ret =3D steam_exchange_report(steam, cmd, sizeof(cmd), reply, sizeof(re=
ply));
>  	if (ret < 0)
>  		return ret;
> -	ret =3D steam_recv_report(steam, reply, sizeof(reply));
> -	if (ret < 0)
> -		return ret;
> -	if (reply[0] !=3D ID_GET_STRING_ATTRIBUTE || reply[1] < 1 ||
> -	    reply[1] > sizeof(steam->serial_no) || reply[2] !=3D ATTRIB_STR_UNI=
T_SERIAL) {
> +	if (reply[1] > sizeof(steam->serial_no) || reply[2] !=3D ATTRIB_STR_UNI=
T_SERIAL) {
>  		hid_err(steam->hdev, "%s: invalid reply (%*ph)\n", __func__,
>  				(int)sizeof(reply), reply);

[Severity: High]
Similarly, can this leak uninitialized stack memory to dmesg?

If steam_exchange_report() successfully returns but the reply is invalid or
too short, this error path will log the full sizeof(reply), dumping any
uninitialized stack bytes from the reply buffer into dmesg.

>  		return -EIO;
>  	}

[Severity: High]
Does the probe error path cause a Use-After-Free?

Looking at steam_probe() in the same file, if steam_register() fails, the=20
probe error path jumps to err_hw_stop:

drivers/hid/hid-steam.c:steam_probe() {
    ...
		ret =3D steam_register(steam);
		if (ret) {
			hid_err(hdev,
				"%s:steam_register failed with error %d\n",
				__func__, ret);
			goto err_hw_stop;
		}
    ...
}

However, this bypasses the cancellation of steam->mode_switch which occurs
under err_steam_unregister:

drivers/hid/hid-steam.c:steam_probe() {
    ...
err_steam_unregister:
	spin_lock_irqsave(&steam->lock, flags);
	steam->client_opened =3D 0;
	spin_unlock_irqrestore(&steam->lock, flags);
	cancel_work_sync(&steam->work_connect);
	if (steam->connected)
		steam_unregister(steam);
	cancel_delayed_work_sync(&steam->mode_switch);
err_hw_stop:
	cancel_work_sync(&steam->rumble_work);
	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
	hid_hw_stop(hdev);
    ...
}

If a malicious USB device sends an input report that triggers=20
steam_do_deck_input_event() before steam_register() fails, the mode_switch=
=20
work is scheduled. When steam_probe() returns the error, the steam struct=20
will be freed, but the un-canceled mode_switch delayed work could still=20
execute, causing a UAF on the freed struct.

This teardown issue appears to have been introduced by earlier patches in
this series rearranging the teardown paths without properly covering all
workqueues on the error path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710020048.2337=
655-1-vi@endrift.com?part=3D10
