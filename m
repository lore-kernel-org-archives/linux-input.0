Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C2F3B0ACC
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789383127; cv=none; b=tfa5DCSVwrp/9qIhsAymDTvEwdJtJPP0S+ijq6cBX1lxGQB4hJWox79nvtqmvxKLGCASeMd8XhvE8bSHOoBGOVcFMP+TwRV627rfS1Odh81oqeM2WVRtgZh7rPdRHTlx+f9Qv3XD+Drtg+YjFEiBPywHTsmjKxYkGQyRJ4IaOM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789383127; c=relaxed/simple;
	bh=AIWPpwQWJ7D4wXrAp6x6Zj++CfCddd0J8K+7EJdCjLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLFdS8Z0WxjJS36rLyKKVEDPPTI67wdFT0Oo3SAoqTI2sYrdiXhuwrIYGTkTmj4B66BH1vGA3c7GoCcuRs5cT0hrvCopmr08UPMDhnalgNMSKmR/FbB/YUqaQL42ENz23pfewuqEi7sDx4T1nPbjt8KeWPpMWlTxoExUGtmgUHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=SqDbCkvu; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="SqDbCkvu"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 0FCCC635B040;
	Mon, 14 Sep 2026 12:52:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1789383122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AIWPpwQWJ7D4wXrAp6x6Zj++CfCddd0J8K+7EJdCjLs=;
	b=SqDbCkvuMbIORo6PeMJ6g/Kj59+cPmU34ddMuxq9xtZx3VqgxwBovkS5Wily5/hKzWNA6d
	Baq5YLa5h2u68s1xMNVYagJQRiPXGDWEglC2tNmUD649cyDw0P3oMOz6I8G+PVPL6PP04B
	v9fM0qpWRSOUJLzXGoSKcuSTgCKRI5U=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-input@vger.kernel.org
Cc: lains@riseup.net, hadess@hadess.net, jikos@kernel.org, bentiss@kernel.org,
 erikhakan@gmail.com, Shuah Khan <skhan@linuxfoundation.org>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>, Rafael Passos <rafael@rcpassos.me>
Subject:
 Re: [PATCH] HID: logitech-hidpp: fix hi-res scroll for Bolt-connected MX
 Master
Date: Mon, 14 Sep 2026 12:51:48 +0200
Message-ID: <LYMlyJcyQt29e1KlLnEoLw@natalenko.name>
In-Reply-To: <awkjflaaQZW7nPVUOsxJ5A@natalenko.name>
References:
 <20260904034843.1340846-1-rafael@rcpassos.me>
 <awkjflaaQZW7nPVUOsxJ5A@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8iB0MynRRhm_jXadG52oQg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
x-ms-reactions: disallow

--nextPart8iB0MynRRhm_jXadG52oQg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-input@vger.kernel.org
Date: Mon, 14 Sep 2026 12:51:48 +0200
Message-ID: <LYMlyJcyQt29e1KlLnEoLw@natalenko.name>
In-Reply-To: <awkjflaaQZW7nPVUOsxJ5A@natalenko.name>
MIME-Version: 1.0

On pond=C4=9Bl=C3=AD 14. z=C3=A1=C5=99=C3=AD 2026 12:31:01, st=C5=99edoevro=
psk=C3=BD letn=C3=AD =C4=8Das Oleksandr Natalenko wrote:
>=20
> For v7.3-rc3 + Bolt receiver + MX Master 4 mouse:
>=20
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

OK, no, something is not right: the mouse behaved fine after a fresh boot w=
ith the patch applied, but once I switched it to another device and then ba=
ck, the scroll started to be crazy again.

=2D-=20
Oleksandr Natalenko, MSE
--nextPart8iB0MynRRhm_jXadG52oQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmqn0cQACgkQil/iNcg8
M0ubXhAA6n5PppHw8eYLRI78gc1AmfR0SpqSZL2nZCtRStr+KHPipbKacTC6uKLC
NM3NYoxv6zZbha5UkvT/UEM87O9601c+x6zud4ufcFRLOGCOICxzxzGdBPL8YMPo
bqxkX5fGJ62nIxjVSx1D15OgW01xAgWv3Mq9KtuzXxNGSdoWpwLPdNhrTvaVHG4v
LgojnNA8wFsrpF7PwLHDqihsCCbtnZXcD8v9WwCUlkEagKKUKhDtGzcDYmvrnChE
6v9iLszVmXC73YgcRa0vSjwzB7BXkCZomKrenRwx2PC5pNVnlDojjSfX4Wk+lEDa
RhkhezJ9WmskVgctSB8Y2mfdzM+tqXmc35LR8gazYlQF249z3g3K6J/W/j+Ekq0U
hO/kPIkw5oB9ZFv54iPmLPWxMiGbczuF79LGHWq0CjD02jTsgZHDj22LHfz+dccq
DQf8HuAZ8T7q9xYkD0qEUsVIqXc1Y1k2GQTLX+zrfy2Oi1X+RjYyOJXUArLOr1jl
D8vpYYiOhqppBiSOVYV+3lawhLeeoUtWAsPaD10O0i7Grqmf2CoLVeUXtT0TkgL0
5JBPHM90gR+s9selqLccVhpqsAea17ZTFzQ/tkui3rMCvLeGLkT0niLO9DX/kNwq
bF6u/+PpLQFxQ3dCPEXY6XRFakv3aItkJz/VNzOyqwVm9owk7G0=
=iN0R
-----END PGP SIGNATURE-----

--nextPart8iB0MynRRhm_jXadG52oQg--



