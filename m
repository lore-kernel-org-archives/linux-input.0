Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC5537FF40;
	Thu, 25 Jun 2026 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375812; cv=none; b=RIXhiPVQLDLEIS/p0U1gf/70ARq+WClYYd7bKZS33dG4fkGPU7iyRVVmKy5rSAhJ3jw3kg/2oL/VmPcSzMdeeujE+MMgc5Cnu2ncNPuVs2QSB/OkU5BAcpZ/lfo6ls5Mh5jqcn2O4bL3xp/WgBCW1EbQXhvbkksDhhT+BMJ4LtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375812; c=relaxed/simple;
	bh=6Ad7TtFrDQc7hFhtDC187gNuj7FjgUx7uefnEDiJy1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=acTQ4g9YNfoC4akagpP51SuOdPfhtUXXqfjtt6299J/ZxdB4SmtVLswsTphOjpGcUxvwGCvbYtMBIG/enxtBVWDomCLod996m4S+q+ShMyzZvAxuxk5MEEEowgXbjP7fmHk2el3FMP1RtGFw1A+Ewslfc7xP1xv3ZjB8HQKTNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNh1wqak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNh1wqak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FBB1F00A3D;
	Thu, 25 Jun 2026 08:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782375811;
	bh=6Ad7TtFrDQc7hFhtDC187gNuj7FjgUx7uefnEDiJy1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VNh1wqakpry2X707eY3s5NlyA0jIE2dk7Cniys34nAeyv6Pzhd7amcnaleuoVwIS0
	 E1ndRbVrELr57o5FV+V90AhE4zrap6V/Jo8R/L27JT8/M0y25/Ic0pEUubgHIupY+Y
	 pPFGNo1ZutjJfIpuOYCQLkWlv+mwx1ZabLkv+0ejW0Bz7nCykEsWd0wOPJL07/jXIf
	 vqodsb4MV9pHvnLGq4jKwc/dQH44z3RU7YRVSZw0gPKA3kpSt03e7R62WPwNMkC+H1
	 SRAHBBobhfG6kINcfeqtoczS2esyWr9cYGsGxhCD1jBkHujqJcZA0mMeiX5wrbV1bf
	 cDdd2jamXoSlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/6 RESEND] dt-bindings: input: cpcap-pwrbutton:
 convert to DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260625081812.33474-3-clamor95@gmail.com>
References: <20260625081812.33474-1-clamor95@gmail.com>
 <20260625081812.33474-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 08:23:30 +0000
Message-Id: <20260625082330.D0FBB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Convert power button devicetree bindings for the Motorola CPCAP MFD from
> TXT to YAML format. This patch does not change any functionality; the
> bindings remain the same.
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625081812.3347=
4-1-clamor95@gmail.com?part=3D2

