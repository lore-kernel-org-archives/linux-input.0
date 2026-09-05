Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54B4370D71
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601053; cv=none; b=bYtLYS4XWQZUJu4YcpBt/Cs2JT9Kk+oNp5vdHEmEH5Zi0NEuUiSo9rXa66IN+63ZCMkXesTom5WCHP8Fk09FKkBPv9EeLyH5mWyLWlPHFgRmg6egN63hh2xgDYOHkdwLnO3eyMi4OKTg6gKekfIusRNqQl2pbxVd11uDhJ4x+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601053; c=relaxed/simple;
	bh=ezr4BNZLWb6MT7EgMXHLkLvSrE/gd0KLEILyGK6/znQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV3UAFd5QjlBqYj2hITCAvYDe2ovLNQDXPjY/bi8trXFyfjJn5CnzLWvfSoyD1IpSF0HO9WlOa8o48OHMP+y7V54FnrFvycvbRyPkcTFHN3EE39m16HnKOSRfwOymKixauraLrxuGRZBqbEZbGfILLNFCHD47y6BN/w+aKZL5kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjxdkRk1; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjxdkRk1"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1c3d79b9bso1452102a12.3
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 02:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601051; x=1789205851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qIk+EbZ1mbotjHlbU5KOJAFSs4jlrNY2j9DG/30vshg=;
        b=hjxdkRk1rYsDF2Z2Xz7i+HMiA6qcpVdLGu4qy3MAVYnrTuTsaqy47IvcF1HJIo2pKx
         Qc9WRhZMRVRf7P6emHQ1FIqnb5iGq8gUCgk8pZfJWCoxkPoaqYEDzEGacs3+906zyTir
         tglM3DUVSgrqdYRKPMEYwztinxZPcepwRwxnEOxuKPQ+SLTWxB2GC0RzKWGdxV/gln5z
         oO1Ou6Lzem+3x0vK7i/nGiOwj07V1becodaPaomEaHd6KN74kwf7M/znWr9WkLHj+xT6
         jvve+Of2eSu8eoWy5gd1bhbEOXMtv5QxxGGHbRqnPTHk19n9IH6pQ7D7zw1DZ2UFrHGY
         43Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601051; x=1789205851;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qIk+EbZ1mbotjHlbU5KOJAFSs4jlrNY2j9DG/30vshg=;
        b=pEIWhLB/9+Kz1MrjLeF2U8G8UG/39oIGVKHR8vZ6ZHcU+wXEnlSKTLgl+cq6+lY6qE
         cQH08aXv3DjRZLnhqu8I/NFrq74bWjYlPyYyTSCv7tVD0DZXo4PuJeuvNhvMHV/c/MQO
         RefY59+pNx6lXFCZ6qbhoChMJaWKwHjBhFx7FuqMReYW9sIIXTA0lgWea1HVEHeNRT3W
         XAwlryt8EDaXPrzK94qt2Bordpvr/iB3kqIuHCR+9E7g+E4KmVthk68/gKK69jCOvk/c
         mdXk7CV3wJI+H6xvLr1MVUpNOz6Regqe0ktnrZ1niRmYpVXnFBAfxF2r/y16MV8mDdbc
         YEMQ==
X-Gm-Message-State: AFuF++k6M9XCqaqPMCMZrArlgw0CwzgLyROX83jdaLkZKw6NTHEM3MSR
	UffMn3/YCRbfKLDO5S1ifGPRX0upHzf5uzOXMNvLxd3nlFDI6wYDnyJ0
X-Gm-Gg: AYBFou2fRBO0TrbPATw3dLHoWyrJSwXNiazOhIUBPIDHQT8xsu2tTxLiswQEUm+1dd6
	WoGbIYBGQQTovpNc4sl347RKnq9QVRdp8Ld65G9JSFlLuvpA/yJpaQKNspN9j60d8oyq7cnnHGO
	Tvjgai01OkUPrufTGIb6e1bsI7L6+ET3wvlJIR78xN0U9C6nxniBRXk44IzjJb6aolzKUrNEUMR
	H8Pus2UvDDIRvUtd0fN3Lkd2x7yiAdALRn1AswLHI43OZ2Q0imgC2HJXdILGOcyGBf0tNTu1qQ+
	JbQyylAW6nzDuRWAXqapN77KXnAN5f8nJsvOM11S5N51I1OsWdxvdafzfUxqXGSsNd/D5146Sx6
	wiSIq4tgMnvlgrApiqVN/Lk0oIgAG8nvkffztFQz0BAF3XufysOq62LNeydR2ZotYqk/BSGP3J0
	93ccgB70zVfBKCn7izAtz8/CBf0qxkatK4GqVFSBAKGd+w/8c+v8Hr3XtrY/lQ+hoe0C1gHyIkE
	/MPwxySzXWs++LL00QLG/csLhfbiQ==
X-Received: by 2002:a05:6a21:3397:b0:3bf:63af:855 with SMTP id adf61e73a8af0-3da39d18db4mr19264229637.1.1788601050951;
        Sat, 05 Sep 2026 02:37:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ff40:39da:76d2:2e7d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324356931sm18718525c88.4.2026.09.05.02.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:37:29 -0700 (PDT)
Date: Sat, 5 Sep 2026 02:37:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhian Liang <liangzhan5dev@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: tca8418_keypad -  Add devm cleanup to disable
 interrupts on unload
Message-ID: <apvip-xz2GFH96uU@google.com>
References: <20260903192942.21906-1-liangzhan5dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903192942.21906-1-liangzhan5dev@gmail.com>

Hi Zhian,

On Fri, Sep 04, 2026 at 03:29:41AM +0800, Zhian Liang wrote:
> tca8418_configure() enables TCA8418 interrupts by writing the CFG
> register.  If input_register_device() fails afterwards, probe returns
> an error and devres releases the IRQ handler, but the hardware is
> left with interrupts still enabled.

What kind of issues does it cause?

Thanks.

-- 
Dmitry
