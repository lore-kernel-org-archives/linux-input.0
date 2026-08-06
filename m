Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E488E31E848
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041587; cv=none; b=piYRfw8VWzTlqwsIaeUCeN/Mv9mnSjgx92l2FtxsPOgpUYdxYqXf9sKZz6MsnqTPc5JTwwXX77hfAfhUdm0dDUyrLH0pUDtW1TOufxcAbAQahfwv/TuKhT6fuseh2IKCRSrmbzI1ueNXLBuSQepBHI/5wPa8psuEuHBy0JYT1DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041587; c=relaxed/simple;
	bh=NV+IA53dz9VkHcKJtbdngrpQGXRELNM+2tXFLrXNSLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ7PiayF73uei4Penq+slSlUUX3tnHgQ2ilqcYb/vlrv68ZH0Gbhxs8uEqhHa1A8zWbQ9MQkY5AKV9oov4cUO+pchD1vL0Gc28aDbjA/lidxRwZC3096c1AJgIfA8zwxx+PoNfunjaIRWDG9EYW/EM3yFfrcErv7lRyVbpdPCZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gu/ZNCnw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu/ZNCnw"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3900e39d935so2440242a91.0
        for <linux-input@vger.kernel.org>; Thu, 06 Aug 2026 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786041585; x=1786646385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p+7d30qMdbhTyDmqMFX+O8IHOCgpcLlN0txxCdEaKHI=;
        b=gu/ZNCnwMY0RwVy2TX2eeTkA+CTJ5L/7Mzw3s++mL71Dm3IBu//M6bTE7vy8bPwlUa
         7mOwfR0R+WtbOCP2LSgpryv13nHlUVZjBzI2XiPNwN9C96K7F1QnKGNc8QwD4mr0kPrD
         wEDr0jZQk3m2UO1KKKDznIlWef9PVo0dnkT7ObzGG8q/dg0wDFK9buDkPwRd3j5+0JBx
         6NrgIuCRpZbUmyuUI6PTeIIUkMMutJw28MItExDdLHbaILuLOFMElALMfNlOrU+gGnlx
         lggGKAL54Dqz8OFu75c/pBak5eOCm6IwYeP/GNnAF6DeWF38mbLRkCIVd4l4mPjKchtu
         mJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786041585; x=1786646385;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p+7d30qMdbhTyDmqMFX+O8IHOCgpcLlN0txxCdEaKHI=;
        b=oqQoG/UUa89ybJduDr9JwlZGFAcUqgM43tJrvvb4bIMMwr6krTgjJQdvLPFv7e5AGd
         LWHJBcXM/wS+m0RunTzbfmiNthzAWu6T1yZ956J9W+LZX5mLJ0mS2ojTRE90P8q16yi3
         gcOLxX9SpIsxtZ0oHF0PQqlUrLEG7KJiTYBfhLaRXaTF8YdD/5B8fEpXYuwz3COm4sh/
         0ClXeHnZCUkMr7z25G3FSOWwTr/fOhGG6iz4A3pmx2wgHO9k39U0WHBnsZzWOFZdcRPj
         fTti/Kg2EqVBMt6VnQBC1rFyoQ217NymAp7Lsq1RSL797pvkfTPCd04TpGIsljdqDIwt
         1FGg==
X-Gm-Message-State: AOJu0YyatUP742X6915PPjZ5poSxsqowjD8GFXfRUApOXko+E0+8N6Ql
	RZMe2CQoknNi2E5bDy+Mx9R919fY/vQuhK5UiITAUno6YfpfWbuFwOG5OplOqw==
X-Gm-Gg: AR+sD11KmZ+q5lpDz8pHI9YFeqMo3GkjDlroMob3zsWTeXPddm00fh5qWTka54IoEot
	HujaB7TMrJFzu19MkQ3Ajh+LckMDgNGfI0XpD98KJbZJlGin950gHFOgDTKOoozts7r+7WmLbCz
	566wUDbLlC1RbiJYEbJ+txi3nuaItlsW3E12ZTGgb9zc+9eyUyqLzRSmrRvASyE52KvA4lKOcmV
	VLbaaJVZWqwkCXGjJyDnZkBj6s8cp7ku/p9jpxDt9uVsnYsiLEbkMJpiDJPgXuXiWTxf4TAmbx8
	vI2dGlU3tQFpj751v9skq+g7Qitsc0YJ1LVJH/Mewkd1kUv9XXEgu59O4wfRUbXyuf3l3DYFV2Q
	iCxrLJSz668lzVQFakGwZZ9q/g1Ybc9PEVP1yeDTokk6wx2suicD+FwUkp2BQPmGP5fbim56/sd
	ReQihAV7jlzSEGsAxaeoWvhdND8EfJQob4nppKWwJaBvDxz5exkFwnXZ7xQyi/XGiqrHi9+L8o8
	IQmRSv2D5TcMXMXl/Vq8yX/WNF3gw==
X-Received: by 2002:a17:90b:5484:b0:37f:c69d:ce69 with SMTP id 98e67ed59e1d1-3903c581f08mr17425221a91.10.1786041585118;
        Thu, 06 Aug 2026 11:39:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b209:871b:9f7e:a5e4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141009ab943sm503689c88.7.2026.08.06.11.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 11:39:44 -0700 (PDT)
Date: Thu, 6 Aug 2026 11:39:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - fix GPF in suspend and resume
 when unbound
Message-ID: <anTUTsHmD1gv1UZn@google.com>
References: <anQe8UiyUR4x0flD@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anQe8UiyUR4x0flD@google.com>

On Wed, Aug 05, 2026 at 10:44:23PM -0700, Dmitry Torokhov wrote:
> Transport drivers (such as rmi_i2c and rmi_spi) invoke
> rmi_driver_suspend() and rmi_driver_resume() on their child rmi_dev
> device during system power management events. However, transport drivers
> are fully registered and operational even if the physical RMI driver
> failed to bind or probe the rmi_dev device.
> 
> When rmi_driver_suspend() or rmi_driver_resume() is called on an unbound
> rmi_dev, dev_get_drvdata() returns NULL. Calling rmi_disable_irq() or
> rmi_enable_irq() without driver data attached causes a NULL pointer
> dereference and General Protection Fault when attempting to lock
> data->enabled_mutex.
> 
> Fix this by checking if driver data is attached to rmi_dev in
> rmi_driver_suspend() and rmi_driver_resume(), exiting early if
> no driver data is present.

Note that better fix would be to have RMI driver implement PM methods
(suspend, resume) but that requires more careful planning, especially
around RMI-HID.

Thanks.

-- 
Dmitry
