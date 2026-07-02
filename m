Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A433C4B88
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031800; cv=none; b=t6Vuhj3gADzmO8CoZV0ycV8qvWTHFvIPw0+utlkAewsfAi545GmKyDIJM/k3pokNZ0W5LVelIEQs8QCfOSnf2l32hN02ITvN8PgMrvBgViFBetjegSk86A2qPnoF2SCu6zcx2kdy7nWJ6blPhKLUIjIQRJKhZ1UxTghqK4Gaslc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031800; c=relaxed/simple;
	bh=iJtmyHsR/KrAEdyoyPSphdLk9z6JtAVa4gay6RTROoA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ki9bV+Q4sRahG/Lajp4r9UiH6Q3Ngq5TXSSOhYS4DcqBXuvLXdpVxGk5MGHzs9gVMjILpzlaSimE4frpsqpbtCVz+hZxQr49L/bpRDYo1txyZn1ztkwgcdil+3NM7qaOuXyeNv6jROHKNBeAhfIKAxA3WrA6HtmxKJoXRdlDOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO0gZ2/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO0gZ2/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4121F000E9;
	Thu,  2 Jul 2026 22:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783031799;
	bh=EHt9CSVGTkLwNEG1lgslJMg1AqoDGMeTQQ3QkowForQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hO0gZ2/3DZf43cHJIcrRqUqKXz19OqDYVO4pqtL7OV86nZM7LGqeJJJfHBWlHbbrK
	 rFB/ji1WIwb3vq1XcTcqkklqZaL8G9CR7ecRx8afH1pHE5H+Hb7uCcdZ/0yxPLy0mB
	 Z4fxBfGi6ocEn1onj5tp7c67LQo85K59yTn58Jv0Gx2MuH56sBbJPu6owtzNpvoXIR
	 McLxZSHYwtpgS2Bnsu0fZ7piSHvMqfi66OnCDzjhsSFEXRhP7fVq5HkHH+dnEiFYeo
	 ngqyzfHIexbfOfiaPYa5t8VnoS548gly5Yl3lWH5ewZCx0M8kVv2XWGU13OWqgFKo0
	 GM9BZBzg4CT2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] HID: steam: Retry send/recv reports if stale
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260702222145.1863104-10-vi@endrift.com>
References: <20260702222145.1863104-1-vi@endrift.com>
 <20260702222145.1863104-10-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 22:36:37 +0000
Message-Id: <20260702223638.CE4121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Insufficient bounds checking allows uninitialized kernel stack mem=
ory to be parsed, exposed to userspace, and logged to dmesg.
--

commit 74668d65404cd2e20c8afd5929ec0da105fd2ec0
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Retry send/recv reports if stale

This commit introduces a retry mechanism for sending and receiving reports =
to
handle stale replies. It adds steam_exchange_report() to wrap the send and
receive logic with retries, avoiding failures from firmware bugs.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index e97431bc2828c..8d036b3412539 100644
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
> +		if (ret < 0) {
> +			hid_err(steam->hdev, "%s: error reading reply (%*ph)\n",
> +					__func__, csize, cmd);
> +			return ret;
> +		}
> +		if (reply[0] =3D=3D cmd[0] && reply[1] >=3D 1)

[Severity: High]
This is a pre-existing issue, but does this code evaluate uninitialized
stack memory if steam_recv_report() returns a short read?

steam_recv_report() has a mathematically flawed bounds check that can fail
to reject truncated packets or bypass the check entirely for 0-1 byte repli=
es:

	if (ret >=3D 2 && data[1] > ret + 2) {
		...
		return -EPROTO;
	}

Because reply is uninitialized on the stack in callers like steam_get_seria=
l(),
can a short read from a malfunctioning or malicious USB device cause us to
read uninitialized memory here?

Could it also potentially return success if the stack happens to match the
expected values?

> +			break;
> +		if (retries > 0)
> +			continue;
> +		hid_err(steam->hdev, "%s: invalid reply (%*ph)\n", __func__,
> +				rsize, reply);

[Severity: High]
This is a pre-existing issue, but if steam_recv_report() returned a short r=
ead,
does this log uninitialized stack memory to dmesg since it dumps the full
rsize bytes of the reply buffer?

> +		return -EPROTO;
> +	} while (retries--);
> +
> +	return ret;
> +}
> +
>  static int steam_get_serial(struct steam_device *steam)
>  {
[ ... ]
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

[Severity: High]
This is a pre-existing issue, but since the length from reply[1] is not
validated against the actual bytes received, does the later call to strscpy=
()
leak up to 31 bytes of uninitialized kernel stack memory to userspace?

drivers/hid/hid-steam.c:steam_get_serial() {
	...
	reply[3 + STEAM_SERIAL_LEN] =3D 0;
	strscpy(steam->serial_no, reply + 3, reply[1]);
	return ret;
}

Can a remote or malfunctioning USB device returning short or empty HID payl=
oads
trigger this information leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702222145.1863=
104-1-vi@endrift.com?part=3D10
