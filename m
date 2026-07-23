Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B0403AE8
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843916; cv=none; b=tLiC9xkMv7DOytvO3XP2jOSTHiTYUxyWto9a22Qu8YAWJ4KWssCBGxHx4RGF2rUAfN3r5/wD1KDakt4AJDiOeN4YMj1CXczr3SoGKfVSA7ZJW0p+awFoUidNKQII8U7tNaLljyIV4lSJMbIpIenoDp8tqGVOeJ7h7Jp4D2eSLr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843916; c=relaxed/simple;
	bh=6f79sbA5nfTpY98bqD9k4KCZXyJjapdhSkgU3+eBOmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohbOd/WhIl+hayogVYbQN/deqfW1WWbmGdswBhMJ0HXr1pjd3FvQaQgob4LyRoXT3pR62b6+ju/95TzUXOz1qUIySjraBTLYY2Zljvbr2yW+Mt4SzDn32sXgfuOq7mrxDdNtYD/7LJAkOXQNLk8snauwxrzbW6Ov6x1UNxUDNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpEftS63; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpEftS63"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8485b358552so1200954b3a.2
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 14:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784843912; x=1785448712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9+8eCFfIFOiymdCrrKAG5J0qjb2XOXmK+uwpPgsZyCM=;
        b=MpEftS63fwY7dVgpixr5ULLFvC/VFZYr8JbuOTyIr2/7ER2qONK1QoGGXGD3EnOfHl
         8Vds4llHKHXLmVNqGcAYrjlsNKCGGmM0/PJfwn1VG1Yq9HPiNMKI17kh+gJiBo2l5o6N
         p3A1kwDtKudj8U3gx8Wz1+o4oi3MXeptK1TwqMeUOM+PF9l5lyGc/EW1SXZWSADbsXII
         CRuSkHAuhLUL2OXNj1pgjBRwOdH9T4dr3HyP+eVMM2LZlv0hnMPNxZWa6L3D3Gl/izPp
         AJ2Chq3uxCs6QBqp+HZYfcQeUGe0TMfG9xkqjMf45KcxTXgZ2mjNhHcSwbWiqVgl4jIo
         SA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843912; x=1785448712;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9+8eCFfIFOiymdCrrKAG5J0qjb2XOXmK+uwpPgsZyCM=;
        b=cJXVbbIRqQOWNWZBCzHZPoI5obOLbHwyeiffoQLljgR+houIzxlxxlS6BvPuM6AbPa
         EUXWPqYDuMGoq/WfIedOUe3+YY8uMlV4ccIu7frRJ0ZwBTz0Nbq62lCu8PDCBLp9P+wq
         0YahuZE3dJkwLbWfKYoImFPN5Qihak+U8HuY6omQkDKjeVtf/Y7OYaJWQOEaYLpytkPx
         wzdmkrQddJ0Fsr8nz4FcXwLo9MQTMkhvl9GrPGcwfzSx8Ue8VSb8oVAisT7Jbh4+XREN
         eJA2oMB+jO3IkyOGccSeDJxwqJiX46cZnUL4hJi4s2lLyPUmSn5ZekIf62V2dDRJ3NvN
         9Wgg==
X-Forwarded-Encrypted: i=1; AHgh+Rrprv2iXYuxO20qC2Lp5bnWtYpmqcpaqpNZBtm+VJcQVNlZrGQKfz4B5SgFDysl17PaxqzwJ1lhMwEgFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZ15KLi7fTxhfoARRtEW9YDSwda+/MbH+RL/B1oF6Sq6CunZY
	9BOQ36906BYab4lTQ1Xv9l9Nz7bwBBTQ1VUQO4tRWQK+xzJhc0LLoFPM
X-Gm-Gg: AR+sD106pqPE7y9CyQ6HbNeoMmEDes0lBMrCgTd1jxGfJvz3bDMR8AeWvepO9qUaxK+
	kp7SO+sktoq0G/bORHZ7CLxPNr8KUPjQTx/lMjSyrHxWQfkdFZxlB7jpA0iaKtNO8or0hf4fp6G
	4oSkfhDPb4gs83T3DMTlTju/YbrFoR/vhj2cTTD02w673u8QnYiMN8Q34PAmm2WnCJ9AfZ4Fb5c
	04y/91IFKmY75uNEnHz5vX6uAWOp+bFj0PCvhAYX4MQvi+5eutPn74kExChDDK2Uo06FDPejh+2
	tJvptOVkLofhXYTMrG+8xF3XF8vm+IULgnPolQRBXyTytpu5wLg0O4917edO+s28BCNow2PyYmY
	AAh/FR2dKvJdfucErISrUPcPCpBrzLTTFcG6cNEiSxrAOQz9sJpVErvOWIXWO8PpRCy7sEPXaFR
	PBRA0DrYkQvFy0gD439K9LGJ2+hEFhP+wsIAcf4ebSnwqQDfWb4wJo
X-Received: by 2002:a05:6a20:e291:b0:3bf:6acf:2940 with SMTP id adf61e73a8af0-3c44af77533mr5350478637.11.1784843911763;
        Thu, 23 Jul 2026 14:58:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f5d:dfe5:9bb9:71ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1cf8fasm24297371eec.31.2026.07.23.14.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:58:30 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:58:25 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Eliav Farber <farbere@amazon.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, 
	guohanjun@huawei.com, mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org, orsonzhai@gmail.com, 
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	W_Armin@gmx.de, ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, 
	jason@os.amperecomputing.com, pedro.pbg@usp.br, paulmck@kernel.org, frederic@kernel.org, 
	kees@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 07/12] Input: adp5585: use
 devm_blocking_notifier_chain_register()
Message-ID: <amKOW9ILpWd7w15Q@google.com>
References: <20260723175513.39849-1-farbere@amazon.com>
 <20260723175513.39849-3-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723175513.39849-3-farbere@amazon.com>

On Thu, Jul 23, 2026 at 05:55:08PM +0000, Eliav Farber wrote:
> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> adp5585_keys_unreg_notifier() callback.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Feel free to merge with the rest of the series.

Thanks.

-- 
Dmitry
