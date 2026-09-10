Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BDB396B96;
	Thu, 10 Sep 2026 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011134; cv=none; b=Q8xeDUu8K4Jfwe4JklYJkqd1hVP76lcTnczPZ0+cqEGZcAZNNxNshUpxjSPGE3Ud4c2p2oW/+h/1GoWwFTICaRo+ryv9hiZ3drnU1syg0f9pHx8Irbh7Otx3WnvfbOkR8Uhi9uRMcSBTvnSurt4q/kxwyh8L6hDTctHzh7PTFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011134; c=relaxed/simple;
	bh=8N42WN5a/jghyuD+PYG6cenusKKosc+y3vNRH3MD/7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nuEBXC/Uyw7LZlaMbI1M+rMYf+wHUeSODZchE0dIE5vnXtAWzscPS2lTmCBUWLtj7Kz/IAFxKVe+6ZMXu5Ld2PGqjuP66ecEgqAkxQD749ojuNRV0T5PDXOpnmXycXEor5VpcaDKmm+EvYQsctrtknK9rQ/DMZfCBqlA377km0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXifELma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXifELma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3270F1F00893;
	Thu, 10 Sep 2026 03:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011130;
	bh=8N42WN5a/jghyuD+PYG6cenusKKosc+y3vNRH3MD/7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QXifELmaH0DDQ8hKmanYJAwjwkQvZYgJELzDNCPx9DYtI7UvTQYJwSotmIA44Eym9
	 Pmer1eAf6prO8OFXWTxzLLSOBJXXLgqv0QHcJK45d1E7Ea8SqYNCr1B2ur4uwEuDsj
	 RiAqA8UpOhFHM7YQFPRhlIHC+JT2Rzeu6gur0gWX+vDZXt9qAPTl3HsaCfrZYVuBSy
	 ygJwZGkgDjCaiaoLKPKkH1IHjidYx+UVRq7Saue0vAEb5g+6G/tPLPvel+wYilQYik
	 vYjqwwjWbovYisKAYgbNv19S9wKm1eSrdQWjk8+TUVrbGEKdj7KPZbK6GAdtDbI+WI
	 raBAmYKaPbwPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/15] HID: hid-oxp: serialize complete RGB updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Aldea" <andrei1998@gmail.com>
Cc: linux-leds@vger.kernel.org, lee@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260910032115.28669-7-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-7-andrei1998@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 03:32:09 +0000
Message-Id: <20260910033210.3270F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> The transport mutex protects one report at a time, but changing an RGB
> effect requires a status command followed by a color or effect command.
> Serialize whole RGB transactions so sysfs and delayed brightness work do
> not interleave these command sequences.
>=20
> Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
> Assisted-by: LLM
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910032115.2866=
9-1-andrei1998@gmail.com?part=3D6

