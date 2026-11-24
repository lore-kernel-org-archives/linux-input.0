Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500893;
	b=bf0IxYz/MZTbLReVYCLPL6viQOfnts6B7fAKqtDdBXL4wthAn/WJEaV6r0xJpWEvsW/v
	 4AsMkOYf1uANmgFV7M2IOCLHggjQoniX23PFQQSK7KUX0MG74Fm/R4/kC0Onbu2hcbIqu
	 9imh3F3je7lkReUV/PX1IDoKXqakVAZ4xCl2T9qjVR4H/GLLBCNwg7LKOs0F1AhFUtDHx
	 RsoXm8DDfPNK/Pt++FiEwWokTkSJ4Q4B8eWPXlPvfhCwTI79sr0qFGw+vu8zhujmfah/j
	 stsdOrQQsOuvbOW7guszCuQEvfEaFBe1L2AdGLbzKOvlHwg0p34TWxS6WXX7nKKYvlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jZ43zXMGQsDQJ/kOcZ+O6TRwG6ELUr556TGyE0uK/yE=;
	b=solDwEV4fmUHecus4V0kXDPWr4o90csOKkt8yh1himGwoFxzCs7cIIVFWylRqaEFtCqK
	 nMfOXzyhzWtpYxtSQS9ETBMyZHEvEixSpoZQ8hi/yxnQYOYqO7lignDEwSeBV4WVTwNBE
	 COiptMfo38mjG17L94pd2RLFKjHDEF8KvuA0IoziGhO2PeJnzVcp9QKeqEoO8IwmPyflo
	 cl+//02KqxEUTU6ik08iTZQG/ACmaQISinNZXnwqMqP1Abuu7kq/yT9N45WZeigrKii2V
	 2wRcDuE0s8iHjwgLH1+hw0cwCgPHgp0XhzpTAhYgsFlYIXv2EY+DfPlT1NFxybQQEgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QjGj4Udx;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0134D606A31E
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 06:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0134D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QjGj4Udx
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38190551625so8471444eec.1
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 22:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795500892; x=1796105692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jZ43zXMGQsDQJ/kOcZ+O6TRwG6ELUr556TGyE0uK/yE=;
        b=QjGj4UdxVVJ6Ict/WGa6OCqL5YWVIijBF/PMwateYbBV8/JOSZ1quWCTiiRPwWJzHD
         9AdjJ591T/idte24u040VJ1d9cXhrqOgKDWn13jSUGsWImr/Hqv8B+M0u/Nermw+zrGt
         Q4t+CecrToohOA2bf+0uPhwqJPrpzGeZKh7h9nMesBlGiVmJ6+tRYfyEZ/yfhHDiXDCQ
         k+lXRdfGZSh1RhYaZOsAHoRraT+VQkEIvsOJQ7gyuWfnf4TVfdhL8y/+rIQ8AXL/bRb1
         0MAORgxGoPjtM73Y2lYgpahaaNAOkelXCcyItJrmeuobKbepxJE3LuPfVAt7kQNltsXW
         rung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500892; x=1796105692;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jZ43zXMGQsDQJ/kOcZ+O6TRwG6ELUr556TGyE0uK/yE=;
        b=Qx3j981y+5UQCwg8oZKseTEHKFulIdfTs5RuWu8AC+Vg4M0X+xgQw1z9uSD63xgXTs
         18zz7eEX1fWsMCdRnKd0ClJZlBYkO1MdBwXNRPOxponZkmH/boYWHTY+AZ9o2KL1ZcwI
         wNTtQ7EvqSW/l9k9Q1LzQi9qhRlotXD/Oz+yGfbOlZvKi63fVF5+tKMHt0iqLlvepLpk
         AjlEXmx/NFpi6czO0UguxCuvj9eToSEdAZvZGRhi+2CGgADCUuXLTN7cjvr9WCufVF7q
         sTzqkAgLX7gBJsxHKYw2d6B1NE94b8OVgdkneG2PAEOKOkA3YGLxlyfg/c3YdE+vMusv
         TjRQ==
