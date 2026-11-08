Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794097139;
	b=H30ckFCE2VT/GKkIJn6hcp8O95fwRdjZsHYkvP1LYK7FEX2atTlcLwk3aiDNW2XOCVvV
	 dhx8yTxaJ26Z+yksYn2G15y32uKF8hvHfRj/uDbv0ae3B1flYqQtshm8bT3dG0vn06xYa
	 5KhkRoFFsPzqPdG1ExTVu2/Oq+SvlXAWoYLr82lKXNDdHJ+pKS66eHfjNAemja3tLhGEs
	 glHkrPApoeT0RrMRkfQwms2TOHQl0fYIBn0GaEaQ5yHeid56/9RMtCLP6y265jXNPIPON
	 EQAwSZ5ypTwxTweShtpQPLK+Y1Jtft5fqEmdtdW5vta7k6PcPH2xGUDUAkBTC8+1KuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794097139;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=EfxSBm3bzgzf2A9VtrSo7r03r+1kEbbvQLbRQsMqp+w=;
	b=Ghh6hAOx6Saezqm+YMftrH0eLOX2GN8rsRgLDipE33l8aJrh+BdAgNRjCdF6FTis7c9q
	 ArngpVsOy86cc/I30wkBaZN/uF5jv4Q0A1SOn1bQSWe+VgjTlvKZq0jOJwpe8XBdhhid0
	 O/z5eoRf5MrPUP+siHI2qVtFQ0ccFeskLP1iXlVsr+VKtt4WWZhiCuQh5U4BIs7kv/MZN
	 6q4D+JLcme9yGRZpg1wNEFGnWFD4fg+4VylWAvp7KV2TLDJiL5i1nNsSEVxs/9Kbadbc4
	 AAMFlFMtCeoFFbKR540i2oxZ5ywMeipM5caXBVkutJE32pcQ3JltJ09dAhEBH5gNZhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d2TGOyRm;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2436F606A32E
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 00:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2436F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d2TGOyRm
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so251455eec.0
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 16:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794097138; x=1794701938; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EfxSBm3bzgzf2A9VtrSo7r03r+1kEbbvQLbRQsMqp+w=;
        b=d2TGOyRm9+/hxneg1TLi5SkUGIVJcqxd8tpssnCoA0seFj3UMrwvzsK5ZaHkPacPPu
         ckxD31vn1SjS5iXNgOSzpCEG9U0T0FWN5A9KQxamnbvhyXMdKEOzB6yQ2kNXbMiayf6A
         OEAd+KVeIC31GxBm0Ikq2kl9254iGD5WHineEOWGqTBc1Af5gHncO7GT6y6zBSSxSz0W
         WzIkoVSoKYiecR6VFOu9nWuqeg6YmABUN8x6cCAjdd2fBfX+KUlRNC4i56W+Xx2Adq04
         DHVi6c64AREYizRAlkRX4xS9PPwfktK6RUGferj3DRAAKN88KxW/s9dh/v+ZoIT/wF9+
         lUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794097138; x=1794701938;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EfxSBm3bzgzf2A9VtrSo7r03r+1kEbbvQLbRQsMqp+w=;
        b=2ZFQsaydHRfJbZFFbCpfXAgkdipQGBzmPkMrgHeT/4EbzTdJJ3OsstEPhXmetPK5Ys
         7FmRl0goYz1Ip5LvgOcnT3iDCjg8uvy+TAnQmDwltitLeYSIaTw01vmLHqBGdHxBnrST
         vP1LtUR+wxeZS4kmWq7x6GE6OzLbpxrduUkqX6CEBbepeKeibCzLBWgq6LtRx9qbl/2+
         J7CKpsq1iHPaNIBd3uyfUWt6OXKs7moORv6CFYITD+Itc593XQTI8wEew5AcD2gRTxK+
         JJkphHuqaz4zj/BkKuJiLEuEryYP6nsivj+8BjjXZZy8M/rGgglLgBGAkJaximLD3g/n
         SBdg==
