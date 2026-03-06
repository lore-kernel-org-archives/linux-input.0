Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578B536D4F8
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 06:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772776807; cv=pass; b=FfN8p9ELq1xVEAtqitfhM4HDWkIuvHPDEBBPXpzED7eNrSGkYKjvv7jAzN11I34kxSLpCZcm+2nQxI1AZY2eQ6l+ZU+RQdItlZA/kuPRNGVgjDPu9srOGGLxBVfgxvYmj/ZiHhymmb9uHgHgFv+/tNP915pH13e1NXu5Z+OAe+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772776807; c=relaxed/simple;
	bh=kjwNEp1CqCGxSTyWX9N9XmwmrQUlwMmG1H6eQUsq+80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNMx2RnOldSegfG0zJPMBmKbFnf6tX18Z8en4cEMVqLU1CDM3s7Vpim225QDEJm3wmi3gmixoaSq0kcCGBojZyEN+/5n2Yr54h3hk2oBQn4MJ6wjrKFBBW6HUFXF+O27ub3pobngVaFXQxNPItYRGXiolf2y51LBfOhdgFxDtF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSyfmr9U; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSyfmr9U"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb7edbcde6so1070895685a.3
        for <linux-input@vger.kernel.org>; Thu, 05 Mar 2026 22:00:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772776804; cv=none;
        d=google.com; s=arc-20240605;
        b=Ys/adwgxZhvG+8mpIvZxV1zfzW7bIzx+BQFw7WEhFselWgybbVaCb/XKFDeMSJ1QJa
         baPe7nJP+znDDMjL9d45G+AFuADC6n3XYteE3fHyPopl1LnJsqZ5OyZeEfg+1WhZDykQ
         eolF6OTq1fH/kZnqBKtu6AFtXLMtpvzrmR4FfatdJbRaa/M6NJwc7qdm7rxV7LhowDMT
         M1ZpOjtHhVcLdYknCp0upwsid2sih2Jg1UT7rfHZtsYpbitdEQpYtl3eHH/qeL51/gEU
         UB3bHmpXMOkjpDQsqqu/Pf1Gw8RyZB32DBMv0trZ9BZMCcIXLmDEygNDVmGmHYXu8/De
         Obzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f4jm5ioibzYYsuxN3e/HZpHO7iQlD6PFHQJP6euigrU=;
        fh=cTmDwk1W8XLBfWDz05uSDHqO9U3FDWGGz+KM/M2RM/s=;
        b=dUdQ05bS7BEBiwHLQSakyt4PbEJ9gJ9bAw0XlX/eYblbbvNj8xY1EbfVGaKyPrnk5H
         8sR8jQMG53te5e+cWMYYOARLsWDC8S1D3N9p6oWw10pxe8l/AzsDhKxndIAHYt/vr4C8
         2Igkz/Y5p14k3bRjPynnzQb0suq7llllb7Vg5EI+bNxrrPP1SKDkKmQYu8BFLo9P4AQK
         eLvx+xI5kbofAQ8+40CdBIXM3iG2FaafyeRG7/yp2ZfO3KhJ7iAfEmjPCfz1q7vPxplT
         AmfBnBOtphxfVuR9eynq5CA/xflOMxQGZeTZI+k+Uji2V4jUOVYlbmBjPWokHmNqJMXT
         hhJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772776804; x=1773381604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4jm5ioibzYYsuxN3e/HZpHO7iQlD6PFHQJP6euigrU=;
        b=LSyfmr9UA7KmvEqi9791wMTzwgx2QWwcF33uND+o2mxl938rrsh2v8VedbvT7GR2d+
         wPcIcXgdNklNdSh6hAAIhNiZ9kF5YSfWK6OqIzqSdG8zIp8Yy4DYCfZjMbTBnF0/pN2o
         XH2puLGgsq64fEkijZCGxFWZFAy3a+D3yJTyzY71yWsbrLL8GloazbS7ihDlspaFBhn6
         lhPeS6e5sYtxs4l3XbwbHQyvITw21mLjgDgetZO8q/Zo6Fds98Y9R0apBL6YsGLm6JUS
         G4SBEUqpCbzu2NwPC95eDuvweSDx+T2mSqXQt0cL7WOaYTiY/o29QyiwXIi5FtLQhJ0F
         qtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772776804; x=1773381604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4jm5ioibzYYsuxN3e/HZpHO7iQlD6PFHQJP6euigrU=;
        b=HoOozXl1Qv/17SUDHFi7mWd0lahquD0w0D6IPqGGsiTRiwB1cQKBnocvDVdB77KIrW
         7JQvSUleNKpFc0mmoJbxD1CamBoAKDF19qjr1SfbVJsJt/tM9RBkbuWr4ahI6uze4JUx
         O0vDGRWkMqiB5P5Pd15DWKDfpZxaOx2sI9dZ3PS55vKaq+ntgOg9xACEm8ke7TfpHxH2
         61+ft33jDEmy4hF0PBgpkDFOAKurANiuIqE4Rt6GR99NQ1cjO5sEaLbQtt8Ouw1X40Ev
         u4M7M9IiAGxXjqJEzspvnudSKGCev+8peGuKwRDQUaiVZb7XrZkTLqh5hcjKOE0xpdym
         g8Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUy3T1S49QZG5+ffoRUszdWMyMnxeK2nkCmfheZdUnH+YlbLYj1SzPdSEdGamn7BNPRCVJtx38JXrRXjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDpuXRDH1bcsm13W1CJ2/PhH3f4mQmc8mGiYnwwJiCN6ojkqpA
	mPNT1X+nQoZsXb+zxIliGTyv4KMYkdpvdIjBFigX8DqjYB9CeDP2AqERfKDK9sckGi5O4/mtmJl
	ZBAN2fqyJMz6oS06xjmq+KOfKNMaADVaft69Q
