Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A136A3FE372
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774360767; cv=pass; b=UK7zygtf6JJCd68qCY6+8JRTT/IWtr+NNjvz81UIcbD1F9ktDXKRF/O+4TRRQQ4XSwo4NOkYaXunO1qW8rBFVZ2Ohvw1DS23H3O+y1j9pQqDgTGmA8QJqxFXn6fN2y0DNGEeuweM6Ymkump8zc2OpH+kVcsDuACe1ShCYbMmdeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774360767; c=relaxed/simple;
	bh=vyYBXmhCUT5TEiHQD+vOUjtsirAq1qrV4cFv8LNcU/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRJhCtEdLVDBjyspOpOe4y+iZP/VCLhS6k7LJlPmxA7cgPb5B0+Ol97qv9Cblh1MGBikT8cosHtaqCcOWBWgRiNwqq6qCJ25UKSf+YoShFfiLl1CdtZGGcEOnCcGLcVUu0KUrDUb8KTcTVx6wZeNCkWRvRCH8z2RyIDAN3A2HDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0gQGQ9O; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0gQGQ9O"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so1907247a12.0
        for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 06:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774360764; cv=none;
        d=google.com; s=arc-20240605;
        b=Ud3dfbNc3P0Ki0t+UcOp0skwgv37uK1kv37buYJOq/yHOd0+Olgv/yjHmFevw2dDLG
         gXMIfLtx5E0LTjN7Zhay1IGTbYbZ6pH9rgvIWu7ypUbr9oKOnaIvFWwig21g/A1FptPS
         UP/a3qAJWyT/1Tfr6/qXLHHKw0NERkmlY4G0oXFLdUWFcn4TN3Zpm1ifTCR6LbH7DQOo
         4LTv1nRfxByBeWE/ay0RAJUulhk+we8PN1Yai7CgELH4iWUXN6tCA5q4WHT2L1Q8NTxl
         Divbm6/mKcyqENUEF99QcQ7/tFME/I9vJxoFeRRUgxDQDc+q7BA6lVip1AXCX7x4oxOV
         +27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nZr+AxGZP6/2WYmYW4LcFFjgJ/CK7ZmXGyAcp7nSmlk=;
        fh=h7DmfadJxR6M7zM4p0zZvAna60LxNA6c89AcQr+dozg=;
        b=A1HIqf+gRRNIgRIMLhPRw0/zJH7usUhJRs+vKouTamamwqHDE+YKzDQAg923zIfs+C
         c8Hlc5+BB7ey5bnkql59dV+RpgYpBuARd9EDcJ70YAaKKGvWN4fvDoT4YR/d4QdNCIsJ
         pJTBWricxxyYcAS9VgsgpyMN0mF1D8w24Xx4PtBKKyHctaX9NdAprw13hp7dtuF9pM9q
         b+tcwwpfLtwgQcfnEjzq1/yLwNwiFPetr7v46zLI40nh71Jbi2ONZgIDsEdWQh92ltHT
         1RNIA9tV1d5JCZhGfsuImvDFyhO/5TM16xy66HdFwbzG/IgH7H/bhL/Q4VNPuB/rL69p
         Z/Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774360764; x=1774965564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZr+AxGZP6/2WYmYW4LcFFjgJ/CK7ZmXGyAcp7nSmlk=;
        b=B0gQGQ9OlF5Yl5HbXvhSaAYUoBeiP4S9pqt+UC/6o/k7Wg64BkHRM9cKOBmr6YxTmM
         RIba0ZXx6GfxoAC315YHFrGzr4Xwzjsn0y5nqy5oAd9IWNfW2PrbVnwRqX6kLtz+68hg
         06YPd8LSU/HaFkWYHiYnp0ch+14IUAy6uKYM6uRfCfg+pK1SyVR8CwB8+QcayNjYQd8e
         qCFtCV9fRLqo4k3UC32CcJgwV8oI1fKZj2GbR+dU0Tt9ZrODg5ydzgJJPV7MIE1Q4OGM
         qL7rnwpEGnrg5pRYxWHp3mCihQCPtHs8EUtosS9ICSL6dJw2PkjgnPyt9sNdJ7tN/lZS
         B9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774360764; x=1774965564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nZr+AxGZP6/2WYmYW4LcFFjgJ/CK7ZmXGyAcp7nSmlk=;
        b=WFg/sfvyTQRidfdhch5GnrCXUk6sjuNMkZRwCGR6rQ9aXvE0rNZlRoY8mSVcku38F9
         REm5lwW2m9fYijMdyOS4+tIlEFbVWG+T/f5WT3Zm9TPNn4GPr2gCXa10CH2dhNVJ5hsa
         D0owOKKXJVSPtiG7iZLtO+IA3s71Y/258dAKVYo3N7cQf6G3UnyFg6u8nrtu6LoAxHAm
         vZFeIntfXHGm6yQWUQObmG7bmFgCxRENW7Qv2sR6IHr1IkvWXU1muhUn3vU3IFSAATS0
         CGz0zWFJcA6OLuWIrvWZdxVHwbFFfNlVOs47GRK+/Y1jNc/TEoLU3J21vVolTQGMoR8K
         mSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcr5dby8kP3a0Q2kxxguz0TJHM9leX6WdQ+XYgVTKabH23zrInabgWXtl0fMb+xBg5dCBhKgJznyaZJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXu39b4Hzy51rS4JuSUd2cEBNJ2XvvotOnED9eNES3s1f9WxhY
	hfz+lijJgrfWY8WFbT7ujcaASp3QZbAY4XCBJDVzIBpkBj1/XUJykB6rw8iBoshj3mw3e32xpl2
	/lvXuV/KJBFmGWPcbeeHVU7m/BPBrV1E=