X-Forwarded-Encrypted: i=1; AL+hErHsTnGIKxh29cyJRXfHUjKqCu1z+R9rcxlrPb+DNkQMf6BoZdZwFY1FFoOtgtFjYKb08Zfgrv/ipPYz3Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8GTBtX2ev+Qdo0ppJ02/Jk9+tkK8RO5Y/GYq7wzF6ypcZgbwhj
	n3Mc50gpDgiFSaTnanXddEuinpoK43CR3f5zkMCU1kB+fA5LtaDpTg+H
X-Gm-Gg: AZFdTZe/zFbv5FM1IxY1HUJqdE6TRwavFm263KIG8Qm7x7Ca3dZ1B9hu+Nrh2xaYFqs
	BtWWGpxWd6Q8M0mtycxGYxtVXEK+GNc5MLSMl5uMCv32AmdVU5sJGrgSZW2SlXbFSk7p7/K6CbB
	PX8McfCv2Bqhl0y+4yiKx3BwJmOOQVmB4lQByvHnIxVSt7cUSEMnIwnKXWE1hyF4n71ESIMr7ua
	1NY0hWNi/2+sUu+v63u6psojucThLtbuJ6hG9OPvOTPg0PTQcTbBexkEMP/jg7qv4WzuI6bRkk2
	XzWwEqkCftWsJwt49w+Uqy2Z4ku043vR9nN77+31wn8uxsXeBYSh1FPqEGLZluKmFQqAFggb9pp
	+k6y9yOOTsTpJBFSJHO1cFQuqa+0WIr+eLvnxvUwhl8EhGjQcHbtJ76My1H8RImW8XIoTGbkTbB
	oUSVEBQkgSrTT/orD9iWbZwnoyMThZynT/GGWx8WKhsk+YLAQC6xLNrfdFKTiaben2yoZtScVwM
	f//uOPZ9K+Xk0UDjr2m+Ulx18xuSeo2ptdhpn0O7/E9tGtbUA4ZXSnXxiHN8pLE8xX2XIcUYmfv
	01xd1s7wOraWZ2N8KJ41eQnNNAZ9FQmnVDhoERj/wijGuRPjVWqXn9Ir5Q/LHWhqWEUqDOQEwd2
	ZnwmtGAq1+i4BCS8ZbQ==
X-Received: by 2002:a05:693c:39cc:b0:386:48c1:6c5e with SMTP id 5a478bee46e88-38648c1719dmr12070166eec.37.1795500891853;
        Mon, 23 Nov 2026 22:14:51 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:ee3b:b892:771b:3bc7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm13328033eec.27.2026.11.23.22.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:14:51 -0800 (PST)
Date: Mon, 23 Nov 2026 22:14:48 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Siqi Chen <chensiqi@uniontech.com>
Cc: Anshul Dalal <anshulusr@gmail.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: adafruit-seesaw - check i2c_transfer() return
 value
Message-ID: <awUrVOJjlHUrDXUD@google.com>
References: <20261124054344.1067234-1-chensiqi@uniontech.com>
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
In-Reply-To: <20261124054344.1067234-1-chensiqi@uniontech.com>

On Tue, Nov 24, 2026 at 01:43:44PM +0800, Siqi Chen wrote:
> i2c_transfer() returns the number of messages transferred or a negative
> error code. The seesaw register read helper only checks for negative
> errors and therefore treats short transfers as successful.
> 
> If only the register-address message is transferred, callers consume
> data that was not read from the device. This can result in bogus button
> or axis events.
> 
> Require both messages to be transferred, preserve negative error codes,
> and return -EIO for a short transfer.
> 
> Fixes: 52c4e5985a73 ("Input: driver for Adafruit Seesaw Gamepad")
> Signed-off-by: Siqi Chen <chensiqi@uniontech.com>

Applied, thank you.

-- 
Dmitry
