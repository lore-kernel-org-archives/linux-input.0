Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4D48CD4B
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397226; cv=pass; b=cC/4PmeZla84Oq7zsmFjWDNnC147dIIdGOSc80MA+Arl7U1/0MCKTqvnP5fIvl63uEBcfwrri50vo6sj1wF4LOW3eoxhP3ycptTOzIYJ0yeH++hAzTRH6mPEfgKg/g9kWVf5Hfl1I2FAj7PAnYhd2niJfHpL+V+kS3Zfv1+M27o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397226; c=relaxed/simple;
	bh=ojWZsLxBf/E+oTlWaEvpu7l9Gy8FFWSO9+FSkAQyrOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Unhfafh6+1cJ5dJggK+7CSEMoToGiWJuWJNcvu+a5s1HOI6iIHlfVVPP7wjXYb6JkSUdF3g8hdUo+jtWV186kLynd23IJRQTZzC26MfMMgwCWMNN6QYTG/9swmCBGUJUjQLt2OXAZzlyz0nXSVqA8zddyEZiXq/wO8rKTbtFD1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkQOSc2K; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkQOSc2K"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a05effaf8dso489161b3a.2
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 01:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792397225; cv=none;
        d=google.com; s=arc-20260327;
        b=pts7/CbGzAOKdlLhjCatEGIdl+ledL1ttTW94WYiA0XRrswY2YqX05pYX9DtKhSBAB
         dsJCo1SYulHD4tSN4bnHD6qnXw5eBPaMxQOo2TaQ3c52AcvtZoYZLx9ULrPRCtVbpxaY
         Z4pU8Sx72RA/83M2PiMMfNfxQKS02Jca0FIcd0mVfhjF+P8b62glZEWmpgZppZLQwSAc
         0NUc1vdGNZG1w+if/uwqSriuk+fUvXoLYYE9c+I9OuNntozUoNB4s4RAPQFUA9me8kTR
         TwREpTE3H5kw6i/9B7mMRkFHEiYu04oHj3mEMouf/3GzNm9chJjTROHmlIJ2yveDOS0U
         vU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OapHBRcO/exbGoTSwjHoSV037nGR79dQye9OkHt9RRs=;
        fh=a989laamQPHkWHENUTo27lyEMkB+j1yGMCZD0NbSnHQ=;
        b=j9hOWNZ1mqzyeNJzK4M3WOsdoE3ZQzuzP74jr4qg5dwiHd4/wMuT6DOzvuFmkPmMzh
         MqdC6SkdQwmlqKxiTEjFPXit9ndD9syZ+MC9KIvyvqWA6zMCZOdHAoMhL0t+zvS2wLD+
         XkGBim/tg49F6oG8hya37emS770T9YnolspK2co1D6yxAHrzG9krk4avf/j7A9Vx+Sz1
         A1OkeTGDicrvj2QnzHpj9QhkwghQMLP1kItZ0akglJWlVyJyMysSvj6YqduiCLG/ECmx
         T5eNkNuG0FswCbYJCwkTkE5WXCOiGVbYBgyu/95AzKt6n6LsxsCo975c7ydbngfz18e2
         eVpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792397225; x=1793002025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OapHBRcO/exbGoTSwjHoSV037nGR79dQye9OkHt9RRs=;
        b=TkQOSc2KalxknOqVU+eistxoosuP7UMGLTMlh/iZ5K0ItpGMd7YJRzim/mcJwb2XPF
         /hTOtLNK1z3VQCDr9KAqkcofQa6mQ1Vg074rjAHkT/ZsNgxykaDt4xjoRC9N2TdeR8Cx
         AiHl5wDlHzJDdY3SzlWpZrD6qZUj7oKf5wIG05EO1ax/LM2uv3p5XEt2EZuJWihikIhw
         4xXiEehxbpV6y1VIO20PmiHGpZ8N9b7bMN8y/Otw+oQQ+B86MW5sW+nBb5WRIbk1Sdeh
         /A3kH5OX7qB4ghgcBagPE0njtCFzgAvtADwGsUzAkk4EL2u0LUhpS2+pyM/fW3bk6bdE
         gLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792397225; x=1793002025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OapHBRcO/exbGoTSwjHoSV037nGR79dQye9OkHt9RRs=;
        b=OxalLujD7g/kJQvXHGFPGN+xKXxdpznunXBYDWtV7sVqRgiYm0rZLDu1b7m+P45xH1
         Hi8mro6wBgXd4ZRXCAs2QHHY5LNrj+pDDSXRX9ZWjQch/8Ua70JMODf+JrlHdRWvi8eK
         YYVT8OsCvCcd/FTwxzlt8VnCSxDzIDxtUKgBJI2uZ+5Qw+IhHNX5KgG2LIsHnN0DA63q
         laPG6eU6jAm3vyfx3TnJrzOGwUL7+OQru5WYtd5tZu8uXFujOJ82R4P/uILD/rcmW5yL
         MDPGxUBLLjzIWBp8MtTiQLDcagbYuM9nRGoSCMnd/UucBHcvJCy1aNG62PTFXefEuGrc
         6HNA==
