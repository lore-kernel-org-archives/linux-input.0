Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7543E410E
	for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790421195; cv=none; b=e4AKV+xRDzdqw+ZXtWklI58sa8CbcnRMrh8Qe/zAKiGgvk9U+hKIswbb0vrWUWJzEkAQdn46eX37k8jo/JnnAWDzeJpMdeahLSXB6wwKOD3RMfx2gvFTJcWRfoIMHJZzvA5owCEaETNhzSOIOGNW9D1VdgKFQmm7Jvd8zbdDN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790421195; c=relaxed/simple;
	bh=DLgC3aps3XoDhJw1Zkr5LjA4E7cGsw40nQ05koVXezU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWUTyjY+4i9sEjz3qqcUtT917dRGgEx8UTXu6HWMXyPigHlLP625wvEVmWvgHTnUqjWnp/yIR/7GB+wp7lETtET+fJMLedy96Gt8fHdGxbfaFo+iJHNJBjVk3ZptPsWbbiAaQaZpMq68BoVQcA2rBMPpY2msglhv+QLbKd3oUS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROKJgTLX; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROKJgTLX"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a8038a9f10so2233001a12.1
        for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790421192; x=1791025992; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SV0LRzTvQ8p2vwhmqhzurHNmTdPATy7R4StnDd5yBSM=;
        b=ROKJgTLXymsWgzJl5Ashi+MQIs7EI8mBXazssB5N7Vd52sxpM1ft8MPerTy97i0g2R
         07qCC3Kf1mrO93cLwqh2IJxvxtpXXwaVazKrnFiN4UoQbVT4DV5H8JTud5UZHuferJJ5
         SiEp9EWcO5M/XkX7IZULIKfQHGffj98FkiXg1TxuHgQAi7eOLfi5rgQpzgsMqpP/k4zf
         mYcfs/Ev0HLKSgArAg9yENlDjCx6rnl/GK5zIvDeQQYd0PdZifv3R1e2SUFAFPLuRPcj
         YvLJg+AamFBsFykvh3Bg6Fq5oD3S0YcUGV53tE7UeRrGlYuH96jxvzY2Y3s0mT4eH/o8
         Kvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790421192; x=1791025992;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SV0LRzTvQ8p2vwhmqhzurHNmTdPATy7R4StnDd5yBSM=;
        b=COr4kGpuLyzwxqDKA32n6IKWBEV9HxU1Mil4O+iajqOh/AB89OgdevBckH0xdbsyx2
         TbI69rXILwYuCWiTYRvXzpL5pM5xr1YwQJlxLTkGTpcn5b/yVvXpvnu38I669XiavMTI
         bxVviBT59SXxDYEaX4JprfJnXN3+d5KhS0aZ/yo2QdAWUERHfrRX87D086zEEYsOOOQg
         l7d/0NbSQbQaoBttps3BF6iDWZ8Ay8oNGV5fll/S2zQbN3vd627shjrb+Fb/nCbc3Y72
         n+RT8c3qne0kT8gMzBIJ6jtmf9VnGknBtSVLNNrlt4cuVNwTnhZDPVhetmENzoGthidA
         oCPg==
X-Forwarded-Encrypted: i=1; AKwUvBzOALlfZcBWt1jqbkEe9Ae9V7PXhkpUrg1DsWJcBAEDAFSwT33QlgmigfvQikSOQugAKaVpPJmiBrDXlw==@vger.kernel.org
X-Gm-Message-State: AFuF++l+X5Wzo8spmAWjAtUCHtTVYvqf1aPPsn4SI7KECzkZDnsrLekr
	0oZHeuYy8zO29+0g4vyPM1H5uAZMcOg8ZG6g6/PBYNE8veWgdtBLuJFk
