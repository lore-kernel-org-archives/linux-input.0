Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E83D3498
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667233; cv=none; b=k48TMwSB1uVRGaV1RBgS5myIWqSKkskY184zezmm/bMgjGAdgiK6w430pFuIG12PQNMsQZG13KZHAuyjIOF2iKiHhwPSiaoaPbwiWq2Nm6ABvjfDeV7oyWj0XkouKjlQxEY7ZS1Ov7C/woW5IWxgq3vMNWMWi4eyuRNhMV73pl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667233; c=relaxed/simple;
	bh=vejERJLbtHMItX9QwbdLlH7SUjKNtSbDUb8OrpTRBqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mX4gs55VMyLXjqfgzMn8kD8AIUynsGLS+SE0tPO0SBKwB/frVMb2gViX9LgGMjPJQQXSpI2jhzIFOduAulNXU86/hM0tH+m0El5wOOlVGZfj4z5y1vGX7d/xj1NvInh+/PiHTJcnrOrlYrdf0nqqM8M4w14iyh5jMFRZPxqaBuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDA0FAAR; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDA0FAAR"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c76e702e01aso37149a12.3
        for <linux-input@vger.kernel.org>; Wed, 08 Apr 2026 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775667231; x=1776272031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRas9nghnlejMyC8GOsPHc9l1zlwDenXkPzL6Ft8tXM=;
        b=PDA0FAARkO7RO+UzVsv+EdE5RqQ7krcMeGpIaWRlwgtuGE9wU8ts1LIxaU7PhKjWva
         YwYJWf1MN8wO0BErcqnXHF0/fnjmDyPZu6TxQrkqnxwoRvnp4Ka915sglgVwEk54C8Xu
         crtbOVJGhjTHD19BMP1knPwDZ601pAfcEsMA/MU9+p3J1REdQdkXLSMN6AwA0YglWy2Z
         ABFVPJu7SiX/vPAVDeH/G2bnjkrqZbq9lXJ/dm1Y9s96aCVy0jDxLf/0WROX1Sxmv++a
         Xy432MQZbI848LjgaBmdn6s7Dm2hAfGwDZNKUgTtHR8gnXv/OIFSpuJ59zmCcW3GxwdD
         fRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775667231; x=1776272031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRas9nghnlejMyC8GOsPHc9l1zlwDenXkPzL6Ft8tXM=;
        b=AYfw6hmK49sell2rZTkAOJ5qw9aMieAGvrtxsyOgZzW3BCJsCuQc6X/mOQMRXr4svw
         gYMoSEynD9z/cGaEGnCkpUxy0XP29pfC4kWzKaQA0YVupzMkLqn8OZqb73Ns+UeSaFBc
         oZ1S/ATymXQ2BBq4mhnOrh90aMBevdWyYmOcPMWlz9n6SG7Gcs74bqVD3V//1Z/KkmiJ
         SFyrYQNA6RZ8VPhc31J8kC1icftNM2VhCoaGGjeji1pY183UYcqljgjmwLpvTQbd2Lj2
         6FC3vGHOft9MshjFbpEtRoiqPB0Y5i4V2N5CcFgdqrXyku3jPCnhBKPz/BzlZwx7dwct
         WQEg==
X-Forwarded-Encrypted: i=1; AJvYcCXH/L+eyQqBK6ORsrRvd9x58PGJoxOVQRUeZvTycY/IcDX7w5ZZp21hSUz3DF+YNjDxfpIwHCAd422jCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxslPrkau6CL8U+pScyc4LSvxYzkbKrXofXTmfHvFstTZRJJ2uy
	X5JtzvFAjxbBYkhJmaTzmq+WTW8Y1CI1+VC4CcZb7xgRdmMjEns9UtfG