X-Gm-Message-State: APuU4Z/iGbonrIEXqQi87cfWF9QOfippTyOexAfRQhayQkYOcG+b7WC3
	BH/5sKKJ2URwLmE+2SJ6yIxQQZi/WTdJL66YLjr9V+/zZwKJ9CkWYk+q
X-Gm-Gg: AYBFou0MKiv5+/qmBqOOuhFiXd9FqVMOX+EXUBNrjeVsATrkP6EkMdocYi+8Ba7vZjl
	auuE7xn/rs4CmrU+8DsvEa/R6YUckSRylhXv6XaTLYW85Rk+nITACWOpwNwu3SMMYT0p7DKaLvz
	SFJ0BxBts3Z6EbZim8h8aG7F5NAkOTV2SUlCnr5CGnRY5Cr+qyZ6bMRvA4BHNSUVpAm3cgj+KHZ
	7kqYkw1JEOJ9d1H/a4iM6qKyLK6BOQ3lkLat7OK02Jw/Iotl5skUYigFiJP4cQPOgC7NuElHsML
	fLTdfRG0ehwI9QaTconbu1a855+VcI5+SEG1OSr9ghJGFM0KO4vAleU0T5oXHr84SENn1bSXEPj
	N7Zsey0yTilAb94IJJzzTb1eb/y2/8Is7NUdPDz7soxsJhlHDIq0dL5WA8pPjnLJCv171JLWLa7
	IuC3smt/xuh3++AXlEb5hmEuZrL+Z9YUBFlUE0B7ftld3BJ3Qe4AjVAt/6db7R6dNkKAzk21fJJ
	F9YGKvSsBnz1lMK44L33kFOpyUx9U72LcgPkij9wjDJLExjgOWtftz/waE+2SLEBMCKSuIARs3w
	MRNL/zISZT++Qthg2uWIEdTlCgIsH6cedn45Mx42zzK3Oto8Lxg08AVG/6a9MdF80iMc
X-Received: by 2002:a05:701b:4294:10b0:1b2:6c97:fecd with SMTP id a92af1059eb24-1b39fecea0amr167005c88.42.1794097138049;
        Sat, 07 Nov 2026 16:18:58 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:5a4:1cb9:242d:4f00])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b372ed839fsm2018026c88.0.2026.11.07.16.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 16:18:56 -0800 (PST)
Date: Sat, 07 Nov 2026 16:18:56 -0800
Message-ID: <ccc5eb71825e1bd468007e548a8367e7@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Thorsten Blum <blum@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: amijoy - fix memory region leak on registration failure
In-Reply-To: <20261107160159.367919-2-blum@kernel.org>
References: <20261107160159.367919-2-blum@kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Thorsten,

On Sat, Nov 07, 2026 at 05:01:57PM +0100, Thorsten Blum wrote:
> If input_register_device() fails in amijoy_init(), release the memory
> region for port i before cleaning up the previously registered ports.
>
> Fixes: 127278ce2254 ("Input: joysticks - handle errors when registering input devices")
> Cc: stable@vger.kernel.org
...
>  		err = input_register_device(amijoy_dev[i]);
>  		if (err) {
>  			input_free_device(amijoy_dev[i]);
> +			release_mem_region(CUSTOM_PHYSADDR + 10 + i * 2, 2);
>  			goto fail;
>  		}

Do we really need this in stable? It has been like this for 20 years,
and only affects an unlikely input_register_device() failure (basically
-ENOMEM during init) on Amiga hardware, so please drop Cc: stable.

Without the constraint of keeping the diff minimal for stable, could we
also clean up the error handling here instead of unwinding inline (and
out of order relative to input_allocate_device() / request_mem_region())?
Either add cascading err_release_mem / err_free_dev labels before the
unregister loop so unwinding happens in reverse order without repeating
input_free_device(), or factor per-port initialization out into a small
amijoy_setup_port() helper.

Thanks.

-- 
Dmitry
