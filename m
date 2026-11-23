Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464783;
	b=kftlHLAM0lNolXvro3rM1XQXeFZkwayJ7s+r8h0v9q9oLgqQqqjfTyqWFJsLrU2jJMfX
	 LF37yeO4sadP8UGI/lR63rHPiWYGL1FiCLuknd9F+Dby5WSk0gDHKaTaeW7NVa8+uqoZ2
	 Zkw95wyxTD4/ZsDa5s98OKSlBMkIg2zXhXnqh7i5/3zxseE7UoO9vqU9a7I9oPfEGGbuZ
	 83I4+pYPAwNzNosvl/eiA8ttxzFYwNLNBp/eB6kEsh30JE29yQ0JdjRfIBpBTGmCOlzY4
	 gHtOZDEa/znA6XNuoej3dJAEjAplO+/QmsJdlDiHPXTYXeo1RjkAcNCqDZjRcCCZ+Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Vl+Jr3N/YEqz9NFVbM7G/TwPrthGUN0HgQHZE/6GVYs=;
	b=Jk4ck9edpvuRScjhgGd+ptBiYQSPbzoJuZv1+5DSXpdIneRtwdkYQEKqZ1z3VUzW6Viw
	 mqvaIpfCaca38/l+OEPoIAP30HA8fLUYvd7WvkaCOVEv9zWe85PSxAbec716CrkX/425n
	 xFepwvkiHuw1CAaOsUmnY3CmqLefS8u0MDzdrMvzX0DmVwqYBHDd8OzJCFwlPFlgddXcV
	 JKkO9SxJku8qc2iDNRL8x2ztIFbCi8bwrp/i2ff3eSxq/rsy3PJ/Vdup9mPXuGoTzb7+4
	 Cod80pRpoVmiJRIS23KTigET3c9jsLxUPasqzSQCtm0qhp1ve7jFLXa8WTa+bUtzAtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBwGTjYq;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4054E606A321
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 20:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4054E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBwGTjYq
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a2761c69fbso2875749c88.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 12:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795464782; x=1796069582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vl+Jr3N/YEqz9NFVbM7G/TwPrthGUN0HgQHZE/6GVYs=;
        b=XBwGTjYqQTUhH8gOOPo7XYWKULuUQj/EpvbNDliWDwCiUoZljy6hipnGBLvu6Cnf5I
         QB4eBs8VRrzDPEFIyfvnEECbj62cghj/ipTuo/74QHstzb5WBVfWu4m02MzsNJkRGKvI
         SL8fcrbPP0dhsR+7166QGff/5/sQV76QwiPZ7j97puU4qusj2tHix5UXAB3PKH0FfvdF
         VB7kwwzfXflu7ZjkINak8Hp7mvsdVxjbRWKOPxeP6S6R2nC5D+bm4l+C8kc5KUkVw6fN
         cK8+myDOVOK7fbti9aE2nqTQHnvbOopkfcQ73z56fwYLjpAI07pa3Vv+0MfVvQC4YUsN
         YlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795464782; x=1796069582;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vl+Jr3N/YEqz9NFVbM7G/TwPrthGUN0HgQHZE/6GVYs=;
        b=EMgogjqt/U8ZDiftesryq1pJZYpHdYrTwc4W4C9sPWhh1mVaaiNLlodWch0n9Ig8IY
         BFdDo54Vosa749v2yJm3ZINrtJFa6cyJMuTLmJ4iMaDUcyetLi9c2rapYko2I+fM14hU
         DqHdaidTjLcMkopxpasCBUj1lW0vs5keNig+4msGKOJgZhGXmDMJvdizyu7Og07Cp7gk
         7637bq61sU4V0qFfpzNMWiuOeG/CT4eLlLD/micz4X5KHJ08cQBz1sEt+l2rdvRbxA+U
         5QzrEHPe3Rv3icH9nX+OPkdeitzYppDM6diRfWnHehr7jU/uwvMxzRcPfLV2OLa6vQD/
         dXXg==
X-Forwarded-Encrypted: i=1; AL+hErHTRPfuuqpRqVPWZ0/1RiAEQdXUxfPSPknU25BbrDvMJf77JgMrl58/ZmWGrxQRPCI9p3AMFsh163/22A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+88wNeAj65Sif1Cj62a3WSzxEasqiuJyR4MFH6cgNG5mcWRgQ4
	hvze7eHQIrZPd8hkYwv0hPWqhN5YbMFc/I1GUw2RxMmrjs7u3yqOX+oX
