Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48092314A65
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 23:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783468121; cv=none; b=qkwp3ZzB9ynB7/LWEiHiPyEYsWjOpV8g3OEYekdyJK4/PoIhkvz2GBXfAV3IoCwBbVQNMw3QzvxGqbdLawSYXQgWJb3MM40804Vb8PdlVpb8iGgo6zNamagDFeShvC3PAPYtJ6x8KpQVJpIVrhgjCOtaLLouoSbkMqhqoQYhz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783468121; c=relaxed/simple;
	bh=GfUwT4QBuhMF4cmJAET6++3qIFYm/vLq6+2IFQMwh88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dVpRh5W9oAsLrC3O+4fK9vSivu6CDzspMTHNYEUuUgdniyxsKE+78xQpatkMM7ebxk0BX3x7egHWtX1ksEVRn7btxme/fBBpqXcfN2USyPvnHCpHW/L28WoyyIDrmNchXWJGOwPLDqUeOnX+PNSxUO3F2thGt9wxKzwkvpDNHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miTCo64z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miTCo64z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32831F000E9;
	Tue,  7 Jul 2026 23:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783468120;
	bh=2tC9eW6zSEBJefsa1PP1c8IMSVf0k86BNo3EJWZMQ/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=miTCo64zcXaddBLhegHR307CfzU8OzQv+35bht4y5VZjvoH8bwRc8PCiQO9EpImzw
	 Szgpg+X61s1LTtj/8lDYS1bX6/0Md5GmGxwGoK07E8ZYgwqXNiM+sMKThI97XEHolx
	 UpPZYiGj8FMVWI0mBDK9TMrutIUDOFxoZOXMJBH7qc/0ra4GLrIsUjcu27HRoKvlIq
	 bz/6AHSftrDu2LqdIcAQtXiKEZjeEajMtRdZatM4iTSVSqxp4j0sNTTmTZjaGX3p76
	 8cirjhhzKVv07WOd5K+rpVsF+MQT+DkVcyy9oLgA10E/NnTjgPiTiY6T+q8UsCGuu7
	 sqXZ16gZKlOCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] HID: steam: Retry send/recv reports if stale
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260707233241.2644971-11-vi@endrift.com>
References: <20260707233241.2644971-1-vi@endrift.com>
 <20260707233241.2644971-11-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 23:48:39 +0000
Message-Id: <20260707234839.A32831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Log spam in expected retry path due to unconditional `hid_err` i=
n `steam_recv_report`.
- [Medium] Out-of-bounds stack read in `hid_dbg` when the device report exc=
eeds the caller's buffer.
- [Medium] `steam_recv_report` reads uninitialized stack memory on short ha=
rdware reads.
--

--- Patch [10]: [PATCH v2 10/10] HID: steam: Retry send/recv reports if sta=
le ---
commit 181ac85173536f44d1a324b3bc0042d43fa8238e
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Retry send/recv reports if stale

Sometimes recv report will reply with a stale result from a previous send
report. Instead of failing out, we should retry them, as they generally
reply correctly after three tries, give or take.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 49f6733d89359..ba2dd40a79763 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -497,6 +497,43 @@ static int steam_write_settings(struct steam_device =
*steam,
>  	return steam_recv_report(steam, cmd, 2 + cmd[1]);
>  }
> =20
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

[Severity: Medium]
Does this call cause an out-of-bounds stack read in steam_recv_report()?

When a device sends a padded report that is larger than the caller's buffer
(like the 36-byte reply buffer in steam_get_serial()), steam_recv_report()
copies the correct size but logs using the unbounded ret length:

steam_recv_report() {
    ...
    size =3D min(size, ret);
    memcpy(data, buf + 1, size);
    ...
    hid_dbg(steam->hdev, "Received report %*ph\n", ret, data);
    ...
}

Since ret can be larger than size, won't hid_dbg() read past the end of the
reply buffer on the stack?

[Severity: Medium]
Can this also result in reading uninitialized stack memory on short reads?

If the hardware sends a short report where hid_hw_raw_request() returns
0 or 1, memcpy() copies 0 bytes, leaving the caller's reply buffer
uninitialized.

steam_recv_report() {
    ...
    if (ret < 2 || ret < data[1] + 2) {
        hid_err(steam->hdev, "%s: expected %u bytes, read %i\n",
                __func__, data[1] + 2, ret);
        return -EPROTO;
    }
}

When ret < 2, data[1] has not been populated. Won't this read and log an
uninitialized byte from the stack?

> +		/*
> +		 * Sometimes this can fail on the first few tries on the Steam
> +		 * Controller (2015). It appears to be a firmware bug, and Steam
> +		 * itself just retries, so we should also retry a few times to
> +		 * see if we get it.
> +		 */
> +		if (ret =3D=3D -EPROTO)

[Severity: Medium]
Will this retry logic cause log spam during normal operation?

Because steam_recv_report() unconditionally calls hid_err() before returning
-EPROTO:

steam_recv_report() {
    ...
    if (ret < 2 || ret < data[1] + 2) {
        hid_err(steam->hdev, "%s: expected %u bytes, read %i\n",
                __func__, data[1] + 2, ret);
        return -EPROTO;
    }
}

Won't every expected retry here flood the kernel log with error messages?

> +			continue;
> +		if (ret < 0) {
> +			hid_err(steam->hdev, "%s: error reading reply (%*ph)\n",
> +					__func__, csize, cmd);
> +			return ret;
> +		}
> +		if (reply[0] =3D=3D cmd[0] && reply[1] >=3D 1)
> +			break;
> +		if (retries > 0)
> +			continue;
> +		hid_err(steam->hdev, "%s: invalid reply (%*ph)\n", __func__,
> +				rsize, reply);
> +		return -EPROTO;
> +	} while (retries--);
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707233241.2644=
971-1-vi@endrift.com?part=3D10
