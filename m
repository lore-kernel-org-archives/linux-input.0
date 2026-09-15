Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57182431E49
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 04:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789446696; cv=none; b=a2Gsd5oHRa5w5xX6lKzNMQ1+Y8gWJ5jaZmYPkhYDvz9LuPvkER3GZM8Uk1iH4PX6z7oXjiIvUhabXsjEZP90kWFRRpA8D59bf0GPhL15KcXc2L35vWS2Ag4MG3Zdc+CJ7hvhGAtxBJzuii+GFRUVhFf/TrF2LNKgBo2s7YtxXaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789446696; c=relaxed/simple;
	bh=aA5Y65sUh5ASzrECnC0J4mtzsACnCZsUUFd7ircv8ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mt/c7UlbuiBTwYopc2A55kREKVnc6J2hSNdjowOzr7wfl+ioDhDt70R4iEFnNTPp0P1IqJVoDufGJ+dKMoBnYGgN3ogycB3zX0hKA58e/Iu0A0tLYpXVTYMiLmP08r/P7sQtTykB8daLvpKG98NXehmaYbAzZFHsgBZKKGoqguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgRwYsBg; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgRwYsBg"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-395cf2535acso592142a91.1
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 21:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789446683; x=1790051483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZvpGpkLwYIiw/rxF7PoZSHAZ78tlo5vcBFE4Ln3eUgo=;
        b=RgRwYsBgMvRgioJRvqUcOlvUKu0abAko6/C3vwuCEHRQJMI+JlwTPt3DyGrFpdTFVo
         QqpGbWlkuOVRhJZ1HR+13saLHTQgvb8NV2kJ9/VRSTJLEItYakRD5xUv+a3Drl+TVGyf
         jHxnjuFab9FNWsWD6X6rmffcaNh+PRI0a6Qy0+Xl60S1TJj8JYX4LEH5E/3RNg8VTfzn
         rQx7F9BwdkULmosMQfrYaxssHjQc1EmJ7ZU3KbeOtyzSRMMrT7PHm9ihY8mtYFIfj/8O
         RnBtCdDFWdw7AHxNI18J+POqqnREX4tOlgyUfEVW2w1qLj9U/i77zmz1ninnAfe44tgB
         x6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789446683; x=1790051483;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZvpGpkLwYIiw/rxF7PoZSHAZ78tlo5vcBFE4Ln3eUgo=;
        b=r36pY7GrnTQt2VyY86sQBZHZZYq2JKqYb34hXAgQBiW2O4z6PwH7dTOCG/eOkXk/9d
         BygImQ206FwCWVMEQPSi40p/RTj7CLFuzITe6vpg1Lv5CqPRBQCo1xnCVNwvOWRVXKtP
         UzONiytUq3+8ACGRCsLtq1IENa8i/SKfK6g8+oupzfIw8xsuEb9bQdiceXT+C/3ip8RL
         0HPmQUj45f9StyRFVOO9fLq/jcgiQufBN9EBdB6mKI61TYz3hg0GYLK0e116g3xpMhNs
         /PYR4LAbok6bZfOISGltXEtGU2S/BPBDB7CUXxXkN8PaqyytSkzB1ZE3wQiMFlW+bK51
         dIdQ==
X-Forwarded-Encrypted: i=1; AKwUvBzkUlvEakjrZhue2c5qEoH2ExUfv53DuGNyKbKi8KUw1Xzs52V99iC9w65GYlPXeTxEZzIQk/vQy1bIZg==@vger.kernel.org
X-Gm-Message-State: AFuF++kaU0yR2okABq1sRE5gBgRKuwfGL5RJjpX/E8M4/Ni2YSCZO0H7
	lCSTiNZWPF9mykauJ2LhfaShdoLpO+ZLS/KFCfG3eHjXv/hB2S3wYcwT
X-Gm-Gg: AYBFou3Uu/9dx/coObxXP0qXeNXeY/jwp8mmo4yzt+bEkyPVZvz99STRYZo9V0RGqH6
	h+7Oq2Pz8ofkuhiZSxt45UX6WIS5sxPvnVWw7JBJ9HPWqq2hbDTS+3AZR3+BzOCH66l26lt2o/N
	EhVXh56GCVeT//LqCLc49jDYmUTYsTTBcv8dTi2BHDt72+YUD/XlHU4Nxq8wtRawyaHdqr4tcbG
	gID8yIQm3Za+1aIqJigGrD+GfrMpkJxCBPRc/O2FHD5Sm4jmYzAa26+bGa2cQjzFftcMQCikgtn
	1WOSVudVg9bFKBBXxwVRvhk/T17iFVdQ28A4T8onqIIuStREKwBEx43/0IvFIwaGN138A7WQSzP
	05fwsGYR7GoWYRkL/KQrJKlh+T6eqAaDH7IFRKhBhpaaAaDyIfJur9sS7HUs0giPdMEJg3Bg93c
	IRMJEwDaCz7qrD/XVP5Z1ypyY+ICD8wbEgVX+hrBQPK8QWw8OrZWv2typ5mO96RZSDoTcxbUOU3
	zwrGOwm9DSwCJwhlsSEirZ/Vc2vGMVbd7p06hIMpffqeIkr
X-Received: by 2002:a17:90b:4a11:b0:38f:a81:15b1 with SMTP id 98e67ed59e1d1-39dfe188cd9mr3239494a91.19.1789446683158;
        Mon, 14 Sep 2026 21:31:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bc03778c7sm20657595eec.9.2026.09.14.21.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 21:31:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <feb99d33-074e-444b-8fc3-ae53ec365965@roeck-us.net>
Date: Mon, 14 Sep 2026 21:31:20 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] HID: generic: Respect specialized drivers match
 callbacks
To: Vas Zayarskiy <contact@vasily.cc>, Aleksa Savic
 <savicaleksa83@gmail.com>, Jack Doan <me@jackdoan.com>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
References: <20260914233728.22725-1-contact@vasily.cc>
 <20260914233728.22725-2-contact@vasily.cc>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260914233728.22725-2-contact@vasily.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/26 16:37, Vas Zayarskiy wrote:
> A driver can reject an interface in its match callback even when its ID
> table matches. hid-generic currently yields based on the ID table alone,
> leaving such an interface without a driver.
> 
> Consult the callback after matching the ID table so hid-generic can keep
> interfaces declined by specialized drivers. This allows the AMPINEL
> hwmon driver to leave the separate keyboard interface to hid-generic.
> 
> The same callback check was proposed previously for Logitech devices:
> 
> Link: https://lkml.iu.edu/hypermail/linux/kernel/2212.0/06724.html

That was from 2022 and seems to have been abandoned, making me wonder
if it is still broken for Logitech devices or if another solution
was found.

Guenter

> 
> Assisted-by: LLM sparse
> Signed-off-by: Vas Zayarskiy <contact@vasily.cc>
> ---
>   drivers/hid/hid-generic.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
> index c2de91674..ebc38ae76 100644
> --- a/drivers/hid/hid-generic.c
> +++ b/drivers/hid/hid-generic.c
> @@ -31,7 +31,13 @@ static int __check_hid_generic(struct device_driver *drv, void *data)
>   	if (hdrv == &hid_generic)
>   		return 0;
>   
> -	return hid_match_device(hdev, hdrv) != NULL;
> +	if (!hid_match_device(hdev, hdrv))
> +		return 0;
> +
> +	if (hdrv->match)
> +		return hdrv->match(hdev, false);
> +
> +	return 1;
>   }
>   
>   static bool hid_generic_match(struct hid_device *hdev,