X-Gm-Gg: ATEYQzz4OUNzFgGicGi74/5FjDiJQwjOKYfrAxK5TB7tRqeLHH8zYHCTcZ/Xac6zVfx
	CWCnniyNNRm3KGHDrdobpKmGbj/1ddyoj6hmq0gfFEMtau3yI/LE9ECy+KeHRHMOj/5aleGWLWz
	5L5FV2G5cVXNkz6JVgp0sgXCVeFIKli2CGLzdlSPsp5mzGtrl4jeHz8jMViX8CRvpeVEL26SdvZ
	uen0gpBOleQIHdH5To9jwa6UPsbO/lXfvcQsRv6inxGO7aGgGUbo/9l6gGMpBo1WVFcenS2Qswg
	rsizit8=
X-Received: by 2002:a05:620a:4495:b0:8b2:7558:409c with SMTP id
 af79cd13be357-8cd6d433536mr127115485a.36.1772776804131; Thu, 05 Mar 2026
 22:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227231606.421263-1-colin.i.king@gmail.com>
In-Reply-To: <20260227231606.421263-1-colin.i.king@gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 5 Mar 2026 21:59:51 -0800
X-Gm-Features: AaiRm53llqtE11GAWF7TQT_j_IqIvRNKAACgRqaUCHB6Ec0GjYvrpcWqbWg4a1Q
Message-ID: <CAFqHKTkYqnpN8JA6P9kv4QFw1sbrgZ6Ctn4VXf7KXChCWnDM5Q@mail.gmail.com>
Subject: Re: [PATCH][next] HID: hid-lenovo-go-s: Fix spelling mistake
 "configuratiion" -> "configuration"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 3:17=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a spelling mistake in a dev_err_probe message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/hid/hid-lenovo-go-s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.=
c
> index cacc5bd5ed2b..dbb88492fbba 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c
> @@ -1401,7 +1401,7 @@ static int hid_gos_cfg_probe(struct hid_device *hde=
v,
>         ret =3D devm_device_add_group(gos_cdev_rgb.led_cdev.dev, &rgb_att=
r_group);
>         if (ret) {
>                 dev_err_probe(&hdev->dev, ret,
> -                             "Failed to create RGB configuratiion attrib=
utes\n");
> +                             "Failed to create RGB configuration attribu=
tes\n");
>                 return ret;
>         }
>
> --
> 2.51.0
>

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
