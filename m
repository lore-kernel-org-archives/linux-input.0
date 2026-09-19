Received: from mail-qv2-f3.google.com (mail-qv2-f3.google.com [74.125.230.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8BB314A90
	for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 22:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789858621; cv=pass; b=hbsh29RkNYbyJWCFmakjNXqp3LkXy6dblwt6Dm27hzV7Ne+4gDo4HZOv0xGrixxZGcRGHWCyxdHMpuPcPY7EZda2898hkegj4aslt6QU2UyU0/BjUbM8SFgxUXSAHScAwEErqv65fCmm7YyQmYWIpbfImJWYJcr5/rd95UnYhM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789858621; c=relaxed/simple;
	bh=jd+AFs1UozMzUYo/4ng/l7WLWjUZGS/WRbp1bu41oew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfCrhBGhQGjrwZ6GMOQ3IXS0HgD/kOf93OGSuSLnVeUuD35Zm/oYYvM3D0nuz26AxNuTFH4/25O86pQzc37Q/hjpFzm0Z5b+IleQGkrBu/qngrmNWjeX+MBIWIYOByTMcbshEN1VScY2sEWKCWeay4KqVLdjWO4a4MHP6eQam/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6tpTM9h; arc=pass smtp.client-ip=74.125.230.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6tpTM9h"
Received: by mail-qv2-f3.google.com with SMTP id 6a1803df08f44-91262b52687so7233646d6.0
        for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 15:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789858619; cv=none;
        d=google.com; s=arc-20260327;
        b=SIOmSKtZEwig4kmGxlwEkmjMsJjhwzGVR+Q2VqKVJkqf89b0iF+39xU1ignrdS5QK9
         v1GfKcGSrRe3TBvlaKkfyaV+oUC61zqUZF4CF0KX6J1kKBpO+pMQ8nt01RiPAFBf1/vt
         cV9jGVISWreZEOA9kgjdg0nTWGVYcl6H8DPPDHtr58shW9SO7uHT82d8l0AsCSaM5f9f
         /iyusz5AfYFL6ovhfVRcu+AbJdvWVVI03LJ1Q22OrbfuSda52Il5dkmlxhKnHfJCFefB
         gTNY98lsFrAzoc4Nt6gzkzrOioZZ0Qy9wQsfo741vG28oU82S0bDc2QdUN3KEvTGpUz7
         Hzog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jd+AFs1UozMzUYo/4ng/l7WLWjUZGS/WRbp1bu41oew=;
        fh=iTCwrAk3NwDkH0KRkKVFLoCl3OkyLzflIXEbkIofnoQ=;
        b=pD220jZnivvVwNBgxWlcl4T9Z0HezeuHWjRuasAjMS44KCrzPz6DBVykMyWVBGc1kg
         P6rOgL4Mf7xF9pk+uAXVFbXuKkO6PdriSKZbzhwEm4uk6pflbLIXLpJfucc+8n9zKAov
         cd47NPUXR9tzHXTf9F8NjzmKlVyRJ1VqlTey8igiaA4v3VWvdl5lTpdlcDPAfGyOhlh8
         InCUI6PQOSBzBatZFIh368tGCYHe+ncJawLgiI1paC9rwbYHO94TJJVopAvK4IqYuSjX
         mBWK31IrYiCFNzy5rAnNrI4xwa7h6iRsrtM48pJk6K0nJRrGr8v/7EyuOjod9xD7ovSc
         loPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789858619; x=1790463419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jd+AFs1UozMzUYo/4ng/l7WLWjUZGS/WRbp1bu41oew=;
        b=j6tpTM9hr10a2RPAGTMtAcM4/SNR8y3DjbHafkmdQqQlu1A3EnOnV65QhwwfL7iGxZ
         74KN6GhrbnBXSVJ8bR+UKeJW9+unZ7ma/ug81g968yyGtFU2DcxX3LaoEcwjnVMAGbwu
         b5TFTsc80Q9vbHeAqGwu2Urar+nRNuOobpJyipO2nqMEBR5hCqK4Sk5fQrIiy1dKMihv
         3nMcJzDs23HdKXUgqFr43bkJEFGyFYuZZI7VJAJb0HGmSazQL5ZVfzjhic3/hJQMbsvZ
         02J7qhTqD1mA7ZQfQ0qPEM9+iWJ/Ev1Rc789BaH+ey/ea4e1zv63RDbRgmtOjVCr1fkV
         qWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789858619; x=1790463419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jd+AFs1UozMzUYo/4ng/l7WLWjUZGS/WRbp1bu41oew=;
        b=RHHbgLyNY4nhjgFqSe0aIO/hxkojYlvUh4LJr5u4vznABuKcfbGxNmmmR6EhczrBDY
         29fZvm/YLeedarJPy3xqhr9RNVoOhdF8J9MX+pxPrLIH1bkYv24K95z9dZNTCmmPW7nY
         FCvKivcmQ5jKSI+vcCICYWyw+3PTmyblpdIEmDRFR38eqfhp87zIqJWv3hhlQStDUYtq
         kYv3R2jiKWqz97NQXRAubbG26OncAiAhrx5O5+UrBTX6jXlDEFypn8i88doXJbiqf7w/
         RTC9uINbInFE1kx6LZfCU25Adm8LR45WRC1cY6FAPT+fBV8N6bYtwdMkY6Vq9qr+TEWg
         rPfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGXXHTeyb3HCukt4ZHovdZ/UcZERkzWN8sP2VATfmoLiGkHsyOe6tIvljHweQaMtqHtQGieXr8a71FRg==@vger.kernel.org
X-Gm-Message-State: AFuF++kjd/3a7ls0rJuhmaVqjuS2ZVOSLkQJhzjt5nEEM1WYU0RRTWF2
	YEJUTqVDHOfEtRUcSSezzVA1vTJ2kswycQP7jT/zMoByxj6O93TtHVhPagelKjvIUSwdnlKnL4h
	/5nh70CQAP7OfZLqz6a/+pz3yjv60zzk=
X-Gm-Gg: AYBFou1dVZyBn63PbHWlh+ymL1fSQeK2q7tAyrbz09xXTNwWvosTn9qtwJCafLod/uq
	loBXWtaSUM33tW9HYBOkfw3e0xnhNt6dzShu4zbYlHy+PgKPmQen2M8vwqIFiueqlv/qyvsP+MZ
	cY/qkl9XM8u61plNsNC1+S+lzxZRKjeEtl5L/jgjouMoNyosZKBBchweWe6Qp937bjjUvs7WTC5
	TQeFFYZ8r29LruKoWxlkRHDFHhFBY7sotJPpSOz8HHC4l8+JkK14Izaj1mbLlV+JccF1ACOLGM3
	4EsUgd97XYVxRnOr+zcBM6jeE2T1fcKRpJHnHwCJJhYloe+ih3/o0vAaBpN7gT7h9XYPX2K1F0A
	u6rX7T/GyykyDRb4rGsgqUy15U9AnkIiHL8TigDgZ
X-Received: by 2002:ad4:5748:0:b0:912:517b:40fa with SMTP id
 6a1803df08f44-912a801bee5mr35579356d6.44.1789858618635; Sat, 19 Sep 2026
 15:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919083655.586922-1-enelsonmoore@gmail.com> <CAD++jLmuuLXpWsiZAFEA-QWZsB_6qcaM3PomhtKhHFHbzse5iw@mail.gmail.com>
In-Reply-To: <CAD++jLmuuLXpWsiZAFEA-QWZsB_6qcaM3PomhtKhHFHbzse5iw@mail.gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 19 Sep 2026 15:56:48 -0700
X-Gm-Features: AcwNN1UGTDJgGcyXU7D2JaYejEQlWEe1KXFmg-_RTnPu_ebNdg98jhIE48FePPQ
Message-ID: <CADkSEUigNMbUi88zOCcLkTNduYk_z-k5bushv3nUAL7vGdCdEQ@mail.gmail.com>
Subject: Re: [PATCH] Input: gpio_mouse - remove driver that has never been
 used in the kernel
To: Linus Walleij <linusw@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andres Salomon <dilinger@queued.net>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-input@vger.kernel.org, 
	Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Linus,

On Sat, Sep 19, 2026 at 5:12=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:
> Why though? It is fully modernized and probably has a value
> for people like "makers" who just want to connect an oldschool
> mouse to their random Raspberry Pi.

You're right. The driver is so small, too.

> I think it's better if we focus on removing code that is just
> using platform devices and hacks and is hopeless
> to maintain. For example the OLPC...

That's a good idea. I've started working on a patch to remove OLPC
support - at least 6500 lines of code and I'm not even done yet!

Ethan
