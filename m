Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671749;
	b=eAfDs1Ol5NrzTGZ7CnRY4FPnJCDoq9oJn4T8PKNFCLIfs0EOMgfK5Hqp+l8T2Z+Ia53L
	 9pKOY8+m5CxBYJ9ve44rZHX4OqIF5NA0niYL5kcpC9eQWmp1LLByqB2oEmTHBtnCQoNla
	 4xCe1qLLta7LNifJynyDDKp1QAIvqQIXsrHw4oaiOhXSkueaEGRRNXYY3YLWPtOSYMS3v
	 PboYo8DZN6omddSBWU5VyuIsODfQNvU7Zj/M80uXVgZ4cbSJHdPvKP9e+CzA1CeYnwwYM
	 uC0Xc7iAaWonD2dJKy12GNwUXIQTbBENCsIKItq3LH0P4AzVew+1d1ktBQ6bCDQicTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=++8bio5HQvXBSXEt4G6PkyVHRIkX4ffk6U1NuOhu1sE=;
	b=yJXNPj8VfUKv1mAuTmev2WrF2dV+8xXHuprqxC5ojlGg0Cdxg6sSYgJpMwgAbho5+kjC
	 hVnkEeJrxDMZKFM3HRMuWMHKpHEDKQ6rHzXLNPDbcf4ve+XXpKefXQdF8a3+yLaywcYMu
	 uEWnyLLxrSuGzgrV5AUjM4c4Qq9bbQ1Deqvpyh2paYjIbJmw/TFbnurPDnpZzF2j1RXgV
	 2MYc40L33+S7iU54+0JT4Mkd9dAs40b2/rYzfjxkxi+BwFmlB56EB169BttP/0Mi7LMky
	 BYWdj32OHyIuOmUmpGigfxvcaXDPNriNN573aCv3IXpHTgzWDIu/FzD54m57txfGFCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m39Eyg12;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733E7606A31C
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 05:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 733E7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m39Eyg12
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b546061d58so15213276c88.1
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 21:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795671748; x=1796276548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=++8bio5HQvXBSXEt4G6PkyVHRIkX4ffk6U1NuOhu1sE=;
        b=m39Eyg123dSahbukQROoyqmw9Qf4U5rSatEUOz6jaPy5kUfcXOOY0VR40BVcOt9hIH
         NkDqCcIV/NoSbbU/XKApFhE39ud/l/FbIPrs6+Edc3DBFGtnM+28t2ENqB0wXteTqhj3
         LIDUbJ2df7pjBxbyZNvWoMM3Z7SCGKql5HiX6ZrCuxO2QMzLVEk9EcnfugU8Gv4mGZW7
         blw9kfljA05BLFvyHEcs30YNOL8sUkR/XcVEfQHzc/hmblomnfpIHnYDvFZNpPwBPelu
         LI03jTZlDATE+7kZAxPKBvXOBQmbYQP77OshQjOGflpuLLQxaWvjquWF3/c5Yeu/BQD2
         d1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795671748; x=1796276548;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=++8bio5HQvXBSXEt4G6PkyVHRIkX4ffk6U1NuOhu1sE=;
        b=n/bF3O3hAKz07jBlJyxzaclxU7QeLwldQ+LNTqiDFswELKhNbZpiHYlDNwIbcG8k51
         topFlHogDJEMRrmJlC3E2tK4t7nsNGawY+53/BgYWCFMSQZLd0cnqKNeo6JUy2vO9r0R
         QUzJAoUoMA5TJPkDkYkTtJYSF91vqHbyIN4+WyT4tcYBaqXZsHm7bcjLi84q79YiOvF9
         GoTa3VX6B4E1VikqKFmc3k1IMOkc9TwVwvnzrTZyWfAi/K0qPx2DW4dYznXlaMzPLQJF
         w4OEuh3WDsPwYZrxWZ8c96a/1NLG5lgtx45RNw7DOeZ3VrmNs2UxOONqyxxa4VX4vUta
         w0WQ==
