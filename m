Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381882;
	b=DZdcYeJlgRM5/vfzaUkyYvLVqYdTJBjoc/+BJYz/8VdzYVOu5aHvYJGFEsaYK6sUiWsg
	 nEpPYrusQvKRsQ4FZtyhndTaJAol7WaYrZlZQOfrG3XiHCJlmgpDv0gChTYX0X1FVz5W4
	 Ag/AHvFRAQWpboOaw5zKMn3cNbJ8IfJov7hgg/m0FvGDZN0E1BQKbzJgaijCJ0eIC89Us
	 IqkzbOknOrNeO4rD6f61lXHN5ITMZK2BkjnDOdGtBm4ruTcA/tErdbA1MVnZtzaUE7PTD
	 yFszjRpJxrJeLj5x0o+CEOueN3inAR/2DIOI/7dZjrDlmLQQFKiV/1qusGX15CfZ0UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381882;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+u5+ckLx73YREPyFSPjj+TC6ke8CgJHSbNxFOWkAGpo=;
	b=PyGZ5ZcuGfDrmzlyo1a1hUSOGns+bwf1z1PH4vNMv/0kHEgcZn66R8EBDlCm3OvXwiXJ
	 1bnQztGks3/QicIspgIlN65r1eDqh4ZLqYWcbPHefUqPkn9jWs4kZ6KBIxPek3+/dDSpi
	 4QFnd7VBqWczwl7C0hylGyECv0VxYZ+v9zEdqQcgYp/zNaLQBdfeakybIEnQ0uoMWsAC9
	 bf4sR/9eU1dEt3ud8eXTv2X6nbCPJiqLFWXkD8otYewfogmJpWJ1ceJFbGtvICCpDMAx7
	 k6GxMIUEN873APdEGQMA2ur9pgKt6OOe3eYBWFJF9cmChocXDXte8Rf6lL8M6kBcpZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNxbpvJB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCF1606A320
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNxbpvJB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90031F00A05;
	Wed, 11 Nov 2026 07:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794381882;
	bh=+u5+ckLx73YREPyFSPjj+TC6ke8CgJHSbNxFOWkAGpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fNxbpvJBcyfA1i6c07f5ag6m1k6ztVxomAl9BhDtF4z/Oas75CuNhWB5HTN8tSfRj
	 hs65SbC/pyuNXgUTlQ+GkaTruuHXC9LZWLlWG1EbAV/i71WoE/dnoDRGGCTz7+N/Ys
	 P57gCKLK5zTiPKDNuhfbUN+o2Ss5VXZjhajJRzcQxijuUax3e+zV6w81f0ptTml2wf
	 SVnzbi7/6r5q88JavpAS+s7UcUY9ywj01I2GrPzFj+bXRHugVNi/BnTOD5x2cy3VYD
	 dVhtqIRQ2JYFCUAvJcEhDPFXCzNC2T3822ZHjwpMRhocE5SwAZmsGKSB1Lcc7GG9WT
	 0v0fY+jdIrHKg==
Message-ID: <sashiko-outbox-208508@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] HID: nintendo-switch2-usb: Clean up urb in probe
 error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261111065001.3626071-3-vi@endrift.com>
References: <20261111065001.3626071-1-vi@endrift.com>
 <20261111065001.3626071-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 07:24:41 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] HID: nintendo-switch2-usb: missing Fixes trailer for
  switch2_usb_probe() fix
--

commit e3ee270bfbbf6fa6ea6a7562052781a9e5556f6b
Author: Vicki Pfau <vi@endrift.com>

> HID: nintendo-switch2-usb: Clean up urb in probe error path
>
> In switch2_usb_probe the error path if the initial urb submission fails
> forgets to unanchor the urb. This patch adds that in.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20261111032125.2888320-1-vi%40endrif=
t.com?part=3D1
> Signed-off-by: Vicki Pfau <vi@endrift.com>

[Severity: Low]
Since this fixes a probe error path bug, should it include a Fixes tag?

  Fixes: 9417132df63e ("HID: nintendo: Add preliminary Switch 2 controller =
driver")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111065001.3626=
071-1-vi@endrift.com?part=3D3
