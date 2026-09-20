Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431D40860D
	for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789903118; cv=none; b=hyxNh/gX4MKGbCIiruyj9MY08SwQFRWDWkOxWG37WpIz6aSrb3xjbMarjjpc2b3sd8Zt2hxg/7vVwUWMkJ2yLiOdLattMLMYBQnlr+rfkmm4Awq7NC2sp8SIjHnIrvsqoikcklmtRbes5+ICDR/95mqGzk5NSsfv9w1PXwXaf6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789903118; c=relaxed/simple;
	bh=Li3iwEnZ2fbtAyYIxOexzKfR2N+sr+eqTzPVvE8agJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jzqt+eXAz9yizxdHpEOSDk0D4M+Hji2TYZmgeoo3cTqgL2j3tQ4K0HGweCak1WvKLeByACdVo1/AeSyJtQzoDY8S/piDWhHbQyjhhgJ86jyFPzyqo3xEl2NNxuP0Lrrstht6wIAnSTtIPv1oID2CeEK0uvHEUR2G74D+fg9GhFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlRLvX4S; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlRLvX4S"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4d04d73b8so1758843a12.1
        for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 04:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789903112; x=1790507912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TM04cPfd8SMnOH7M401IKOVKCmgjut2CF74wmQKCKU4=;
        b=YlRLvX4SdYkIh6+cHrdlZJDxSsKxeMMtbytVy+cZiyy/Jq1G/n+kXpl5025ICpC69U
         GLnBHuizZa0uFhZn0Ee9bHpWMq+RDvD5hUNB30A839mddlqXexG+VHp2apvxaRb8tOK+
         XUGM+u1naXngRFbEmGm9NJb9qFTf3ssXUAfddUN/X2Nm6J2Ofi5eKsfJwpIlGG6iiB/T
         19vM8/rLfJWnBuDDOoQS71yxaJPIW5Ly0eS0hQR/MUr9GpsJTwPEfMw6M1uttk5M823D
         +harcnbnFCNj2twQGjNNBxQ5L8MOpfB0PW0Fj3UWkxxNYqPjSfAJ9PBJvT9mDba92DBT
         OZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789903112; x=1790507912;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TM04cPfd8SMnOH7M401IKOVKCmgjut2CF74wmQKCKU4=;
        b=xjpLHGB32DSFYMySzEL561yfriVTifR/G8SrO/7QU0Ms4FT2SwHBXNuW+uVxGYVfxW
         zrKDSWSSwor0zpZPzae6nLlhCZptaVrqsRHFk2YQlG6OliQZQ0ZTS0gVpC2YT7Pg3m/H
         1obAx78+Mx3LNy/RKSew2mhDzQ75xSx5g6UVq7tBZ2HDuHoEkycEpV5+FT7A/2VwLHg9
         MkSmkbl3E1wRU92794zRPKmAMNxjXEPv1AVsaX9jMBScltV2M8UY9MmrhYLVvkfLaXS8
         Eg+j7bq5T9UMk43mu2bNWg4NKRu5OCnW5W30FhouZU9U70UIeGI+xPrSI9erBlQ9NXui
         GqOw==
X-Gm-Message-State: AFuF++nX879vcvqsHVXEkBIbfXmorwFtHahxcivGwwybG0Gj76qfXi6p
	PhHn/hgJ+OOtYQ0B7Ze3ZrhFIu/OihxcnjsdERoLzLcg7VdMKhf9Lff8n0BCJQ==
X-Gm-Gg: AYBFou3oSyR7ktMq//i7DkCtmYUqzBdcJx+FMWY+HI6m41MvTDS1LHL7bQyuZzuHj8/
	NMaCwEAPn8xpxOtT17rVi7Yc5rUAEvqzV6T5gSdyL5KhUZkORytKSyS3cy7QoqCkgPWZO5WARKw
	m8LXZfGmozfDy+mpkeyoVdarGqgkpARkA3DY4TmmYhSUjBPiFkPJfLqeyFZA20E81EJ0NwwJ+bK
	o8Q9kxOCn/2Btv6UFo8irPhg4EPsUu8HiWYiOmZu9OI/3rEq9ak5iYNq1QeGTXF88JoWlf1pRQ4
	74ZaR9AmWCU0RtHTq7Q/lyTEVSWi+PQGnrbGUoYJjby5I0ls65PSJ4konk2Qao0JIcC165SHtqo
	Pux6pFh6xROMFff8eZsgcR6niGZjUBpmpsj+vW3Qh7phFJY9f1ggu4U9coB+3R3lCiIJFMts6rc
	Smols/JmF5NM9HoK99b3A7EtSULriqL3QlhAWArC5Z0huO3cGmtbzUjKxHDHLh1vKmUXVIPEcL3
	14IfG/RgiXIvsDbKkvLqoCQaIZz51qC7hI=
X-Received: by 2002:a05:6a20:cf86:b0:3dd:a006:ed97 with SMTP id adf61e73a8af0-3dda006edd9mr7285207637.45.1789903111574;
        Sun, 20 Sep 2026 04:18:31 -0700 (PDT)
Received: from eggarch ([2409:40c4:136:c0b:7911:68d7:f26b:cf67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3311a6e5sm11681230eec.7.2026.09.20.04.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 04:18:31 -0700 (PDT)
Date: Sun, 20 Sep 2026 16:48:25 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: heiko.brey@gmx.de
Cc: linux-input@vger.kernel.org
Subject: Re: i8042: Fujitsu LIFEBOOK U7410 needs i8042.nomux (keyboard and
 touchpad dead)
Message-ID: <aq--Vu_IEDwSPOBp@eggarch>
References: <89f36f3f5e4c2d07b9ff72bc0b355875c336e498.camel@gmx.de>
 <aq7SdGsoL82CFBZp@eggarch>
 <d005d3212d7018fda5aa2d2ab29231fd4c573f3a.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d005d3212d7018fda5aa2d2ab29231fd4c573f3a.camel@gmx.de>

On Sun, Sep 20, 2026 at 10:03:39AM +0200, Heiko Brey wrote:
> Hi Lovekesh,
> 
> thanks for the quick reply.
> 
> I tested with only i8042.nomux=1 (without i8042.reset). Keyboard and
> touchpad work on both a warm reboot and a cold boot, so the reset
> parameter is not needed.
> 
> /proc/cmdline during the test:
>   BOOT_IMAGE=/boot/vmlinuz-7.0.0-31-generic ... ro quiet splash
> i8042.nomux=1
> 
> Happy to test a patch on this machine once you have one.
Great! I'll just submit the patch upstream directly within the hour.
You could test it and reply with a Tested-by tag on it.

Regards,
Lovekesh
