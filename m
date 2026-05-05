Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9AC3DCDB0
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972248; cv=none; b=ZvgCaNou0jAwvSBvmozcJREC452cxMVOW1F0BO8xA/tAU2q1mYO6xPUM3ev41hitik5kjAj7whb7QtOmwzw7450dT8KolLfQwEFntGFAY/4wLYW8ciPWTFYpO6ZrUfKIgXpR47z6jNmU3tpLYFwEpLfnDpsHEzKzaP6z+laKeGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972248; c=relaxed/simple;
	bh=14DO9U4ZByT2mMLX/faRIDllnJShplwGSpW5i/RfZvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9NwvNWXXwyYf0bhEDSOBLMZ8zefdbwwHlmPVDQ3eI2U5giK7z4hF24sfUUgB7e8s0TzdLgNwKhpYDnCBpaKv8eTj4iQq+tpOHMbT110SPbVNLSWWAvMHUHXgYP+K3wQJYaXnyXRgD1LVar0X0zONHgH+HfvlSw2nqrIvX4hMbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j6tbPbvL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j6tbPbvL"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so844598766b.2
        for <linux-input@vger.kernel.org>; Tue, 05 May 2026 02:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777972244; x=1778577044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BKVuC8P0D/n2pZsdliIu0oHoVTQb3ML0sBjQuAlRidA=;
        b=j6tbPbvLYgIenKIux9ifzQ2b0l/+1IjKdtmS6n1aufnzt+ssF9tEA95gpomnSu1CNI
         JgR+jJvFK3y8orFOyY03tsMWQfCefdft091IyP1WQ4bdwU8IbeBKW3SWnawrnKTi84Pe
         kmOiAgDAk+gYuyLhok5SPSDZ6ds/UlAxmtqz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777972244; x=1778577044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKVuC8P0D/n2pZsdliIu0oHoVTQb3ML0sBjQuAlRidA=;
        b=CuwimqmTWTgqXe/P086tNHEA2X8XQiBiKlFzUmT+wntjdBLxcxL7ZNwXUAlVkZAr+V
         luBPNsvxJ9i+FDRzdecr7obrVF7WE8h5tbeDpt9ULzleSCl6nOPQdIeAPpliEIbD7n70
         ZYQTlFTOafC/omyci/O8Qnj5416rYHlHhWPkYKeVnc9PKCetoKdNq1OFRnpe2xwP/jxr
         39jufilCxmN7Ui1XiGX547DC7C84gfKpYs//2dvLnxi/8+rVtN+l2YiBjAbQz2WFix/K
         BgfCcF9ds+75iQjgX+WnCTY4bTXgZmz6uSqr5JAJyBzOHiAea4yUn1gT83l0OpjicRHI
         XZUA==
X-Forwarded-Encrypted: i=1; AFNElJ+/f1uPkXqjIOODuXN9ujs9NB/tdDzYAXFsIXJ0almTAElhYIem1lBxxpeybmA03nrX4944+LAYXavR0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTCTSvtN8U518V8shI6++iyZMQsMJiTyeNm4BPY2Z6ubD4puTj
	7L96/oZhcsQNvZeRdm/Pe/DT7CPgaMDJlFrtqJZVSKEUV7QbRzJzJOMK3mEMjmZh0tBlxzxIvrV
	+5ssXu9XH
