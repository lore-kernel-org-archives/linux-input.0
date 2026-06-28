Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1768287E
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782608050; cv=none; b=mMLY+CM2WJZeEZdwbr8qye8HH5p75Mr3iQ7YRS24/9BHAiv0ipVeH7xm8yuXM60sqJcnnW1rhd7Rh2SSTQ3o48GnKj5wGYD9td44GxlXPoGh/ISROTRYUw4bgqXA7Zgy2+VAX9pnpje9dGXThgoy5OItY46IBhFqmFMIRaDAJpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782608050; c=relaxed/simple;
	bh=2BtiFujZvh1ae0+kGOb0XD8sut799XEBzApZdTAq1IA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D0VQupvn+ABycolrDgdoAzZCRN4MfXoESF9mn4GHb8INYtkKR2O3ZjHPBkZUdbWRtBGIVCghL/RJdvm1VCXPFrDlYWa41vv0RcY3ifWeBS4hIPt+ltF7tVlJTkhLXgrQQZz7tDYZGgQj1p/FHGWx2Y6760mK8MmwpwqpKTj5pSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjBDXwdl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjBDXwdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4B61F000E9;
	Sun, 28 Jun 2026 00:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782608048;
	bh=n/cXW9Bb0NOU68FsvK0oVyYyZj/8wWTmbcah72VMmrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mjBDXwdlTjmUKysZpDa02iibasDjkUQ0kHyoDLtcQf079axpkJ23kii5qnAz5bJBv
	 lAWtfpHqFIrD3vy9lDcNqYHLndGHAT4NMT2dBZI0XkcEFHT9EZfkn3jaRIoBNcn92A
	 PoRkqlmDlbcvOehRZr4qiAYY+tH4WU6jUcuU2aKHTHS2keGTVe/8T0SnHhKzRoAwJ+
	 enArY0Su/+HCDeTZBrfU+8uatNZVVOrSOCsEs6Y9L3oL11RvDmVJ+BMHNs/IFEWDm0
	 /XJAx7EBBrSHV4hsarL3bPkpq7/j+C7/xSNnco72xQx9F5Yl8Roes+gRZIWACEJKhy
	 SufFdIbBS9mmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: steam: reject short serial number reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260628004106.26920-1-alhouseenyousef@gmail.com>
References: <20260628004106.26920-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 00:54:08 +0000
Message-Id: <20260628005408.6C4B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The serial number payload is systematically truncated and its buff=
er is improperly NUL-terminated. `strscpy(steam->serial_no, reply + 3, repl=
y[1])` incorrectly uses the dynamic payload length (`reply[1]`) as the dest=
ination buffer size limit. Because `strscpy` guarantees NUL-termination by =
copying at most `size - 1` bytes, it unconditionally truncates the last byt=
e of the serial number. Furthermore, `reply[3 + STEAM_SERIAL_LEN] =3D 0` ha=
rdcodes the NUL terminator at index 24 (the maximum possible payload bounda=
ry). If the device returns the maximum 22-byte payload, this overwrites the=
 22nd payload byte before copying. If the payload is shorter, it leaves uni=
nitialized stack memory between the end of the payload and the NUL terminat=
or, which would be exposed if `strscpy` used the correct buffer size.
- [High] Works and delayed works are cancelled before the underlying hardwa=
re is stopped, creating a race condition that leads to a Use-After-Free (UA=
F) on the `steam_device` structure.
--

commit 9b12928f5d4ac893e4176a52f291e99aaa7d63e9
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

HID: steam: reject short serial number reports

This patch modifies the steam driver to correctly validate the length of
the serial number response. It accounts for the stripped report ID in the
return value and ensures that both the header and its declared payload are
fully received before parsing.

Closes: https://syzkaller.appspot.com/bug?extid=3D75f3f9bff8c510602d36

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 197126d6e0810..8c8bfb10e8b82 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -454,11 +454,20 @@ static int steam_get_serial(struct steam_device *st=
eam)
>  	ret =3D steam_recv_report(steam, reply, sizeof(reply));
>  	if (ret < 0)
>  		goto out;
> +	/* hid_hw_raw_request() counts the stripped report ID byte. */
> +	if (ret < 4) {
> +		ret =3D -EIO;
> +		goto out;
> +	}
>  	if (reply[0] !=3D ID_GET_STRING_ATTRIBUTE || reply[1] < 1 ||
>  	    reply[1] > sizeof(steam->serial_no) || reply[2] !=3D ATTRIB_STR_UNI=
T_SERIAL) {
>  		ret =3D -EIO;
>  		goto out;
>  	}
> +	if (ret - 1 < 3 + reply[1]) {
> +		ret =3D -EIO;
> +		goto out;
> +	}
>  	reply[3 + STEAM_SERIAL_LEN] =3D 0;
>  	strscpy(steam->serial_no, reply + 3, reply[1]);

[Severity: High]
This is a pre-existing issue, but does this logic truncate the serial numbe=
r?

Because strscpy() guarantees NUL-termination by copying at most size - 1
bytes, passing reply[1] as the destination size limit will unconditionally
truncate the last byte of the serial number payload.

Additionally, setting reply[3 + STEAM_SERIAL_LEN] =3D 0 hardcodes the NUL
terminator at the maximum boundary.

If the device returns the maximum 22-byte payload, this overwrites the 22nd
payload byte. If the payload is shorter, could this leave uninitialized
stack memory between the end of the payload and the NUL terminator?


I also noticed another potential problem in steam_remove() which is not
touched by this patch:

> static void steam_remove(struct hid_device *hdev)
> {
[ ... ]
> 	cancel_delayed_work_sync(&steam->mode_switch);
> 	cancel_work_sync(&steam->work_connect);
> 	cancel_work_sync(&steam->rumble_work);
> 	cancel_work_sync(&steam->unregister_work);
> 	steam->client_hdev =3D NULL;
> 	steam->client_opened =3D 0;
> 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
> 		hid_info(hdev, "Steam wireless receiver disconnected");
> 	}
> 	hid_hw_close(hdev);
> 	hid_hw_stop(hdev);

[Severity: High]
This isn't a bug introduced by this patch, but could this cancellation
sequence cause a use-after-free on the steam struct?

Since the driver explicitly cancels works before stopping the underlying
hardware with hid_hw_close() and hid_hw_stop(), an incoming interrupt could
trigger steam_raw_event() and reschedule the work.

If the work is rescheduled right before steam_remove() returns, could the
workqueue execute on the freed steam struct after the driver core cleans
it up?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628004106.2692=
0-1-alhouseenyousef@gmail.com?part=3D1
