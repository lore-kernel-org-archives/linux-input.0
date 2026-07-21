Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4743A1B5
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 00:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784592747; cv=none; b=Hi1uqw7Ug3i6HvPov+2F0+KMcabmyEYUgfQnhjx17IpT+HmlDIVsZvrDsbROgVUvRSAh5PG792Bef1hJdTe3o33QrdyxQLSIggV2IIzJghaDIHq5u4H0FpzcBi2iy69eSnECnYsE35cvuPRKSaW99ZSsKP5uFjnm2aAVOOmxaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784592747; c=relaxed/simple;
	bh=RsxvZ2kjNpRuxeiC7PhLOyIc/slr6yzCYWGOMYLH9MA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=BA0oZBXvEZz5ixBVxlp4pfEZRImCh+cuuvXHH7lvJSk3aFL6rhzFvM95a0+JRlwqhveztcsHA3V5asw5KfBdTiO6XlpR6n13qTKCIQ4UsMGGUhPCH2dA8Z44QOvJMlxFNjGRyVb1u3hei8C7WbveT7a47PSxrcj0mlS0MV1E0a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=mR6hwAj+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="mR6hwAj+"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ce7d2adef4so105984895ad.3
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 17:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784592745; x=1785197545; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=onrnB+/aHr7Wf+QkbszHMvIqFKZqE++ytmEcsC/rl1w=;
        b=mR6hwAj+ENbCuxA17/4Y77ns/cj3Ou8n9GaV25zHtC75bcAGipdPPwYQ5RATmeYRUv
         78qHcseUDHBW2eFu7qaMa+7UNu/IkCfMBm3tn5tZjtH88X7QxNb7XrcfkbJHgwFdaSM6
         Fy3n9bMVBhU6Mc1c4+7CWNYAn80hRyBU74uK3KHTSB+ahQDi8uAMmHzYSZifiVtamTsX
         Coqedl0zFbhrcsvKlpGR5KF+++T7qdXj5X7cJyj4xAW5H3wlE8BOmUukGbmIlKJcEspb
         SZ4CSPBK6lb6+Yp0IaJbFh3GCkDndtLgEmWGK9zG1h1E9VnVzokASww0kpE0Ft6DSjnJ
         pykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784592745; x=1785197545;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=onrnB+/aHr7Wf+QkbszHMvIqFKZqE++ytmEcsC/rl1w=;
        b=nt/qwGNOmbrno2JoaquavxbrdrFYuNdu++Q2KRMhvkdNM1cl9WO46beL7pScbo6AlG
         f050sws1FqUdMtS0VGdbjbbltcfeI74Yu4YgRkIqNcZytmMlcsuL9u037B5cheFfP7A/
         1ZVnxmYr4OGxKscJhM5Y4saDOWuHjOaGJ68r7xLqjJbZjxYIjN4HPmaAwB44TVXIFnju
         sun79SxmUSQeCN/0QRExcm55/XA5vqz31P7gr0FhbNdXU/MGGd157AnbuT1wU4laBSJa
         ttUgvGmzn8szU0CapMpBAaVs2365hEVwPcQgH1jBFACSnPVKIv+ImEfeBCh1i2cI4FOK
         2+oQ==
X-Forwarded-Encrypted: i=1; AHgh+RqvCUhFoT4xw+gTAp0FUqtNF6MPTR0b1DTKJ37IELBvJevfYUcA6ShxqqfIut7eU4Jn2gppUbOtDaRThw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw438SzwLRYR0qk2qx7pTAUDGddJ2nCY0P6N94y/+VEG1zpOip3
	bbi47HqNw49dpoogalPK5YgvwLODhYSACI6FK7f/jR5zMrMHPX7ShKGpklVzYll7uKA=
X-Gm-Gg: AR+sD13f5uJs8J4iD37smcqU4UC0hnFJyrLmAubfFznujVdkARgrzu1HVymHsr71x23
	1VaCKczEZa0jrqenzWowCB12Ohb9Jb9+SSND1h9610lh7ye5z9FWGfMoVBOX14nrVi8mBLAR7BI
	i1yF2rfH6p4qmPdyCaDlCWFUkLNNX+lm5JITaxX3zLNidzjxtS8XZlr9tNdMQabzEcXKGBYRX5E
	+QqzjdNMU642oQnvSluocmssvPrtpVjKeeazs7IEXvuRKzgGSQ8/CCYJMtUMnXddiX6hItWHK96
	Euh/e/tfvzBlnHTaBpJHFCA7AsniMdrQJuQ9mpEtfKux/zwKb0W2u4ho7nBhsBNMA398QRNjqxA
	7ljhu89vTHLVPrBLOnYwa4N2zN/fA8KbSfI6eXnCgY+mzqYSSaJdw26LyovTUMTajW8CUaNM8TQ
	GUZlfNPA2ii59kRD/gRav1VVOc/RQhSc8=
X-Received: by 2002:a17:902:d486:b0:2c9:ceb9:865b with SMTP id d9443c01a7336-2cf34878da9mr176347675ad.21.1784592745086;
        Mon, 20 Jul 2026 17:12:25 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf74b60b29sm17937985ad.32.2026.07.20.17.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 17:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 20:12:24 -0400
Message-Id: <DK3TBWQUQA87.1W5VP00KA1C7O@etsalapatis.com>
Subject: Re: [PATCH v2] HID: bpf: Fix signedness bug in hid_bpf_hw_request
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Guangshuo Li" <lgs201920130244@gmail.com>, "Jiri Kosina"
 <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Johan Hovold" <johan@kernel.org>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Kees Cook" <kees@kernel.org>,
 <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260713132608.1265541-1-lgs201920130244@gmail.com>
In-Reply-To: <20260713132608.1265541-1-lgs201920130244@gmail.com>

On Mon Jul 13, 2026 at 9:26 AM EDT, Guangshuo Li wrote:
> hid_bpf_hw_request() clamps the return value of hid_hw_raw_request() to
> the size of the caller-supplied buffer before copying data back to the
> BPF buffer.
>
> However, ret is signed while size is unsigned. If hid_hw_raw_request()
> returns a negative error code, the comparison promotes ret to size_t.
> This makes the negative value look like a very large positive value, so
> the error is clamped to size. The following memcpy() then treats the
> failed request as a successful transfer and copies stale data back to
> the caller.
>
> Handle negative return values before comparing ret with size and jump to
> the common cleanup path on error. This preserves negative error codes
> while still preventing oversized successful returns from overflowing
> the caller-supplied buffer.
>
> Fixes: 2b658c1c442e ("HID: bpf: prevent buffer overflow in hid_hw_request=
")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
> v2:
>   - Handle negative return values before comparing the return length
>     with the unsigned buffer size, as suggested by Emil Tsalapatis.
>   - Use the common cleanup path for negative return values.
>
>  drivers/hid/bpf/hid_bpf_dispatch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index d0130658091b..520b8f56a514 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -445,12 +445,14 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *b=
uf, size_t buf__sz,
>  					      reqtype,
>  					      (u64)(long)ctx,
>  					      true); /* prevent infinite recursions */
> -
> +	if (ret < 0)
> +		goto done;
>  	if (ret > size)
>  		ret =3D size;
>  	if (ret > 0)
>  		memcpy(buf, dma_data, ret);
> =20
> +done:
>  	kfree(dma_data);
>  	return ret;
>  }