X-Gm-Gg: AZFdTZdJNS/3QkDlFd4TTti9m+F2MikcUdwUDRPAIilKSPAk2JexqCpBzasxWPPFNw3
	vb7h7fxYqS6K48sw0RFo+ph0g8HgvvMtp8Of74di+fcwsmU5M79EutoFY2ERs+LRTzXtLz5WC6L
	ZBCdPWxfcGerxjEOOjUSB5MEJk+yKxSSIwQDHs43UlUowEBa5z+/Anu3JhfsLclEKkQE1KGE7TU
	cLeetDH9Y724JqvbWT1tg3U5eOlwFVZNwhNtp1kk8W3iJk9wWu0dQ2/bjBDcdQPnHh8DGd7xNnh
	4cI5wlqHbp9sD7/KsOZ76xfL1nSKhDnya1/eepjsnQQsuRP/t0qWDTOSpMJQ3efu2NWm0lD8Sg7
	I0RTzUKTfQU/Ov4N2n26vbsOA7PjpG8801bbVAu009FazYenrQi+4c2iq/uQx1Z9erKcxF5N6P9
	jLktxNYfzm1yYqb4eLFBqbeuDJIxy0Z6ktRNpnZNgZ49yRKYieLcCRlS8uttjQgQ7dwXeDZXujc
	tt2fS2QKE9uxQtvRj+CmqUk1DnqR1R+xZBSATJ7XGTZfXuZ1m44SPu0wE88inbK4WY4/EBHIDGt
	jWXUUKFh+vqP3UEHiiZ88odjsfyNm6BmoX2vaCT4V7AND5wNyiceGP2sj4X1c97exNHrI1o=
X-Received: by 2002:a05:7022:e80e:b0:1ab:de8b:5f0f with SMTP id a92af1059eb24-1b556924b07mr13875087c88.40.1795464782093;
        Mon, 23 Nov 2026 12:13:02 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm34059654c88.13.2026.11.23.12.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:13:01 -0800 (PST)
Date: Mon, 23 Nov 2026 12:12:58 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Marek Vasut <marek.vasut@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 01/10] Input: matrix_keypad - validate GPIO counts
 against matrix limits
Message-ID: <awSdwBnT5bk_BS-G@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-2-lee@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123183200.3900004-2-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:07PM +0000, Lee Jones wrote:
> matrix_keypad_init_gpio() obtains the row and column GPIO counts via
> gpiod_count() and only checks for negative error codes before storing
> them in keypad->num_row_gpios and keypad->num_col_gpios.
> 
> If firmware supplies more than MATRIX_MAX_ROWS (32) row GPIOs or
> MATRIX_MAX_COLS (32) column GPIOs, the setup loops write past the fixed
> row_gpios, col_gpios, and row_irqs arrays inside struct matrix_keypad,
> and matrix_keypad_scan() overflows the stack-allocated new_state array.
> Conversely, a zero count causes get_count_order() to return -1, leading
> to an undefined shift when computing row_shift.
> 
> Reject non-positive GPIO counts as well as counts exceeding
> MATRIX_MAX_ROWS or MATRIX_MAX_COLS, and size col_gpios with
> MATRIX_MAX_COLS for consistency.
> 
> Fixes: 584bf366f8fa ("Input: matrix_keypad - switch to gpiod API and generic device properties")
> Closes: https://sashiko.dev/#/bug/linux-ed4b89af-6c76-4e5f-b140-fb2b107b12d0
> Cc: stable@vger.kernel.org

We trust DT somewhat so I do not think this needs to be in stable.

> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/input/keyboard/matrix_keypad.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
> index 11018382e84e..c2f839a3de90 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -33,7 +33,7 @@ struct matrix_keypad {
>  	struct gpio_desc *row_gpios[MATRIX_MAX_ROWS];
>  	unsigned int num_row_gpios;
>  
> -	struct gpio_desc *col_gpios[MATRIX_MAX_ROWS];
> +	struct gpio_desc *col_gpios[MATRIX_MAX_COLS];

Luckily they are the same...

>  	unsigned int num_col_gpios;
>  
>  	unsigned int row_irqs[MATRIX_MAX_ROWS];
> @@ -302,11 +302,16 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
>  
>  	nrow = gpiod_count(&pdev->dev, "row");
>  	ncol = gpiod_count(&pdev->dev, "col");
> -	if (nrow < 0 || ncol < 0) {
> +	if (nrow <= 0 || ncol <= 0) {

gpiod_count() never returns 0. It's either positive, or -ENOENT.

>  		dev_err(&pdev->dev, "missing row or column GPIOs\n");
>  		return -EINVAL;
>  	}
>  
> +	if (nrow > MATRIX_MAX_ROWS || ncol > MATRIX_MAX_COLS) {
> +		dev_err(&pdev->dev, "too many row or column GPIOs\n");
> +		return -EINVAL;
> +	}
> +
>  	keypad->num_row_gpios = nrow;
>  	keypad->num_col_gpios = ncol;
>  

Thanks.

-- 
Dmitry