X-Gm-Gg: AeBDiethAErqKxROyJF0/VQCrxvvP1qAOwzgJZvZHpJQ1/iVX56f/LreUfiM/cD3dBw
	Ir6wYfVo87imRXSY0m8Pta0FH77zgHbahu+6B3c7N6AMJTKwVg7IVNmANnPjh8taDdkXsgz/bTh
	Iv1dVRFKcZjvS6RGbSfAZ4PC081gcR1N6dJ0I81Wjj2DC6LsxKYH6UZVE8zRedKlqju36jnpJdY
	ytJ+nh/CFu82Ta4XL2nx+NEfNy8EpM0KaPPbD+1dmL3qJPH4kVHjh7F+R+5ycKCcpVGKs/banC2
	OS+JLYwDXFe245UL6Acp1GsHADhwunJpJdHkNZxvTfBM7jb2wAKI6pnU7z4uIE8tOcGVRFrPUQr
	iWkYEa02HkFypbNG5CWReRxhT3uUnNs3Kx/akPOdUnlMJIfiFO+RjWlvTNUe3sypqrOGvzs+lIu
	d+98lPfpvgaToJ6T1XTKzQ8oYui01qeScrFeraIEizUq5nBkt5FHstyYU2WrDUbkVisfmX4qU=
X-Received: by 2002:a17:907:5c1:b0:bc3:6b0e:1686 with SMTP id a640c23a62f3a-bc411c2bb66mr106122766b.37.1777972244505;
        Tue, 05 May 2026 02:10:44 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc1a0abebe1sm230983566b.16.2026.05.05.02.10.43
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 02:10:43 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8f9568e074so748164266b.0
        for <linux-input@vger.kernel.org>; Tue, 05 May 2026 02:10:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/6dX8xRfwlC2TOpaxodjTnO496Nep5YXfLje/CMFYIUtxjUrB3lBEvS7WX5Zn6ANWXdBMTZW1AUXMAlg==@vger.kernel.org
X-Received: by 2002:a17:907:a06:b0:bc3:a4cf:aecd with SMTP id
 a640c23a62f3a-bc40f91f749mr115011666b.14.1777972242226; Tue, 05 May 2026
 02:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504185448.4055973-1-dmitry.torokhov@gmail.com> <20260504185448.4055973-3-dmitry.torokhov@gmail.com>
In-Reply-To: <20260504185448.4055973-3-dmitry.torokhov@gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 5 May 2026 11:10:30 +0200
X-Gmail-Original-Message-ID: <CANiDSCsctO2BhVe8gFy+O24Nn_KSBZTogCr0VvcbXVov90==pw@mail.gmail.com>
X-Gm-Features: AVHnY4IqjqOL-bBF8rRuHihOXEZZZwMzOeq9kALdcyH4xyt3I8rVUobKwGo9N7M
Message-ID: <CANiDSCsctO2BhVe8gFy+O24Nn_KSBZTogCr0VvcbXVov90==pw@mail.gmail.com>
Subject: Re: [PATCH 3/3] Input: atmel_mxt_ts - use __free() for obuf in mxt_object_show
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 20:54, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> Use the __free(kfree) macro for the obuf allocation in mxt_object_show()
> to simplify the code.
>
> Assisted-by: Gemini:gemini-3.1-pro
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index d660cc5b5fe3..6af4db5ed117 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -2870,14 +2870,12 @@ static ssize_t mxt_object_show(struct device *dev,
>         int count = 0;
>         int i, j;
>         int error;
> -       u8 *obuf;
>
>         /* Pre-allocate buffer large enough to hold max sized object. */
> -       obuf = kmalloc(256, GFP_KERNEL);
> +       u8 *obuf __free(kfree) = kmalloc(256, GFP_KERNEL);
>         if (!obuf)
>                 return -ENOMEM;
>
> -       error = 0;
>         for (i = 0; i < data->info->object_num; i++) {
>                 object = data->object_table + i;
>
> @@ -2892,15 +2890,13 @@ static ssize_t mxt_object_show(struct device *dev,
>
>                         error = __mxt_read_reg(data->client, addr, size, obuf);
>                         if (error)
> -                               goto done;
> +                               return error;
>
>                         count = mxt_show_instance(buf, count, object, j, obuf);
>                 }
>         }
>
> -done:
> -       kfree(obuf);
> -       return error ?: count;
> +       return count;
>  }
>
>  static int mxt_check_firmware_format(struct device *dev,
> --
> 2.54.0.545.g6539524ca2-goog
>


-- 
Ricardo Ribalda
