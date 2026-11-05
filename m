Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793871768;
	b=FjmHeo6CgpbDrsFmaIPjVdgxkntWD84Q+P8K8xB8bNBdirJ4tO6h/feU47DUf2e/SfdP
	 thIQO6Cj6L/mEy8y7PpgofRmHipxQUz+JZoL5dN7R32NpS3OZYy/Q4L5kaNQj6HdbS5pq
	 aUHG0W9XcpJ547tWRN0AmQASK6qug1oIx/qgX7YUT+ileW7aEw2zZmZWqBa25gIYKp8bG
	 JXW6osRRJmNjKeBJyHMuctoI7TSBH1K1rzRTSyo5fcafy/cSCGtoauYd47SE2JTNwAhmJ
	 e7wSR7oWmRRO7EyFY6aQe8Pu+lYs2SbLLOTiDqT3kR6ufQ1nv4hwH9j8cBtBLsfE9yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=9KVyqZjLxhSDOn37BJsTtiq5i2CumiInDbFkl3r3JTg=;
	b=b3yoB6/yvPASwUd6Hc3CoMjtI5EVrDW1mfI/6DjSsiEVjUk/mZ7MtqPEVFMpCWBWtTAj
	 hYZh/QoMziuFuoGu51eZ9wf7X0B8CTj1a7aMSGNQrZXpwBLZhuoeItQsnQiGQ+XwstHPV
	 1fae47pGKKM9NhbEAjNLcbK8Aqqw/HDSVzVt52HvHnAT70ieWTaDcbENTE6/7X1/kDRZ4
	 r/4UAqOX2FkXokKiMfaSHSQ8ZHL0XykSNObaCQogpvD+CnRxHZKn3iHRQC/x8rA+Q5dJA
	 QkT3LvhwCIvCtmoWfUQlT6rU6VM6ME2hnhJgRqdEYT0Lew6xCqC7Geb8jtAtIkYqAUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBCZOVag;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC10606A32C
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 09:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DC10606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBCZOVag
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b5669a5100so1887317a12.1
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 01:42:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793871766; cv=none;
        d=google.com; s=arc-20260327;
        b=RkEd1FfEpi5Hokt3+ylnVt9UsWPE8Gk6bHdEDRpjGA+kufr07FNARmevnZuiyjPII3
         NUS+nxhAyT+PoRcE5cN5vdyGQ9sLcV8hQGSyIUzTaCSuUb5Ed5oFPPqJit40o8BaCxUz
         HeJZLaZM/4/ZtOzofbFSV2cy2++RSYLCUEaKKmfuEbRkY3FGuAWryKonlvWndsyD0ZGF
         JTVtN+VbBWSs7F9kttd+gHX2kf8GDIQoKoPXgZbUqndafxnRvH1zw7wXEAIdjXn9f2Uf
         vKhadQWFL11PSGoH4+d8zdAHfC8MM7jGNBfLPFihXNlAHArpbSoPiA08EgL4E72fhHmb
         TkDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9KVyqZjLxhSDOn37BJsTtiq5i2CumiInDbFkl3r3JTg=;
        fh=6+tYHKksBJpyPHjJxNDMe0gdY0hebY1D8i2OlJdoEQI=;
        b=ZWK4QTKmyoDRled/mJ2MrEv8BAC/IKit3v67JMDDDlh09XacwJLewEE71Tr8Y05k5C
         hbBzRFhOsB3LPcBe1TSAb1oHl2QV34IUr9JSGf7uY4vYxs6FxRJa7Tr5JZNJpJwPPOoZ
         fFQTS0fXjYbvgmbdPzSc2KT9rKcGVn4AtqX7e4KscQD9v0aLVX82Wdt13n5a8uNLujxD
         SJ9jpmKfY1INn5Z57O4Ps8eJ4Q3A/RWxLEKE+lcYhRg7W+Vncn64Bne+lTya72bl38XW
         uePu6Sqaocd6JtdfRfg9Cw8+tPBy3COtg8/HCwp2xz1tSKdNN5i+ZGsLhhFN8ydLUBJ3
         s+YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793871766; x=1794476566; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KVyqZjLxhSDOn37BJsTtiq5i2CumiInDbFkl3r3JTg=;
        b=lBCZOVagTQVLd9KXSuiTDMdDSUssX6sHOvFz6jllJYqirrCE9hPUTo49xM4gJtulHD
         mbB90BoJR+kAHY5NgspfzKWw2JtqDRvz3eqaznwFv3AmMzGIX8fp8vhmJSQ0mwgwjguK
         pT2aWtLj5fBJ9jcZbx+nC1NK4eQOvNHWxie867CTF/vf5DFavxvesOEdTQSHjvJofvqW
         wGHKGvjhrHgi62Vy+rz7cAxQP1+FsgnMIG5U7uhcDf9ppFWsbDTtAU5ysfnZYVzCix4q
         cw5IbWu3uYh8SbdQ59hSYfZqX6k7oxzo6nXPyNkUXO15cChw3EeKoUbntDa2K+ueweim
         kH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793871766; x=1794476566;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9KVyqZjLxhSDOn37BJsTtiq5i2CumiInDbFkl3r3JTg=;
        b=OKc9HMLXf3sHQopAyUI6jWVqDKiUpWhG6pGBQSrx0Yy5dC8iqZEEWICkZJyJs7QxzD
         9SDQnN5ncqQoXNyEMcc3vfPkhJqAXDMpefvbw0LqsBhno1IVHAdZek6QLbcdvHmQLbys
         icgK+NeiluE2GpaUHdRM7B/1NHhAy6lTgT9HxOWBw6jgKmO2kRs6go+di1O6KlKn6Omt
         ZOjF4/gqyskK1UzqcrUH/Nf3PSu4m/EyLHznsLMpd5k9qAHs0Hmv87rP18keARBjp0NB
         /NkzvxH4GgEo0X0tqsqEuSs6vM4UfnrSCGUya5ztV77XNY74yraqBlsPvz+JZxxAKMC2
         Cs5Q==
