Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0382310651
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 05:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775107057; cv=none; b=hoUC/p/JxxrHdkMQ4w0GToa4zQfE43Jww4XCE5ycO8zsbfqZ4q2uKEeS+misL/LsCofMgI/mNpMCryHNyb4otaSRfZFmN8JW/g47fHp8rUQgLwSy0RXObbGBGCKvXkM9jXvI4yw1nFW5OGZGeUoH9qfXGbqc4kWblT0h9RirrJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775107057; c=relaxed/simple;
	bh=ZCXnOByptGSWhtsn3L5uQ7eNiLXMPx1Bs9taTz+3lqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoD2KSFmJjsU8wUVFScYoDI+K8zU69nudAHhibe+sqXTO4fLJTKo3H+HYlxfsThCF6eAwrtzUDLLI7PkBmu5cERAlkXblGZ7vNy3hcDd76Pjnqysu94PCUSLB1km8r4CRWsMveJrsDtYdr7y9QWvKDFDPZxuwMisoWvwDzFSsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li3ixfUZ; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li3ixfUZ"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c18af885c0so999742eec.0
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 22:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775107056; x=1775711856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxnWxLrLSCSrbUl5981R8JEjXR3s+V1Z+NsBygeyHN4=;
        b=Li3ixfUZVbNU1R2SA2VwEv8mp14Ybvk2/HY36pLyIDHhBntaUwRSVcLGgJr2qpFfCk
         rNn0RRjGIrSHyMoqh1gQrk9J8NsnoShLwmqsRanO8BvFVMmMn9p1TcF3YhVkdC0/2cRN
         dIWCWlzE5+tbp8FGm2JjJt93gBHm5Yf5HAAknQkex6u5luWEu1j+7kPK0mU/gFRvN+qi
         JCF01ihtvrDQx32g6CKjqLX/hsArHnQRWZsEUmGdncG7etplnGbZREIf+FGb2d+TZIhs
         ccKbtas9oRQLB/se4BAvm7K0WUTazBp7tpYyRkl9h9Fln0LRKVNAa9Y9Tb3Sg1ocY18S
         ytIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775107056; x=1775711856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxnWxLrLSCSrbUl5981R8JEjXR3s+V1Z+NsBygeyHN4=;
        b=IVjvTm7+us5R6anBKCzwOD3RetcACH9RmrHbqoScNCBFEo7V4sVq/X9W6gE5K/UF9O
         6yRINI8yBJve19WnVy5yHguw/1n9CrVr9Yt8EQAFUFjEmLVJ9oXJL+oIfPFuHhnJxTAK
         f/PWNPTyEqf5FnUfUJl51vO4jM+Fg1JCoqzMSUGAEZqoFe5JkKOPI4uulhjcQYvHb1sN
         xaimb3A6a7PyGbFHVK4ymEsvPriceADqG0hCjBZF+JyyPh1zZ7WO1Pa5qAMa/z9OzmTX
         VZBwudR6ocdIsttqRU5lvnh0KV5fuaUubPtJQRN5AidvEGwizVmoXjkc80e07q8wwmAF
         pc/g==
X-Forwarded-Encrypted: i=1; AJvYcCXRGJUrHaOWBxbHUgAOBSoivzs7KzqP8N8tgOMVg9V9fD35+DTiDKDn0CqDL1li/9zglajOM3t2IXagBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymOEsHzGE0EuMYmSN6elxJ6qezkjsdcZKY3Z74stMl9nWb0Sbl
	CtSFWx8EGfqJScKG0nAmaRvO3dBF/iUcz0nMo7SvGh0cNy1plPM6tIOt
X-Gm-Gg: ATEYQzx27c1y1s/AFQ5+GH6XVsqVXjkosRZDAvsADaJNXE0x/sHH6Y9c+cO4JPhgEgT
	sdRg7donDprqCA2uwwpegSffm9S8Rsf7GEvAj2PZdvOYqkRXGn07SEjx/eD+0wQkUkJ80fukzxR
	Twm1Sx/RkO2HJCCNjInYV1NSbJJQYEjc052+8qI2Vq948zIT+FjRE4/HTZN2MmY5aCUX8E9ifr1
	AnzLVeRDzEsLXb4zQtB0cToFhw6Jh5Ip9BUtIN0xRKEPfXL87x3ASl5gkL5s4wasOwaP1iBOobm
	ir9Ry+yDMUJMCHVtq0CIZgsKTo3pG9NnvL38YcddZJgEDR7FYb0ciSZEaXpWLEZLnXtCFEcRNwL
	FvLouJEWsx7r+oia7iKAwHFgdkp6ZPizk31c7fGPb2ffnU++DXgy8gFVTBt3mKYvHj6E+8iGXGp
	9bdhg5KNxjAG1NbQe7r1ukrj8HS6AH3atfYrKgpVaYWGt9Rej+CcPVhYrX467vKQFx
X-Received: by 2002:a05:7301:fa0d:b0:2c1:6676:5ebd with SMTP id 5a478bee46e88-2c930e6b1fbmr3332040eec.10.1775107055635;
        Wed, 01 Apr 2026 22:17:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5f38:4c97:ec41:caa0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c151sm1701575eec.19.2026.04.01.22.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 22:17:34 -0700 (PDT)
Date: Wed, 1 Apr 2026 22:17:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: phucduc.bui@gmail.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Jeff LaBundy <jeff@labundy.com>, 
	Bastian Hecht <hechtb@gmail.com>, Javier Carrasco <javier.carrasco@wolfvision.net>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] input: touchscreen: st1232: add system wakeup
 support
Message-ID: <ac37o-N5lqFMwDCC@google.com>
References: <20260306104025.43970-1-phucduc.bui@gmail.com>
 <20260306111912.58388-1-phucduc.bui@gmail.com>
 <20260306111912.58388-4-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306111912.58388-4-phucduc.bui@gmail.com>

On Fri, Mar 06, 2026 at 06:19:12PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> The ST1232 touchscreen controller can generate an interrupt when the
> panel is touched, which may be used as a wakeup source for the system.
> 
> Add support for system wakeup by initializing the device wakeup
> capability in probe() based on the "wakeup-source" device property.
> When wakeup is enabled, the driver enables IRQ wake during suspend
> so that touch events can wake the system.
> 
> If wakeup is not enabled, the driver retains the existing behavior of
> disabling the IRQ and powering down the controller during suspend.

I do not believe this patch is needed: i2c core already handles
"wakeup-source" property and manages wakeup IRQ.

Thanks.

-- 
Dmitry
