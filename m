Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFF143F0A9
	for <linux-input@vger.kernel.org>; Thu, 16 Jul 2026 01:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784165958; cv=none; b=slpLVOIFlMEDqSg0nqCdFSHEh3E+KNdES3Y7ql+oJ3vE3v36NvwOPR2SjApGpQ03Vly3ujHZsTcyiUUZaSLST/56mQW+8Hu2uwGUY3UYmNyMHo3rcMPNrwNS5se/NaK5IOMEIhGVMxba7s0tkh6sNPL6RUOwGvotUN/9vAH//lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784165958; c=relaxed/simple;
	bh=fdAnqaOc+rUMOJpHZziZl5Lk43TORcfAUUEYawPaZE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNvshFpimdj/VE4D5sJVd9Ko02Yc7/DVvitfT2nX0yl2N9n82YX8Zl4MaNVnnG5khYYKUqclGu7hYjdxWrjbgxHbZgJDBvGzRDA/tSyYfv9zvxZxAIXBv+Z84oLUxaUXCOX/gBW1pfPXJ2i9VzF9NK3zqmUivqfXXhocTh66Y5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwQ+gmRx; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwQ+gmRx"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso71350a12.0
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 18:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784165956; x=1784770756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2LFq8d65Je28fIePEd6QvW3ZI6oIA9cT5Zo7N2b0PO4=;
        b=EwQ+gmRxqsotpgv7fq7hWYvz02bNGrpDsutNYvDaSTXCU+MPeGpdmzMts0pYvyDyht
         oXOB0nrvs4y33WmlBJMs3fhePtPh7cpN978D+gfVLma04YLRanS0v8HnPlt2+jQmlMtl
         csfrIpZETWCCn36GC0+mwYkq5GTZKDb2mTIsdak8ehBJsCQNBiPmzBMjZNMlgZQRDrdc
         KkiOyAipwhk7kYHlK6rlHlwGfy42L5r0Q8KF0R7l+PS+c3sXKLqkDE5eT7w6Yb540grV
         wehQLp1XZQ5BqOoN+7EUUE0htAzDqTLKmOKKD9Hl2OLUJnihdnVhqy2jiWHDIL8ui1lt
         vHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784165956; x=1784770756;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2LFq8d65Je28fIePEd6QvW3ZI6oIA9cT5Zo7N2b0PO4=;
        b=ByGUxEBlYcn6cJOSLxiikZRv6VE5nG8Ya5PPp/Mjf176Vd7w5JMNVSk3ePsKMvAWns
         Rnp/gijM8D99zztoALoRfWOoLWllZsdZ57HOHcORdwKIO3OYAzsLURQIrG0YvxMiiTnK
         McyathdzanBIpxSbAucKS5dwcGVSk01dnj8KlJ21gTRg34zPRPPUvy6nyIwW0Q3l2+9G
         kRD37C4E5eLSJ9LdMG9pmPWeTyXx3U+dJKFirmFLzBe5OQ3k9/C63WV5G3QwTfWbJcVt
         5oLTMOlXDgPZgCTiVe9+MfnE6qRKuULUEf9o1kJOkxId41aXpfZKY8ttXbdXjntf3Wan
         BLPA==
X-Gm-Message-State: AOJu0YyslURcBrlInsYKFKQalsUprJFWTDL+Vcc7WOSKiawK3mflBbq1
	OUcSFbkjpDxeoDMBLul5KLsAW7A7nElUuXH2xAsJajHn6/4iGHQlyJro
X-Gm-Gg: AfdE7cktlOVPjgYonQT8SXoQNbeMjaUhzXgiLZro2WfVYdw3FQuLLklmpcrB6p4ZJLR
	BfzhcEQK3xtroNRQETXWXSE+61VMO5W3RYkIdQGcBU8xyyiu8k1H6UzTKxNPV6q2H/kPcP6dsnI
	GI3BHfNYj00hTFry8x9ZcjK4R+C1ckWUPAIPSfHvS1oOXC45RWM687bGCWB1MgWqxUEGYU6ZVxz
	+6pkywiWa5Fz5VkahKeWSvwFo0dNc0T0d2clwPxdBgxEo+QgLtBtrTNksAbv+43P91gA4DBobFb
	Buu9vdknmEbNHdJbM/ZCy/FHlE0sBQhxIpmBt2NuH4R2jOek+pAmwEtgIJOyaWxwz7G9LN2e3PS
	qe7Kg910x37NGf8J4HITjTKuSTANYMFd20ViT1CYPtBqAVpN9ORC5HPxvhB7J7dCMzOT1uNOd8Q
	rJEyuqI4AFjBddchRdXxasAHTTqiuBgfm69LmEWo5Kow==
X-Received: by 2002:a05:6a20:da08:b0:3a2:ed4a:5d7e with SMTP id adf61e73a8af0-3c38db3187cmr684245637.22.1784165956513;
        Wed, 15 Jul 2026 18:39:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:575a:5ca:2b13:aa89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6e9edfsm5457397eec.28.2026.07.15.18.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 18:39:11 -0700 (PDT)
Date: Wed, 15 Jul 2026 18:39:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ian Bridges <icb@fastmail.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Input: wacom_w8001 - replace strlcat() with a strscpy()
 helper
Message-ID: <alg2MmumKIejFMHq@google.com>
References: <albg4Rv7QxvLJD05@dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <albg4Rv7QxvLJD05@dev>

On Tue, Jul 14, 2026 at 08:22:41PM -0500, Ian Bridges wrote:
> In preparation for removing the strlcat() API[1], replace its five
> uses with a small append helper built on strnlen() and strscpy().
> 
> The five calls append device name fragments to a basename buffer
> that grows in place across the setup functions. The helper takes
> the same arguments as strlcat() and writes the same bytes, including
> when a fragment is truncated.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Ian Bridges <icb@fastmail.org>

Applied, thank you.

-- 
Dmitry