X-Forwarded-Encrypted: i=1; AKwUvByA2I9ZDJmyyj6lWbbgUTXk6elI05WiuFSR7CrVX13roAzlF2fZ+3Mb56pTR75Ih7Expyd0U7UpGG4Rig==@vger.kernel.org
X-Gm-Message-State: APuU4Z9IaypGCNK1yv6bCnBmOnRmuUeHfaKLJSH6MSwxuES0pk2pMTyR
	9Hs/FsA9dnVPnPwlGtPbalMfa0gYh08Cja6H/9IL589o7pRrY3R40IY/Y7hEj1PWX625PI8BjyO
	0X0OSvYGUvUueDtZ1I4H8J/lrQ1rbq8Q=
X-Gm-Gg: AYBFou2S3qhyw3sI1itElb0OUEF4Oe79K/PceeEesOCMNI5n/MB3MENoVjO3xv0NJc/
	rCAVCzUvFdnacMPhwFKrYfExZ5IFnUG9E99ebAp59MB/diRM8a2OwzAp/URf+fHk3EE1zZHEb5c
	X7awnobki0yjBxHGfjR2/uLmsXBBM0qq9Od/vd/5gXQqNPpi8Y0nPz8eIAwnkAzoi0bsYqYDGoy
	j2vCFicfPoKzqnVxP/Mt/B3IDufek81PwdmIFy57y50AWuLKh9WkIQd4saGrk+o9qJGHEofylH6
	jVG8vBsBGMJQ8+coa1+629i+EYTfj0MBiq+V60JkAX5KpwIMX2vuHFmmoyQElLvfLZHElJYGOq/
	tjal8TVGIXzW9VQtaTaS4izUGGOy5yXHEOyo=
X-Received: by 2002:aa7:c2c9:0:b0:6aa:a33a:2762 with SMTP id
 4fb4d7f45d1cf-6b4d3377817mr10254827a12.2.1793871766289; Thu, 05 Nov 2026
 01:42:46 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021105109.199886-1-l.scorcia@gmail.com> <20261021105109.199886-5-l.scorcia@gmail.com>
 <179310028255.2808517.13933580516140278450@kernel.org>
In-Reply-To: <179310028255.2808517.13933580516140278450@kernel.org>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Thu, 5 Nov 2026 10:42:35 +0100
X-Gm-Features: AclHuK8keS0URREeVHi2bDcMrIMTrg9GDE11ruNkJWdKZdjkdmjRgehGKxzojT4
Message-ID: <CAORyz2Lv9fBrKZOQ7kFBE+u-nJ-dFpRm_3G0JTS=bHtEL6n_GQ@mail.gmail.com>
Subject: Re: [PATCH v11 4/9] mfd: mt6397: Use MFD_CELL_* to describe sub-devices
To: Lee Jones <lee@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Val Packett <val@packett.cool>, 
	Fabien Parent <parent.f@gmail.com>, Akari Tsuyukusa <akkun11.open@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +     MFD_CELL_OF("mt6323-pwrc", mt6323_pwrc_resources, NULL, 0, 0,
>
> Nit: This is non-blocking, but if you have to respin, please use the
> 100-char limit to keep these on single lines where possible. Same for
> all the others below.

Ack. I will rebase this patch over current 7.4-rc1, adjust the line
width and send it independently of the addition of mt6392.
Thank you
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
