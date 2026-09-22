Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B694E780A
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109577; cv=none; b=j1Nxfrw/Uqf7YC/PmjfzVcTY7jqeKfSg0aQLLrB1kf6980GQ9Pw4iv5ehBAsIQf6bG7DdxmwKJFJRQuRRU58pH5Pz5twNRREmQgLft0ESUleTzJ64Ssyq2QOnm/0OYYLouMFeAlh+wa81P/b6KGePbxE+UNpbcBQAhb8QqwG1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109577; c=relaxed/simple;
	bh=Dap49Akyr6cG8akHhi/1aEC8xPHtxnLzIq8zn2le+Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOJ2krHLTzyIgIL+wmJtO540rMQIEogiwMeCSusB6HYQmZWuQxy8PaXHo4Ro0rRo87iuPGvuAkP6cVezgw7wmrWOwuftNtIFMhTu4FMzg548etA0LGG+Y1HIP5DeVXAtwb/tg/8937PqZNViU2YaMMSfxixhcfWJT/7npUNTqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=onjG9yk0; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="onjG9yk0"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id CF045635B041;
	Tue, 22 Sep 2026 22:34:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1790109251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dap49Akyr6cG8akHhi/1aEC8xPHtxnLzIq8zn2le+Ek=;
	b=onjG9yk0YQbn5RH64OhTWvdShE+6+Ym6H7OFh1zhbOImYBn9ZfwepAwDMr/fKedhwSzDz3
	hphjxj9e/OQACOdu93Q8DDyYnwo5C8BdjZuincv9LXj9dU3z+MIUAtha4fkuGVQ/RxlSkf
	rrscJXxHIv4GalLWpBwOhoIXWgEXrTU=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-input@vger.kernel.org
Cc: Rafael Passos <rafael@rcpassos.me>, lains@riseup.net, hadess@hadess.net,
 jikos@kernel.org, bentiss@kernel.org, erikhakan@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>
Subject:
 Re: [PATCH] HID: logitech-hidpp: fix hi-res scroll for Bolt-connected MX
 Master
Date: Tue, 22 Sep 2026 22:33:54 +0200
Message-ID: <7jEyeORtSdKPKK3Gw5UU0w@natalenko.name>
In-Reply-To: <F5F7038C-228C-4F8B-B0E0-BB470C8D2605@rcpassos.me>
References:
 <20260904034843.1340846-1-rafael@rcpassos.me>
 <LYMlyJcyQt29e1KlLnEoLw@natalenko.name>
 <F5F7038C-228C-4F8B-B0E0-BB470C8D2605@rcpassos.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartw7HFtWR0S5meJgQva4pCiA";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
x-ms-reactions: disallow

--nextPartw7HFtWR0S5meJgQva4pCiA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-input@vger.kernel.org
Date: Tue, 22 Sep 2026 22:33:54 +0200
Message-ID: <7jEyeORtSdKPKK3Gw5UU0w@natalenko.name>
In-Reply-To: <F5F7038C-228C-4F8B-B0E0-BB470C8D2605@rcpassos.me>
MIME-Version: 1.0

Hello.

On =C3=BAter=C3=BD 22. z=C3=A1=C5=99=C3=AD 2026 18:32:16, st=C5=99edoevrops=
k=C3=BD letn=C3=AD =C4=8Das Rafael Passos wrote:
> Hi Oleksandr,=20
>=20
> On September 14, 2026 11:51:48 GMT+01:00, Oleksandr Natalenko <oleksandr@=
natalenko.name> wrote:
> >On pond=C4=9Bl=C3=AD 14. z=C3=A1=C5=99=C3=AD 2026 12:31:01, st=C5=99edoe=
vropsk=C3=BD letn=C3=AD =C4=8Das Oleksandr Natalenko wrote:
> >>=20
> >> For v7.3-rc3 + Bolt receiver + MX Master 4 mouse:
> >>=20
> >> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> >
> >OK, no, something is not right: the mouse behaved fine after a fresh boo=
t with the patch applied, but once I switched it to another device and then=
 back, the scroll started to be crazy again.
> >
>=20
> Could you send the detailed steps of your testing procedure?
> I'd like to try reproducing it when I'm back home.=20

Nothing special: I've got two Bolt receivers connected to two different mac=
hines, each receiver is paired with MX Keys S and MX Master 4. I switch bot=
h the keyboard and the mouse between two machines with a keyboard shortcut =
that triggers Solaar rule to change the host.

I'm going to try the series Erik sent today.

=2D-=20
Oleksandr Natalenko, MSE
--nextPartw7HFtWR0S5meJgQva4pCiA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmqy5jIACgkQil/iNcg8
M0tVHhAAlBZogwxOOzJOCqVEIZmMiOVuLdeKOSHl0032wijOSVM1padjMYIYjdFm
qhl5+lzr0CFpQ1muBtLu+MLr8f9jQy7aYQDcyS2OuoFMpmBb9pA6QJfIXbbzPGDm
YCUYEp+qSzWtkE0Mwd0IGpg7nWi+0Z2AGO3qV1UeJDPxaSE1i+1R0uAH1JRtFUc5
pUHbhYlMJlQRqorDslJhayZXwjAyvrfxoNe9obZLmKEQyGv806FbCKfTdf5t9Hua
o52RC6C5YUhygmImwOy+osfsxfwjeOlsc8xfmBef2n8sVsxBob6TPX6GneY7mEuu
QEjZism5iOQ2A359ONM6H38oT0OFCp43eMCnrwPhLNEZIi8hM1lN4j+K3ZB8RZmL
ySby6YoCtuDPHlXauPJBXs6Wb3AMuuMF8res1tjZGTUUKWMRnHGnomVYCPerEI1n
/bPvt8zKGTooQGOZkjv7QAzEsiXwTgsOoBwZ36yS0s+lEFwIfrysTk4Wmn2WXMuK
1zUCB52EsJzbKlzIPgFzGQVyFbmQsh9d7HBMa2oT8pRWKlixzv4I95yhAEgRbqZ6
NAae0Sq5kjbGdCyKROHyG+hiVP43CCKlI1BE2tLIxKQz+T0vj/g7bj1XlGg2bsE4
4Il69tsh7UkyFQeL7DEs/8qN5XQw6Csnq8mT+a7NPEImMDoq8lU=
=axLk
-----END PGP SIGNATURE-----

--nextPartw7HFtWR0S5meJgQva4pCiA--



