Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732066;
	b=0Dsm8r/S+aRgakyuTvlI//+p4AyXLJKdkWtD0XnweKk2/MCQ/WcbtONENMf5zaOdOGyn
	 Oph6iktffvlYujU5fRE8j4dFOCxy5ADwDtvRUpD3Kfu2AIE2WAKJ+R23EF6TufTHwTckW
	 k+JRDixND7RnoVEzLIPKwgrQalIHdw2EnCw346+bon0NfcgmZzCZQMrb1XH/dNMd4coMS
	 nVPkS/o6br7JtFciAakTB2NVh8UMB/JG9+findYnhH3Gh0Jy8KjjuKhVZ7B07X96VYExc
	 1acEwQ/sH5N9ms53fZ38JHIxxhKVYuQkMRgGGIShvdFrCM6znNpLMmKWx/jFjYhIgIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=qSLS6P8awR8sg8YK6TCBsmvvbL4PGOeF41QBtG7ggjM=;
	b=fJ0qn1k3KWkayAylT0opFtu0SSKce9DlU0XcS0DyG8VYlqXGcU4916wgpuLdaSykgoB/
	 yAMDtMd86O8gX+DXK45+j7GSWAqGm9gMPgo+5uBOa8122cwzkx+e2rIIusVI7tIv1ddAe
	 n6V1DoFGWm1Vssml1ygl4UXHo+S24oQK4rrC3bO6uoCL/ToWq43cevw3XSH9/V/0lj9Z3
	 sIiOhBnSZe0giCh86Lpa8k5dnFU8ILIGX5uMpPS2cD44CRVQLFg/fE9P44HS0IbUSY3aM
	 cf57wT14JdgBoaOSwpDNTYVjuXLWO9bXBJlIRceUxrs018Al3i6g3HwdCZDlpfmTAsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LgITnaNd;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B40606A329
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 18:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28B40606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LgITnaNd
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3535a54bed9so6731057eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 10:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732065; x=1794336865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qSLS6P8awR8sg8YK6TCBsmvvbL4PGOeF41QBtG7ggjM=;
        b=LgITnaNdSvowF6Qh9MK3lhkdJPA8Hol85Npafv8fz6TgPGGRUf3tlmYysTR89Xtxp6
         VSnrZDzLthYWxaLR1kgxM9Jur6pTJsckxVY4tK/XJBjEyJ3M3Gxoj5yFyUjxjbrUIBHY
         MyUU9yqaJ9iRsVwaDEW1Gzu20I3B4dufRV/InC434N05ZrwIQF4DjjkL1uVzCrFLcHMP
         P1D5zUfo9KF7DdPoBkMh6cFnxX/BGNublaSDhMQ8yWb3fqRzQ988S1tPrmLmpUzioddU
         JBuxKh78qeEIG78xc6hHQmruArbOJM7KN2Edhs7yjt0E8wSiKbFRBA+mFX35jq8145R/
         P2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732065; x=1794336865;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSLS6P8awR8sg8YK6TCBsmvvbL4PGOeF41QBtG7ggjM=;
        b=nlV/koP5cxEFnw4kXAWGzE3HBVTWhKGGwS3N5L5RPXXviccDTLR/2s3dIdIg553ElH
         HMX4T2w4d6oHhXq7tNsT/qpWQNU7hY2DSBQL7blgnQJ0idZoN05Rv9sHeWxChKNXKPb7
         wUFwFY5U/x/6EPE3MeUyjZhT/Uj5HFaWiYFe48hI0CiCbSNjzUDch8eptfDZGSU70X+6
         pPvkoClnYvZkQDnyvCfLhmakQIUKwA8NJl8snUzyLahMHA1GBfDTbIC6GcUUtOefUFRU
         04fAifk140nde809n0occn8cugsW5ewsHOOlS5xfv7ZB8Icq1ys+87BHsXwSuWlAYrvO
         mD5A==
