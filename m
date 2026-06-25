Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107B37B03E;
	Thu, 25 Jun 2026 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375871; cv=none; b=fg8Aa+I0WqKIRT0eHHhwlY1fPYx6uifsee5FNJAVumhN18r+zqZeQKP1sDcVG+W04wCCXoXVN0e5C0PxA28v0bPCWfzIt1aiU3toVDAljuo7SALa29yvEKiFkOChSARftkjmLGJBJOSiAS8xkGpNKOyDmKo1zT/TcVzGt8D8Ob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375871; c=relaxed/simple;
	bh=QqpFTRuCYbfkrvajuXGbgu8Cm7Y1hSYlQvHARFpT59w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lb/PzzCtq3miNxsyJs7VYK+2dwn9Y17Yt3Q7Xbk2r1aqibDSsRanjUsWbitiPV/xUmqWuF67dG5CXc7WiUDVB8D3kvlD1ptXdINVe+OE6FIp08f4+KmAlnHo4PZ1Ym5tIRHBbulT3UNWsKBzChiYAmVAQgzz5uysZqawSEF7e7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDgdYCIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDgdYCIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95941F000E9;
	Thu, 25 Jun 2026 08:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782375870;
	bh=QqpFTRuCYbfkrvajuXGbgu8Cm7Y1hSYlQvHARFpT59w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iDgdYCINetY7SkQ2ivYP8zNSDTSzrLzNMnSrZ+15idpq3UQXUXupK1rAmupvaT0cR
	 gLI8srx7gNcaOrBO7dKATVDg6EC1tz4O8ajuTdFp+ma/BphnnJBorwGXWOzdzFNuWp
	 onPynzuYa5ZNsTUwrZMVvvwNHSUCW705fUuiFQGF3TD0fCoHQoIWMaF3ISNiiuJ1WX
	 DUCat5VQE7MixipWPAQqbV9q020q7IHbRGG/f2fQ+hHy9e12yHw0EFwg0UiqFjoPqs
	 jIDeouEf0M0JpeIAbHdu45YtW/sr41KOWQQDhcgrZ0tBjPurGMHPeeA0QmeHxaCbKm
	 rdvMVwp5Uly5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/6 RESEND] dt-bindings: leds: leds-cpcap: convert to
 DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org, conor+dt@kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260625081812.33474-2-clamor95@gmail.com>
References: <20260625081812.33474-1-clamor95@gmail.com>
 <20260625081812.33474-2-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 08:24:29 +0000
Message-Id: <20260625082429.B95941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Convert LEDs devicetree bindings for the Motorola CPCAP MFD from TXT to
> YAML format. This patch does not change any functionality; the bindings
> remain the same.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625081812.3347=
4-1-clamor95@gmail.com?part=3D1