X-Forwarded-Encrypted: i=1; AKwUvByq87U5dW6RbKLUkRGl0iKFiHCZ1jsArc9JinrP8/QhZaab3yvjSyrkPKP0iL7Mk9OFom7eaU24ZdpExg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJmOYouIdHXa+K3V35qp8GEr9Sijh5n97jy4xZeHZol3eUF5Xpn
	x10CIW9Nm8F7Otgh8jALwYxn58eZ/pFBs7k1T1BRZ7yx/8Ff0FMsZpcQ06PXj4MEmVp0Pl0xMNP
	s4OJCx5m4qm/Tj48PFHfj8DYgXbddPnY=
X-Gm-Gg: AYBFou3Cb+V4ttLzdj+F6/Ruwx+lCSWGlH4c+fHDcslLe91ZDD13B9WTLdk8lnaqIWn
	6zOf3M0FrWlIRLSPtFvYIOEVB6itLlLan9ttzY+sfay4hBm5HJiix7mcQJltmrJxqJsVbHZJ/nQ
	ZHviBUT3rwXPJ5EZbhtX3UtsyljGEUco95HHjPF6vvHg1nYaYKoP2Iqh9kwICG7xWdoF7Qr2+am
	2WW8245DhcOvPNU2os5Knfb/poelMMJinowLfDjAGdOCVkqfa3h7eQ0CR4AerthurJ5fDroVDSy
	FFSUpwkwllkjNfWYCjrdNrrQBxGMCsSvQ9Uo7/emjqA65+tVLX0PmOlsZXsGem19NqthKELvUhp
	98uBUFngJkX93RHIEdbntE96tNKmsJJfLyVACCT06droQ4mIFgCmpHQBD0pr5gHlLt0VCwv+BPu
	MHpWLNJw==
X-Received: by 2002:a05:6a00:1f12:b0:880:973d:597a with SMTP id
 d2e1a72fcca58-8a04d04e513mr5511453b3a.53.1792397224811; Mon, 19 Oct 2026
 01:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261017140827.290666-1-lukapanio@gmail.com> <20261017140827.290666-6-lukapanio@gmail.com>
 <20261019-free-groovy-grebe-7e50d3@quoll>
In-Reply-To: <20261019-free-groovy-grebe-7e50d3@quoll>
From: Luka Panio <lukapanio@gmail.com>
Date: Mon, 19 Oct 2026 10:06:53 +0200
X-Gm-Features: AclHuK9kTiQI2FRvtYDoJKATe8CTCBUQkubjvei0NZuQDDdDmbhaB9xhCb4qNvE
Message-ID: <CACi=Ov7D503Ug-D2xmKvRP-LceQpEWOrktXTy5Srdc-MZO=02Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] dt-bindings: input: touchscreen: edt-ft5x06: Add
 FocalTech FT8722
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,


The FT8722 is a TDDI: a single chip that includes both display AND
touchscreen controllers.
But seems like other  cases like this handle it differently:
focaltech,ft8719 is the touch side, while the display side is
documented as ebbg,ft8719. I=E2=80=99ll follow that in v2 and use
focaltech,ft8722 for the touch controller, with the display getting a
compatible for the panel module including panel manufacturer name, or
something like that.

Agreed on the properties as well. The supplies are shared with the
display and described on the panel node, and there is no wake GPIO, so
v2 will disallow vcc-supply, iovcc-supply and wake-gpios for the
FT8722 and keep reset-gpios required.
