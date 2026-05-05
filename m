Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D824D39B952
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993393; cv=none; b=bihKpwTluS/ar6Fa8b+liRU6iLAUr8xvZZMeAN6jHn/cPh06VI+AbC6RT+hiKe1eXIPRe9Rlw8XaL5SKJLc71M3ozSXAFMEa6Ly/EH11VGfs/75Q0PO02nWf+N0pg8RPuJvh/qBSjmU/T/7D6bb8Q+3x/sKj7+ak7ru2zJCw1Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993393; c=relaxed/simple;
	bh=A9wpaSBbR1ublzL/Sy2zUllnDSEWVh69TzLmMcbXZ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMm6VLOafNfSIUzvzrINjuEXquvpV7avE/Z5oK+tDuK8gU/HjpocURSzHxEIOv/D2TjoGyc9U6/eOqoGLUwI4vY2lEBFYvy5NVjlRxGXdTq0BIcoIYNaptgb5yGXMD12q0hgyAA6f1fGFP0WGDx0XYP7zMxQoThUjCECiYir7Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsHsKd8r; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsHsKd8r"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ad21f437eeso33340015ad.0
        for <linux-input@vger.kernel.org>; Tue, 05 May 2026 08:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777993391; x=1778598191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKYwXEKBkfxrwukpDctwnP55c5ugAMD8+9dw4QCucpc=;
        b=OsHsKd8rK5oIhfHwRZbAUsyG9x1n8Qa724mT5Cj8TJHExm2iYXMRQaT5D1Z77hDyTI
         xA4cM1J85Eabfc1x8G8kOucgIS5NLfQLIfFzDZuHZmGvelW+kQzEXIZ/p7RjLRVhWVb6
         H+GoFgOgt8N/IosJ7YGaivt8IaSVi67n4at9NhoTVeDxF8jLcQFBrm0dI85pTeGD8xw8
         73jZP3RRLPr2uciV9Yuwyr6g7XVzgEEs8iLJbJRzRNnQ3/gpE1WzT3EClnD3GOt0xpY9
         e72MJQ1xsCVfrVBPtlB8w+J232SS/XyBASUgjkrQtX7pdbRZFl489eRAQQ4x954YnNvr
         lsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777993391; x=1778598191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKYwXEKBkfxrwukpDctwnP55c5ugAMD8+9dw4QCucpc=;
        b=kgqtUvWNVGOV/2pYl4blde6aakYE0A1BPPFmO0f2hN+euXcKn1Ah81hrmg9uR53vFC
         kxuXESbOZyziY4Eju8RxUUj+cD0/9798hvPfqVgzdoT0A7vWx7yFjOVirqzLMOx2sLAv
         /PMIVmVDKeG/LVOTXs+e4+kuEcNk6tLmdEImNaHvm2lc7gQxJT8xZdWpZlnesi4KJo2z
         bKagQErufs19woeEs8z1DgApODjvcjRYKpoGvFQeDC5jg48xvaNga210XXYrRWIo/Ui1
         qW8d0eB5duB1qnqhfxMtpPpPU9By1yw3MaS8KP2JcjShUtyqjyHnOnIonDxD18ND6zH6
         6LxQ==
X-Forwarded-Encrypted: i=1; AFNElJ93hmQ+kD8VL8Hnp2xmLlBhe389YsZ7YHIqAkF1QL4/ueMuJB3i/la2mw9yRCVYs6mA1AEQIBkBZquKZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ0NYlvQ8SkxrX/kIwAfKAqAsez28VkGeQcqF4zXUK+8WC3/cf
	fPl8E9zU9yLDuKq+zL5PfKOTGQhCyjvN78Hs3X5mBKBNT9wL13MF4oXo
X-Gm-Gg: AeBDiesaVzZhqzHVTn8KNYlzg6bEFvApRm2k5z7HPAygXX5vlB58QAjsJcE9Y3DE7uj
	83mL2w78WaMLwPnWzXwoQz43De4sPl1OFM2VWJmxP7bjRVPagGJWHKgglZ9U75m5clFaaQDMKvW
	auy7UweUmtgeoaONRM3N1y1tzzx++xgzHaLonzDfjyH/T/3R1HZBnydCKj654nIFJstP03QSZZa
	Y8etO4085l/lMjizj9a9IxgGNXH03lRqjaHPJst2P+gSbpEAXICrLX4b49mnvXokiSWlQEyjPZm
	1c8YQYAQIp5AI9qdI+KYpKRHJfApaZogSyLgdpzWo15E3MOFsvjtiQeInN9qmzgR6dcovQvY78q
	BgDYeEsnEpHJDHEkvFTWtmq5fs70j1vY5PArochpZ3Z8hkmOEyhtIaoBMq16lljOH3F+n2mswu+
	KWzGOpXpJ7CFixST8eB/BZcWiUsB1JJYMsWhrJM+hIjynMJhkQojFHXj9eeVhsXzaNhHw4tzAFQ
	bE=
X-Received: by 2002:a17:903:3c47:b0:2ae:47b0:dc80 with SMTP id d9443c01a7336-2ba4d7aadebmr32397605ad.11.1777993389459;
        Tue, 05 May 2026 08:03:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae366c7sm143554025ad.55.2026.05.05.08.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:03:08 -0700 (PDT)
Date: Tue, 5 May 2026 08:03:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] Input: atmel_mxt_ts - fix boundary check in
 mxt_prepare_cfg_mem
Message-ID: <afoFzH1RvBwUajER@google.com>
References: <20260504185448.4055973-1-dmitry.torokhov@gmail.com>
 <CANiDSCv+h_ry7W1e1mFNLhont-1xigEZj6jL3m=FVgv2UC+KzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCv+h_ry7W1e1mFNLhont-1xigEZj6jL3m=FVgv2UC+KzQ@mail.gmail.com>

Hi Ricardo,

On Tue, May 05, 2026 at 11:08:15AM +0200, Ricardo Ribalda wrote:
> HI Dmitry
> 
> FWIW this patch looks correct to me...

Thank you for looking this over.

> 
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> But there are a couple of things that look weird.
> 
> 1) The patch line (1503) does not seem to match your tree
> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/tree/drivers/input/touchscreen/atmel_mxt_ts.c#n1503

Yeah, I have an unrelated path in my queue that affects line offsets,

> 
> 2) The sscanf just before this check has two conversions (val and
> offset), but you only check for ret != 1. Should't it be ret !=2? or I
> am missing something?

"%n" format specifier does not increment number of successfully parsed
elements returned by sscanf(). It kind of makes sense although may look
surprising.

Thanks.

-- 
Dmitry