X-Gm-Gg: AYBFou1N8jZQGeDNQTKs6D2E2P5wL2gNAKSstdupznECL3jd4xlaa5VcYESj/VvyKzW
	+swzKdiR/WzSIX4m8GaCUZp6BOsMl8H6GWkIHfoubWLqtZ88ASX1N6FAuEU88j2QDV4qWTTpKQW
	K4rwyHmNx9aAfQLZfcdI1c0KnKigNGDLfHHEhCGanxnm2nMiRt85YvgaTQeQtr08ZZlUqo9J3ue
	5HCIr8/tzSbs1FJIAROh8WQ10YzdOJ1YBtqMJN44sD96dZDKHoDBfZX6lmGhSampNIlwonRO1Fi
	8kRSC/YrW6In2cTZ77TuOKWkil2i4TZI7PaG8dMxoVu6Q2ibD9/Xp80N1spKFm+13yP552F24Mk
	HXQ2/U7nFJ6m12FQNCs1mORzV1melbffjqNMxYCu7BgI3ga0tZvrI24Jvh/PcIpC/atB63TYwXS
	b/gpddLpIzACO4iRhjyuD3gLVt55/RyprnCycFVI9P4+ZmsnfR9ZTm3ZnzqKgDMIEuysTIERhSC
	Lyg6Wo4J4PM6yHshsI8x/cP5Y2IA15x/njMv3x92Uo=
X-Received: by 2002:a05:6402:52c9:b0:6a9:984b:4c71 with SMTP id 4fb4d7f45d1cf-6aac90dca01mr6954387a12.33.1790421191787;
        Sat, 26 Sep 2026 04:13:11 -0700 (PDT)
Received: from fedora.localnet (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5dd5e49sm1928651a12.19.2026.09.26.04.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 04:13:11 -0700 (PDT)
From: Erik =?UTF-8?B?SMOla2Fuc3Nvbg==?= <erikhakan@gmail.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Filipe =?UTF-8?B?TGHDrW5z?= <lains@riseup.net>,
 Bastien Nocera <hadess@hadess.net>, Rafael Passos <rafael@rcpassos.me>,
 =?UTF-8?B?R3LDqWdvaXJl?= Stein <greyxor@protonmail.com>,
 Alexey Zagorodnikov <xglooom@gmail.com>,
 Roman Stingler <roman.stingler@gmail.com>,
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
 =?UTF-8?B?S2F0ZcWZaW5hIE1lZHbEm2RvdsOh?= <k8ie@mcld.eu>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: logitech-hidpp: fix Bolt hi-res wheel handling
Date: Sat, 26 Sep 2026 13:13:09 +0200
Message-ID: <2UD2rmaWS9W0wgq6AdNLxw@gmail.com>
In-Reply-To: <6UWkRWWaSvGIWNWwY_bPDw@natalenko.name>
References:
 <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
 <r8QjhQUkS86zOaJsxE4nUw@gmail.com> <6UWkRWWaSvGIWNWwY_bPDw@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi!

On Thursday, 24 September 2026 23:57:05 Central European Summer Time Oleksandr 
Natalenko wrote:

> No idea TBH. The mouse is this one:
> 
> https://www.logitech.com/en-us/shop/p/mx-master-4
> 
> I haven't seen proximity mentioned anywhere is specs. But I can try to sniff
> for these events, just let me know how.

Great, thanks, we can do some tshark capture then. That's what I did locally. 

1. First, in Solaar, make sure diversion is off.

2. Then, find what bus and device your mouse is on:

lsusb -d 046d:c548

It should give an answer like this:
Bus 005 Device 007: ID 046d:c548 Logitech, Inc. Logi Bolt Receiver

3. And from there you get bus=5 and device=7, so do a tshark capture:
sudo tshark -i usbmon5 -Y 'usb.device_address == 7 && usb.urb_type == 0x43 && 
usb.transfer_type == 0x01 && usb.data_len > 0' -x

This should output ALL incoming data, i.e. including every little mouse 
movement, so it will be noisy.
So try to keep the mouse stationary to minimize noise and try to only touch 
the thumbwheel. Both hovering your finger very close but not quite touching, 
then a single tap, and finally just holding your finger still on the wheel.

I saw some information online though that the MX Master 4 supports touch, but 
not tap or proximity, so presumably we'll only get one of the three.

4. Please also give me the output of:
sudo lsusb -v -d 046d:c548 | grep -E 'bInterfaceNumber|bEndpointAddress'
It should list the interfaces on the Bolt receiver, which should be the two 
native HID interfaces and the HID++ interface that I think is for devices with 
touchpads.

5. If you want, you can try the same when the Solaar Divert is set to on as 
well, that would give confirmation that the mouse follows the protocol found 
online.

If you get a lot of data that you don't want to send on the LKML you can just 
send it directly to me if you want :) 

Cheers!
Erik




