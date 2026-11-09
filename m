Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794267936;
	b=w5w7E5DS8JVAY2HqtiOtH/XQpNHVib2MTn+71wWWtudP1+U8QvJlXEH5VkQQD+JFHAOD
	 YauZ4PnqKCqcPzexmNhNTpGnytdWjhYb3SIA2vStUvuGA6s+NHDsqMfhA+mpDwiCtlQYc
	 yoMgkhcv7LEYSKTIhpALALSMijg/l6o/b02Sgc38TZPY5qK1v27QUvvtAPK0spsLrSELF
	 sdwxjFUUJVJGn+VCs1BeV9pAnlQr2CIT8CUNzMVx+q0nA+k7Y0bmFysR1/BMcIWjL/MLF
	 dutNh5EqUlMqg9OukWkExl70Ao+6LbFnwfngmuU/e2YAVorQmCghclouRtrNRT0tjhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267936;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=10FbvBDq/04YgyEUghoAbXIiLNNEnt9De+mGX9CvheQ=;
	b=l2TbgGm2SX0prjzdOwt+ryR8tV8x2jCm+IP9fgu7Yq1ArOn+F2Jb822siccKkHobDshg
	 SgLrwwGlR7FCYbZv7Vn1epW+/nGqn0A1msR+p8G+Q0OMTyIeM7I4Takndh/6lIloiTOKP
	 Qmuxm8x+jSrJDjgLQoOpFJWtmOtrIyh8DDZNmiRSXH3gS+oD4IWRPJHMCzpHk5y8hNZPL
	 Fe68RR+h6TxLUxFm0X53bJmI0s+Zf/gSz9D/X1PwDUtnCOj3G3vAzVkhFNzxLc2TpvgMs
	 LhiX2PWEHpEbG5Bj97LmD6pP2fcQBK82Pc/U7qIeFUC9PT0kA4Kn1r8ZZSJbvnruZbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=JwyIewsN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9610D606A326;
	Mon,  9 Nov 2026 23:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9610D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=JwyIewsN
ARC-Seal: i=1; a=rsa-sha256; t=1794267902; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Jl31lSMvAzs/XqniX+ACHNNgLcxh0n7S+lz+DZr6SyBm3hDpGepwqcOki1h+cJrOeujxCTdmrLR7T0OCQs2HI1Ewjxsa99Slfot431Z6b6fhmzAZTzLVSUUYAdmtY0AfMAqeKTFlSTk8GtLsG7itieQyCU/ebpNF85GyW7uEsWs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794267902; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=10FbvBDq/04YgyEUghoAbXIiLNNEnt9De+mGX9CvheQ=; 
	b=fZ9ON26zuxGZhARbjFNbVx7i1uAOwOCPl8ewW7Pt2ECgx5HxpZrkoo7eEcXsSlctqO3NMum+6uULgxg/dofrsNkrAUezLlMuke1Vy2gPILXqDy3w0Fb29IJMUbTYSAps1zzrGcKBMock/OR+F28nI5rH+ZfdFY8fsOmNcfx5rM8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=JwyIewsNStZ/Wt2NIM9abY1PQIynbu0eW2uT+bZ2g1vmq1HDPiJTpuRYWNzOr45UWTu18xgfkPJcLBzYOUmfRchjeMwZN5bbkXC9T1tW9paT6zSOP3f1HETZ3NmSaPQmG6F1vCPD6/e5xSakmeNvaMTvIGl/nXAvEcnBfwyHQP0=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=10FbvBDq/04YgyEUghoAbXIiLNNEnt9De+mGX9CvheQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794267900917859.4909486908807;
	Mon, 9 Nov 2026 15:45:00 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 33B26180313; Tue, 10 Nov 2026 00:44:57 +0100 (CET)
Date: Tue, 10 Nov 2026 00:44:57 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Daniel Mack <daniel@zonque.org>, 
	Russell King <linux@armlinux.org.uk>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: apm-power - remove driver
Message-ID: <avJZ291EhnpqMsbv@venus>
References: <20261109080944.3802916-1-dmitry.torokhov@gmail.com>
 <8560bc0d-5687-4b77-ab07-3d6dda465537@app.fastmail.com>
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
	protocol="application/pgp-signature"; boundary="afsg2feyk35ak5d3"
Content-Disposition: inline
In-Reply-To: <8560bc0d-5687-4b77-ab07-3d6dda465537@app.fastmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.259.76
X-ZohoMailClient: External


--afsg2feyk35ak5d3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] Input: apm-power - remove driver
MIME-Version: 1.0

Hi,

On Mon, Nov 09, 2026 at 11:00:31AM +0100, Arnd Bergmann wrote:
> I think we can follow the same logic for drivers/power/supply/apm_power.c
> and remove that once my board removal lands: the only actual battery
> that is ever registered with battery_desc.use_for_apm=1 is for the
> OLPC XO1.5, and that one does not have CONFIG_APM_EMULATION, so that
> can probably all go away.

Sound good to me.

Greetings,

-- Sebastian

--afsg2feyk35ak5d3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmryWvUACgkQ2O7X88g7
+pqI/xAAqeRkQA+UJwRYt5dT8H6Yz6GBLiuHjjMxpo6wHfEaysnnRr0DTXs8O1hw
XTPbkvWk4iJPLcPe6lV77roXb+mVOYzK3oQLia5iMBo3JsF9SupHHfP/TCdV2fdG
ag2xTw+nWEawqiRtuSYdetqvv7KZG/LFwswuacMcm0Ab2pYbfAnjL0ppU2hRueaI
VuUQZGw/hRRIng17OAXcXV3hqW2TMP2xqRjlE/x6G0WNd1qVqg1FyrpVF1ch+cVx
KtLbtjThTIn+EktcPMS4f8S5VjcBqmItPK+D916Wj3TpX4by10KZerWuM2lwaQTC
4+SfdiwsrgAwZSKdBO5OxcYd6Oavuk6xCcbK2XyEDu7eCAYJo4kEGR8hj/KnuFMP
O/WGj9ojFN4W6xR/7f9A+JnxkH1DrWUX7ogH1Q9NKrdGi/niquj1SqMR9LYPFLnE
euisogiejfT3UfUZekMOH44svDGLHkDOwBXhQV3jYoIgizORSdv+yGNjoptUwhfO
ziczuPIQh3Q3AOFSvnvv3axZXPGB+qH7P9PAFkFIZL3fpipl3HjzqAkglDP0u4b1
/5xgy55ItIHIRI0SiXNAWgkwWAtq/cTck0wg5M+eR8PUqih8hYMX7//3gyIQSRZ3
Nh/khhBn6DIeZoSxMVOBOGShlJeruGksa5EZYV8oFx7vwOM87WE=
=BZQT
-----END PGP SIGNATURE-----

--afsg2feyk35ak5d3--
