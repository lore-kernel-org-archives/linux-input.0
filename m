Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1163AC0ED
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789167432; cv=none; b=XWZq38rRvZFi2mjKUMFBXaqNvXyxe0rR9ABJDhu1a1uwPeONBeH50xgSbq3AE1uqai8VsXRW/Zdr/Pvf+nNl+01YiwR6OlwipTwZT4UYlxBqeZq6QD6o7Qj/+/Al/ZJqc7bUghcJ4ChOE6E/s1+UYy6j6VIB5UQeo73HwDdl1UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789167432; c=relaxed/simple;
	bh=nPSFGPK4qUyT27Vl4UYL/XqaMQuwHQmHFbfvctmtSxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVG0SGb2YAq7LlTJCBkojbbl4LUYUolJjr41mw1Ae7rOBK8HUZw/aKpPxLMbqVfeAgoRl7OFQXWgCWG13qaUdT7vI3t+IYUOIuLWt1CHF+oeN6g44wZVKIGOPs2QNfbElGaHDPcnCzc89FRFRd0e7oopLE8UTBhq7XjBRHkwkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SptDik7a; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SptDik7a"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e65b1cc29so4772955e9.1
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789167427; x=1789772227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nPSFGPK4qUyT27Vl4UYL/XqaMQuwHQmHFbfvctmtSxY=;
        b=SptDik7aG1uaaAndSaXEdBhIZqFFiZ10UpxSSCCfTRWZ3peBfyJgUSfcCnfLXbvGuQ
         A2hJbir6QuLIq7tsHXr6Oh8BCqph6MIYu+WPtdjSHq9WEVIt0etq6NXbUYyUT+C2KkOE
         mGjM35WIT6n3ERhERPB7tGbRSBB37GgnrBAnvIAYpk682cmjAjSzwaTdQh6Y91WF0KmL
         2s9GWGgEtTfFUNb2h/XD3NBoEIgBlOPDqIhy3wWJiUtmolXsOyQvUDr2/GrO8OcnE1Rr
         p6IaH9br8fzt1++UIqRThzVx4jmRixaDfRxLmNmS4Sr6RCVo3Me0NGJsShbNUXOFVLsD
         jJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789167427; x=1789772227;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nPSFGPK4qUyT27Vl4UYL/XqaMQuwHQmHFbfvctmtSxY=;
        b=U93rPHeFnMz1OdlkxMh5lLwoCeSeauEF1DJD1Vo7lyGx+piMPe5+qQsIGHfm2Pf0dT
         q+MglgqaZGNca6UCHHna0/xahYa/kRhH/WPWNs3dVqz/aii4kcW1eLZgrcTxUMW4D5n1
         C3/Z6QApQOuE9RCzgRRjmDLhVnymZlTmzoI8+fumfXM2YJsH9nOTAA4xnfa9njZMxCzR
         kh2x4dQjMBN3hf2aL9TPxLoCZ4B6zDpozcm1bKGhUMiGs1sc2SEXVTz/xiYIzcax4jZB
         LtURUe3o8MBvNM+Go8qq68qIQnYHAxAgaV75IUjnwH8fHj7R3sm2qMDdmBS3gGCartK7
         w4Ww==
X-Forwarded-Encrypted: i=1; AKwUvBzUJkPixfdqg/gZzosIFAcC/4sn8pFtCsYQiLcuQ8GPqnlUyOIlbfdvWNnPJ619bwhr09fVdz+UTwKYsA==@vger.kernel.org
X-Gm-Message-State: AFuF++kcZ5n7Al/JNRqosQiL/C5SfnkiRFa6Jv1MtK0N3a2V885ZtXmg
	9IofJB46SkHeRKWy7GXGAQ+4AqQl7QcM1SzFchlai4yx8oVXU2iYdfDEC0Tu21FjadM=
