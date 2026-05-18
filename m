Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C6382F13
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124518; cv=none; b=gU/A/1P1AZFoumQNCmrbcqsLfyMcqP2VdrxPMY/5PXY6VxUbPHd1M65guWQN9kDC7FujyfdfVLdDy1BWLLSKkYwW7R6BcGADuUf1oNs1T8uI3N9gNBCybpnXb291+NbZPxwWV3s7NtaV+kyKbFRyzcT1zUMGTpB78ZsNMroemTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124518; c=relaxed/simple;
	bh=sOJxMZchOv0WgrC6+6PbayYyvo16Eg4LJgmrDhVE/y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAXCwUagIHT6rIdwRvU2DXpxb0Xs8lVBTXSHiIkJmQPD1CnCD+F99Gdy/3F/2Q9+zhsxwrpFCsBXKc/Rlor97yGBC9sm5LPCNV2F0p35661UXuwbluGUuY6egTJ1dU1iyKCEKLIk09RVhaRc1w4Owci3orObdO9lDyc6MEKxXn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bE2y/vXD; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bE2y/vXD"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50e5b55062fso24120361cf.2
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779124515; x=1779729315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QbJKB2lw5vG8p4X0Zp1dtcwqkjeJLsy09spRbfmWxU=;
        b=bE2y/vXDtDg6cpXPYBaCCtJ1FIcvJwP1yDgHQ9TaKdy4DnTo1zBnCm9hnkyDyze8zh
         aJsj9AiGbOILzvzcLi8zgcvnT0620HdCYvaQmOVi+DI7Pg9NQzvBbYpl+q/rIZlf3UWn
         eAYDrdBWU4cP+3oawOkNBOKXDbfWcGLz6JhSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779124515; x=1779729315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0QbJKB2lw5vG8p4X0Zp1dtcwqkjeJLsy09spRbfmWxU=;
        b=I8GR6+7YaLPKIRfDDv7CzfLZyzoO/1ikA5VX9FhLjtSO4CmKs6pQQn1K10bphsNU/y
         XWnQWNmfKLIXh8KEnI2l2qUOpftkiT3ho2spGEMwskZbNdrHUp8D1OWiVDWn0CBniRW2
         xpfpjM0gjz8whUv0NXBswcrZjrtcJ2xnh5yJ/gMp5Wz11tE4M4Qn/mxKGK9vcwKAYvvd
         9pX5SqTOewSoChyEqpT9IiHMAvyu4sBXXk5U/pElp2BScOlYKSROOTdqacfvhjn3O9bW
         ZJT2WOHLeXytIuP9Ixib/HPmH/k60YnB6qb3HXOOkdD7uFv1E32NpIe2HN9uEYfVp/Y0
         IY5g==
X-Forwarded-Encrypted: i=1; AFNElJ+wvuG6+/q4gK8r0twxXY5KBXFXqon4/kVx4+3kDOyS1bGr10YHPRyBCMh50kRuM2D9t+TQxURcoXdoBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2+HWLzcdOX1oZ4T5aEOZrKo9hmbeyL6HNyWuoZqavPoM5I05
	RTp64BsCtydygrYgqDWWN+o/8SX/V9h9BW9qjw3Dn/Jkoa5FKjk21uLwrCXLtXnwsG8nGmIrMcc
	ZJHU=
X-Gm-Gg: Acq92OEyEk/UnmFLudRt8xqo54BmlzQD/XAGOfVE9ZlH/pBt+IdnOU/t0Fx3TpaSY7c
	dzwyAxe7WQfwJTgZej/Kysc27VXzdbP0BCGm6XkLGHQIXQltDAjgTAGEMRug/Lyniz+6jg8k+VW
	5nTmK+OwK2wGOJo6UB8WRDWs2kzspyMvsTH6dxh15wm7C9P9sqSDH5+4vmRPJO7X1T0hL94mtX7
	jKYpPTC0e2+QBUQ00tiRPukko6trk8RjA+3KpanL8iTQi1sTax3o7wpqtenhhavbnDNOP3km/FG
	YMoX9lb7WiJj5V1CW/hwxgWFM4wA8B+IuTzf4iNVU1OK9xCKDS6wAYQd2L5L6SwPcCmc6NgC1x9
	CWN5Q5ZS/qNV+GO7wtlhic2Lf9l9JzaNtODjy7rUSgtIkKYO0X/6Mi+1tKsYtkY+TuiBYmsBuVm
	wLCLVmu4EiEYbq2WvNREAH9YtyJmQJO+Zz39BG1s4JcUU94lyl9+KqHifrrgqP7OiMIn8JDe2M
X-Received: by 2002:a05:622a:1181:b0:50f:c36a:3821 with SMTP id d75a77b69052e-5165a1e7b22mr227271851cf.34.1779124512643;
        Mon, 18 May 2026 10:15:12 -0700 (PDT)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456d0bd6sm138679181cf.11.2026.05.18.10.15.07
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 10:15:10 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so38457996d6.1
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 10:15:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/NPoKFM+cnDaF56ON4xumOsSDwmD8+DbFiKTZYF1/y/Aok0diTv+wjPrR8jYuSI+vIhBlTk9Hrrs+6wg==@vger.kernel.org
X-Received: by 2002:a0c:ea46:0:b0:8be:1620:a95a with SMTP id
 6a1803df08f44-8ca0f67c3d3mr193127066d6.27.1779124505831; Mon, 18 May 2026
 10:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778822464.git.harrison.vanderbyl@gmail.com> <9e749a3a483e4a3c684eac3ee6a4b241c94a0362.1778822464.git.harrison.vanderbyl@gmail.com>
In-Reply-To: <9e749a3a483e4a3c684eac3ee6a4b241c94a0362.1778822464.git.harrison.vanderbyl@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 May 2026 10:14:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W-T3gnhsPY1TPaShBcj6MtXhPntAm=ecZ8pK9aKg=LFg@mail.gmail.com>
X-Gm-Features: AVHnY4IADEBlAYng-Vk8ynfnLq-alsFZFnj4hN5gU5NdDYItYKJ7p8Mb41QcTng
Message-ID: <CAD=FV=W-T3gnhsPY1TPaShBcj6MtXhPntAm=ecZ8pK9aKg=LFg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] drm/panel-edp: Add panel for Surface Pro 12in
To: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, 
	neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	jikos@kernel.org, bentiss@kernel.org, luzmaximilian@gmail.com, 
	hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 14, 2026 at 10:43=E2=80=AFPM Harrison Vanderbyl
<harrison.vanderbyl@gmail.com> wrote:
>
> Add an entry for the BOE NE120DRM-N28 panel,
> used in the Microsoft Surface Pro 12-inch.
>
> The values chosen were tested to be working fine
> for wake from sleep and hibernation.
>
> Panel edid:
>
> 00 ff ff ff ff ff ff 00 09 e5 c9 0c a0 06 00 07
> 0a 22 01 04 a5 19 11 78 07 9f 15 a6 55 4c 9b 25
> 0e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 62 53 94 a0 80 b8 2e 50 18 10
> 3a 00 fe a9 00 00 00 1a 13 7d 94 a0 80 b8 2e 50
> 18 10 3a 00 fe a9 00 00 00 1a 00 00 00 fd 00 18
> 5a 5b 88 20 01 0a 20 20 20 20 20 20 00 00 00 fc
> 00 4e 45 31 32 30 44 52 4d 2d 4e 32 38 0a 00 0a
>
> Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[5/7] drm/panel-edp: Add panel for Surface Pro 12in
      commit: 02f48ffdf96c83ca3e6600fe5dec872b34b68775
