Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696153;
	b=yJKq77oVikkm54IEpfBPem0UVFMqKINN/kF3jEnHekmslHhT5WAaCEPe8ZzLpeV3JmIx
	 81p8fd6V7h8n6dRE/5cwJaFSbebDRU7c/sc6/CwRa+ZXO6bAd/cvpVNPtGLYIlmM1V/0I
	 8fO2T0F6QcH19dStUsYIywp4b3yF0cJ7YK8SVWTaTuEagaXapSnaySHvi1is2Uu5TmLsx
	 SXwVhsrBk5rBcZcg4ZqCaNMYAqgDevZQP48AWGdh2zrnsf8uj9S94RmJeqgWGRwKiE73p
	 Bqx5jecM2faFRQp68hjl9c2aMdHlzmIxqwgwaUQyfMgTFdQFfsosjuqmH84bGOHytBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696153;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=63BcEqnlg295LDv2aeqv9MpAVGdLbkxykMRhbCGq7To=;
	b=xNp3Gn0HoZOwX+/2j9Cn+6RxyQmtdWiuTCgKaGfYUrciXdTOQSEzt9/TAxb1KB1+4b74
	 JtGpHTh7KwpDQxOlVg5uXZlKd+uuSiN/TWl7Cg6CJbpwQfvqf2F3BLCuPS6F/pYdwgaOX
	 qf5N11vVv6o9suADlr5oX8RoX1u7aAAWMEYsYNsWDHOMrWSFUhnuQA+6XxYUtTQcnwR3z
	 VNIYlC4fI88fkKVUTgJzo28Sjvuct3igtoq2YwctVQihkZjHrff3d7U/1oko12bJ8BWwU
	 ijwWKlY3K1VTVgg+PBis5Y2dAR5KsBBSm5+gNA3nktv/meBNpblYjWsV5HGwTwPE6PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E+W4tSFF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA0606A326
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E+W4tSFF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248161F00919;
	Tue,  3 Nov 2026 08:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696152;
	bh=63BcEqnlg295LDv2aeqv9MpAVGdLbkxykMRhbCGq7To=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E+W4tSFF6kTXQJpQsX+rSWXxrw+Wmz+bG2OuUQxtqE0TS5fUbWfcbmTsSGMvsuE88
	 eaiqCI793tplOZ4IkrhLBrUvwD0ixGmFg93svofcYrk/guM5XTm7r7ivJhRBO4ef93
	 Xq8eo9E/YmwAXwBPU/5WZu0WiRbGyiV2giAjK+1fDxu+416biwANrE2Golqplo5L69
	 6TxMmK2nZn5DID2Y2tHMXRc0OvcqiXzgmesPzhT19pyh8MK5Ys7Cm0RDNQuRSVIkdh
	 STxX6xWSPjb6D3wqB+XtLBWB4vtQ7nue/ysDGtEydjVbX5OWyAiNtxrpIOZ63/JMdz
	 uK3UT6qLdPHVg==
Message-ID: <sashiko-outbox-194899@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: adi - bound the two-stream packet merge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanglei Zhu" <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261103084135.426629-3-zhugl3@xiaopeng.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
 <20261103084135.426629-3-zhugl3@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 08:55:51 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Input: adi: off-by-one check and uninvalidated streams in adi_mo=
ve_bits()
--

commit 72de23854de8740c131cf08cbda4e0025c231b6c
Author: Guanglei Zhu <zhugl3@xiaopeng.com>

Input: adi - bound the two-stream packet merge

This commit adds bounds checks in adi_move_bits() before merging the
second ADI stream into adi[0].data to prevent out-of-bounds reads and
writes when the packet length is oversized.

> diff --git a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
> index e07b71978509b..03535e58d6a60 100644
> --- a/drivers/input/joystick/adi.c
> +++ b/drivers/input/joystick/adi.c
> @@ -168,6 +168,9 @@ static void adi_move_bits(struct adi_port *port, int =
length)
> =20
>  	if (adi[0].ret <=3D 0 || adi[1].ret <=3D 0) return;
>  	if (adi[0].data[0] & 0x20 || ~adi[1].data[0] & 0x20) return;
> +	if (adi[0].ret + adi[1].ret > ADI_MAX_LENGTH ||
> +	    ((length - 1) >> 1) + adi[1].ret + 1 >=3D ADI_MAX_LENGTH)
> +		return;

[Severity: Medium]
Should the first check here use >=3D ADI_MAX_LENGTH instead of > ADI_MAX_LE=
NGTH,
and should adi[0].ret and adi[1].ret be invalidated before returning?

In struct adi, data is declared as unsigned char data[ADI_MAX_LENGTH], with
index 0 storing the start bit and payload bits stored at 1-based indices
1..ret. In adi_get_bits(), the index is incremented before checking against
adi->ret:

	if ((adi->idx +=3D count) > adi->ret) return 0;
	for (i =3D 0; i < count; i++)
		bits |=3D ((adi->data[adi->idx - i] >> 5) & 1) << i;

Because adi[0].ret + adi[1].ret > ADI_MAX_LENGTH allows adi[0].ret to reach
ADI_MAX_LENGTH (256), if adi_decode() consumes 256 bits, adi_get_bits() will
reach adi->idx =3D=3D adi->ret =3D=3D 256 and read adi[0].data[256] one byt=
e past the
end of adi[0].data[].

In addition, once adi_move_bits() has verified that the packet is in 2-stre=
am
mode (!(adi[0].data[0] & 0x20) && (adi[1].data[0] & 0x20)), returning early
without setting adi[0].ret =3D adi[1].ret =3D -1 leaves both unmerged half-=
streams
marked valid (ret > 0). Wouldn't that cause adi_connect() and adi_read() to
decode the unmerged half-streams in adi[0] and adi[1] as if they were valid
standalone packets instead of rejecting the malformed 2-stream read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103084135.4266=
29-3-zhugl3@xiaopeng.com?part=3D1
