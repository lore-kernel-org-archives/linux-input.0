Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277545;
	b=qLA6wRUkyEvmxoBypbj5Vxs3PO7eoFdR+WguEe0OjReCeMuzt/dMRruM6KidMjA6N7dB
	 BSkys2Cwuuvui07YwlOfuEyj66yU2q/Ok6qZh5V1eQmBe3Lmit8nEe0vibAru2FgQSEEO
	 UnY+WY8ZeSkQy25NBWZ+Mlf7JAxwC2qjbmR8MAvDTfKQbCOjNVfWqAvXh7AS5LT6Jq2vX
	 E61RddFJGh2R1WINl4qxpMcnqu0F5glOq06zMLoayK0GppARjUuz/rCi4hfuQvOMlI9Cw
	 PF+ZjUyaMBOVxh/AQB2mUgJaLgX2AjuRbGTNKgUMPu0iqO4Uxy2MbZV6QyqTYgzHaFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XPldadiNKhoZegiaTvf8CiokX5nZmrBDQdfxqSW4DgY=;
	b=pdrR4ZhJIkggpwYY3koCUCk5iwTQdTHcEejeARFhxU2iif0fviHgqIAOMdM/yfJgDqAn
	 bGUrJ6HygXv4AwK4CgNxluI3yCnagfGBzRZFWEY6zIRjZMdAssR1BLVA8x8F8+rbn3RKB
	 jt+UmVyd8vcqw//FQnJIxLGmKxfdIfcKS6VyotgH/1ktgdSYsTnWzbC3ndH7NpvdBon1Y
	 npBWrF3N6GNNKdoJ5bsShH7+fpqfBSrYnY6hiheJAL26aB9JgCFFmQ+K658jtbH413DK8
	 A72ZrcgNI5so4UgJ+a19g3MFQmBlBNXYomH7wSbqdh3ijDC1cOEZgSENNZ9EIYKxo0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifJwtyRO;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1328B606A325
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1328B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifJwtyRO
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36ff9c9da34so2639016eec.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 18:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794277544; x=1794882344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XPldadiNKhoZegiaTvf8CiokX5nZmrBDQdfxqSW4DgY=;
        b=ifJwtyRO6Rvdzuf5RXRzy7ct3bd5CDyCkVxVZpgd3Ig6fwQCkbp9KCt3ko8KEqpJru
         +sCzk8uSSG7rXdzapbnIqrOGkYEaG+Df4Db5RHwWm1YItysfhd1KuA2eUZLvB7Kcba+p
         VbtAagVe/A36U+j9GgCSF0JGtBR6vM0GLoVzw1E3A8TSLNILkr8HKKtaB+wugRaeMxWe
         VVB8UH2KdAmUi9JLZlVDVhfCQUljK/+np0pHR+Co5sUEkvVMSBBX92wDgZ2Adyhf/UH0
         BLTWe3yxFuK6W/HoFJvfcm7TuhmK+m90MJgw6anlnCBS1u9UYKPWakerbUgz+FUgyg4n
         +xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794277544; x=1794882344;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XPldadiNKhoZegiaTvf8CiokX5nZmrBDQdfxqSW4DgY=;
        b=1w9iwNrRVvT6McgNwPJnbumnP4i1mbzJsp5+jeI5yDjkC1THMLWvPKs6tPVHvfi6ie
         nEVgYIuWiCWpFDYu5HiCOxfBG9eqa+ofxrKhFFkzHjvFSizx1n7P+s1VkxZaE/8xCRmw
         Lbuq75mmpfFJ/Vyf3rFMQB350EC4Vcv5AMbSj8pZInqkMgEmEWnbVn3tWokSsi7ErN6q
         tgE3wyiPRkheNvGRx8s9DEGZhlDkzR3QOVbUYowma+A6Nb9ggO+5M4hCglLp+Yc7CtXf
         o7gLMt6Ued0zwRjXwtk4BkJGytpU2XWE88SLCxvoLLDpkr/DaLObyFPn2wg+qOTQ5gTc
         W97Q==
X-Forwarded-Encrypted: i=1; AL+hErFFfYcU+FdCtcW90PJHPA4V0MrRgUl9XhI32x5xSGXoOIkOG+OyZ5pNWdo/bTt3oqZny1E49xjn+SCnXA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/S1S1mlARHN5UR6DyLM8SpUayhDfie5nIxphZKOf5PrEWM7gIJ
	mduqtkqo/TWUlqTFJmGDn6vO9eMYG1Yyn/eUAsVm8dHezKLA+nOjiTTt
X-Gm-Gg: AYBFou16iJ8CutiUnDNfMk7VaAIG5UXdj0P8hCx8jwFCDVbBJJYciXlM4CBCZEl8a89
	JKcE+G5YPU1yKS1UvFMkrBpRsYdkLb/h7OX+2QTWpnO+6bYaXYPNDDON02iWYS+RXv8j/9TAAyK
	v/QZXZC7jP47lkOfUsaI6646hczdWcwrIcVp47ubXfxR0Q3ZdYyKMoAIVnq8DKJ0aIX5vtXTUxL
	/qgy7qZFOVq+BSMnKBQFk1ZPALk1AkUel5OzKTJBw0eh5080Sd04tFDNMY8MaEh44ir9r+gX4hm
	2+euF0FNhdfxwk2Q6WR7k75nIVVvpgxzXi1n8Ad0WNg7JV9Vg+7R/+XETOTB48lncwn7mj0pxjj
	jy7M/nfqZsNO+CsClsKg3H7QggUNlU5xQEP3IW3RDvsNZam5ZVpSW9yjzrNZR5N7erZykuxFUIl
	YRn6r3AbzDrwgVmszlQkmOuY8Jgd5m3ZEkBL0pUiAZcr+KYMnPajtH4hrSl3orEe2uTiuiid6Qr
	kbGcnhz5YfPXj8qg77L4jaCmkBe3PBjmLbF+pY77FI0V1+Yj9o/3dAK/T4wSWeZTPzDUu03ho4j
	oCwOFaTXW5fi1goENFzz8cxgw+vbldf5RGFDTfRqItL0jqXqpPqp4ftGAEYMuPDqYaNw3qc=
X-Received: by 2002:a05:693c:894d:20b0:35c:85fa:5a61 with SMTP id 5a478bee46e88-37520215e02mr1487679eec.38.1794277543714;
        Mon, 09 Nov 2026 18:25:43 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:856b:460b:b522:14ec])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306casm2213095eec.9.2026.11.09.18.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:25:41 -0800 (PST)
Date: Mon, 9 Nov 2026 18:25:38 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Siarhei Vishniakou <svv@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Input: add ABS_TWIST and support it in HID and Wacom
Message-ID: <avKAaJxlxE8gOYVV@google.com>
References: <20261110020632.4003499-1-svv@google.com>
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
In-Reply-To: <20261110020632.4003499-1-svv@google.com>

Hi Siarhei,

On Mon, Nov 09, 2026 at 06:06:29PM -0800, Siarhei Vishniakou wrote:
> Some styli can report rotation along their long ("barrel") axis,
> commonly referred to as "twist". While the HID specification defines
> this usage as HID_DG_TWIST (0x000d0041) in the Digitizers page, there is
> currently no corresponding evdev axis code to expose it to userspace.
> 
> Because evdev has no MSC_SCAN equivalent for axes, drivers and OEMs
> currently work around this by mapping stylus twist onto unrelated axes
> such as ABS_Z or ABS_RZ. As a result, userspace input stacks must
> maintain device-specific workarounds to know which axis carries twist.

How is it different from orientation?

Thanks.

-- 
Dmitry
