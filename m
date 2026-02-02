Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEC541754
	for <linux-input@vger.kernel.org>; Mon,  2 Feb 2026 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047338; cv=none; b=YQkbDTCmu7pDOfa5W92gK4q+hg21Z+dwiScNHSkqhtLGafZ20Oj4FkWCFhO4S5xZMwTmI4qKmGUpa98rf2pzcp1hw2IuxnVRHbBgMTyszBPQ5rZfXzMAjVko+kg5MBWkG+i6q++nLIFe/rbPUL+8+TaKLxuT5zWv1XOOzGORT3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047338; c=relaxed/simple;
	bh=OAbXJdhCDBHhq7qKk57tzyoxjIGL5E1A/S3oMEGUmmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQ6uwU4S9eV7mQ3PK+5+/INDpTyacitgzcP50mopKorXXQnq5NnCO/TMih+r2NxGJvag5RkgfblENJePbdK+RP1a1beECI19M7t2TXCLaCXpy+tjzbUkmsz+kj/8EiY6fPsKJHiXK9ypHcMOEaYJpqGSP24f+xr2fjoOAqx1RK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R7r5PWag; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R7r5PWag"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48068127f00so39472415e9.3
        for <linux-input@vger.kernel.org>; Mon, 02 Feb 2026 07:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770047336; x=1770652136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TT0/khnC8UevM+sztHZVeOrmJNAebfgO8MLsm9xz5uM=;
        b=R7r5PWagO3pEE/Dm/M+jZ9C9Xnmzvi8pVMnqSOjWHhUkdPqKQnkGsu/KZgaeS70Wwa
         VPFTiQS/HMvdxpx5oyN+5IKLfrGrkLoYZtXe/mNGGl88eje4wUoUI5FB4cIVT0it5JTn
         PdNtfkeFnMPXTymmurC4i2mYQn9vEwns2DTToFiT0Yy3KAvixwVUWNrQJe+JD3Vvd5XA
         neVfx7pz2gUZNHXZ86Odf7CpDgseEVk1fmp96xrn8W7oDtudYP3T+Z8Dlj21a7L0cllm
         qRduEKg3PL+6MdyKakyPfQaAQFWdfRF2Z6uu/ePr+T0vMU+19hKo3fLn6H6yZEl80jwa
         tOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770047336; x=1770652136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TT0/khnC8UevM+sztHZVeOrmJNAebfgO8MLsm9xz5uM=;
        b=lV1DwfOXahbZ18nlnsDYDLirPSkF1uKlImNkKfmPb8MMAf4+f8FLTSrXvXGII5gxzD
         Hy3iWnFE5OfvOOj8+AAq16fsz1pA88fcwEkaWgWBIgK8rMuI32loo+JAgSJD3z8asXxx
         6yLlVwuTc2ZSfam33Ku8viDgTPOypnN+s99Gf6rdbnlRTpTzV0vjUzjdRjJ3LW1+uacd
         tc+Byuq5RVNfOJexoeprom91jziPKhb15IRIWW08fFphtGSu7K9ZBAs13lWJHgwPybDR
         LpeIN7QjM8WStL0T+NJ8ORjJi6QKv11WFHLxmDt/gT0HJ0Jww9cu4qyo3yAkrJFhSFpJ
         RyeA==
X-Forwarded-Encrypted: i=1; AJvYcCU4BTp9pDJ11tm81Ll4qnuRewhsCmWd+HXfeXjXmFzQA2m4NXFHSuf8l03/2OfS4ULkr3tncrbvgmSLOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFmJwemY0kDKcYolazqJ0OhPzTfKlUOBDqyQig2Kk13+/2UuOk
	+6mf2C3Gs5zEqLwDmHlVCN7VOQNzlKMU8SeniUVAP91pgJDI0RFQ85MzbkrOLvDL6B4=
X-Gm-Gg: AZuq6aIXnFSW8jSyzSQvkhrqNbUQyhLr7NPI1dN3/gSNkgvciMX8SxBSaTVww0NMj5j
	BIawg9uGxywQN0mFkDI/E0N3qMOgJEM7/4ZB+QsAc2XVFR8WCIKqF08MhxbmqYusVDFhLfdW4K1
	kd6018wofA6hMGyiHEG2Rb0Nul9SB0Kw3b5m1/0y+lBIp59LdXUH9hSHhJ8z9tcAY+o99sPRdxG
	bXKpw1PKi0Iemgbt5f4e00EeNsBLmpYlFhPBvbHvMDNKbdDl5SslNlQwuyXFcRp/5xDR9Lu9NlW
	acdKux/emq7SuE5cVgEFRmqY053A/Oj7otPVVsCVCaMdee0OkYPWSE1HIyzlnGpFinw+d0yCe6S
	tFxbSRVhkB/PbMQtAZH2pq9F8Qe0MjlRSzj3bFXwU3KrRbln8TT1VPhrKTfSd05vzfTAzgWjDmf
	BIEKRk25JjwRniVqYw0YL4mxypT3PoDGw+DhNtaRPYU/rGk1f+oFGKZcmWWGH5hLRYRA==
X-Received: by 2002:a05:6000:26c6:b0:430:fcda:452d with SMTP id ffacd0b85a97d-435f3a72b46mr16660252f8f.22.1770047335878;
        Mon, 02 Feb 2026 07:48:55 -0800 (PST)
Received: from ?IPV6:2001:a61:133f:5501:1fa6:d8e8:bd82:1a4c? ([2001:a61:133f:5501:1fa6:d8e8:bd82:1a4c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edfccsm43041412f8f.17.2026.02.02.07.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 07:48:55 -0800 (PST)
Message-ID: <1c317994-2932-4e2e-8e80-1c90606e63c9@suse.com>
Date: Mon, 2 Feb 2026 16:48:49 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: usbhid: Intermittent EPROTO errors trigger USB reset and
 interrupt user input
To: Alan Stern <stern@rowland.harvard.edu>,
 Liam Mitchell <mitchell.liam@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAOQ1CL6Q+4GNy=kgisLzs0UBXFT3b02PG8t-0rPuW-Wf6NhQ6g@mail.gmail.com>
 <1ebf9d19-7293-4902-857b-164fd4d21f25@rowland.harvard.edu>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <1ebf9d19-7293-4902-857b-164fd4d21f25@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01.02.26 21:40, Alan Stern wrote:
> On Sun, Feb 01, 2026 at 06:57:06PM +0100, Liam Mitchell wrote:
>> Hi,
>>
>> I'm trying to understand and fix intermittent keyboard/trackpad issues
>> on my 2013 MacBook Pro running Linux v6.18.4:
>> - missed/repeated/sticky keys while typing (this thread)

Alan,

this raises a question. What happens to KEY_UP events generated in
between the last EPROTO and the reset? It seems to me like we need
to assume that a reset implies that all keys have been released.

	Regards
		Oliver

