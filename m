Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793872602;
	b=IcK8vz49OvwNlgGDoYJ/YTD0THu5xlPyzbjaErWX5dEsZc6l8Rj3aVV7bYaKAAr/jPRd
	 OV1MdZtfKBWZK/S8eT8Si6s/pKc/hY4FYDAsqncKWojGrGTa39YNsHrU/SZaknQU0SoLx
	 C/2ZwI+1JZQVE1i1q4acASrpQUTrqOcPEdwPeNscv5ocayJSNPbN/z7wGzgvfhewReDd5
	 ucHAjc+rB9+lRgI1rxJUGwG6qrLcVVCCwMIneEhvKX34Fkyzq3N4ZTdkD2DNK6qEc5iJg
	 Duq2UMEFOB+a1EqlUx3Aiq3kQCbeiqZrpJ7D/VYv+oQpCnuH51VQo5JEvXzH+YrRk/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872602;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9Ww0O3pMNUh1h2HmWxVUmN6w10chXYiDiH1QuUNFZEA=;
	b=428gHv14FjVpym5ElK56ZaaSAnYofm0Hbm4APxXFc+yuqJgQtE67P8hd4O4yjX1yh0qL
	 cyRbSSfoFbCu7RztM+E9vZ6h73/hQRO3IlsQ1G039g0SITUQfGWf8eo0JXhPrTK2pQaSx
	 IkqJ8E73is+5wcwo5u6O6knpsbbPg+sECbnyTEV62eJNoo8p8qZQ6HHqNWDOqiWYirHJJ
	 7qMM078uwyrmdZudysioVY1R0znyT+4xAYNTl+AS2+ftxtvSHs4gUfoftPw/Tybr+m/dl
	 GHD9ofTd28j+TgABIyi+KFUQAKyspxSTtwpkS/U3xdcB4K/+HKYOIP9CoCE6rbBFXNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eTC8Nb//";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546BF606A31B;
	Thu,  5 Nov 2026 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTC8Nb//
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793872601;
	b=DmW2lcBW6cGahpPCTVvU1sPX5CHjJkp6j6Q/g0zvYsF8+cNglth7q4xKGTd3lT/qFDqb
	 TA66bdhweNbFwl7hRr0rdwWKjCA3v01FN0bSsShYuAfWHV0j9eZQyuE/Ay8Wiv4NbClsy
	 KCON34V2TJs+bnBlQnom+4v5HotATWRMOf2JuyQSHMnaiMsxFANQa2cCdzedLmTMB1yK/
	 U4iKepWsJH/EGzkjFmOH05L4ehYDp3c4HGcwGisurfOifnyLrlol6pSdILe4P6b2MTyJ9
	 6gpUxv37OlJYneEnsqkA/BRQDNpyBwnFwNeXY6JW+jyFxMAM/n238TeUxb0WtF2zNUg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793872601;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9Ww0O3pMNUh1h2HmWxVUmN6w10chXYiDiH1QuUNFZEA=;
	b=1wCn4AniQbFsMmb7Y3t+bdhVCQo0y/8Cc3zz3KpOOkr5KOfYUMOBXigz5TO+uiQUrBjB
	 /aVtQNikruwxqpCoQbwI7pmcNL2SWREEySoSk/mjPWlbclJN3OCCD22S3kQalCZ9ohb60
	 y9F6x2Zywh7P36wvweKYDNpjRnIK2nucVcPQ6d7sc2uRNNeb5oIFUJtce8p0xo4wX0lNr
	 iSYgGqr/DcOms5Clo88u82GyzDX0pvRiYF/6vGDCO9FTaYJZGqvld+PYQBGMHAEQeWyPj
	 OSB5FY66TCom9nwNQlMHKYvc5VNzZVTCNu4ijfggo5HSyCNYR3yy18QIco4JfIM15Fg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 2A4FC1F000C1;
	Thu,  5 Nov 2026 09:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793872601;
	bh=9Ww0O3pMNUh1h2HmWxVUmN6w10chXYiDiH1QuUNFZEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eTC8Nb//5dNutxenNHd9Gv1iBrXO4PrZilCbzTTqxXksaLkIKsKqmgrflfX/t7gJL
	 plCvkqdpRdHp0ZWO4uTynDJ676BQZvWrVgd6pjrnaxEzOoXLg7QmwN/ff1F4E4FlP2
	 NuFn8VsO0ll+qN/hv68bVczS9YJdjGz72J6Qe4KQGE7GeRq/2KI1MAfl/sQacpcZ96
	 BXy5V0JIq3A69nLJYDpXQjvCvA7xYC/e6OXV8WnsMeaKIezJdFQ4+l3Hy8pPOEAwYm
	 rYL1k/uBMOie/w0HS1NIy0EsHBIZD/r/SbpP7rDebQhb93IfGzklUpUCrvRmFpkHc4
	 t5uYfzbjWDJxg==
Date: Thu, 5 Nov 2026 10:56:34 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, jic23@kernel.org, bentiss@kernel.org,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, simeon@maryasin.name, lixu.zhang@intel.com
Subject: Re: [PATCH v2 1/7] HID: sensor: hub: Synchronize callback removal
 with raw events
Message-ID: <20261105105634.00003a1c@kernel.org>
In-Reply-To: <20261104201403.2039921-2-srinivas.pandruvada@linux.intel.com>
References: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
	<20261104201403.2039921-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  4 Nov 2026 12:13:57 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Raw-event processing holds pdata->lock across callback lookup and
> invocation, and takes dyn_callback_lock during lookup. Removal must
> prevent both active callbacks and future lookups before client state can
> be released.
>=20
> Take pdata->lock before dyn_callback_lock, matching raw-event order,
> and unlink the callback while holding both locks. This ensures active
> raw-event callbacks have finished and prevents future lookups.
>=20
> Fixes: 401ca24fb34a ("HID: sensors: introduce sensor framework")
> Reported-by: =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=
=8F=D1=81=D0=B8=D0=BD <simeon@maryasin.name>
> Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=3D=
eUdbPthG2xrLqwQQ@mail.gmail.com/
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

--=20
Kind regards,
Joshua Crofts
