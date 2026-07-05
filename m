Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BD339FCAE
	for <linux-input@vger.kernel.org>; Sun,  5 Jul 2026 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783279733; cv=pass; b=lAvYi6rzMlCkOTqTwhoRDbn7qxiNQi8Y6OmD0tR2oRyc4lQSzuGMRlamPnBXFDDk/sMoqVyn55WnkErYwBXMqOssegp0waRjDjVvcjjcDtmtINai6DB0gAMszzHP3uQgbqHeG49EDK4S+4n2Zy+KpDpJ5neQQQ9RcRJJVpth4O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783279733; c=relaxed/simple;
	bh=VhQsGX+V9ShWrFHxkQbu1Cb0ivr/xcJBbpB4mcmpj60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muxpymU1Zi4mxq4Zx2W+YvB6V5LnvPF7TBZ9sHkuFLpgQEobju0Ra6D8eI4FrqT8GEqGSzRJ7W2Bdzh8WsbzrT/UczRk/i+pCSGS6RANqZNNSfC9lqrVLGo5Ig/Q9EfnLKEHZZxjlsKVjP3AKA8gXzWNxQgs62Z8/g2h6jXrRZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0Rz9hFh; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0Rz9hFh"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6989c0ec3c5so4492613a12.2
        for <linux-input@vger.kernel.org>; Sun, 05 Jul 2026 12:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783279730; cv=none;
        d=google.com; s=arc-20260327;
        b=oq2xT8xuFApbSgewgFYSlI7QvgLvKJGdgt+dObFYO+wy3pE3gOa1/ZLs26/phA583I
         Rg7rcZFiYEBMR+WAO15ED3Cgzi4MmPGEDJ7II1K/HGZ+aiRzwvRivWtXJ30RJrYV4dHB
         I0IhyUPwGgFa8TiDMaCQqs0q7g+rAdIsddQ1hcg6/dtzLs64NVQPieV7WChPujiZSOXp
         oJYHE7ED+BuWsa9emdypcJ6EMVFxZZPXsWX9pXs9ncnlDy3wfr8qOfpKegWG57deGHb3
         tCTEg0sadiEqvY8lPX0tekGS5g59M8iavENSUXlucqYIWrJNaHGs6itnToOuvf81uVfo
         GORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6JUnRCM2Qxk6xap+InmsyC5JjApM9odZFBQkppiWmYI=;
        fh=ES3J/wY7bUUReri7B6dAsaEmkHRr8hLl2r4IGTDfRPM=;
        b=s1YLks0MvX0rMT2zVM607hVgjeXGJlP+mYoCVn0WTgPoIG6sJHfI6Xwc1ZHs1lhX/b
         nmajbRgKSnJL668vfkw9JBsC0c4g+lu41l15LItKGMbcchHv8SO+RSSaFOOF8a+dOiaN
         RTdyB85E+zDXubCILKpO5vYxRCRNwoMbfI4EbMwFBwFIe4YvciVbJoia3L422bbUZdr7
         tAQ+CTDve/JK18n7xiBhRB7Y+q4FxS5B3wuIb6lcGU6V8DRDBLEK0HJ2jjux2M18zbOW
         Z5ky/rM01YtnkoeqEfUspsP9UuC9AZEV+VB3y+NBMH+X2dZv8VRc0XGN33VqVofwbFWk
         K36A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783279730; x=1783884530; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6JUnRCM2Qxk6xap+InmsyC5JjApM9odZFBQkppiWmYI=;
        b=J0Rz9hFhl52b/CWkrpvzcx0Am4/EpNLTz9CsPrcTGSKcjOPscQvr7qoWyXrWBcPY3+
         KcBS7BHDEOJinM8YtJH+AKP2zbGUD9R1ltaqdvR+1xFZH4zfUeVbiUcxTc2nih0StTjF
         DWWOdK9R9UmFqHXpIhi1DWsAHCOxAKpEmN2UESspBxHehEHQho+NqhaDHwCKvz6vSQPp
         fRPMGirJzF6V2rx8OOX9+v673+O6ZW1lpqqySLNkD0niPE1hZFTG8i1TS0aZUAM7V1rb
         blztwB6yg/Ur3NEVKE4uotmQ2Tfvt6fwW5MLdDRLMJ/W/8s9/LtVZ3w0bySHcOo55wCJ
         WVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783279730; x=1783884530;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6JUnRCM2Qxk6xap+InmsyC5JjApM9odZFBQkppiWmYI=;
        b=Sr1kyhl+HwIbs+tAdtYvL5uMZJQMPvtQHnbLkBFXGdFCriqizsPMkVvH5HMXA7y+2j
         8Z7NEZ/2aoMZ1YAZf5VNliBb2VZUKGjd7oQUMnLVAwo0bfnJ8KhKJ7SaLPY1CSn3bULZ
         NvieGg3S5j/DFe/Ce2Y98Pi1GtFWXdBT4u7ozfiSqS71jsoY65efGwfmK0W9nkkqH/CM
         IG8zTEaIy8ekQoT8gyNBEhOjHiBhlJg7Sl+8/j1LnIhvOeIpEeGPOqxGCerQf5H59e8N
         n5cKJuuENbJh7Pg+HpZZWi1GXpSXuKPyMtN1vWNmu+4r+tyEdX19jlj4etqO6L1yq9e0
         ngnw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+3DjAJa/iAPxq+4a4Z0E+yr7a1e3gptXawOGGtDB1CQJcxhwSFBS2+MHlRrjiKZG3S4O9PDMD4bGTPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YztasAJTfWpqCH95AqesqLIgURLaiJv0z2WKneFoityBRbZjKQ8
	HXiAHhBbSbCadP4i5/G5qi1gcSxcFatDQKaqdVcrB//O8HvCQrNtpulb7vz0ZHzp9G7rgSVIuU4
	JBUKQy6NX9r6g2zoTqZU0mp/+UbTGemQ=
