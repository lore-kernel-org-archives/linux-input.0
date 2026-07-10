Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2A1531E8
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783649895; cv=none; b=Vfr/wbGshuKIDqk8qnrQJ8tq+lpFAmbv4XhXMVG7whRHV9AKfY43Es0kQ0byEMF+oICD1/XU1buS2gqezfm0zdalLSE7G+RI7ARvs9bvjdLpNmR5mJYkLitIQ0XBzXcDKMWWzJKKiMuoDW9RE6XzjVP5ese3v47CIeEqwWWQ25A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783649895; c=relaxed/simple;
	bh=xvb1YL+BnAolCLZNXhJCN/ErQ7g5UeVJ7XCktBRvCRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qgAFZ66Kuq0SETgHmczOf47DjyAqBw2ZAoCFZxdGTyuh8CD3TY5e8sXe3TIxTDo4bkGct1OnSvE2Vlgug3G/sEI4TVQq1wqqmt0d4OLomZ0FkZCnDXOQOLGlrrdM1yyTeGqmULE5Iza8kwTQG+0Kmo1dBSJGrGZ00y5Fks73I6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehU18CaI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehU18CaI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94441F000E9;
	Fri, 10 Jul 2026 02:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783649894;
	bh=SUO7OY3fuKluF71S5sqKtzBzxxFD8L+aU59HsZJm5t4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ehU18CaI7hMBmmaGYYqNddQicCKV6BdTp1fdKVcWWsqOvY1y7L75Ih+zpB9u+/BBD
	 8ChMANikIRwoNX+kkBtGBiwRqaqXp1KG5tgR3NmRHMAKa38IbhYjmVSU9M76P0W5zv
	 Pbjgao7WCxGj+/s5TOEfcM9x4NxHCUuBn1DAoOPTVw+vXMD3Ls3nNb/Sh0PC/oXOKr
	 2w1DOnchgttQPr+pcFENUA+50wJVl7VuvAvQrjS0dx+4vwfNL85aghfEYjhZVEgcKg
	 LuRR6gIL6qKSbhgNCjgolI9EAZrvTNncLFzSLfD+/xM+AsMg6ZKQxenxYNIUxwLCNs
	 0Cg7t6D53mLYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/10] HID: steam: Improve logging and other cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260710020048.2337655-9-vi@endrift.com>
References: <20260710020048.2337655-1-vi@endrift.com>
 <20260710020048.2337655-9-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 02:17:20 +0000
Message-Id: <20260710021812.D94441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a kernel stack information leak by logging un=
initialized memory in the error path of `steam_get_serial`.

Pre-existing issues:
- [High] `steam_get_serial()` does not verify the length of the received re=
port before reading from the uninitialized `reply` buffer, leaking kernel s=
tack memory into the device serial number.
- [High] Infinite workqueue reschedule loop if the controller disconnects w=
hile force feedback is active.
--

--- Patch [8]: [PATCH v3 08/10] HID: steam: Improve logging and other clean=
up ---
commit 077388dea9c00bbb5cfcdddffe77daaebbb2a614
Author: Vicki Pfau <vi@endrift.com>
Subject: HID: steam: Improve logging and other cleanup

This commit adds more logging as appropriate, reindents an enum to match=20
surrounding style, and replaces manual lock/unlock sequences with scope-bas=
ed=20
guard() constructs.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
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

[Severity: High]
This is a pre-existing issue, but can this validation block read out-of-bou=
nds
uninitialized memory?

If a device returns a short report (e.g., 1 byte), steam_recv_report()
returns 1, leaving reply[1] and reply[2] uninitialized.

If these uninitialized bytes happen to match the validation criteria, could
strscpy() copy up to 21 bytes of uninitialized stack memory into
steam->serial_no, which is then exposed to userspace via the input subsyste=
m?

> -		ret =3D -EIO;
> -		goto out;
> +		hid_err(steam->hdev, "%s: invalid reply (%*ph)\n", __func__,
> +				(int)sizeof(reply), reply);

[Severity: High]
Could this leak uninitialized stack memory to dmesg?

If steam_recv_report() returns a short report (e.g., fewer bytes than
sizeof(reply)), the reply buffer won't be fully populated.

The newly added hid_err() unconditionally prints the entire sizeof(reply)
array. Does this expose uninitialized kernel stack data to the kernel ring
buffer?

> +		return -EIO;
>  	}
>  	reply[3 + STEAM_SERIAL_LEN] =3D 0;
>  	strscpy(steam->serial_no, reply + 3, reply[1]);
> -out:
> -	mutex_unlock(&steam->report_mutex);
>  	return ret;
>  }

[ ... ]

> @@ -1193,6 +1201,7 @@ static void steam_unregister(struct steam_device *s=
team)
>  {
>  	if (!steam->serial_no[0])
>  		return;
> =20
>  	hid_info(steam->hdev, "Steam Controller '%s' disconnected",
>  			steam->serial_no);
>  	steam_battery_unregister(steam);
>  	steam_sensors_unregister(steam);
>  	steam_input_unregister(steam);

[Severity: High]
This is a pre-existing issue, but is there a risk of an infinite loop if the
controller disconnects while force feedback is active?

In steam_coalesce_rumble_cb(), the work continuously reschedules itself bas=
ed
on the non-zero state of rumble_left or rumble_right:

steam_coalesce_rumble_cb()
    if (steam->rumble_left || steam->rumble_right)
        schedule_delayed_work(&steam->coalesce_rumble_work, HZ / 20);

When steam_unregister() is called on device disconnect, it unregisters the
input devices but doesn't appear to cancel the active force feedback works =
or
clear their persistent magnitude state.

Could this cause the workqueue to infinitely wake up and send USB reports to
the dongle until it's physically unplugged?

>  	mutex_lock(&steam_devices_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710020048.2337=
655-1-vi@endrift.com?part=3D8
