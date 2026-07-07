Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FBC372662
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783391570; cv=none; b=tfte2v3/TzmcO71lkQOx+ZgamxTsy5RGoNifoBEX/PuVLnwjP1LmJanS9XacVD3PqEpMYGrXw3WVhFT1zdErzWtda8YflVtq/uZb9+vr/Y4z/6nJr4xFI7vMay4UxHKBzywGzkakNm/nrdllpLlxG68hqXztMdxNXTK3zsBTxPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783391570; c=relaxed/simple;
	bh=oTxuq1uYybzzZuUbaw4M4gHWkxvV26chWpzR5irnVsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhGnD1WGtfHfXMLOShXBGo3qaaFQH97XdLjFZmG3Rk+QnQxzUsCd4/s+wCZ2b+7H/Z3VgL0bd24xrf+bD4nnK/OaC8n8lf5Oy/V4pdKeaGSnT+vGohU5ducOOzjjhqebhyupAm0NI65YgVfozWlleWsRlCWFcCJNiUNfoGF8kBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oe9aJEAt; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oe9aJEAt"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-73f6a641f6eso813298137.1
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2026 19:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783391567; x=1783996367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3dXcACB8KGLqG8puEGgdsyUK8P+IbVAgeAicazzLLPY=;
        b=oe9aJEAtXuAkTXnakQ/glgVtwLuoG1fWAHPwFzJinvAe0o+s4nUs/kOnbBfnTmRjQB
         BDcEIjM3Px6hqcRnbkSNMj0wWCJyX9lY5g7it+9gjoet9eR1Nm/QHFOHNGmWDikQDp5q
         UIyuHqr8o4AJHe60YYNJ3Hvj8rQFK1HsrfC9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783391567; x=1783996367;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3dXcACB8KGLqG8puEGgdsyUK8P+IbVAgeAicazzLLPY=;
        b=N4O2Yq60f1jhoAja8/PPIol5zfLn6kjQiK+KbmuyoTm4S2qpF+p3HwHRMe+jlvUrkE
         hLwhdcj135X7gh6VvbfxKJzb2V0KLKmuZmgI7Pwh72y3Es+cDWlIImmBJFTryD5oyr9H
         wetDvRDy5/lTv1o5HZzcTa2mvK7T6zShe18yaZ7aZRCBNpqH0iLc7CcViTscEkBOEtMd
         QieirtH9kJa53UGKgpjKT0Wd+WyGt3LUwJwSVavbDoWhvbtuKKK/6MCVuNFfY+hOh+uu
         +SUhNdFEeZh4vWvcKw6qRsUEQFxZTVjx9vWughiOh9MgSsWTsTIkQhHAYVjIwQBpXLEb
         iq5g==
X-Forwarded-Encrypted: i=1; AHgh+Rqk3fx1hhTBTohj1x6/1vPowkNWw6R/Qc9gxeBYNQomzVHAj37Ady1HZnYq20DqmP+6TpMM1RX7/a/RHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/nABefhA0Jah6O4XMuIwjE9ACLct8CluNcEGTdvgen4j4Kpi
	Au0/kI9o2BA31uSu/Xa+7UwzJJ1+dBphRxtKPo6uranR0ZMCQsnX5MUGc2PLKUodjPEdU60mLB6
	+r0g=
X-Gm-Gg: AfdE7cmxagQH9h6x0NLUR144m440LElaadg0/shNPgjq7rfxtl1tvF6pSBz8uNEDUt0
	i+1MvuoLVN79pq6GLjhAyvkHcUoQ6phqARGy+y7zCyItgaO2s3NDNxT/dRtH7q3EBta2XEdiPAi
	UhFmKWza30YHJIyvSTFbZO+8s5yNkWm5Rm/ZOsZLZdtmN/5hq7BOQBWUyQ2F8CMKoBDLkcQ+iyr
	fraw0nzr71evDakLPQ7ZGie562mCYg7peM0caZDuq9bDGwIQdcZzC3MjLkqmuKc3Kkoxw29jx0l
	U61wKDvsaGFw0O//rSDX6krLU44VcZpjV1ohN8KOpfHDRC1c7kUOIVNCFQcRpmvm7D51/79WfBb
	76nhOFPlQgfeh45rA9ywrZmA4r7cAdRIM9aY6ipJz6D/bCZbUBm3lp76UvI8S2ZSg+mme8oNUn4
	9SeT5++c7QGKwkUeS/LpW3ieITZUYQXlZZ9aZA/pk2Yzmhx/1QfHw=
X-Received: by 2002:a05:6102:390c:b0:634:92df:4dc3 with SMTP id ada2fe7eead31-744b7bb68ffmr1726270137.16.1783391566837;
        Mon, 06 Jul 2026 19:32:46 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7401e006f2asm4159346137.11.2026.07.06.19.32.45
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 19:32:45 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-728f9ecd56aso857481137.3
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2026 19:32:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr6iIkqr3UFRtH3PvCoPEkC0UTV9FX0j3s8zKKycN30XZhKpWEAqiJBKkISjw7BCIRjwsA3jL/H/1Rt+Q==@vger.kernel.org
X-Received: by 2002:a05:6102:3e0b:b0:73e:8694:c6de with SMTP id
 ada2fe7eead31-744b7c5e3fbmr1832689137.23.1783391564990; Mon, 06 Jul 2026
 19:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707015423.3944655-1-aichao@kylinos.cn>
In-Reply-To: <20260707015423.3944655-1-aichao@kylinos.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 6 Jul 2026 19:32:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X0CwVHEg3C8dNTpOmq3E53GSCC2QL2gXF8TNOKvd-Lsw@mail.gmail.com>
X-Gm-Features: AVVi8Cf44S4wV5gWVOPUwV9oTM3AcYPGRRh5QfdtVkVXWN7TKeu4VkN3OHl_8po
Message-ID: <CAD=FV=X0CwVHEg3C8dNTpOmq3E53GSCC2QL2gXF8TNOKvd-Lsw@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Fixes "(null)" device name error logs in i2c_hid_parse
To: Ai Chao <aichao@kylinos.cn>
Cc: jikos@kernel.org, bentiss@kernel.org, treapking@chromium.org, 
	kenkinming2002@gmail.com, raoxu@uniontech.com, superm1@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 6, 2026 at 6:54=E2=80=AFPM Ai Chao <aichao@kylinos.cn> wrote:
>
> When i2c-hid fails to read the HID report descriptor during device
> initialization, the error message prints as:
>
>   hid (null): reading report descriptor failed
>
> The HID device name is set in hid_add_device() after calling
> hdev->ll_driver->parse(), so when i2c_hid_parse() fails and calls
> hid_err(), the device name has not been set yet, resulting in "(null)"
> output.
>
> Use dev_err(&client->dev, ...) instead of hid_err(hid, ...) because
> the I2C client device is fully initialized with a proper name, providing
> meaningful error messages for debugging.
>
> Before: hid (null): reading report descriptor failed
> After:  i2c_hid i2c-TPD0001:00: reading report descriptor failed
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
> change for v2
> - Used Fixes tag.

Could have fooled me. ;-)

-Doug
