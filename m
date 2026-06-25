Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE12253EB;
	Thu, 25 Jun 2026 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375969; cv=none; b=uyYw5KicnX333Ce2SZ/ToJ3Lax4PVaUj+LFIqIms62rqLiyPeKUtCU+g3LV60IpaeT8+XfDQalrD/nDwfBxKmMBn7Jdz/6baZKbac9G8bcvA98xgusocXdWf7AD+MHoQ8Y5H0FrYSFaly6RaOE6wQXHFnjjqhgsmKPtfahUwsS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375969; c=relaxed/simple;
	bh=ogAQWFWgAEmefIFeK/00KKpXvA8UTvhOmXX+TiM8k7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s308C9Z9kbG1IgsHyriTipp8P3Ifj2GA3EnlrEp3AJm+/nysiVWEqKWw8IYVso649LiHNDZ5B/GT1Q6d/VNCKD/EtPyRLMjpwk0okk9LdYmtZn4O6Tdh5E9RdDjHvSPm3C82NCWPOQwSzCCYQiTNbEfXAooPPa3q+PY/LbelwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4AwCQrb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4AwCQrb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512B21F000E9;
	Thu, 25 Jun 2026 08:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782375967;
	bh=ogAQWFWgAEmefIFeK/00KKpXvA8UTvhOmXX+TiM8k7I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n4AwCQrbV+OQCQokPZg1Ct+t7bfVK1nA51j0TEDMNAzAg5ly9TKHcsMLk8XTgag8b
	 TFIWRGAdvr11iH89t7ouqGoLhcxEULlcB7YEaiBhVpDkaCz4wJ4c/qh4gbEWLTiKWz
	 i56GO7uUEFwkQ+vVYi0uXC2CrhG2T15gL7dtJEn08CG9OT/mGE5XDP7LeTMFdoHjy+
	 wBRI4yNTXSIHQ8aOKgxBrE6a99zZLNwINadE6j10U01YhQJ69Huyj5fbVCXUU/ZcWX
	 ih45SeoitABKwtdb/oyTQBoPIFfOycFFeO2BiGlL/OeQ+RPeekzvkbNb/IG/18cw66
	 M0u6/UuIG9F0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: conor+dt@kernel.org, lee@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260625081529.22447-3-clamor95@gmail.com>
References: <20260625081529.22447-1-clamor95@gmail.com>
 <20260625081529.22447-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 08:26:06 +0000
Message-Id: <20260625082607.512B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>=20
> Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201,
> TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF101 dock
> and TF600T, P1801-T and TF701T pad. This is a glue driver handling
> detection and common operations for EC's functions.
>=20
> Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625081529.2244=
7-1-clamor95@gmail.com?part=3D2

