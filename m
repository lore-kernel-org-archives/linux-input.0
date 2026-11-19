Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124662;
	b=w97QacO12ozyk8KeubDJrFR7TRtx38Q5NkuKHJKS8EMA7wSufrPp6L0IU8s5k7gJIC9F
	 3w2qJKyIJbVY/gdU1ndmSkEHtfPDF3k+HrDtc82fLDThlQJBanfJoexRJUuMkoxZfRRmE
	 YotYtPTuQspDx1+5qsgL77u6U01WNFZYuORIPx6KRFBI+MsczN0rvNMSM4xvwRJZaOfpx
	 mZ3Cvuc+tIm+L9WKW3L/XJ2BW8ehKxWfJUV7Wt8g5pdcO6WtqAHd8LXZuzh1EfhzVmr+u
	 NqX8G271YANL8HuKSh+aTUgfE0esLUq+kdAccK8LnA0rcUcsT5sOR8Q6fmNZBcUtCcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124662;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Wz5absPglCkOQW2fWzKJ2+BAXEt62ON5tr4K4+gXeTA=;
	b=3NIhSPwxeMenJKeHPyhXhQ7Z/81mEeMNlv7R0JwOyPOnhnYjmmQjVNdQhGK6ouVbsmfw
	 asFI6HpOYL50HCvntP9NjahzVuQCxjA4xBtDBlw+xNs39koyXdI8V1r3a8QabAc2sDtyv
	 GJHolYMx+WNpmGuTrMV5UPorM5DQC+IdAM9mezTbrDw+Le1Nr2494Xo+gAzDcXTG1mu+6
	 eU476l8rk9eQozkTpO3HBrHSlULg9OXPfKTqoZdEGuLSBNyZjILonprDDPQ3ycWeCrTRi
	 sYB65n0GbKeLjmRcxMcDwRTDwIZXV2D6fFd8OlWwnevW4GA3o+7MwW764ykpebYwvPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOQV9aLf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDC5606A324;
	Thu, 19 Nov 2026 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOQV9aLf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9511F000C0;
	Thu, 19 Nov 2026 21:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795124661;
	bh=Wz5absPglCkOQW2fWzKJ2+BAXEt62ON5tr4K4+gXeTA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=MOQV9aLfZeZpnYUcxrsx9GntX1CM85Lx7xzWVUvzB0TsTddtQK1uhVtK0IztJiVtp
	 GBkeC29rmUlIXj8wW16nQljUZ9WNpqXQ5ZvmvjwwBoWDtjZRg7tFuqEx0ggsxTRvTI
	 /eP2mhiIcZXfNEhBtbA31pm/3r09r2sgjNiow4BV59P3I8iNaHg/bJGslb6c8nw9SC
	 ji761/UUj4Uyxi+7yqNIAin9cOe2UXkTz5bVYHOYr7p1FHMzG0wjCx8XZIgEiPd0af
	 9+zUB5NZQS6750W+VfBC99S1IsRCFDPCi+IGWW5x1RjILxRiimHoJW9QKY9UwLqquM
	 D3j48RfwuSGgw==
Date: Thu, 19 Nov 2026 22:44:19 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Ignacio_Mart=EDn_Arano?= <arano.ignacio@gmail.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: apple: Add "F108Pro Dongle" to the list of non-apple
 keyboards
In-Reply-To: <20261023004419.53935-1-arano.ignacio@gmail.com>
Message-ID: <oo5oq66r-7r2q-qp3n-r834-q53388q09o13@xreary.bet>
References: <20261023004419.53935-1-arano.ignacio@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 Oct 2026, Ignacio Mart=EDn Arano wrote:

> The 2.4 GHz dongle of the AULA F108 Pro keyboard reports itself as
> "Apple, Inc. Aluminium Keyboard (ANSI)" (05ac:024f), so hid-apple binds
> to it and, with the default fnmode, maps F1-F12 to their media
> functions. The keyboard has no Fn key visible to the host (Fn is
> handled in firmware), so the function keys become unreachable.
>=20
> Add its product string to the list of non-Apple keyboards so that
> fnmode=3D3 resolves to fkeysfirst, like it already does for the SONiX
> keyboards sharing the same VID/PID.
>=20
> Signed-off-by: Ignacio Mart=EDn Arano <arano.ignacio@gmail.com>

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs

