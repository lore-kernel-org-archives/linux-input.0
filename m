Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794181955;
	b=cqnprarQhneuePJVSt8hy3zaF6N4tW0Ng09ac7zPb1VrKRkrcHW3q95rXuoH7u2Ue7l2
	 gKhcfR1Iv6Me8q4Jfqhh0e/NAhCBF++hhMF7puHo8nhrukN0j+F+IFr/iq+rkuJkLZE/o
	 xiQjA5ZRZw170jV5OQSyWcUUKEjRs2U8agByWTXPzWLDEx8mlRGKxnxkMUPEe/RFsvb77
	 txtJzYsyVbCdt8YE4qMQ6pUkCCUl1T2uUZ1OU6X+C8fuevcTgFCNn0NY8Pv0SC+K0UUzq
	 s8bMDq0wHYgR42pmB/EHarXzQiTe7/qLCRMF19yrvrwtYQnvfI0W5vza/ftU2Pg4qXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181955;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=ZzZmW7U0j2vJpHF2NsUFVQax3mLzJ80uqYTPEp5SWu8=;
	b=FixskRu9z5AQcALbyitr4e2+isBqHBLau4YPuYHGQpbpTI2QrBcVjKR3FzTWpwciHaa+
	 nIPbh71+ZX4wmJ9nwPQG0tHZyESqm4xzF1XpQ5QmsoiUYhWuSC+CjcYZVfEsAhO/tt9nP
	 lMQY7eqvHTi16YeZp+o7aiDqEJCwrIn3P1sOnpxh2Cov+vgU9EABxo3cZOjiujHYBvWcV
	 1SjZ9Y+n1F0lnWww+lG5cwqxljh1T3zeVA+aEJjKNOJvmXe37KEqU1wRiM5959qT0JRBU
	 G3BQjHBTyDkVXKRF/2mHX5OVBZQmZ7UeiWPrnGo3hAe7Ygy6Ietd6+9BO7drDH6vYmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=OpUROlzi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978CE606A31C;
	Sun,  8 Nov 2026 23:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 978CE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=OpUROlzi
ARC-Seal: i=1; a=rsa-sha256; t=1794181941; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BtFzMLxCW7POmHOdJvh+YwHALuxCRW48T/bezj1uC6xdFetr9tIPL7Iszd+OdGzDicTRGJXtluttjiQHye306N07B5G1fxSyWDVuKI93VbJIqsOwpo/m03zWmCPb/0yOhHJPMj2wy+qakZFU4U5nb947JLi2dTQ/yyAdRZ9y998=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794181941; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZzZmW7U0j2vJpHF2NsUFVQax3mLzJ80uqYTPEp5SWu8=; 
	b=J+ztNFldbR4GOE2FU2XTryHLrv70bkTrCOYeKe8n+7e33QZ+R21A92K0UTx9gaqBAMP31H3JgegChUbV6xhg9poA52MKbC58qMmlS3v4FGfDbc3WKsdGqsYiad3DCLfB0YMviEQCN7ANl3qlVVadvOtVHV157pA3H1okdvHEVsc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=OpUROlziJtMRtlVCbGddqbMWE4oPwZCM2nLSQ0fOYpEOqEce/RZWih6LsE2v456FiUtwqV+oBvq/s+yjeaBo6HGRjAN1E0TtLlCggAwV9aUZ4e5ByC6gmgBnLLwSIcbwii+MVqEFMnl6+Op8qHmivM/j1cf7k5lS1pvwNyD9Njk=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=ZzZmW7U0j2vJpHF2NsUFVQax3mLzJ80uqYTPEp5SWu8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794181940739147.63396619540686;
	Sun, 8 Nov 2026 15:52:20 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 390461808E6; Mon, 09 Nov 2026 00:52:18 +0100 (CET)
Date: Mon, 9 Nov 2026 00:52:18 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 8/8] power: supply: sbs-battery: use 4-argument
 i2c_smbus_read_block_data()
Message-ID: <avELD9tlEfl9Uth7@venus>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
 <20261024-i2c-smbus-read-block-data-v1-8-19bb97467982@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="djssy5i5cnzkks24"
