Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5FF2066DE
	for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 01:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402596; cv=none; b=pWqsIoHMl9geXS1WhQjDyHK3k4O1RuR1AjkkfVNgrmcpkY7SpgeTMNLQl4uXVaxEGREqKRE4iNWsIgu8F9ImG6QKsBzOfX+/y84096zqm/9JRFhSkrcROP5cjfzNNREbw9ZFQhGuCyN2XYytgeQV12v3wpKqlKDvIy9VKiuYYYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402596; c=relaxed/simple;
	bh=RYbTtBTIQC/2zekrz1ZNuc6XbPGA++D398QAiC+0UKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdVTlUG+Ggr+UoyYJ983g1FOB4/xm2ei2Nk4XEfFuhP1TNrfMhZF2do0UvC1dEfWoRwBWOMbN6SaBgScTmH/0SpNkXbUmKvSDCImakE/hjx9XkSO26ESkjjxuLIdbKPEgBuonoOSJXi9Xjd78j3p4t6fhmO1T3bCbR3DS6h2m0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWviNaKJ; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWviNaKJ"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1271257ae53so2112023c88.1
        for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 18:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774402595; x=1775007395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3AYzet/rbgbElXL1qLXjB5IItamG2qrNQe2ZTLEwoI=;
        b=XWviNaKJT8y8v7VLaJW7IeEyK3lkCaKi/wrFB2ygAK4gnwdeEIID7htOUJITU3nA6R
         cl2PfVY4JCOxIgu9+CKHiaZg8END9CUBzSy0TcLe2kKFInUZxObSggimkCzhqZypHMJh
         dMTojfdiUrcZxAP7Fm1f/5LVJEPkqZ29YN2SrSZvXswWpzjN0dLzbX8U+tp/On2Iclkd
         37MYpRLeXlDEXy5V1+XAiDzL34lurGOu2DSqeczpH/XFn3iOiK+F9j5eVkroM69lbore
         HB+RhVXWXbjNab7yMwITZggta/FMyfFQny3dP0ftl+InGwbvPT+RzOMOvRdeRRYxvtwZ
         lyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774402595; x=1775007395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3AYzet/rbgbElXL1qLXjB5IItamG2qrNQe2ZTLEwoI=;
        b=i7XlaSgPsYwCehKRR3ephHyXMbnHw5NRYXXr+K1/bMhW65z7e0jen5VtD8GMpUK1ad
         2tcdQc3e2JftlmTINbuxyGEyVB+t0Qf3sdFT5VnujR1fMMC8wLAaoo2PysJQHN9uibSa
         FhTl3mUXPswHbuUFH/5dZymt25j52yOXjqHM3PpIKAtrDBWssGufRro6M+wLna1zecHo
         fmv6mJ+BVhCMdIvzHbmTIoCLN2mDnKYuPp1ZoQZMkJNIyXCjwxtlTfWUmnXdvXBMsRY2
         DDbnjnbHsD94LigU79V6Zpr74lSbOzk/q4IPHi+5LIuH6DjGpDJeUfmZi7lKUfTvqK/T
         7CBA==
X-Forwarded-Encrypted: i=1; AJvYcCWjbXyI0xAN9rex3fiC8sp95vokE9c34dSXauKX6Qu1LUbUaPzY5y+Yih0TGTYlumsZf7pThHIH28+PBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2JRRQ29eQHbXVd5O/M7wviSOZ4/CCgP6//pnSWVmnxKeV/O7A
	dfEgHd8FPmuWDDpl/7c52suGYLsk7iWyBPNysOjQQN6h1phvmLaZoDVe
X-Gm-Gg: ATEYQzwsKy7b9oOiC8IXfjxjQw4xXyLoaE4hPWdvIRlXM8UfRfLRHPZ7c+WnDdNl+bf
	QhWL+eclTqYNernH50s074XhqfMC3CuV427zwB+7ePqGu7+950Y8fkYqsc8iZB4x34EMoFBEgGS
	dl+2FBt20bABqFwVVU0U2guY3IwVC3a/DwzdAqHXf3R0p/T+WXZquvxXqZlFSH+aysGQ+WCN8kA
	Gj26FEeGx6Gt0dSzjuzoSylUoDG76aLmqUhXKPwyehmzKHALYy6zzXKDLOCN5I+9q4sjMbw4juA
	f9CA6CYcVc5bmzJylJrzjbRr/cPBKoIGuHPacxpn7+defRQqpmRBOhDDiIXAquVOziU4SqSnJti
	4rrtT8fQZVVewTyCyAlSHAMQ9lvX9KbD5yM0DLr/moFP4D0xkxbo8uJhowIBkUVRRo6jcb4iCuB
	17faPBJLca2A0lBh8QnXpdpAgw+mFhckrPUeOe/0BsCHJJuO/y+jda5ljN7QbPyszC
X-Received: by 2002:a05:7022:69a7:b0:127:366f:8bb7 with SMTP id a92af1059eb24-12a96eceb78mr711116c88.25.1774402594510;
        Tue, 24 Mar 2026 18:36:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a686:fd7f:70d3:9156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b90dsm21300866eec.10.2026.03.24.18.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 18:36:33 -0700 (PDT)
Date: Tue, 24 Mar 2026 18:36:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: andriy.shevchenko@linux.intel.com, kees@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: penmount: bound packet buffer indices in IRQ
 path
Message-ID: <acM7X47UDx_yYNJ1@google.com>
References: <20260323121715.74954-1-pengpeng@iscas.ac.cn>
 <20260324131442.27632-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324131442.27632-1-pengpeng@iscas.ac.cn>

Hi Pengpeng,

On Tue, Mar 24, 2026 at 09:14:42PM +0800, Pengpeng Hou wrote:
> pm_interrupt() stores each incoming byte into pm->data[] before the
> packet parser gets a chance to reset pm->idx. If the incoming serial
> stream never matches one of the expected packet headers, pm->idx can
> advance past the fixed receive buffer and the next IRQ will write beyond
> PM_MAX_LENGTH.

How will it advance? The handlers do:

	if (byte_0_check() && pm->packetsize == ++pm->idx)
		...

If we never match any of the protocols then pm->idx will never advance
past 0 (and we will keep overwriting the first byte of the packet
array).

Does your analyzer miss the "short-circuiting" nature of && operator?

Thanks.

-- 
Dmitry
