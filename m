Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1D327C0D
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141670; cv=pass; b=eCCgU4r4sAaJjIZpWR7C9QGq8di1E2xnzPjGTEQAOkmhytWGnRxAk+uMGFG1szeddHnZcBxNFZFiPGzTTmWQF/2k8FdJPdGYhttHKYyWTKYehPyYg9mK03NmPdo6RyOoCRbGJosHU1whmLvCSKF9tnWolrIDheiUm3Cg0sn35D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141670; c=relaxed/simple;
	bh=8zvipcslBvGLMROe27G8a4yy9yYjiXdUNW/PADn7MPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZQljne8nJnPh7c9GpWCkNHt2MbZr32mBFlgJcQHHinwKiLzSqUxDSWB4QmUBzJ+eDGBxQeG6jGJNILUrxHAa2DoiyChb3wtDF2df/HWDZ0bggKiGWIYI+g21NQjg9kulUBct/n7N/PZoRlj3myVt0/u9rQIh63u+4CIzF01jP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hp/xCq0j; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp/xCq0j"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7fffb090ddfso46041217b3.1
        for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 08:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782141668; cv=none;
        d=google.com; s=arc-20240605;
        b=PYlxEvFZdCpPCrc8Dj0DjDzhrAkTcAVIlKvCpfhZJAQil1oHgoomlPO8ftQp4KXk70
         b64RTYNaemClUKh2zm/L0CmYSTxKkDiRYuWbCpms5MTBDIpSYoPEgr3J9K8Azrc7ZNht
         /rjgG+5zug0S2Ca/UgnFnxwa77REaCrkcm0EUbuiEtM/Xyj2GF8pVqaPVWV1zGxwIfSp
         WpW3uaZ4eve2khOc8lqFoBOnTsjJ/HYFIUtCBNdKlzbXZFJh2lKnegfw+maLc3YEJHNX
         ckMpH90FCiPrHawI/2ZcL3JONMCa5ffM9AsN1fbj5Y6LJtKXG3lVQJ7y84kA69W50MIM
         93Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8HFbjIkyjH5nmGj3I8BWSKEfArELaB0NC6yKhSNZlpI=;
        fh=IWy4vznMuQkpaETq8AEVzaJrun58p5PCVFNYrsf5wIE=;
        b=U4aFPgzAVoOl9ZyeRYl1xXX48osqcIm2pTfByZXxuqo2Pn8hzCJn+vWvceLnsu/HFs
         p/PnyVJn0kTz7yJSu1BK5ZoP7vrBdz+w2HYf2R25w9hoibWz+2heT9lvIEWo1LE+jsPF
         YfSez4bOtxKwpeg/xjxy00mbY8osVasWLeD6Heg4sKZrlnnL48CG7hLC+QwwxP+NbVPl
         x7TrYKgPFkWpxoazCGtss9YQ32lCJer3M8k5S+6VdtoAIX9Ri3I966vv6VZmf4wW1TW2
         SbcIBDvQcgOMpXENO4EX5v8Q5xtzt9ZLRfEaw90kOXmdS+TXje+3JHZV2VDE1QzFe/iQ
         vxNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782141668; x=1782746468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HFbjIkyjH5nmGj3I8BWSKEfArELaB0NC6yKhSNZlpI=;
        b=Hp/xCq0jSmF/cz6Yersg9ROypQzUYsFPMudkA9AnxhQY9DVZmA2MNW1svteEvdjuJf
         ZJN5bsAPITiqorkm11y0YhAZ4jw4tSTyp8PZtbODaXeMwZ3ue0M3a3Ts38ROalbmEZxt
         JI5jE5mwEP2XebzDjD8dj6XhGJ01fATQHBfdwVj+nrHjqthwL0EUMKORPGyRYzAa9NjR
         eGq2Y4MT8F6snMFB25EVbQQfIOB5l+HzDU5hfBkOwBE0xn9bMOh9+uStqPohgKFdy57r
         claKS6y3XT2DmZ22+A9h+wfF6KyMwHxX60AGPdWGvfidTAuCz3x+VBOH+ibHV6i2+FVk
         PbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782141668; x=1782746468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8HFbjIkyjH5nmGj3I8BWSKEfArELaB0NC6yKhSNZlpI=;
        b=OU8J2HEfbU4GtMHzBLyJ9c+yinsVr8dyNQU116DdR3OLmJ+0IyoPMPypFchAksHF+Z
         oSpLSekNlY6FAsRPJ71b268s64n1ROqd1VYRujVfxaK33CY/EzA45hPGHxiQ+wxGB0de
         SetuEdMtDx/glL7a+WDaRVw7KpS8IWp7TQsQ1CdiNEi2Uae8dwmyq0YgXdYbO7YqqR2c
         D+GXZftqERxkowdPsFbLXU32f3BuAdvumq1rct1zolCIDiT8K21hxznVPvQgzoH2FoSe
         VwU2oeGrPqpkrLpY0OTVKmWuVuVfl8k0FKAgwcwYCmaUKTyEN7lE8ZiW++Xpfv0w1GRQ
         Azew==