X-Gm-Gg: AfdE7cmaqXLXH7O6WihApknQySXEf9GZru7i6hUwhL+FltpBJ0+hfbks80YJdL2sp10
	zZnIDk5PiOremkpDBMCecnj/aQrFZ1VBCBnfVNJiJRMrn80RCx9ea4nUaSqhVoHmFZLOJNcuiKn
	5+fZ3UwDBGmRPcT0gXKdVYXHEAax9yUtIeyqpfV+viUCRdcuAe+g5NL6/QEMZpF/Kd/YQSrTf1H
	i4AoscU6vxYieM1y4sDrskpJ3rHBEMwo4VMRrkn8wlGI0QaJBsQ2DqLdkJ5kNk92g22thxk2dpr
	QVSU2WKiFH9hTqSW4JS+Qna0DbZ/kujJF8eCsFZbJNsOWfchFLkpugo=
X-Received: by 2002:a05:6402:1911:b0:697:5140:a146 with SMTP id
 4fb4d7f45d1cf-69a1a24e2b0mr2111550a12.5.1783279730260; Sun, 05 Jul 2026
 12:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com> <20260703-b4-maple-cleanup-v1-25-41e424964da5@gmail.com>
In-Reply-To: <20260703-b4-maple-cleanup-v1-25-41e424964da5@gmail.com>
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
Date: Sun, 5 Jul 2026 20:28:39 +0100
X-Gm-Features: AVVi8Cd4RsxuBCDMTegUym6Q-WwoYX7kLkcoRLuTn30KplUiorM2f_4ETnTctuU
Message-ID: <CACwZE5RfhwhOoVSPqibM9+XaPJCf-TdnJxi_UT7Dgv71OJPsFQ@mail.gmail.com>
Subject: Re: [PATCH 25/26] Input: maplecontrol - fix style issues
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Florian Fuchs <fuchsfl@gmail.com>, linux-kernel@vger.kernel.org, 
	Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 Jul 2026 at 06:58, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> Fix coding style and formatting issues reported by checkpatch.pl and
> switch to using BIT(). When reporting D-PAD events avoid conditionals.
>
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/joystick/maplecontrol.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
> index 3ef6652d40cb..457a73d91239 100644
> --- a/drivers/input/joystick/maplecontrol.c
> +++ b/drivers/input/joystick/maplecontrol.c
> @@ -35,22 +35,22 @@ static void dc_pad_callback(struct mapleq *mq)
>         buttons = ~le16_to_cpup((__le16 *)(res + 8));
>
>         input_report_abs(dev, ABS_HAT0Y,
> -               (buttons & 0x0010 ? -1 : 0) + (buttons & 0x0020 ? 1 : 0));
> +                        !!(buttons & BIT(5)) - !!(buttons & BIT(4)));
>         input_report_abs(dev, ABS_HAT0X,
> -               (buttons & 0x0040 ? -1 : 0) + (buttons & 0x0080 ? 1 : 0));
> +                        !!(buttons & BIT(7)) - !!(buttons & BIT(6)));


Maybe I have missed something but what is this !! operator?

Adrian
