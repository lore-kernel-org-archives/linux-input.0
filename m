Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547FE37F339
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 03:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134630; cv=pass; b=P/scAyALW+pE+bdlO9EAGEYE3unVI4ZLGk/pVU5EUD3MLaqs3tuyTFdrFaNY9WYFDWjqWOSKRZ8Al9BLEYbZCT3XcBynISpWCZigmZ+3cgPXZFrkpamuGt7malDh/YqdAI9gSBH83D8cJGQGqecVTDOogf/9U7vJvw4b5UFC//o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134630; c=relaxed/simple;
	bh=yfqpp8WYOenmjb3oYHuHBnzp/XrvWdHp+mrIFBFp1P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oufodO5bMkWpQrlLqH1ZjczxaxkJ9IhGxV0DzzPFoXf+X56Ks+AX733d+3n0Sn1vvgp/re8VhGlJm+B2b+gd6On/XLEnf/zx9WjF7VOmxFO2A/82aScdGOXPWMGJcWYfQjxDLH7CuIg2FcErF/uu/f0Gdfoyx8Cf4QOHyXIaBcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDIBoSoj; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDIBoSoj"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aae314aso399575d50.3
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 20:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790134627; cv=none;
        d=google.com; s=arc-20260327;
        b=U2A2nDKNJi5Gpu/bU2WvJGg1s7ZAyteiyDPiX+a+legLf/XuC1dHvM2YM37mChtyQL
         BBBULPBM8QCm4ImvCRc/ypqCvmfp/wAyJ16F+EiCIaTAnpAjpevxct5ox++yFeNYoehW
         bNo3KP8/mnY2keaaeISfh3ME/Em06XZ8DTKu6+lzAxWH6sIAgx8CRaiyYvVeh5tBDB5L
         KCXUENNccuKj9/RuOTlBT3FI0EjQzO5qewl++oyqrxPDoBuFveBjk1hAZp0DGvnU5ctF
         7t6/oiBrRAM81pborYmdzD4HHMl7lhXwkJLODody4t62xMjH4Jd1EuNR90JFQ1smOSjB
         SPXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+ZFmROfgidpQl1un31xXH76vvuzAN+m1uLmNu7y+jkk=;
        fh=lBthZElrSxSwbOuUrGCLn1OS2KO1r8GnUKv3M3lbXWw=;
        b=RZzISAPMQZft2sLfwu9sdJcvL80Zb4ho+p+NXWPaXPw5KUf80Kplsnywakk10qrRRH
         89gfgJKT0rG/SLG5ex0oheZ/FhyxGoT0nftiX11FM9nxYmJjwa26NZyDHgDxaD20AaZl
         rmKY0I+FB5tHrF9RiR2fTGqCofne7vwLKrbTtv67I5YW0I0+Vx4GDHgJSUCdRwKMASfe
         ++jK55HCshrOCCBDGiTERL7ROkCyTirBGodXSHgBTl8ecSDD4vifHdScqYjg0CWXL5RV
         T3pDuid4hhqQAqZjycKKmBiwLfQceciPXJHSDOh5nisbGdHYC/yrqmN4sPMFT+s0m0up
         IHVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790134627; x=1790739427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+ZFmROfgidpQl1un31xXH76vvuzAN+m1uLmNu7y+jkk=;
        b=eDIBoSojFqTGVFJSfpyI+dgrVgJ+kbpRm8SU7quzy3mtWIaJZUcTEArA5PiD0OXPtA
         qM3yyS8ekPeyyl96ZoemqcL3PX6cxDYD2orEt4+EwXzzZM3LVWyO9xzWPULcGLbMPrK7
         MVf04tgbehhhT2EkzHQx8jbsHEGOIeDqXxD4dRaMtK4SuZwd+pew/FM05mGmdkbYizSe
         TIAp+6/Qlvuuqd9MeFq8ZK53c5a2GPdJH80phkvoV/0FwJt9No1jzw+FqBT6F2iABMW8
         Sie1Db2lZxDLs5f7uLQt9KV2Poc7X/qJelP/4vqatL81y1r9M74FE7ZYT6fITAQMnUN0
         jqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790134627; x=1790739427;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ZFmROfgidpQl1un31xXH76vvuzAN+m1uLmNu7y+jkk=;
        b=l4WZFZmYFlcUfqaAnUgeXzTKCXmGVVCAcQc7r54KXtsYBGfZMvIKx8ucwQfIYy/xDJ
         /6cYRwLD4JszIH9hnKoTHVg/wl+hu0Cq3PkyByopvAJuS5Z0vNBqSAZruc4l9Z0/DT47
         q4MeNtgjx1chmvU2dyfchDghAcCWHq3mJOZd2JBpS1S2PnydwIkNg4ugTdMb8Vgu/THM
         Fzdw1lgXEaGsbya5eWvaTN+6FJaW/k2DTDayFYYXCyrIOIpB0ct9gooxI/ubUVinnuiC
         JoiuiquElveJEmKfjoiiYAAs3b+TI9HLzIbOLYMjyQG42owIT1PYcNs0/ieW5Kp7wgvc
         zW3w==
