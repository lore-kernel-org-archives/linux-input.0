Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337D537B03C
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781134869; cv=none; b=tuI+cXo/CdBiznW2+pfVrTOSiPuRMrO5Adu8JlA3hukzpcL2HD3ZXuEVjHr/NEmGKLVtZMLuC5cpJAkaTbDzKPEB3PEwA5W6JvEdHH26NBicuNsK2qiYeNv6Zg7NIcCTUbRpZvShJZssCcRMh1+teBZaW93thJWpZ2YDh5VyAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781134869; c=relaxed/simple;
	bh=9rozZdgv7t8p8ynviikc0qoAvrM/IC3PX/LUZKZPytU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Im+RbsgSzDqPOz+op7a+JBKycxE9k58GJBt71h9k+/LwaJ9pF6f7RjRXgDJUonzAXDum4PtcVss1KWo/DQ4o+0QMSLTL3EvVH8qROk2av8H/0B8ciKyP/7rbSZhDf/iOmR5Hu447Tk5mpKxWOJRqnnnA2YIjceq8YTCuoQsKrto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAOPjs3L; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAOPjs3L"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304cf518c9dso9205656eec.1
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 16:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781134867; x=1781739667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/EpTMNZ1obqYILWzMgsVeOkGLftyPXzrtSogbriqTbI=;
        b=kAOPjs3LPEts8EtP1R4zJaUGOxk4483n1o3bcroQS3wxpt9naWIXhCud7S9evm5Yxx
         0obAPzDD6uPh2xI7ylf0UlcyIDCix99A5KbwoyRn6FxItVGO9DYZnXvPRf9sK/qvrjA3
         1T6W+6LyCJ96MAOtp49gucQGlfs3sNKchvyJCXkSzN8BKP163sWhurVRKou5K05j7FDC
         r8wy+j4K1baGl5HJmf/nLxiTlWHlC38MsnoPKkH01nRkXYZuob1xDVrlpDgBtUvfx1XD
         rFIBNTpwkI/SuJLGxpyseRlijoe8Rpd4o+0l/spZa8sbFoWmF5t0+4IDBhjJsgxc1yIw
         HH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781134867; x=1781739667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EpTMNZ1obqYILWzMgsVeOkGLftyPXzrtSogbriqTbI=;
        b=kB+XhcRghc14NuM6MKOm4+OEliFXaFG9OJ+TGj3+2aUaEZW6q3UJDR2GfFuEF7WyHq
         tTM2BfLYz10GZWx6/3wTATjPDPHY/JRtFrZHEOfkqaHV/PZ05kOyW7IkYnu3xyLSyQ9R
         +omtP14vhqVqpk1t1WQdf+jN2M+hQR6afdHYY/491h9CTPxKAYPyAQfllDVjdDm09oQZ
         JnHAzhLKdkQntIsVJI+dDPMZxwdJXS+bzZWqt5f5FKhtGLE3ohWYX7s+C2ZewijEd85E
         YmyDGyQJ+UbJbYbKEsDNemZnFbv+YQnrFk0YfWjvec6GpAUY4mrzalCVVVZQjw42BZ1n
         /LPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8U+po7Nw69bntVDJ0E1mju0wW0Fe8DI7clU/hI/hZUT9gyHS0t7Wtw+H6Uu9QHA4y9ix2beIYWl4cZEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Ahx048c8Um3ogVjFMSbC9xi8x4TqY89qMNFNo/97wTwYeQ2s
	8/cvXE6UllZZuBPGPtOm+hVt2kL0fV/Vh34brs/sE1G21xTRTZZvLPh0
X-Gm-Gg: Acq92OHAaonF2ymSt/Ea3kCx6exYr6tuNeqSRJ1ZPFoy/f8SXzrbaeui7KbqYmpNV3W
	7xMzGOfYHICFqp3arxyDhienkgD/lyJz2JSBVIIpVa0UGZneOF+8SSVEFZcqptFnXzWsBOrBfKi
	pG7BsW1rA9ohFkh9Gvib+o8XCjBNmgb+Bqr5hIPuzTXNNNI1Ioo4KPtuniwEH5glNGXSekl8Fw5
	uv0HIpgf8sAtFjx8VOOpyRd2FfTLq+lbrROPQb+0yW3Nj395md+Nu5OMJpeghDZ1extl+SlLJDu
	eLj0lVgYgNXpW4nbClPVSFkLvsSpK1qUYGaGPSFgsWqOrGLWIFys6afv4lqupfGmg7ni7slnZPl
	qx5GTC0Jvau3Re/SnlFOtpudNLecgxFJbPkXI3vBnJFvuMN3btKpBxLoaDih2gWufB2hm060UkB
	tEBeSkCa2bNV7ElUSaYdLVcuNn5KpibjpouO6m71zjbiTWNnmXGWzlal7teHSQn+6p5oQuuiXH9
	e0=
X-Received: by 2002:a05:7300:6c25:b0:307:934e:da79 with SMTP id 5a478bee46e88-30804b769b7mr347241eec.34.1781134867104;
        Wed, 10 Jun 2026 16:41:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ae0e:e075:91c8:6570])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df77a0asm29449322eec.27.2026.06.10.16.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:41:06 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:41:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: git@apitzsch.eu, Marge.Yang@tw.synaptics.com, kees@kernel.org, 
	jiapeng.chong@linux.alibaba.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - unregister function handlers on
 physical driver registration failure
Message-ID: <ain1g0QAE2sr32Pj@google.com>
References: <20260610064633.2837084-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610064633.2837084-1-haoxiang_li2024@163.com>

Hi Haoxiang,

On Wed, Jun 10, 2026 at 02:46:33PM +0800, Haoxiang Li wrote:
> If rmi_register_physical_driver() fails, the current error path
> unregisters only the RMI bus. The function handlers registered
> earlier remain registered with the driver core.
> 
> Add a separate error path to unregister the function handlers
> before unregistering the bus in this failure case.
> 
> Fixes: d6e680837ec5 ("Input: synaptics-rmi4 - fix function name in kerneldoc")

This is not correct commit for fixes. I changed this to 

2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")

and applied, thank you.

Thanks.

-- 
Dmitry
