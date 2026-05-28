Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661DD34389E
	for <linux-input@vger.kernel.org>; Thu, 28 May 2026 05:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946328; cv=none; b=cjakEl08CDxczpb1bXjQtxUli42diabZ8PT6Rb+ss5N+FZrKIfV9nPT7pSFVO/axz6eE1lEW0VkL4dCUX563s/x/RO7wmMhvz/JY0ZY4llVUtDzkd4vFG4LTlhvCPEwAxfBfOovU1LsrTrWihfjpDsbtSMP5mbUjq4HBlSM1Q/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946328; c=relaxed/simple;
	bh=IK1Bb9AuJqkHv96iXJHC5mPYMiYpKU+zCrPc1d5SoUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rc/giXX1yjhDFAJLq+1OGwl3zKicojBLIgjqvZGEpnIBaeOzEtZARULe7Ou6b+iDl9CJzEt7i2C6r8IefSRyy16IlkM1v3Qle+OLehtX5XVZZeYODLMoiPMEWctJvWgI1pSXM9TnRGPdj0Ft3uAhtuTuxNHbkq1KqQGgnAuvK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncEBLQbH; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncEBLQbH"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-136b46c3540so5171682c88.1
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 22:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779946326; x=1780551126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m51ObGqxvbRirSNNGuV//C4DnnfvAOGn+7qB5s8zlHc=;
        b=ncEBLQbHMvHTAXzsg6fSL1Q2WHWhxrxg21cDJyqxFA+tTrQfO4yaaVD+vmb0EHzwXF
         483t8BjbBWwuOrO7qH+J/NZVL5zYxepqv15b6aPnGnvEVmWX6pASjq0IkbFwAkTQh9I8
         hwpzOszSSgYn2JTbtxrh0MTrhd23NQ0YOsM4pL0Xg1fNOtxvog7oX9dcDx8OSTcw7DAj
         FV2hIZlQZ0U6Q82zfDUc+9XB5B80QZZRBw4xPnpzOSxls1IYxfNeJC2XKo4bRKszQQb/
         CN7sjPsYdkybubH3ARplg4x7Dg5mwzk+OpdlfqV6MX/srRKRP/0YM0AjCa69AgXSo79Z
         BQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946326; x=1780551126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m51ObGqxvbRirSNNGuV//C4DnnfvAOGn+7qB5s8zlHc=;
        b=qUrNgd3XFdPrkm6NAlHQv7nPz3PxvNYFD5KDv7+etv61nXcL1DXy4P2Q+GUHIHkm1c
         xBW1Wo52dbQY7vl+dcmTkr/hNBZf8AmL9ySeCeHqK/5OxfATRIzHyI426y+doQl/rZjy
         bXXfMCDqviFLac+kzjrwM65VpH6zlrCcW0GDBpqmFgeV/I+xonKsPy2lPztwV8vwWZTS
         7SsuismXKTeFHKlZ7Le3EObQFhE5ndf/Xf2WRwCfFuu2ajJQo5ebt/ywTIA9aZQ1uKAQ
         q9Vhl1eb7EAVALKgpGarTPRAGtYliBFCh/aBHMr3BjuXhUv0iNsbOTx0HF3FgTZ6qcqB
         r2FQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qNWFOghD0NwRMG/jgRz8FAcVbF8unduwKGpXEwgfBXpeEt2mNXAYwmuumSaE6VsfGzLWbTTlD61o04Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJoYerMUFNFE16+ilMhuclUmnE4VOoHfgkx6WxSofR6RZptNFf
	IGp/nW1K7KoJkNSrp1KHuyEGVLLWgN5LeGfLzuGXH6TUelqHl2I5cgcC
X-Gm-Gg: Acq92OFMJCX7oQ2FknQshrZtyf6ewLQahw08h+4cYk8c3mBITFVZz5FcF3timX88cPJ
	33pofMC3LKb6nrRGcVOdvMMdfmpYKkRpJJb/wGr9rwOzyUAqyuRepD3+EuYum4WYhT5y97uTtVz
	2nJ6M7gx0CCMHA4Go8PMfvNT+ZnXoyV/zv4wZqYWmEfD+E4EfBae62vHGJZmQCLd9rm2CMqO5Xi
	L7U+MNECmwpXb5HmTa/mDNoMU8hzXbJf4wYCHnTiNm9pY+1sUrxIg3/Tq8l1U11TVXmWCw9wQ9z
	IYo5ndXnodj8Itbyp6BtYwtqpyA3I9UbMnJK7dDidFijCQmJt/c3QpUpqBOctjRrEk7+zZujJS9
	4nRzKj3x8mNBKYhxTUWcPkXVJ6/K5W+OPTZdTViq7UI3ec0D6ZShYo6OHBBBTQoMnZZPhxlwLHt
	Zh/BFJq0+4n8orNh35tB87pjklhRLobjSnPdJDU/UwMzoLgpLJgPKfkFMRoV1vXDuxnLfedaiUk
	Tc=
X-Received: by 2002:a05:7022:6093:b0:12c:6e85:505c with SMTP id a92af1059eb24-1365f70f672mr9871005c88.4.1779946326427;
        Wed, 27 May 2026 22:32:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ca8d:7a6a:7fd3:5948])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-136b2b1f2a6sm9493424c88.4.2026.05.27.22.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:32:05 -0700 (PDT)
Date: Wed, 27 May 2026 22:32:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
	Denis Benato <denis.benato@linux.dev>, Zhouwang Huang <honjow311@gmail.com>, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/4] HID: hid-msi: Add MSI Claw configuration driver
Message-ID: <ahfQW54YoHj2Pal_@google.com>
References: <20260527222122.10620-1-derekjohn.clark@gmail.com>
 <20260527222122.10620-2-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527222122.10620-2-derekjohn.clark@gmail.com>

Hi Derek,

On Wed, May 27, 2026 at 10:21:19PM +0000, Derek J. Clark wrote:
> Adds configuration HID driver for the MSI Claw series of handheld PC's.
> In this initial patch add the initial driver outline and attributes for
> changing the gamepad mode, M-key behavior, and add a WO reset function.
> 
> Sending the SWITCH_MODE and RESET commands causes a USB disconnect in
> the device. The completion will therefore never get hit and would trigger
> an -EIO. To avoid showing the user an error for every write to these
> attrs a bypass for the completion handling is introduced when timeout ==
> 0.
> 
> The initial version of this patch was written by Denis Benato, which
> contained the initial reverse-engineering and implementation for the
> gamepad mode switching. This work was later expanded by Zhouwang Huang
> to include more gamepad modes. Finally, I refactored the drivers data
> in/out flow and overall format to conform to kernel driver best
> practices and style guides. Claude was used as an initial reviewer of
> this patch.

I wonder why do you need to roll asynchronous probing and asynchronous
resume by hand? This I think complicates the driver greatly and forces
you to use a ton of works, spinlocks, and checks.

Thanks.

-- 
Dmitry