X-Forwarded-Encrypted: i=1; AKwUvBy8ScAndCIrB/KR7QGEaz99gZRO9CFAO+qi7MTrDvocBrcQDybHWyJApecJdHR8/eaMB0GM+hmFEMQuww==@vger.kernel.org
X-Gm-Message-State: AFuF++kBK8bELOLGoSILUSc2O58cGa6kmD4qbGtKI4dT4Pzl29JGTP6r
	te4gHpDzusDWMJMMeTf5oCl/vluPJB5qTiK6ey//rNEZknJnZXW/B6InqLyB9HX4DK2zG11UvH5
	TwsVuxdtvLfU2Vlf6EWZwfYA2mz7W8kjMbO2n
X-Gm-Gg: AYBFou0CNaMwVuNLkVUMJUgCEMSKNcbaozU1HR+3VZ3iy+m3UrEL0GSqqSTBu6l/193
	ny+F2S17F1Ziu8T4k2Ui+Qn8S/rh47X0RNkPrLXQKDBkd6vKtGDLQFyoX08/B24nea/18wqgBuc
	R33Zq2pVMtxaJqw7BakEtMZIXO2dXasPwL97Pi8yPsm5BKi5LWc3usX5FB3e4OoFt+fG2HFMQ4x
	pkcdPHKXRk257MlW0cfCSNSHWdhGdXaydgNT81mGhLprAA9y8Z9kFSwfaNWavuq9ga+XE0GcCws
	oyAYEjXbZETtrqnBcJUt6E0f4sKIINF9nsUps7O1TId7UuwEfg1Xtn6LythMjNd56HtK9IZ/CSN
	dUw7dwhImo1hrCbbkhAmd/Ifl5YH20RsdYqlCc54/bMJ0ONKjb8hqJQ==
X-Received: by 2002:a05:690e:813:20b0:66f:7d56:cf77 with SMTP id
 956f58d0204a3-672d578ffd7mr617427d50.26.1790134627332; Tue, 22 Sep 2026
 20:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806080018.10050-1-kartikey406@gmail.com>
In-Reply-To: <20260806080018.10050-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 23 Sep 2026 09:06:55 +0530
X-Gm-Features: AcwNN1UgAdWRW0CPTd0_d3jSSC0DEL0l0d8D5ZdtmqlAgKIGlSvpt7WCNa3r8tk
Message-ID: <CADhLXY4_jL0b5P+7_vHBdkGeNRAYJN4MFEPSoV2fyMdAKHWAHQ@mail.gmail.com>
Subject: Re: [PATCH] Input: sur40 - fix use-after-free in sur40_open()
To: dmitry.torokhov@gmail.com
Cc: kees@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+683f6c071b5abfc266c1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 1:30=E2=80=AFPM Deepanshu Kartikey <kartikey406@gmai=
l.com> wrote:
>
> If any of the registration steps after input_register_device() fail
> (v4l2_device_register(), vb2_queue_init(), ctrl handler setup,
> video_register_device()), the error path frees sur40 via
> input_free_device() + kfree() without ever calling
> input_unregister_device(). Since the input device was already
> registered, it remains live and openable, so a racing open() (e.g.
> from udevd) can dereference the freed sur40 via sur40_open().
>
> Split the unwind so that once input_register_device() has succeeded,
> the failure path properly calls input_unregister_device() before
> freeing sur40 and its buffer.
>
> Fixes: 08b936012964 ("Input: sur40 - switch to using polled mode of input=
 devices")
> Reported-by: syzbot+683f6c071b5abfc266c1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D683f6c071b5abfc266c1
> Tested-by: syzbot+683f6c071b5abfc266c1@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/input/touchscreen/sur40.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscree=
n/sur40.c
> index fe63d53d56db..b0958422ff76 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -808,6 +808,10 @@ static int sur40_probe(struct usb_interface *interfa=
ce,
>         video_unregister_device(&sur40->vdev);
>  err_unreg_v4l2:
>         v4l2_device_unregister(&sur40->v4l2);
> +       input_unregister_device(input);
> +       kfree(sur40->bulk_in_buffer);
> +       kfree(sur40);
> +       return error;
>  err_free_buffer:
>         kfree(sur40->bulk_in_buffer);
>  err_free_input:
> --
> 2.34.1
>

Gentle Reminder. Please let me know the status of this patch.

Thanks

Deepanshu
