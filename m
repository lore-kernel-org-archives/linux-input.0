Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2929D281
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386073; cv=none; b=sjraNpkq2Buap6NQlQRmbj1ujhG21QVnqHDzxbesiLvImzDYsp4JiYBvYAr4z84UW+iaO+y/uNM4BSZIDQ/4ChBaveXN6pcduC5TtJeRvx9zkV9RqEg5g989vbzRhztjTluWVsG5jwiJfVbQBW9dvasA5dqSgCqf1xMJDiBmPJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386073; c=relaxed/simple;
	bh=h8z1bxpZ3C8ZO0V9iIZqFLYUGDL6nLDkKDCgi9nQtF8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=slIXH3Fi2bUqk+gWSHBuqaCehcIwB5u5QAKCUYW/qS0//UOP9Mk1n9KNi4MxrFKju1CqNfmyN5a8HWF6CX27KtnMfMbJZ2zs1HmexQRlWDdbWoPPJr0eGmTMu9WCTfVxPmK9G+SriN+M8gWJ6fXGnADmwbIAVBPRDR+c4zZ5TrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apyqunj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apyqunj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2481F00A3D;
	Thu, 30 Jul 2026 04:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785386072;
	bh=uVztWyaPA0e719pVwcZLUgA12kBRJdytvMe2Kla27xY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=apyqunj2RXKoREcMoX0lIyUUzuhmmJN5pHgjmWEQoOx8uMp6w3Mvd0WG+38fYigoH
	 FqDMNl4WU6MmuyqFPvSYIQ2EMLl+13aNkO0QImauPzsz/Cxt5vqvPVcXdCX3hvheXd
	 0BeMETA/jpBMSn1laNN/b9gdPTnWZyGaYnnQUdW1UTV01t5m0L9s4AMchPDP48B6Sg
	 d6WYnlJUgcsoXhUia3W3BYMQrwcSYYjUM7/JvoGPguCNp/UNj3MOU+hQFDtO+cIlP9
	 GbmlvY39HKVyycOprWQ/egVR9Y9bYYx0PWAeLBCbA5ZvIu4h404W1ZqDM5+1QXXeIj
	 OS7nU9KM306JA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/11] HID: steam: Improve logging and other cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260730041251.1659029-9-vi@endrift.com>
References: <20260730041251.1659029-1-vi@endrift.com>
 <20260730041251.1659029-9-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 04:34:32 +0000
Message-Id: <20260730043432.6E2481F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added error logging in `steam_get_serial` leaks uninitia=
lized kernel stack memory to the kernel log via `hid_err`.
--

--- Patch [8]: [PATCH v5 08/11] HID: steam: Improve logging and other clean=
up ---
commit 15f36444bb8b36e80ca21a45d7b255628f820523
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Improve logging and other cleanup

This patch adds additional logging to the hid-steam driver and aligns
enumeration definitions. It also cleans up several error paths by replacing
manual mutex lock and unlock calls with scope-based guard() protection.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 663fda8a86fdb..222b5751040a6 100644
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
Could this leak uninitialized stack memory to the kernel log?

The reply array is allocated on the stack at the start of steam_get_serial()
without being zero-initialized.

If steam_recv_report() reads a short or invalid response, it may return
fewer bytes than the full size of the buffer. By unconditionally printing
sizeof(reply) bytes in this error path, it looks like uninitialized kernel
stack data will be dumped to dmesg.

Would it be safer to print only the number of bytes actually received (ret),
or to zero-initialize the reply array when it is declared?

> +		return -EIO;
>  	}
>  	reply[3 + STEAM_SERIAL_LEN] =3D 0;
>  	strscpy(steam->serial_no, reply + 3, reply[1]);
> -out:
> -	mutex_unlock(&steam->report_mutex);
>  	return ret;
>  }
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730041251.1659=
029-1-vi@endrift.com?part=3D8
