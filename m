Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D14B8DD8
	for <linux-input@vger.kernel.org>; Fri,  5 Jun 2026 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650011; cv=none; b=b6Uk0YYdvRboarmN6MfNYtrk8mTnSvJERUEy5MRCR30eTM91qb5pwGu9/AjttW3R1/5Or6wiPqypETti/Zb0vCO3cxG/Cpu951xwsXYRvMU6dvxn2SJdd57nZlcswWdDwlCr4DbpXOc6wQddR+T5mnpnvcuoA/YQtWMTIID/+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650011; c=relaxed/simple;
	bh=SlnRvEHZdTAVUgRbO1O5HB6p/gVWWts1KMn78O2XXwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mANFSsyWjh8mUkACD5WiPEQnDo4s30lJOW2+otj/Y7ZEa8fT0ebGswCT5X8TyCP0zHE7ygIlB9RViOt2HmQxaxK1y8QAMGwqghLI4tLjuWPmE9cnrSMpKXPd0u4BCMah13cBqjF08qr5Dc8AZaLlqBqvgNwOb8xCblDfg8WrZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWSZ8yTk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWSZ8yTk"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49068493267so12197595e9.1
        for <linux-input@vger.kernel.org>; Fri, 05 Jun 2026 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780650008; x=1781254808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvYMkemOQwz5yP3RpqOFqAyogviiWEUYAJqUf/vwsyI=;
        b=nWSZ8yTkSNZ+yuFfZ40jIQsgdFS4cmLhAEfu26J5CszS6qAtZ4VzCQRCx90OVHHLKo
         jPwPX6uG89Gw6NqmzonwBteqBPzUB6toApqs1lOeJgR7RUieF1uinXU60txgx5hTgh34
         f+KFgwa3bCgFOPDbP+IFfMC6JhIHEGvP8C027I4CV1+kTsXEVSouliHIeSoRGqyaQWhT
         9tULV12Yqqywu9pBzYtQNiWMpUOUkYeXlaENT+xHwV84NZ5gW95uV8LbpJMHwBr6YsdE
         k9lA11D7bEO/J8zofWlNOmKgfA+RZtWVUUMm9YbTtxiH5pOvZdtbzFwFmJgJDKH4bGBh
         Y6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780650008; x=1781254808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LvYMkemOQwz5yP3RpqOFqAyogviiWEUYAJqUf/vwsyI=;
        b=Zs1FdldXBGKifXz/1j17wHGHoh4IfkwAVQ/RTqefRPPrkei39UkSq+w3yjT6QUF+Su
         xgdNS6QuiwsBWDGcGW/z2tdg/tVX1JItzgio5NYaEpemodDgC6Xiz8YuD1PRZiJphDm5
         Ts+GAx7pSqsWbwC2dwmJdOXFwXMFBpTTv9fo3ba5okYZ8rF13FzZyxGPw+eizFevE/Mv
         H8sJ8gwHsMPO7WuZJGSm/Aijiw2aUNsySC/7qL99lPJZFvk7I+auSxZeRge5Dre/PNYv
         HYef6W4HrZ0VM06GAcUVGKE4sgwb+tZ6M4KCpk45yEZfuR0dn+V5cch9w3KX7W8F5d/a
         3CLA==
X-Forwarded-Encrypted: i=1; AFNElJ8ehoXnNe6nBTDAc8AKhZbIxevbPFwPXJ617aPUf0OifzCqqaCQJZ4eWNcpneP4GGxU4TUdhaUphCxpgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfS4TxLZkHuf9HMi5Moja616m5OGYkUGBE6RPyIscB98s3NGH9
	qYRRgunsjpaCMmUtBQcNEh/Kv6Iv2/vY5MQ2AlaZtvW/ezShztextVJr
X-Gm-Gg: Acq92OGY0XHBs+4BCzaBQTQFXmJeclj8yLbJwuDsziNz+RAke6iUkQkl0TObj6NtmGh
	OS4s4KuY/uCW0vZ3oiMG8zLRoiv81kQiCdnmrV5icMPMhGkzSxRq03+Xc421mcpAqySXp3kdKKE
	01mOHOJ8jlsquZuaa79mcdSlGL2JqiesSZNa2r5be2vxd0P7Qe6Y5eXST2St5KZE3rVNwTpBfn1
	vxpE/f2MZehWwGItSlpmptc5DuNkcFmHzILbu5OAGnGs6HNaTJsACEBfqckkrQ+0/jHg6KFVp+q
	1hzcr1PVsdvSOTG5vw9jKYUhDZUZ6yeTednvx45QjXbBUMHVXJ1/oub85MpY3ChwnUiO+o6OmBt
	zqBI5d7ZAqpEUmTCD6PdNIegoymKqNGKzArsPPy80r0qUkGoPcrLih9xwgG5a3VnF3nT1ucRS4Q
	4qWagOz1DCXh2mE8/Pyc4o9p2CmgOP/Fksdq4uM48Zgm9jJg==
X-Received: by 2002:a05:600c:46d2:b0:490:b645:3213 with SMTP id 5b1f17b1804b1-490c25f17ecmr38280535e9.19.1780650007075;
        Fri, 05 Jun 2026 02:00:07 -0700 (PDT)
Received: from foxbook (bfe246.neoplus.adsl.tpnet.pl. [83.28.42.246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm130344315e9.5.2026.06.05.02.00.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 Jun 2026 02:00:06 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:00:03 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Orlando Ulises Aguilar Rojas <orlandoulisesit@gmail.com>,
 linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
 benjamin.tissoires@redhat.com
Subject: Re: [REGRESSION] Sino Wealth 258a:002a keyboard enters stuck shift
 state on USB disconnect
Message-ID: <20260605110003.435619d2.michal.pecio@gmail.com>
In-Reply-To: <aiJvV_DEOOFcqTtZ@beelink>
References: <CAE=pYEp=RZCeRbAtweZ0_zkPr7cUZUu=uoDRkqko7xduVUMEKA@mail.gmail.com>
	<aiJvV_DEOOFcqTtZ@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jun 2026 09:03:42 +0200, Benjamin Tissoires wrote:
> > Trigger captured via udevadm monitor: when a separate Realtek
> > wireless mouse receiver fires unbind -> remove on the USB bus, the
> > Sino Wealth spurious mouse interface reacts to the hub topology
> > change, emits a short report, and the zero-fill behavior causes the
> > keyboard to output "!@#!@#" (Shift held).  
> 
> That is seriously wrong. It's not uncommon for keyboards to expose a
> mouse node when the support "macros" that you can configure in their
> firmware. That allows them to send button events, or even control the
> mouse.
> 
> That being said, if your keyboard reacts to USB events from other
> devices, then there is something seriously wrong in the firmware.
> 
> In any cases, the fix is not to revert the restored behavior, but to
> fix your bogus device.

It's practically impossible for a USB device to respond to disconnection
of another device, but I recall reports of disconnections apparently
causing corruption of other ongoing transactions. These should complete
with -EPIPE, -EPROTO or similar status then. Possibly the kernel or the
device doesn't handle things rigth.

Perhaps a packet trace from usbmon or Wireshark would help understand
what's going on.

> > Physically unplugging and replugging the
> > keyboard does not clear this state; a system reboot is required to
> > restore normal functionality.

When I disconnect a keyboard while holding the SHIFT key, it turns off.
Is there more to this bug than just failing to ignore bogus reports? 

Regards,
Michal
