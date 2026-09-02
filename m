Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0B4052B3;
	Wed,  2 Sep 2026 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788383122; cv=none; b=cmawIuuX8I+HV2/CbRXacHm0/0lrQBqk1aLz90wrnQ9D86kqLl+aULvc6eBx6K9XUf+erMcfN6A3mck29nt1CgcAK+PVqCKKw9ZPCOwHldl5tHDYjOqo6p5f5XtbWQ3Xagz3hwJlOUPIKOj5DU9boQelpBqkydt2T14gO8H3YyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788383122; c=relaxed/simple;
	bh=aKP1WUrN3RtHorM5Q0A2pbrmp9aXnJlDrssy0jVWySA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m54pVoApZhPAqjU1paMPxmwoO/kJRL4DpnsHj/4gm9crKk7VUPLqwUYxrh/S2MM6hjbBPW184DsFAfURLf8KR7A8YBOlS/OHScoFCFIZ9Ui9KvSNRPNpxxqFIWMp6sjV1Kn1RUkZf+NAhIv4yYGrcphTG0Qz3CPYJ3rOZN713hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGzffUUF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGzffUUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0508A1F000E9;
	Wed,  2 Sep 2026 21:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788383119;
	bh=aKP1WUrN3RtHorM5Q0A2pbrmp9aXnJlDrssy0jVWySA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EGzffUUFyvCUzf3Pc1exwL0C2zlesv82G/mLzPycCPW/wTsncYxCfDtMyY4Q0zkF1
	 U0fxgHkyHYrK386IQkGeA3d97jUIoHM668aMAbKtYlb814AaiYtTiEojhGtci54sZ2
	 UumrfdJURQyWENnoIlVvoZcNNm0mFh6vlboNT8mEDQc90xZ7QkSvSw/T9ZaD2yk/td
	 jOKI/zUj9zSmOj9nOnvb8rYgjeHCoY23V6zPFjp1F44mghrNA+MHHy31LiMIG2hQaF
	 fCd60vMMpwjwoVQXLmHikocsAGgMCJK+HYhEehchr4blB0ljEGa5tzmVM5JYeRnRt+
	 bKrcDaGjvgCAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMIC
 dtsi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: devicetree@vger.kernel.org, mfd@lists.linux.dev, lee@kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, linux-input@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260902193351.185771-10-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
 <20260902193351.185771-10-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 21:05:18 +0000
Message-Id: <20260902210519.0508A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Val Packett <val@packett.cool>
>=20
> Add the dtsi to be included by all boards using the MT6392 PMIC,
> providing support for regulator, keys, pinctrl and RTC.
>=20
> Import the new file in the shared device tree for the Pumpkin boards.
>=20
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902193351.1857=
71-1-l.scorcia@gmail.com?part=3D9