X-Gm-Gg: AYBFou2ATQmXIWRyj0SE/BPP2bIX9oSKxOezq5LKN/yS0ns7GgZklJFiY+WYmjnyWMi
	s35EvMQTKil4ga2+ipswbB2CfFbzrhk/EYTMEvrJr3CUyGsikhyCnWUPlumdYpdCmMqb6MRaX5N
	KHQxzQGPfE9a/Q+czE9/OVIvSH0BHf1nUWgMEOLYtw/s0xo6ArPliy8Erhi3lPnwThoEJzOtFRq
	pgFqRCMW1o8tJRJXljdCdyLZ83d3b4R7npp96n4BMn+jH1ASl4UYPILdWVzDjSBIzMNsZq1ZgJK
	0Ibs0dU9MZgXZDzpHY9C+X+oN6VBYZfDlXHDNIaU1mao+Vq26GzrqGjTD0f00yLR3nwQvE4Fly1
	jqAaDnQA42nlkEtWfoclj8eXs1cBcA8uDIHC83huRGFzYVlYnedEkbTuw2U0D++Nq4i0dZ3EDxq
	ouHm2m+E1/8q5E5NHmXp90O/+S+ERpYRVahVycTCdpsaF/9VB18oZK2eYl1IxzzShUZ4C6AxcJM
	ZUf
X-Received: by 2002:a05:600c:19c8:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49e619f3ae1mr135996395e9.10.1789167426450;
        Fri, 11 Sep 2026 15:57:06 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-486eb2ecf23sm9215894f8f.5.2026.09.11.15.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:57:05 -0700 (PDT)
Date: Sat, 12 Sep 2026 00:57:02 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Ping Cheng <pinglinux@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] HID: wacom: #include <linux/device-id/hid.h> instead
 of <linux/mod_devicetable.h>
Message-ID: <aqSGjE1NCAQuRhi8@monoceros>
References: <c8efa35aeff7b6ee4f66f1d48d4392976dbde128.1783329551.git.u.kleine-koenig@baylibre.com>
 <CAF8JNhJa3hOqt06XYNvhRa-QYz1LyzczPCdWbzs0Oin5DN+euw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ildf3yo3bibyzv52"
Content-Disposition: inline
In-Reply-To: <CAF8JNhJa3hOqt06XYNvhRa-QYz1LyzczPCdWbzs0Oin5DN+euw@mail.gmail.com>


--ildf3yo3bibyzv52
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] HID: wacom: #include <linux/device-id/hid.h> instead
 of <linux/mod_devicetable.h>
MIME-Version: 1.0

Hello Ping,

On Fri, Sep 11, 2026 at 12:53:29PM -0700, Ping Cheng wrote:
> On Mon, Jul 6, 2026 at 4:39=E2=80=AFAM Uwe Kleine-K=C3=B6nig (The Capable=
 Hub)
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > The single device-id structure that is used by drivers/hid/wacom.h and
> > its users (drivers/hid/wacom_sys.c + drivers/hid/wacom_wac.c) is struct
> > hid_device_id. So #include the much more lightweight
> > <linux/device-id/hid.h> instead the full <linux/mod_devicetable.h>.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig=
@baylibre.com>
> > ---
> > Hello,
> >
> > there is no coordination needed, just make sure to apply it to v7.2-rc2=
 or
> > later. So please take it via the hid tree for the next merge window.
>=20
> What's the status of this patch? I don't see it merged into 7.2 or 7.3-rc.

It wasn't merged yet. The procedure I'd expect is that the designated
maintainers of the HID Wacom driver (i.e. you and Jason Gerecke) send an
ack and then it get's picked up by Jiri or Benjamin (as HID
maintainers).

Best regards
Uwe

--ildf3yo3bibyzv52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqkhzwACgkQj4D7WH0S
/k4/SAf/f0RDXDR/wO9s+zJM8mesKTNn34sySP4Cdv9FevyTmGddrokZSQTBeNzL
kezYoP+cqValVHCEmcdgrQanlTldMxQsMWNGrEEpB8HPX3JKhWP48517VJJoY32m
n117pPxbseeDwuocQ5PzPln15jLrRU8DVnNsUHCDJ+DlNALYscurwTGfjPhryi8x
9WCMRhdDfStrsZb71+DBsMXISMVWIArJmcYLUc53ZVEygfjxHsQYeOpsZngUTzM2
FQ3sdBwulBi5eVDHmOf7wU22zTEB7a0v3R5Ihgxnf2ixBQk8T2zJlwW59XecE18L
njrRilgzWhN/gnjt4wkvbZYLBIgcDg==
=qlg2
-----END PGP SIGNATURE-----

--ildf3yo3bibyzv52--
