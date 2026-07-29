Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4853ABA45
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 04:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785300067; cv=pass; b=W7ioIp49X4Cy/OMEkYOzINWO+y4GU8io88zf6wdtfxum6JHHi3o4aziAydq/CeZSyP2ozL/H7K2w6x5LEN6DxmwV6b8o008o22QSNXQC8FN8N+jCvWcIPU+nQl0MXk9HnmkJn0KPqI9AX6KU+V12nMQ2PyOI/ty7bTTtMB5YTU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785300067; c=relaxed/simple;
	bh=uA7NG5Dfr4VakgJXB94YnH6+2nDpY+bBSoINVwagc6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfoGwYHNuN96i9F31yZH8furnL6HNSFlxt0a9s+HiIX2YDJ0aQPPgeQzRsuNDDfd3Mmo5yeB8mhda+b8cPvCzjifrp/mm1NiPNzTMb5qcCKpphOEoz6iz8ggzQdAZdwSegIBV5twxJQrelFgapotpqhsTmVc7nrT2IbCbkgFfCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HYkMsGdV; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HYkMsGdV"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6679d88abdcso629504d50.2
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 21:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785300065; cv=none;
        d=google.com; s=arc-20260327;
        b=ftVqAofCGuOE3EkhWAFe2mHfNJo5JkvMHBYXS1X3fNIaq6lvmXdvlyX2Q1nxiU9D7w
         tkx3isUsWJthwggEEfRJmwaa4llsi2gVGscfxayo7TV6KUtqlI1XgmNtivmbakcvDf9f
         tzPf1uxtvdhPLSx1kivkUcl3usz44LVvHsKC6dSHKZ0UjBqGLulnDwDFMBuXQNDWAm+b
         h9acl+HLmYkDAbYjInz9819moCg7ii/bj+UooFLDh78w/OYbGpo1pY2qdwo9nzt8yWnV
         0EqAumBieHEhbQFCqXwIWwVJhm7Xisk2toysrwGl7ndQN7/pD7VrYGZmoLKRLpSMURms
         e/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uA7NG5Dfr4VakgJXB94YnH6+2nDpY+bBSoINVwagc6U=;
        fh=SHty455XBFCtKXNInY2pd9Dvku9jtqXro3abznpddEs=;
        b=FmKuLSwk1xRNEPo/QSdOfyeE68TsDlmit4NjM780QEW7J4TUcMhIhxNLE4d1xU5Fy6
         IsE9Lw5i8pqk9erW6TLza8DEuxfaaIIi5afeIbRFUQIwzhf/aDI1V389wDBdm30WrnaV
         bw1fNEs/K/qslFnhiGnbMN8yC1r5TnXZVwxiJFE5VSmvXttTl7hmDhk8mvLwaDt34Nc2
         5etfNDcKmMl/j0qr1RzoDIqyjAR34m/yUp3oscmbk3l7rNsB4UQTKM3erFsJg6vYtyTp
         esJTivlXFP6Y8n87DhAdOZFBSuJ2q1hTERDR+hXPl23njI/H7GlGW3LHTOeGoqi054TY
         ocAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785300065; x=1785904865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uA7NG5Dfr4VakgJXB94YnH6+2nDpY+bBSoINVwagc6U=;
        b=HYkMsGdVWuhCl3L7mt6d2MfvUuXqBf/ipU5IwBBEtWpkXWUCQ8E+hLv2yp/c+KwE7F
         cvbWL9H+0dXwlSoD4LfFjb49NfPHdJJ/n9dWAwXTWl8qdBgVL5EYSNA9SHR1+Pbeuzy7
         1jFRPIQdPOckBdce9dj8zjNXKLdwM/03Ho8kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785300065; x=1785904865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uA7NG5Dfr4VakgJXB94YnH6+2nDpY+bBSoINVwagc6U=;
        b=MWCPDo50kRlbNxPEdKYpSEAv+DEv0ejLlccT2m+h0pqB4yVQrufMTrsj1QlMwV+5ob
         +zdpaz2dlHMG6GPiNnGJjJG/c4SIbYtQgVeRbkxAUVLNW8/lfO02IyskO9eJ95olbqFV
         4Y2CmBc+x8CpXCDxLEAGMIRlS8wCoOlRDrtCFoe75roItah8Hlo2TKAXwPZ/755RzzWE
         O28Rk8zpURo74s/HNPWC0VnrLOtLj3OHPbCBLAyyQErCLlvPubwsXszi81wOfenMzh9z
         LPvFsEbrfIjavQSuJ7F0E+Vu5mwDO4tnDfrUkK6W2orOiGP9sJKnytPwwpRqvjw3XPW4
         ct6g==
X-Gm-Message-State: AOJu0Yx8dFUKXqmb0NCHqlRtJSIJqmBQw84Zu3jOLaFeLNfJCioKh+82
	ujkoKOYnBttN9C38XignE6qjvMBkBl33uM6VadBp+Qh1ZL/cip0+dMF6Mv3XqRIuer6hngNgZPQ
	UI5MqG1Ff9+lntCqOGPjZgeJCIt6JdaW/O0h8ryWq
X-Gm-Gg: AR+sD12CONAnedSF6lo+3+49YbRIbP0jJ/nifWpHyp4trQIouiDSZCGVrWem0kkIPwh
	ORLVdQZ5+ISej2Ah5fpDhXkD9Uyv35gx9dkymZbTjXniul75x+WjlkLf7ibmRpj1mivdXUGZwVV
	ZchdaMn3c7eShIhFy/E2isd5/EQTODBLVnv1emE/h0oPyUkmHV+3cLRPWqz63jOCEXF+jA5vkai
	aRX5/HDSlkH0nzEBNgisbqiuDQt1N+jHs15pAQZSCHZuJc/T4Dh/xw43x3ouuU1MICRRxiLei3d
	l7SdZc9gJjQDoVu/uDlY2ERdS0333CQkp5aeiApswPtijRJehu2Njz1Ol0+DVw56gXp+UWTodpU
	=
X-Received: by 2002:a05:690c:4c0c:b0:7ea:809c:2af5 with SMTP id
 00721157ae682-81f9935399dmr26755907b3.37.1785300065323; Tue, 28 Jul 2026
 21:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728212438.54078-1-rosenp@gmail.com> <20260728212438.54078-2-rosenp@gmail.com>
In-Reply-To: <20260728212438.54078-2-rosenp@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 29 Jul 2026 12:40:54 +0800
X-Gm-Features: AUfX_mycg9wolGjQePESF--FJZRN09rHxCnfAnS_fOgAk4-5gb4BJmW1LYVjLVA
Message-ID: <CAGXv+5GfUGRsGkRAWyX+GnJC8GOREqgkXeN4sVxE4+Y01PG+hQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] Input: mtk-pmic-keys: use of_device_get_match_data()
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 5:24=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> Instead of open coding it, use the proper function.
>
> All entries have a corresponding data entry so a NULL check is not
> applied here.
>
> Remove of_device.h as a result.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