X-Gm-Message-State: APuU4Z88HvDDgwDD6w3sqxwMr6tztrcjVTBJE2gzEXE3d4dPcNuNW+yt
	8eAyfESNKKZf3PXPIO6t3rL/pbT5z2TPQ+AESVtaih1WNgKDPGAqQdo6
X-Gm-Gg: AZFdTZfvgkfkUEN+uYbLqBVqZX8nwtJ2sZapch7I6MTet9X0BAVflemY3Hy+sEctjId
	J4e6Ko21Sh6F2vf+ogFWaEpQjokJdFziMBr6tyNfSTFJGM7QiyXDIWmDyyrTaJd6PXdlT9w3nJ6
	oxT7OrKJk+x+Dfh5sQRWTHel41zrPw9QYxeB/tQjk7Cb2YF129boBr0z4YbfUejrSIKdwGdB6MP
	bS8o9jpfYo4baL6cbXEKNmJbKSoMkH307XqAjEaOt6tO+VlMw6kM8xHH1jChYJTqpTQq40SOeth
	yy13Qf44qA+7T2fjdFcZpVUVZpglP7mPwl1E/K9OvLm6gm9l8HYgU9liW7Xj2El3B0XKtUritQS
	B6+PmlJjjjdf+sSccmL91vFhBdn5qlZZj0uhWzzPE0B55EoHI+moK+AM2KU2gA1YLiymuGpXIr6
	M6Dxj4w/UywpnZ076D/JugSrg4LqKWbibRqoJk7l5EewukYwzx4ZJHLnXWWH+C+SkBYzTBq02qe
	ZJde4qj/mjW6cdhl+t7t9sQax0CAYhhAHcr5YamJjhj6jyrIrBxf6LVrxmh66rZUFNOM1eTVALR
	2tugKReM/rGtBHttazXq/u9N++lxVgSqfPsdHPvrH+j1zK+4CfP3PfW7BiUalEVUqkDrDz4=
X-Received: by 2002:a05:693c:60d4:b0:360:5f7e:2eb9 with SMTP id 5a478bee46e88-3857111f65amr22589262eec.32.1795671748496;
        Wed, 25 Nov 2026 21:42:28 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f528:8797:fe51:9f7e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm72206669eec.5.2026.11.25.21.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:42:27 -0800 (PST)
Date: Wed, 25 Nov 2026 21:42:25 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aibing Chen <chenaibing@cmss.chinamobile.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: adi - use scnprintf() for the device name
Message-ID: <awfGt6HfOVgT1H8R@google.com>
References: <20261126053234.455-1-chenaibing@cmss.chinamobile.com>
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
In-Reply-To: <20261126053234.455-1-chenaibing@cmss.chinamobile.com>

On Thu, Nov 26, 2026 at 01:32:34PM +0800, Aibing Chen wrote:
> adi_init_input() composes the device name as "Logitech %s [%s]" from the
> model string in buf[] and the controller name in adi->cname, into a 64
> byte array.  buf can hold up to 63 characters and cname up to 15, so the
> composed name can reach 90 bytes and does not fit.  The name is
> informational and truncating it is acceptable, but the call site does not
> say so.
> 
> Building with W=1, where -Wformat-truncation is enabled, the file does not
> build today; COMPILE_TEST configurations additionally turn the warning
> into an error through CONFIG_WERROR:
> 
>   drivers/input/joystick/adi.c:395:60: error: '%s' directive output may be
>     truncated writing up to 63 bytes into a region of size 55
>     [-Werror=format-truncation=]
> 
> Use scnprintf(), the helper that expresses a bounded, truncation tolerant
> write, so that the file builds warning free and the intent is visible at
> the call site.
> 
> No functional change.
> 
> Signed-off-by: Aibing Chen <chenaibing@cmss.chinamobile.com>

Applied, thank you.

-- 
Dmitry
