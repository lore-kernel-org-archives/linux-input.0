Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1601468C15;
	Fri, 11 Sep 2026 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116816; cv=none; b=aWFpJufC3q+dZygUzEwujNEGyOYl4C0UPeaSKzXUQpBO81xiIeV9+D6SOnDCNrelXyame7EAGD3OIURAH7jIF293NL99LwDnuByorimt6YzzmlBBeqEZsiDdd9pdav6aCn8X5s8F7ttw2T1wVhjMp3uRPkw3gAh0riXKbrm2xFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116816; c=relaxed/simple;
	bh=UPAd5pd/ujZq6oZPZ0EtGkW6xgwZq/lTZtHLSrATxpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fkSFnxqLJl35SPJrfssyFaX6AsRzfj/7DPVzjSdBLbHkiN0KnL4v32zDIMwGrhLSiTHiseterww5kgFCX/gZsdVypWq1EaTzVCoG4Kjc1tr8ERv4OfJ20g85rqCS6skvgfj9mqz2b0528FaKgTtKY4ampiXO8JAhO+l8zijqaGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcLYSn0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcLYSn0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7BB1F000FF;
	Fri, 11 Sep 2026 08:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789116815;
	bh=UPAd5pd/ujZq6oZPZ0EtGkW6xgwZq/lTZtHLSrATxpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NcLYSn0pIoj6uEfqc5/wYdxWOu5hKkAG9b3zfDTNxOl37m9QJN0+tfKc8Nojn9pVB
	 2vxMlA9d4m7ax7aQqvzjvOq6OyienTAajENihoe5RMRyq+Nd/UjLatQGD7O0v/wznj
	 NpleGNOCbzmAl+lm8do/kdKB+dhjuCv64mvMshpoCJI4vVpSaXvJBVvdybs7YX0WyO
	 upi0ZYuMslvyHhYhholGMcEPWSWzM77G05X1TOuQ3Uea0h2HHx6yj8c6GrPtZGy4Bu
	 3wUHqZKnfTS5/4pBABAsm9mXoo+NXOvgBcgpI1aJmBQ4UB0Ty1jWG6nIUCTvPzN4tl
	 cYEY+kMsfso5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/10] dt-bindings: display: panel:
 novatek,nt36672a: add Tianma FHD+ video mode variant
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?WcSwxJ7EsFRDQU4gS0FWQUtMSQ==?= <kavakliyigitcan@gmail.com>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, lee@kernel.org, conor+dt@kernel.org, linux-leds@vger.kernel.org, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260911-ginkgo-submission-final-v1-3-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-3-0e68e63a18d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 08:53:32 +0000
Message-Id: <20260911085334.CE7BB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>
>=20
> Add compatible string "tianma,fhd-video-ginkgo" for the 1080x2340 Tianma
> video mode panel found on the Xiaomi Redmi Note 8 (ginkgo / SM6125).
>=20
> The downstream vendor DT identifies the panel as "nt36672a video mode
> dsi tianma panel" without documenting a glass model number. Following
> the established convention of "tianma,fhd-video" for Poco F1, this
> variant is added under the existing NT36672A binding schema.
>=20
> Signed-off-by: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-ginkgo-sub=
mission-final-v1-0-0e68e63a18d4@gmail.com?part=3D3