X-Gm-Message-State: APuU4Z8SVGdC65VFyG/jgaAp5jq2bHk/M4YwZuuUx0o5OZf9t5kgX9pu
	IO8ToHyYlx6IvcCB4wIua4rjTrJre2GAfBa/Lu5MzhPfgXHzFaaPyPWWEC1zTQ==
X-Gm-Gg: AYBFou2YG3t59hMw0+bwGT9evDOux39BHZWQYJcGqSJEt7jCuHayhlYBQmVOOHwun6+
	Ocb8F+hFuFGECN7Ne8Nx+2/dhOjbqW1LDn2yLzQJAQXNgIdtRZtQgatAg6aM7Fbkx/4W8/bJMfU
	LLOpi1fnohO0fAQI7PiCeWYYL247vvquVCGLMdJFo5cSVLljOGGV2nUQbx68duyUs5c2z1AaCKS
	fBt/QPtngWeljCXO1JRH/W/wTZQk/jZuWxQNhtrufcOZ18IQmD1c6yYX910T+KyZbvSVLX6ZX20
	C8MtPqv8Zjjr3BV8ZdbtLwSBzPQHejKlCG2BN9qjPKLJS05pKls0YBbCx21haoWuflPUAo8dnG7
	ROa8LkhQQ907eMs/OW6dw5F9iB3eoizM3LpR1mV4D48tTQ8O7MzfkIp/03udQ9pfttSkJjSeYRl
	LSHV8ynlsTSzgzBi68lF2BdvMdaRfWcpIHLyiLtJofa4vO/kPuy9LCRm7rwpU0WxyZnzp8S7e+e
	75WPDm8ldjOb7nES2XKBto5Dld+fwpwQoj2LbJn8oW8rc7jMS27gzzBIYomjvNHkRoZx+RwB1VT
	M2smGsOoN26l1++pZS8X+TyMV+QI102W+6kGTUtWjVF9SzFEgk8w5HVyPPchr+k8BPVd
X-Received: by 2002:a05:7301:3ab0:b0:369:535f:4d12 with SMTP id 5a478bee46e88-36a4221aa1dmr21444083eec.3.1793732064912;
        Tue, 03 Nov 2026 10:54:24 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm82913eec.9.2026.11.03.10.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:54:24 -0800 (PST)
Date: Tue, 3 Nov 2026 10:54:21 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH] Input: lpc32xx-keys - reject matrices bigger than the
 hardware has
Message-ID: <auos7TgVNv7EWnbj@google.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
 <20261103084135.426629-5-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261103084135.426629-5-zhugl3@xiaopeng.com>

On Tue, Nov 03, 2026 at 04:41:32PM +0800, Guanglei Zhu wrote:
> The scanner state array holds the last state of eight matrix
> columns, and the interrupt handler walks the matrix size that the
> device tree declared:
> 
> 	u8 lastkeystates[8];
> 	...
> 	for (i = 0; i < kscandat->matrix_sz; i++)
> 		lpc32xx_mod_states(kscandat, i);
> 
> The probe path only checks that rows and columns match; the
> hardware supports square matrices from 1x1 up to 8x8, but nothing
> stops a device tree from declaring more, which makes the state
> array index run past the field into the rest of the driver data -
> including the keymap pointer the same code dereferences.
> 
> Reject matrices larger than the hardware supports.
> 
> Fixes: 69690bec400e ("Input: add support for key scan interface of the LPC32xx SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
>  drivers/input/keyboard/lpc32xx-keys.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
> index 285d5c32fe70..1d0b082e7881 100644
> --- a/drivers/input/keyboard/lpc32xx-keys.c
> +++ b/drivers/input/keyboard/lpc32xx-keys.c
> @@ -142,6 +142,11 @@ static int lpc32xx_parse_dt(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> +	if (rows > 8) {

This should be a constant/#define.

> +		dev_err(dev, "rows and columns must be at most 8!\n");
> +		return -EINVAL;
> +	}
> +
>  	kscandat->matrix_sz = rows;
>  	kscandat->row_shift = get_count_order(columns);

Thanks.

-- 
Dmitry