X-Forwarded-Encrypted: i=1; AHgh+Rpo8Ou/mnSFsO4w9bLHIi6VUla8MB64qSsqxppmJ64+UaOPX8m/vwHSJKvMwlBENx7y50G4EOly+N0RgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/IznO0uizm0wJDnF8cx/KzyXCQ6MoOZfGJoScQwG88qZBBIu
	/vpkTOfVvezPUdqxR8blSv05Ew8Bn1AKB+TVM83mfm2ttndPVgSEJt8PlSobgkSkgC28FhkRdgN
	Dmy+8I9ETmJ7iuofpT+/reltHUZt8z1I=
X-Gm-Gg: AfdE7cmt0MoBR6J51gYK7km0Bi8yK8YfkC/+xoVt/ArQBzqZNi7HuYWTe3+7I5yqP2a
	HqVm0DVXD0AN9A4fVJP1gaXiU11pnODPci0QUrUN0i6sBYlUZfNZIgEwFrl2EH0QOZ7mxmvG6cM
	/ci3aeb/8+jU5bOI3ZAZcVcYuMWVGcpM4sZk/qnr8SAtvcFE0lMv6M3G7J8/OaI8s+aI8HF96o4
	39JmlNXrwK/I9m05jA5MAbM5SaKOCLUtESPKUEwxyF1RM/IUZ4bcy8HUW12LLzNGRAo/KwdEQ==
X-Received: by 2002:a05:690c:39c:b0:7bd:73f3:7a58 with SMTP id
 00721157ae682-801216280e6mr120841637b3.11.1782141667701; Mon, 22 Jun 2026
 08:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622052135.1804135-1-sanjayembedded@gmail.com>
In-Reply-To: <20260622052135.1804135-1-sanjayembedded@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 22 Jun 2026 10:18:45 -0500
X-Gm-Features: AVVi8CeJhQ1YA9yY3iSTy2JTki3SbfzKbLRF3Z3-5aNIG5o5PJNrGqwFOvwLbOQ
Message-ID: <CAKqfh0HeGExuwMpdcW3=OH8Qm=Y261dc2AJs=e8Cyj79_FE48Q@mail.gmail.com>
Subject: Re: [PATCH v1] iio: temperature: hid-sensor-temperature: switch to
 non-devm iio_device_register()
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	hongyan.song@intel.com, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 12:21=E2=80=AFAM Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
>
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>
> Avoid using devm_iio_device_register(), as this driver requires explicit
> error handling and teardown ordering.
>
> Mixing devm_* APIs with goto-based error unwinding breaks the expected
> LIFO resource release model and can introduce race windows during device
> removal. In particular, the IIO device may remain visible to userspace
> while dependent resources are already being freed, potentially leading
> to use-after-free issues.
>
> Add explicit iio_device_unregister() call in the teardown path to ensure
> deterministic cleanup and follow kernel resource management conventions.
>
> Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/temperature/hid-sensor-temperature.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

My rb will be a tad redundant but

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

and should Cc stable as Andy said but hopefully Jonathan can amend :)

--=20
best regards,
max
