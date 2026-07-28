Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541BB47A882
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 23:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281301; cv=none; b=eiJhGhkVhqn/qxMyS6u04xAE4e7vDLS255U+WYDoli28WTeMxADf8bwtE2SGPoxZgMiaHOF5Org1SAtMlgSRZ7Lq0eg0KXUIJLOL+fyZ9v/5IW0V9lZ+7XeAPK3MPUcNizQzAmhFLGteoZ+6zo890i5MzybXabg6dkak/OJyj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281301; c=relaxed/simple;
	bh=WE2RMSzRPf7DDQZEcwS0yv0zbdw93XAGK3ydReqc3KQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ga/6gNpcZEcWY+ZSSrZnDYJhd7KObW2K3u/dJDAA87HuhVDKjYLrBt2Ulge9Fgxa8cy7hgKl2lkGbVcvL9uXeWqeHREBgdKs3Zu+pPGujEi4TAinAB+Cf/GZKAjcZ0b6NhDYjpynm+MveYRPFDzE8MjoiGOQszZOGLuxmZu1hyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0pMjS1W; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0pMjS1W"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so281244a91.2
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 16:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785281300; x=1785886100; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EDTWcg9smDGyOPZ/CcGP4ZShZmqvB9amjqwO/70m1hU=;
        b=g0pMjS1WkJ5pfn6uQmWmg0DXduBMetGdSkVAzeqiThW7xCimEG8fU/w8LUX78ZzIgC
         TgObBLclekCZMbGY3z/PR8xJlemfbuL47+aee82l5f0eAKAdYIWQuDQP369TrdbJRrV2
         xFAsGbu89tgDakDeCh3axVMtBmXGa9DxE2SPZJLggi44JpQLB396G8fB8PHp0h9Fv9mC
         pghIplB8mWBYwwQf1Ey2d6aRaldG8vPj21zALz5lC8LVtMdsUKPsYQIaTLF/k9zFgZ3c
         cPwSteTadltwpH1dK79q9quCMldvrQi+RhlnvZ9y60ww3zlxdRqpNKBONxrfxj2WXkD5
         9n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785281300; x=1785886100;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EDTWcg9smDGyOPZ/CcGP4ZShZmqvB9amjqwO/70m1hU=;
        b=ArXoJAXldhSDigWYwQiwP2hwCI25oz6vw3BGgpJVIGDCPufNmz39U85Jzm69ZBVBAA
         ji26RTA4g9OMIrWYmSKr2PPeCYpToHCDXLAvGnCoTqa07MRyi94Moop0kFpZBN2WLEk8
         Er43g70i31aXr2xaNGYPknxdOizn7aqMhJJgFyaU6p4spVPzOopsC5VqWMxi6PwjJ6jL
         yOukKbZg17Zi4SAT7MDssNXEs6ePQQ+lsU5vFHGCR24Cce21aCkagOqwNlS3LM8EZjEs
         KneU1emQ5iiPAAdaTfz77a2c57e0qTL9hF7i4jWoHl5trBEXz8fkbjFgqyIInpQPX0Es
         CntQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqe5mxcJg2XaI3Hp6N4EFf07ar3cyvWz8p0ISYaK0n1d04S9v/962NRAE+eeyoIaEcFoKYK4iMzgSReeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRHxuo6VjN+7zCipjtzvYvhO47e5OEm21oXLHgZamGONUTu/cv
	+I60V8QTjebA0o2euhI2O8vtwJKm78zmfJlwX1YR4hT7fGOd8lrIkBbE
X-Gm-Gg: AR+sD138uew2K87odbSJphpS4ZGsDWRZTpFk3Krw4gGJy/hXnMXn29bEZakK6zcsjFN
	myRB7E+ZUNzC6b6fCkPtKcTFdeKKP7sMYqr60qhCiUXJxq0bNiGD4F++dH85bZCptiRrP02ZWhs
	kMezQT0WFNnU3oLwz6AbNtsoQI039JkLZSgDqfURndl30qXQVYTNNlmkwmMOjrGBA0xqytWMuS7
	EFPP0BW8lCP/1XcAGJSnPnqbs0o8NnELlox17ugIK7q/l9hM64HU/B84g0gplTHMkwiqDGqIS7c
	dwx41zOSryChcmC53KwUlgtbrBfKk0CGx8iktzCdEWjqHMkGjAp84QylKm9mlU8OzDMaHBDDSZV
	3iUv12JjpCoz6G3O+KDtZ6atVO4LHvPAsRiF1UKcgGCroCIo4iBNVu+6Z+zIfVVrLnk5Q0kMwbe
	eD/ujPWiFuwP17SCIVDvVnxxBoM/6JpYCJZYx/OM7yicf1nLrNfv9I7tlgjvtMfF5dcWUpzQkpS
	HywP7EAAOOw9SRv4QXJ/y6JIyIL2SK6deVWsJvYpwWkemFmGRg1MMUj
X-Received: by 2002:a17:90b:3a8d:b0:387:e0db:bc30 with SMTP id 98e67ed59e1d1-38f6a457c3bmr4202203a91.38.1785281299593;
        Tue, 28 Jul 2026 16:28:19 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a358:4bd1:35cd:2e45? ([2620:10d:c090:500::5:ff91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b670dcsm2851374eec.7.2026.07.28.16.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 16:28:19 -0700 (PDT)
Message-ID: <7b46b97ab3380a657fed02d1f730d0cd7b484137.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] resolve_btfids: Implement generic
 ensure_mem() to grow arrays
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
  Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, 	linux-input@vger.kernel.org, kernel-team@meta.com
Date: Tue, 28 Jul 2026 16:28:17 -0700
In-Reply-To: <20260722233518.778854-2-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
	 <20260722233518.778854-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-22 at 16:35 -0700, Ihor Solodrai wrote:
> push_*() helpers in resolve_btfids contain copy-pasted array growth
> logic.  Factor it out into ensure_mem() - a simplified variant of
> libbpf_ensure_mem(), and use it in the helpers.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