Content-Disposition: inline
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-8-19bb97467982@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.158.93
X-ZohoMailClient: External


--djssy5i5cnzkks24
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 8/8] power: supply: sbs-battery: use 4-argument
 i2c_smbus_read_block_data()
MIME-Version: 1.0

Hi,

On Sat, Oct 24, 2026 at 07:48:48PM -0700, Dmitry Torokhov wrote:
> Pass the destination buffer size to sbs_read_string_data(), and pass
> the buffer capacity reserving space for a trailing NUL terminator to
> i2c_smbus_read_block_data().
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index 6714313bb3a3..f8b194c58a62 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -424,7 +424,8 @@ static int sbs_read_string_data_fallback(struct i2c_c=
lient *client, u8 address,
>  	return ret;
>  }
> =20
> -static int sbs_read_string_data(struct i2c_client *client, u8 address, c=
har *values)
> +static int sbs_read_string_data(struct i2c_client *client, u8 address,
> +				char *values, size_t size)
>  {
>  	struct sbs_info *chip =3D i2c_get_clientdata(client);
>  	int retries =3D chip->i2c_retry_count;
> @@ -440,7 +441,7 @@ static int sbs_read_string_data(struct i2c_client *cl=
ient, u8 address, char *val
>  	}
> =20
>  	while (retries > 0) {
> -		ret =3D i2c_smbus_read_block_data(client, address, values);
> +		ret =3D i2c_smbus_read_block_data(client, address, size - 1, values);
>  		if (ret >=3D 0)
>  			break;
>  		retries--;
> @@ -709,7 +710,8 @@ static const char *sbs_get_constant_string(struct sbs=
_info *chip,
> =20
>  		addr =3D sbs_data[ret].addr;
> =20
> -		ret =3D sbs_read_string_data(chip->client, addr, buf);
> +		ret =3D sbs_read_string_data(chip->client, addr, buf,
> +					   sizeof(chip->strings[0]));
>  		if (ret < 0)
>  			return ERR_PTR(ret);
>  	}
>=20
> --=20
> 2.56.0.257.gf7497c7d27-goog
>=20

--djssy5i5cnzkks24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrxCyYACgkQ2O7X88g7
+pqbCA//WLpBfQbt6ZJ6XndBJ9N2OdPV0zOs8CxWZ+ua1SthiUpJEudANpYMuh8N
0CmMUo+5FSj0HQmQYi3dnJecNT95GMgFnBhlctIo7MGfkenakz+0kAyVfzUWhh0D
1kRQuB1pN754PEAjDKtaLQFDQq8EWYWI0S78dLmRKl1wlfxiqWQKVTk4uhpKqMsq
WEThh3GiB2xPDttBSP/YU9X5nGmB9WWE4KVB7OuWI5gA/6e23w7MetL78gOvQDXw
DIj8je51ctSbRU5iF2/rsRvjWp/DAQBN6H4OIuqvdJD8VYycfBZ2YM5W42pzhEDf
3LNhVqsMAJWJIEsz+xYtYS578mxAYKCMWQEc5ol1b1wVHbA8J0QUQxJOMhBWQhys
jgN2LwCQQXaiiwwRfJ77TJL/SVwCa9hfo2ST5POaTdIYPWTfKklpf9jNUjy5ISe6
9lfpr94Rw9+B5gMaNJenVgQCVaKGfqdOMMDb2OigI1OpKPC4boV6btBc9bORiHQV
t4BMOKy6MYWlst+LgE1Aw9WGNxArJ24fc+4gprFY2uxJC5ysK1bpXcsha6IyqUA9
5kDAhLMTmfdpijezA1681U7HE88+xx8pjSdG9OSTl0G35IvZMESiWdXgCYx369Dh
/i3G7gy+cnIPSBuVsuvGHLuQPsfELTqm9NlvpHQoBPSZ3yi1pjk=
=XodA
-----END PGP SIGNATURE-----

--djssy5i5cnzkks24--
