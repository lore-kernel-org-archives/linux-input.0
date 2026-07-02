Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477FC3CF69D
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031822; cv=none; b=a3ZVnyYas9dIXEdNc2IK+Kzb7D6wEp4YeV+v8W3GJD9w1dqRmxgAftiKbO1w6/tpXndX6wtWYx2+L3T3LwMxmg1SuP/HNGy8KIKeUShxxOfdSnZ3cHLuo1/j5l9c4Flxd5Vvx97USp98wJ3wESVUaCt+yNpGkGTJp2DeQTn1dx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031822; c=relaxed/simple;
	bh=Jxjyah7sgjPmZCbwr7e1Q8edDvwjgi65UllGdx2CuiA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XQJxjPpt9A3ohAPqZgMd0CzH2DNwuPHh5feMMONXtvwHMnmjE/6xsl9enQuZzJIMq+LVEv9FF81uh7V6Zm2y/TYtRxRuf4sO+d6XnEo5VLEEORrUJ5PBWoObKo56FpOQbpLrBHqi7pLhxV1V1w8v5samYtPU9iKOqZMwRQe+07I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OswEZU/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OswEZU/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4735C1F000E9;
	Thu,  2 Jul 2026 22:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783031818;
	bh=MBEwTgxGVcp3gdsTglMPf8GW3ih6LRnz2ka3HIKGAe0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OswEZU/Xe0VR4vHVlI0r7VzewIzRkBmylVuAo6LYI7EIh6KmYHeJQOP5Y2lm9ixua
	 ZB5TJa/N6JMrvvCgFM9azj4J6nze6/JZHxwQQuDKAzGoqEnHo8nl5oJcdLAiAb/GwO
	 U6c3k8nJmLsu0HeuOUeLrvjGinecq+k8PLHWDgN/ymBBJUOPZMcPTwUnR7iGXiU7wU
	 VfryL7tvL3e8XpwmscnauXrqkAd8OgIFFSHr2kEI2eJ7VnOzW/TobNEpni4USI5uJ+
	 ic/Xyx7FOJ7HIEL3/6wReXos5BJMPyfhaccHxz9MkEXLV3BEWHvng7gJ4QHz0J3+6n
	 8bDm4nTCHYwHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] HID: steam: Reject short reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260702222145.1863104-9-vi@endrift.com>
References: <20260702222145.1863104-1-vi@endrift.com>
 <20260702222145.1863104-9-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 22:36:57 +0000
Message-Id: <20260702223658.4735C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The newly added short-read check in `steam_recv_report` contains m=
ultiple logic errors that render it ineffective, allowing short reads to by=
pass validation and leak uninitialized kernel stack memory, while also erro=
neously rejecting valid reports.

Pre-existing issues:
- [High] Self-deadlock in haptic rumble callbacks due to recursive acquisit=
ion of `steam->report_mutex`.
--

commit 27b5eb27907342525c15b39fe076131c6198f9b3
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Reject short reads
   =20
Steam Controller FEATURE reports encode the size of the message in the
message itself. Previously we were trusting that the size reported matched
the size we actually read, leading to a potential issue with short reads.
Instead, we should actually verify the length of the read.

Link: https://syzkaller.appspot.com/bug?extid=3D75f3f9bff8c510602d36

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 593151709cf1d..e97431bc2828c 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -389,6 +389,12 @@ static int steam_recv_report(struct steam_device *st=
eam,
>  		hid_err(steam->hdev, "%s: error %d\n", __func__, ret);
>  	else
>  		hid_dbg(steam->hdev, "Received report %*ph\n", ret, data);
> +
> +	if (ret >=3D 2 && data[1] > ret + 2) {

[Severity: High]
Does this logic effectively catch short reads, or does it contain an algebr=
aic
error?=20

It appears data[1] > ret + 2 should be data[1] + 2 > ret. With the current
check, a device returning a short payload would bypass validation.

Additionally, since this check happens after ret is clamped to size earlier
in the function (ret =3D min(size, ret - 1);), won't this reject perfectly =
valid
large reports if the caller only requested a smaller buffer?

Also, the ret >=3D 2 gate allows 0 or 1 byte reads to return successfully. =
If
this occurs, callers like steam_get_serial() will read from an uninitialized
stack buffer.=20

For instance, in steam_get_serial():

drivers/hid/hid-steam.c:steam_get_serial() {
	u8 reply[3 + STEAM_SERIAL_LEN + 1];
	...
	res =3D steam_recv_report(steam, reply, sizeof(reply));
	if (res < 0)
		return res;
	reply[3 + reply[1]] =3D 0;
	strscpy(steam->serial_no, reply + 3, sizeof(steam->serial_no));
}

If steam_recv_report() returns 0 or 1, reply[1] is uninitialized,
potentially causing out-of-bounds reads or leaking kernel stack memory into
steam->serial_no.

> +		hid_err(steam->hdev, "%s: expected %u bytes, read %i\n",
> +				__func__, data[1] + 2, ret);
> +		return -EPROTO;
> +	}
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but does steam_haptic_rumble_cb() cause a
self-deadlock when triggering rumble?

This was introduced by the commit "HID: steam: Coalesce rumble packets"
earlier in the same series and persists through the end of the series.

In steam_haptic_rumble_cb():

drivers/hid/hid-steam.c:steam_haptic_rumble_cb() {
	guard(mutex)(&steam->report_mutex);
	steam_haptic_rumble(steam, 0, steam->rumble_left,
		steam->rumble_right, 2, 0);
}

And steam_haptic_rumble() unconditionally locks the same mutex:

drivers/hid/hid-steam.c:steam_haptic_rumble() {
	mutex_lock(&steam->report_mutex);
	ret =3D steam_send_report(steam, report, sizeof(report));
	mutex_unlock(&steam->report_mutex);
}

Since Linux mutexes are not recursive, won't this permanently hang the syst=
em
workqueue worker executing the rumble callbacks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702222145.1863=
104-1-vi@endrift.com?part=3D9