X-Gm-Gg: ATEYQzyynCqWw46O20PrhHsMdvKAPFZ4YWUcPuZq9HRJe6QiklKzC+aPlO8ynQQ2K4a
	pJCX6cxm+nyy+icxGIY2b4z7YAfdChQQvszjHptfO4WJUn4PYbp8kRPtHB/yQnEnUY/+j3tCLMP
	MP1N7GAfmdv18XnE67KybfCiqZ0CP0xUK3FM/FUoF2SskVb/ZnNgO3mqEyE0oohBwUvLKw/FVkS
	i2T1yUgo87TfJzmfDYbd500T3IhUFUiL/i0BkqlBPcGTbbc7M0Qp4d6CajMf6ni0xrZt3lsfuZ9
	RGF0VkY=
X-Received: by 2002:a05:6402:5050:b0:664:bc6:69a9 with SMTP id
 4fb4d7f45d1cf-668c97208femr10485898a12.17.1774360763402; Tue, 24 Mar 2026
 06:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321202446.724277-1-charles.embedded@gmail.com>
 <20260321202446.724277-3-charles.embedded@gmail.com> <acDLSiujizhuYfOt@google.com>
In-Reply-To: <acDLSiujizhuYfOt@google.com>
From: Charles Dias <charles.embedded@gmail.com>
Date: Tue, 24 Mar 2026 10:59:11 -0300
X-Gm-Features: AQROBzAF-LG6jdD_Sy_sIcgbUNU2zraLmv4fBSoiT-048QHGq-fTekGn3Hr0M8w
Message-ID: <CAHua+AMP-gwgFCX67rdDrfS8RUGpiw2msKYRn07AVWy+u_vTwQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Input: adafruit-seesaw - add interrupt support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Anshul Dalal <anshulusr@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Brigham Campbell <me@brighamcampbell.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Charles Dias <charlesdias.cd@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 2:12=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Charles,
>
> On Sat, Mar 21, 2026 at 05:24:45PM -0300, charles.embedded@gmail.com wrot=
e:
> > @@ -289,6 +341,19 @@ static int seesaw_probe(struct i2c_client *client)
> >       input_set_max_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POL=
L_MAX);
> >       input_set_min_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POL=
L_MIN);
> >
> > +     if (client->irq) {
> > +             err =3D seesaw_register_write_u32(client, SEESAW_GPIO_INT=
ENSET, SEESAW_BUTTON_MASK);
> > +             if (err)
> > +                     return dev_err_probe(&client->dev, err,
> > +                                             "failed to enable hardwar=
e interrupts\n");
>
> Maybe this should be in seesaw_open()?
>
> Thanks.
>
> --
> Dmitry

Hi Dmitry. Thank you for your review!

Since this is a one-time setup, I believe it should remain as is
within the seesaw_probe() function, similar to other pin
configurations.

Please let me know if I'm missing any point here.

Best regards,
Charles Dias
