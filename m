Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47105346A11
	for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790423568; cv=none; b=guS283OWL11zp5KWMmNt7uiDgrpVgnV5uFbLHw1elozV9qppSnTuP94ld67MCe5hnvkj79fS/imNR0FWhPDu5rfs0JksQiOMDByciwIEmPe5qZlDK2QqGCdXCx2Yge515kyqDxdkWwVTRVE4/GjlOv42BAerKtGNbRJlisgKd3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790423568; c=relaxed/simple;
	bh=LNGo9Lk6YmczPhmSAhIOAoe3rGeQtCB78blB4lGK4ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kylZY8kxu6FF362FahgoPZvBtGkSIRST3F6RWMhbYgtpFU7FnFaqh91KCPbBegXuPvMq4ifYkN7g1yHFAU8G+NqhX2yL81RT4RMQeVE3a+IQDK4M4LuOYN/JD4hHi8JoN+gnjrRlQykgtnc3DglNN28TJXB4QP5d71G8/6ac3xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUa2i5PO; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUa2i5PO"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aaf10bf094so1748747a12.2
        for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 04:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790423565; x=1791028365; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jOZJQtJF+6fvMtqVqH7Ln6MjEBTAkHYNteQQULMHp44=;
        b=mUa2i5POAb3aQkstDAzP2yPAI/sWYdXK8hXR7bou4CcpG+EKqTVD6hiJ+CPNwudPbe
         qQgdrP8fXTfNdthd8MceEm0Y59d+QsTnmFd2Y5UNI4seX425tA++2l2E4r/urO4Rss2U
         JP+RwZRrfQh9L2fjm+80kIL0Q6q9tXJgSX4+yCCLeDQlqKrRGm6sKVYlGgwsSoOrsOqP
         DuxlzNMh51sHRL/6BLobNj3rYvyrbnehJ1eboUXjVK0BVYoWVneysqGnFfouMuC9OfWd
         6wEZlnL618uYNo9gufrkznMXLOzmCWeyLWqBCtRONonwcS0zx+k+SHsqstmDfh3IKxV0
         BFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790423565; x=1791028365;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jOZJQtJF+6fvMtqVqH7Ln6MjEBTAkHYNteQQULMHp44=;
        b=bVHeC6j9LXXG2LG9UWnasUjgPVsqnx7vdHvr4czHRaqe/3gSJeCH8rRWoNg/V3Glf5
         LUm8r8IQzaHCIjXBySqAksxHRjVxA9a5+Be5gZWFDFYCNxptSBUEyHh/8dDiAS08FSg1
         iKJWYl2Pz9do639/bqhHNpCls37k6TM991shQDzNJiusBP3BAmOqO5wVolE/tZas5QNX
         Ouer85I5NRgJe1MheC6VM5H1lDxOZcQEzrD2mshQFMx70lVx0sQybSDZWHtj7qYzoGcZ
         ynDMo4y8jiDT24abAGSnX6Vka+d/36s8IoM64uZiy8XbGWeIANhU97r58j6fTxVU68IO
         U6pw==
X-Forwarded-Encrypted: i=1; AKwUvByLPuhlJSyNp3A53BVgkmnaS34AHtQ4a0zldgOa4l2YCZwPR62Iuhs6wuPtDalFMhFRxlbKYMD8H3M3zQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lSbSZYxzsRh0VGVKQER1CRUcuz+HCYunQV5AiGeZbLFVATso1Z
	d4X4k9Wc/dmkZtdGd4BXo1qn22d9Ycmym87cgxkixLHinpGB/b+962NvVCIe7p50RkU=
X-Gm-Gg: AYBFou3YTDFBsxqBpRRvh358sM5ugGkj/wtGOpOLY8vPjb1xTfmPc0PeiDQyjY4ozWI
	m27/Skgv/wKDc5h9bxpWmOWup1aOpDl1xzUkmb+QzYTE0JLwsFFvihZ5nfoPZdwCUIBgYf+/o7o
	tFOen7VpQdxrOhV0vw4z3WA/BtgdctgFPjBpOu5K3LnJig5eNmEAfa2wntOltTTslsCw+4wdnHQ
	swhIzp9js9nVqr0AX1lx4XA9Wyc73YR/WW+hDng/XqLQO34glDVEXngeDtbRWeM+dpcuc3Zsa1N
	csMVTJjMZYNODpv/zMgxDA53Xh0RcPwMKOU5Cq1cdvT6vdyXn6NH+jPgV4WRxZS89/82zJFAUgW
	74XlqYRRGrqBt7OSOMX2rl6PRiyyl9NEg4GpQvWhKRJPvVAeVNT34XWxumPnzisVsJIeXQZ9kle
	CHcI8X1gDxPCHFhbdS5n7eLBtbsKJs/sbvMznNXv1XFOXCmL/Ft2mDBh/2Fky8r18TPpmc8EIus
	iY3VMy5eZ74eIUZusdw3NouLmB2gcQ+49bnE1nbcEc=
X-Received: by 2002:a05:6402:21d8:b0:6aa:734b:1a2e with SMTP id 4fb4d7f45d1cf-6aac9090952mr6404194a12.40.1790423565326;
        Sat, 26 Sep 2026 04:52:45 -0700 (PDT)
Received: from fedora.localnet (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ab5be57b13sm414448a12.33.2026.09.26.04.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 04:52:42 -0700 (PDT)
From: Erik =?UTF-8?B?SMOla2Fuc3Nvbg==?= <erikhakan@gmail.com>
To: Roman Stingler <roman.stingler@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, johannes.goede@oss.qualcomm.com
Cc: Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
 Filipe Lains <lains@riseup.net>, Bastien Nocera <hadess@hadess.net>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject:
 Re: [PATCH] HID: logitech-hidpp: do not overwrite the device's hi-res wheel
 mode
Date: Sat, 26 Sep 2026 13:52:40 +0200
Message-ID: <407JHeAkQjaIVOP3-Y7zGg@gmail.com>
In-Reply-To: <9acaeb9e-551d-474a-9c3e-9be5f667297f@oss.qualcomm.com>
References:
 <20260923181203.422097-1-roman.stingler@gmail.com>
 <9acaeb9e-551d-474a-9c3e-9be5f667297f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi!

I just wanted to point out that the original patch has been reverted due the 
issues caused so this patch can't be applied currently, but I'm working on a 
new approach that I hope will fix everything.

On Friday, 25 September 2026 11:50:59 Central European Summer Time 
johannes.goede@oss.qualcomm.com wrote:
> So in so far as this is a solution at all, it really should be
> limited to Bolt devices only. Although I wonder what switching
> Bolt devices to the hidpp driver wins us after this patch?
> Do they still gain any meaningful functionality from the switch
> to the hidpp driver?

Mainly it's getting device information such as battery and connection status, 
but also, theoretically supporting multiple Bolt devices that have different 
capabilities and settings. E.g. two different mice, one with high resolution, 
one without, or two identical mice but one with invert enabled and one 
without, etc. Unlikely scenarios, but at least theoretically possible.
And same for keyboards, it enables separation by device of any Logitech-
proprietary signals coming through the receiver, as well as optionally e.g. 
media keys and brightness, etc.

Cheers
Erik