X-Gm-Gg: AeBDies2Y7lznBlctX8bMZrIoSftkU+q5jUOvN6K79XwrsoOgYwD7i69r23yAAWcpi7
	NNFuSuUsrv6HbnL/GME6aGqaW+kPoTgSbyzpslINEb16UpsztdEZ811EuFePGYXefyr2yK+Y7WU
	fJPSdNQ2QqmbemBYUY0jJnPzcN/H/LM9wG+8uhmQF7SYRarfq7K1NXQTXGc89fWkSMmOfqbMebx
	oqNW3y5575wZr/tkATHJbF0YWvPxAqaIW8ZSBRl6ZykxzythFqBcjpDSJJYuAZ85GBGP/jurceN
	X+J+41Bch0HeG9Lzluy/I/HmD0d6nibH7x4ZpJtBntbOVS48LSWN+sN5LjkBI2AAUbAlAxRyAg7
	91QrrraYEYxR+jVQUKeWJGCidPjaUW6LiqrJqv1h3mxe1CHCpdJBkWxwzHgLegxS3PY080Opzck
	qi0Bt63asejzROMZ6R4Lq/y9MsP1fNb3kLanV2fQUVdpcMlW7S5QLtDxuLKjHjd+AN
X-Received: by 2002:a05:7022:229:b0:12c:8b9:71f7 with SMTP id a92af1059eb24-12c28c07c1dmr113916c88.24.1775667231398;
        Wed, 08 Apr 2026 09:53:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f3cf:7538:b120:7924])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bede7f085sm20058558c88.12.2026.04.08.09.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 09:53:50 -0700 (PDT)
Date: Wed, 8 Apr 2026 09:53:47 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: pip-izony <eeodqql09@gmail.com>
Cc: Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>, 
	Sanghoon Choi <csh0052@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Input: ims-pcu - fix heap-buffer-overflow in
 ims_pcu_process_data()
Message-ID: <adaH0JBCaG1pzseE@google.com>
References: <20251220002447.392843-4-eeodqql09@gmail.com>
 <20251221211442.841549-2-eeodqql09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221211442.841549-2-eeodqql09@gmail.com>

Hi,

On Sun, Dec 21, 2025 at 04:14:42PM -0500, pip-izony wrote:
> From: Seungjin Bae <eeodqql09@gmail.com>
> 
> The `ims_pcu_process_data()` processes incoming URB data byte by byte.
> However, it fails to check if the `read_pos` index exceeds
> IMS_PCU_BUF_SIZE.
> 
> If a malicious USB device sends a packet larger than IMS_PCU_BUF_SIZE,
> `read_pos` will increment indefinitely. Moreover, since `read_pos` is
> located immediately after `read_buf`, the attacker can overwrite
> `read_pos` itself to arbitrarily control the index.
> 
> This manipulated `read_pos` is subsequently used in
> `ims_pcu_handle_response()` to copy data into `cmd_buf`, leading to a
> heap buffer overflow.
> 
> Specifically, an attacker can overwrite the `cmd_done.wait.head` located
> at offset 136 relative to `cmd_buf` in the `ims_pcu_handle_response()`.
> Consequently, when the driver calls `complete(&pcu->cmd_done)`, it
> triggers a control flow hijack by using the manipulated pointer.
> 
> Fix this by adding a bounds check for `read_pos` before writing to
> `read_buf`. If the packet is too long, discard it, log a warning,
> and reset the parser state.
> 
> Fixes: 628329d524743 ("Input: add IMS Passenger Control Unit driver")
> Co-developed-by: Sanghoon Choi <csh0052@gmail.com>
> Signed-off-by: Sanghoon Choi <csh0052@gmail.com>
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
> ---
>  v1 -> v2: Add warning and reset the state of the parser for bad packet
>  v2 -> v3: Add co-author information
> 
>  drivers/input/misc/ims-pcu.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 4581f1c53644..c98ef71c841e 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -450,6 +450,16 @@ static void ims_pcu_process_data(struct ims_pcu *pcu, struct urb *urb)
>  			continue;
>  
>  		if (pcu->have_dle) {
> +			if (pcu->read_pos >= IMS_PCU_BUF_SIZE) {
> +				dev_warn(pcu->dev,
> +					 "Packet too long (%d bytes), discarding\n",
> +					 pcu->read_pos);
> +				pcu->have_stx = false;
> +				pcu->have_dle = false;
> +				pcu->read_pos = 0;

Here and in the other place we also need to reset checksum, otherwise a
valid packet might get rejected.

I factored out the code resetting packet state and applied, thanks.

-- 
Dmitry
