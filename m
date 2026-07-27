Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AE31A8F97
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785131570; cv=none; b=HD9MZZUOPO9gZ46mZ7MNbVfnPB1i6DVakG0Mav6Z5ZJAfeelozyjb9eLcz9yG4wc4whBsaOKVT1KuHZUbgaXkc+xzcYchJtEnX4kmFDv0ADp4Pqg+BtL0YFF6FpZG1ITKevsuNf8PaIAFdsemhaDNKoE0sGYX4ey26IIEjXco2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785131570; c=relaxed/simple;
	bh=/qBjlPleAnxJ6DejuLJXEvSFMsQQfMBH7TLOv7r3uz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR90mMYPFXyWdWt2e1OOfBBq2H02BiUZRLAelL4Tbq15IoTiylxrpD5GhvCS9+/2B+T2a+yWjFVOHigN6cpC2bwO/6zVX2kuRZhgKxxbD37gswgfSbXJf4/lBmd8/5O2nY9aQMQGVJ5eV+eH9SgEo/JSpyIIGFIau8c1AZtdnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rmMlEMYQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmMlEMYQ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cfff5f88dbso3065685ad.3
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785131569; x=1785736369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hh+bRoGI9pU3WBcFYDGV8CJsvXt3xxUVeBerNliMbOY=;
        b=rmMlEMYQA/175VPlMP5guG3sidhHF3W8hEJIzdMY1OEuv5agJ7a57e/rYEOFiSsG+q
         xZj+uPutTknysXk7YOJlKMm2gzHLu3xVqf3kcNE0rAz06pgRfZMO5bQ1NyhfyyGirsOM
         aMwhsdcvOp/8DowqTwaJxTXPdCUgvpi0mdflGshqj60BI2MZOU/sOuTxVS+Xce1Qwnyk
         jMWr6+vnuqUVITEWwLZODJTwGY0iJr7Osn4TNZqKesz8M2iPieYHlQGJXLcraMh7APN5
         Xu4hm2Wn/q2Dbl8jbziH/Uwl9WK2RGb0IIKbb5YXi4FHU1jL+LVVTgOJbvSovtiQqVmm
         Z7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785131569; x=1785736369;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hh+bRoGI9pU3WBcFYDGV8CJsvXt3xxUVeBerNliMbOY=;
        b=dgMAz7rjrpdOiWZCybbXk+80RS80x/JIpCU8d30OWqfgpc3bsYSv8ZrdtbXai3SH9r
         L0vaVZwC0X7SALYCny9d3QimjcaQtaxMj21X4KyCgAIUterB9H0cOG/ByGugAVuV1aja
         bpMHDQ0QuVT71kbqBA/ZZf63DyGs7dsdHjnWoZXlXHzTlKrRoICe0yty+/FwgFFI9FUv
         4uRgC35JzjQJ011aXaLSGmW0+eDPF/qi4BpsGIKcuPxXSFNluDA0ABysYptLeeB/PEm+
         RnewXDh94eKz8RglTHs0hc7u9M9/ZarLbbY2f/tJQ9og0Vkj9SyzVGyNjHeZW99C2s04
         NNnw==
X-Gm-Message-State: AOJu0YwPSol/hWOWotNQb1D+4+5NElJhEij//Ia/gjEKj/V6giBBCKrD
	8hVBGsxGqCLy25lRCiffxMog5KMR3vqrA6xr1EvxXJHI/g8bbDaSslSIL3YCtQ==
X-Gm-Gg: AR+sD12XAkKRb0vaIAIVLUN+fgnUIeJpGVMmYa2gXJaCzyLZjRSWFWdxuS+nUdP100x
	86dUrZk8SROtPO1VAtcfoBFdOpgdoRQcTJDVWM7fH9iULl0vByFy+vzo8ygn1vkGXac+URV+1m2
	2IWziZF3NgyO6yqBu3NbWhizwfXUZEXwY9kCQCvyaPq/ViCQ1GOODvP1B1CoQR6AnoH1ccShYoU
	RqezlTk8gK3FT+OkZ5KhUvk6VIHE/hcvpeX6HeK3YPaqMy/WJxa3L3v3BlCp1xQxi2AyUYflmSl
	Nh9e/6xBmqPREM6VQHxq5p/FcK9AirM9YGnrwipiFnzhCwQspfHWVooEFVEEKi4k0/VUSqwSC3K
	6cjfhg5Fb4GEujNbw5pHF5qv1G2hxsBx9vwS0X54yExsEnkYYhWxpE8J6xjYpDSnFHCTkYZ8kKi
	Y2rBojOhwcIMg3d1TQmVJMqzS9EYddnCWCyxen4lQMq40=
X-Received: by 2002:a17:903:244c:b0:2cf:477f:57c5 with SMTP id d9443c01a7336-2cfde67c4d2mr67692215ad.1.1785131568658;
        Sun, 26 Jul 2026 22:52:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:fc2f:1878:e714:ef41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548efesm28720960eec.14.2026.07.26.22.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 22:52:47 -0700 (PDT)
Date: Sun, 26 Jul 2026 22:52:44 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH 2/4] Input: psmouse - clean up locking around
 disable_work_sync()
Message-ID: <ambxqW5K6ZfnYaBu@google.com>
References: <20260727050803.1269941-1-dmitry.torokhov@gmail.com>
 <20260727050803.1269941-2-dmitry.torokhov@gmail.com>
 <20260727053254.EE6B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727053254.EE6B71F000E9@smtp.kernel.org>

On Mon, Jul 27, 2026 at 05:32:54AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Moving disable_work_sync() to the top of psmouse_disconnect() breaks the early-abort synchronization in psmouse_resync(), causing delays and queuing stray reconnect events.
> --

This is incorrect analysis. Disconnect may happen a millisecond earlier
or millisecond later, and setting PSMOUSE_CMD_MODE first would not
change anything. We just have to deal with such scenario.

Thanks.

-- 
Dmitry
