Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACA43C73FC
	for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870994; cv=none; b=FI51eFnkMxOSVbuX1HWusrwwfxnM9OChJkKlnnLlKbcMxcBJaANxzNuN+OYTFTwuDOxRrrXyo93CyGEtq/Nbb9q64++vKepHAZzrA0D1ZafUwTJVI+CZJGFouHqzGFUOpoxpbT51fg/AmZBVmFtBwWI6eeFLgMM9fLUAxMFF+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870994; c=relaxed/simple;
	bh=jgwz6ODmjkcOQrIebh/RWM8fA2t14YiD4jTcc10ITRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WOBbR05kBcKir4RLCmdHDPN87jHaDSG+0cXchnNdtcrWthf29kbEsVfVliS6gM8IGveM2wCP2VgEHnFuHK5EU3vh4ioEAsxKWhLxf8AD70cmirrJKZ6jHQV1G4W8HbtY2wtwGppcOa24yNQTzlIPeWvH7aI9xZzK4Ii2da0WRIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Zpg5ZZpj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Zpg5ZZpj"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so680657f8f.1
        for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 04:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774870991; x=1775475791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WhAEc966+DuA2BfT20ZzgZFHkE3/wK16Ytbs6g/G3Y=;
        b=Zpg5ZZpjfyN+ZhyWkzfM75ya8tR4K1FYrEGdg8blvMeNyoDwPf3f2xri+0JX4TLCo1
         vXBsiTRIzCL2ofasXyT8MEGkv+cFD7E45RRQ5D9PcySr3OOOwyv+j0poiaB5OVRk8ZbC
         XDoS3Xyd4bsJ7MYZhUZcDfAXE6rvKITUGflWpoiQ559sIzQaR9fqW7+uMHcGcPY2vDhK
         f7psG2kmpiWcS4b4sttYVOIA4kYT8TQ+bwsFvOF7pP94lz7PVhD9MmUFexuFA71YGrH2
         14FCnF5hyLLZPdpNUmV/o/IQThq5aEt7ILZ2gO+T3msvWszdLhDYdJwtqKVK8HlfD2EB
         lyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774870991; x=1775475791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WhAEc966+DuA2BfT20ZzgZFHkE3/wK16Ytbs6g/G3Y=;
        b=pWatWX8m9vorcJct1MMYEbXWzJ0MdG9LKiAVdq4+JZL5eVxea4//bfIN/PxNL1G/Zy
         Ua7YUfFyTBzKpgqItFPzUtQCk0TOFXiwDGe5IMSsm0w5iqAas7iIYR7p0W+r4w1WghYh
         O9A/CW3jJHjyAX7lLJHMall+LiWEOOTB911RPem+HHvIMHcrD+47vSvHr2y6DP1Bz8M7
         J5xgINbLVjHQPAI0UHWwt6L3bwB15WZ3fruORfgWNECn9QF+J1FBN5xXbXYXmhaf89Wu
         Ad+IOmaapQRnU72VdAUUj/zglH0cLVu6McRbDZkqknPNB9vc7+x5ELazkZETgQCTnjx/
         dsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOTxtKF5DJaybhzJMPgGde2ut2joy+gj/xTl6cT2oAcFCwpzSMzQkcPQ/mwxPO56cvfVL1ScWqu1IY9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmpbRg/dGFDCVjX9gQfUSc1hK598srl4qzfDlW9LV9YJBk5R6j
	6cO9mGAJJX5k4rnLwHk64QmeQWzy6/uZeq+CLjhySw9gNELEYWqhPliYIeJ7NKEsWe38LbdiPKo
	Q1RlV
X-Gm-Gg: ATEYQzyFOuTf6hO3OWErk+QJUWWruJyF9zetaMznCNEXOiRZTtr37pnQIqNMcn/498f
	EZ2X6jCL6wKhI1EvOY0cGu9L4Y7kWowOAguGa+2mUrMJbz/RYYC5uwyOfSJ5lMYbAOK6j8u6bM7
	4jeQX7as2Ys0xUJA8HUmbFbrSfwvof2xLuW6Mpj/agpDHwryO4JvbyPkU6uDOHm62bJ/Thz1U3v
	lQGRYIZ0EA6ShSKCgLfvvonVgbiFOqc7hX+bnxZ7IF/sdDbX+W1REX/O2Hs8WKaH1Se8gntExaP
	fiR3y7MBXVgLtEi1RK4OOVgGsaa/ypMouDw4QwB7rMvALKFkTWKH4GN7hkwDxkocycyebSgZ7MX
	kaaez+jJZlfmhWfK+4THhNPdlMFHIXdiPuEwKX8JWk8BurnBULLRet0TuIEbLL6yfI4Y0ntJg+5
	SQgVTLcPEnPQvxVgmxVoYtdD//MMY5hGQBgQQ0qtlM6NLguATIytwpPJk4OTLPmt3nPpkYJfFDs
	7Sz
X-Received: by 2002:a05:6000:184d:b0:437:711c:8754 with SMTP id ffacd0b85a97d-43b9e9da43fmr20502255f8f.7.1774870991475;
        Mon, 30 Mar 2026 04:43:11 -0700 (PDT)
Received: from ?IPV6:2001:a61:1373:4b01:cc61:7bc9:bea5:a415? ([2001:a61:1373:4b01:cc61:7bc9:bea5:a415])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e2628sm20131568f8f.6.2026.03.30.04.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 04:43:11 -0700 (PDT)
Message-ID: <036cb81b-ae6e-4dcd-8f97-593e754279d1@suse.com>
Date: Mon, 30 Mar 2026 13:43:05 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hid: usbhid: fix deadlock in hid_post_reset()
To: Jiri Kosina <jikos@kernel.org>
Cc: bentiss@kernel.org, linux-input@vger.kernel.org, linux-usb@vger.kernel.org
References: <20260324142507.74873-1-oneukum@suse.com>
 <8q66o2o4-7844-6p76-9964-7pr205p190pr@xreary.bet>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <8q66o2o4-7844-6p76-9964-7pr205p190pr@xreary.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.03.26 11:34, Jiri Kosina wrote:
  
> Did you find this just by code inspection, or was this reported with a
> real device?

Pure inspection. We are looking at USB error handling
in general right now.

	Regards
		Oliver

