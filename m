Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCFB2F39AB
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783208141; cv=none; b=qt93891eQg1OmvjuHheO2yiE5OOmZ1BmSVyjwiebotEVBW/9A1w7N0qEde8eo3rh1C5ifbxTbAiYJ091b+djOfp4zZePHqAH6PqDPbEA6IfXeed82MD+jUI8e3yGBl/ZWrKkl7y1XgimiuLkyRKkHqZExPaKWywIdUkRwT0s9KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783208141; c=relaxed/simple;
	bh=R4iYCCtDh/N9PUQT4zIlhD+NyxjSMHOpjNNiya639So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQcUst3FTUVh82eCW3cBO0mq+aoRmRYkVQJoWuUmRscH2kjIskltY8QqnyPMmsSpmeUNAdo3GtGjS2WRqxs6sOgtScQgkZDYTB7nu94O+wxl9aM2UtZmVQVySU85FFEsTtDRBxF0k1yucLrpFyHhSqFT2zvwnSkinUwQ2B0zFgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RilbJj0y; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RilbJj0y"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-380cda7f00cso1431261a91.0
        for <linux-input@vger.kernel.org>; Sat, 04 Jul 2026 16:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783208140; x=1783812940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wRx5zPwOOd2INJTzzY1Zg0ZOlJO5/PjlM0sjjwbLZDU=;
        b=RilbJj0y+vCq4GQkixYpE0nPwSiErv7nW0EK6+mIUBpoUP5SJxehW2QGXVArLj4/tR
         GSmnK+R9tmLXl+k9URSstkfvTQFiucKnaA1hVUrW3+OezLo7qxD5rXI8SOWSjKpIMPL1
         ZTS0lTNpa7g1F2qFAdLAIHyjp+20VkpzPlmhJXEF+yWiZkoXugq4Mk4S8EVWWD0e63G4
         DZ69GomueSd2g4yavM3nSk98kh27qZ9HKJRYSuvLH0+Wq511ckRWPSSgZtDAaCkOthPJ
         ap79Csy42h4PJ/7wlufBhEhy94uF7XLfZ7ETt7aLFd7gq4KASOv7sSt86UNnACeaqBNy
         OQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783208140; x=1783812940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRx5zPwOOd2INJTzzY1Zg0ZOlJO5/PjlM0sjjwbLZDU=;
        b=qKwACEzs9KZn+Pn0yIfdcWsFmBmdJQFX4Jn+KS7eQvIspczm+etnmtSnpcVT1himBM
         Cmm7W+k9yT7dLIHre4XhAyAbHLL2A+4VE/goM091lHLgu25QQKrZXRq4Hnb6KhWiHnZR
         l0MJGbnDBGDpV4dxd+8eW2uft5ZIjJkNzctTl8JKsVhO+UFy+2iIol25r7aQdI0QGa5c
         zwzD0oaMyBLUMTX5kisybBWJ64nITMZ2dIptcllg+Si6pJZDJpGgZocxItti+xoSnlIL
         OQWPqggeMO/VlhKKnblETF/Uf+EkBUu2E72WiSWhz9/JNSnFYLHXiYpxPr0/3Hbb+VhC
         cimg==
X-Gm-Message-State: AOJu0YyqaxDom+JlFxub2t/Y8BrKo9bXChBFFReJg0qObLAXzdrQb1Ix
	pjG14BhPZ1hEtOmirDKen5Fdeg0CLcXnYjPMNB0IDYIaiUvL0jba/kDe
X-Gm-Gg: AfdE7cmls8s5Un8duCh685e8plLdPCM4F7/h54w2Q6YtdKoGQ96RJPaCVPByTz51zC+
	cqlAyQF5KFRzpQUlqgiJT2k9n0xA4VCdMGKlzGUf1BAYwKATtaDx/D4YaiqBbvxULZgGecTc3+r
	SCmov8Z8Y2FpGHRNmGeEbp1fGkB92EpPVItZL07bf2ZLMV3RG/xLc890okH+jInw1JnsD5Xpskj
	wHvikoLE86IS7LYDNfJLu1u5GbmycjObrt97/ncq+5NxSc8JkVPWoyk9cZzRPYHQr75PNcAKYIU
	iK5CRbQ2fx4bYZ9obJaPMcf7b5gomM8RPhNVslZH2nfaPMb7SfWwBwJOcNE0xaUjb8uVf5sPYYf
	G/dnw69IlXbN/2Gz8uwhgPg1sAkC3EakWnej6nJdC5AWTRbkVOTQcnl3ah+geKYGtZxm+A1XGA2
	a5cz5LVVV+MIuHnt7/nl7civB2d+t+yauAgxeG00jfbSUnGmSnLYtvmw==
X-Received: by 2002:a17:90b:3c91:b0:375:2a38:1d40 with SMTP id 98e67ed59e1d1-382934ec0c9mr4526023a91.20.1783208139715;
        Sat, 04 Jul 2026 16:35:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3f90:534a:314e:e11d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd221bsm37173682eec.22.2026.07.04.16.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 16:35:39 -0700 (PDT)
Date: Sat, 4 Jul 2026 16:35:36 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ims-pcu - add missing MODULE_DEVICE_TABLE()
Message-ID: <akmYw5-S5DY8CGky@google.com>
References: <20260704151730.42772-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704151730.42772-1-pengpeng@iscas.ac.cn>

On Sat, Jul 04, 2026 at 11:17:30PM +0800, Pengpeng Hou wrote:
> The driver has a match table for the usb bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Applied, thank you.

-- 
Dmitry
