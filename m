Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981CA446C09;
	Tue, 21 Jul 2026 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627952; cv=none; b=atrsRrgLy2fWkLSGhsrrGQv7lJqFv86VcCKcA/mBDRqlHITrk8Icva+DS7MLMMv/+fZ2T317JOO9l+Qbu+dPwWMcJnWyOhi8GI7sd+5JNzNMY4mBotcR1M+b3Jfgt3lrhW9XG7QJ5R0c3ydU/vt/4xQY4iOOUCc7c0ahRw3AunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627952; c=relaxed/simple;
	bh=GfNfvVyN4nJ4VbaJaTDj7hcwqUIhPjkWKnazy+LzeCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LR064xRKNcESJjrBKcmvX3DfGsTLP2Oj/8j1+AHdUVcrDHb+XM8Is5E9r66mH4o3i+MnHz3VIwPbe+oSbAJVQ/GmtCUpxviA7ZuWLb4Wf04Z3mywSQxikOlXoQAJMfgvNVCZIh7OAmFQMc0BcMiNhDV2Ts1edwbio/2KAJzC70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHJEiBsL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHJEiBsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101B21F00A3D;
	Tue, 21 Jul 2026 09:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784627951;
	bh=GfNfvVyN4nJ4VbaJaTDj7hcwqUIhPjkWKnazy+LzeCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GHJEiBsLVMKtyZGXye7epQo5lEXkVaWUcyCKngTxr+AETDHevmne6nRR9TEwsG9Fs
	 bOmRzwEnT26rHXWJz0NF0GjVXxQ5kz0pVJPYe2MZljPBGJnuxVtH9uqWa3P4q1P0sr
	 p7xtXg28wlC0iExVyBTLgiKTZEskCOV1b659ZHmf1yVVoCGs0Yfb7u+zhcEwmRqw+C
	 lenjcZV19z4+PXg1FE1D+oDjYfAawJiG9w0SykhP6Fcwo+p1W1BBfrCwVj3k6itkh2
	 dHmYuGZCDYw4GngHNnVH/m92MV7ELpq3/+JST5E7rC47tP29NpeX2vEdEZs0KR4+tM
	 195RGtmvsY5tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 7/7] power: supply: Add charger driver for Asus
 Transformers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, conor+dt@kernel.org, linux-leds@vger.kernel.org, robh@kernel.org, lee@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260721095233.420823-8-clamor95@gmail.com>
References: <20260721095233.420823-1-clamor95@gmail.com>
 <20260721095233.420823-8-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 09:59:10 +0000
Message-Id: <20260721095911.101B21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>=20
> Add support for charger detection capabilities found in the embedded
> controller of ASUS Transformer devices.
>=20
> Suggested-by: Maxim Schwalm <maxim.schwalm@gmail.com>
> Suggested-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721095233.4208=
23-1-clamor95@gmail.com?part=3D7

