Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795742188;
	b=dfLufYQMnRZx+nTa6Y1Zcz5yoyR+jUie2iOQHr3eo3+1grmLt5S5fkwndsk7C2OeZeS1
	 EKMzKHXjdaCLwhbHzDw8OlmXNQ3Byq02v2n31B2034hy6EO8soiaQjzgVd0d2I0S2ZJxI
	 DjGO1ze45erb1fhITelNekDfcsk6Apbwzv0lOnKT65VWeTKoy//5b60lStT/7h4q04+qS
	 Oydc98WNwregr69cl5AVjcsEWefuYcUZCtjhZPXkfdGazFdQZcXLV5a8mkZFP4xGQ7Nu9
	 TaxxRk+SW1ceKYyhYJLxF5f5YWgRE74hhlkol0BnLUxvYScarOhvC7/KbkVod+PAqcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=oPod1KuFvBWGJsle2l5lTHqLGq3m5KHrsHkxQ2HP+ns=;
	b=Jfs5SmEcT5xV9dGGmlbE2fJS41nH7xfrmnsLw7Sah4Dr0WaytiPEn++iYSYr/IqG44/R
	 3amIOpUAbsfdxKY2rDRQ+Kf46eFWWd4LWSsnvbJY5klwahTj2JLLYnNpbkEHrq9Vo1zyH
	 Pbnajc2NGwnKJtBeYIUdtZlTk13FCby00KyQuLGREwizZ6VYwsHg6a2dYcRmR66Hyulm/
	 cdznpjiN64Y8QlLU/elSuFHIxRQb6iIL8WNW18tZtAlnNAaWOFicjLy0n1w1NMUq49Rsa
	 mGRpRnv+E5M8c3x7DxzdQ4FyW/1f0OOCijYtOd2eUmkGuMcrWJfhtWR1Ui5yMfUsn3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yjACiQmb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AAA606A324
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 01:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33AAA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yjACiQmb
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15dd124bbe7so10960723c88.1
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 17:16:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795742187; cv=none;
        d=google.com; s=arc-20260327;
        b=VmuYTVzgA6SIT0Ab+/+lXDB38VVnGTxQwXRyEARNdMnu7Yxl2SVPWkyslAd+erHuvY
         e5pVMYUt1q2vErEVMT8/Rxp1jTU/2+/LvhAqQYYFKCJVCgfcYYpKEUtCQbLPUrkS4E7B
         cbwsoYXA3c8bsbuD4/bIy2fpCeqTDK5jOkvmcM4OzjYSb7GoNr4Voja1DdApL0Gp448S
         mObPu9xDyblNRmvlkwGUuULZYvxiGAwEez+SXAGXFrQS9JrFpzTUgV7E5ban+S2qfNFZ
         NSfZ/HzZcDTJdq0Ikoe5ww3EZbvlEiKlQY8gdavDoGZ3QouTg+ngngGdrIjGcNhmOzjc
         yVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oPod1KuFvBWGJsle2l5lTHqLGq3m5KHrsHkxQ2HP+ns=;
        fh=o/CBTUTGocWRap2NhQ3438tsNg0CizBNzmuGU/pzvhI=;
        b=ezA2AdWiSdUdWuCCHtqKpiwnviUFhRuVoSbTBF1/nMysMEkhg1sH6qyslgUqYgLl6U
         6kUMhn502mglwZ47O3H13dbRugR4r3WBo0aLyfTQIcXcjFYet8EPyUm+TbOMkOvxs426
         81NAXeoE3lNpyNZMflRfpj9fHkAMEK1gvY12GB+pwSBUlNUoMrvKVmZaae6+NCh+h+R6
         jk5CME/1g10ocOURkKo1ypeGLSwj6oRjF0qXlJfMBiEUKBRKzOsyxxd5itxmvCjl7zfr
         CRegfiGc0P3nYOrFdJMxF7ievUNsnh6chQXeIvZ0cHTsQuyUWmXYXp1dWhLAGid7/SuA
         iuXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795742187; x=1796346987; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oPod1KuFvBWGJsle2l5lTHqLGq3m5KHrsHkxQ2HP+ns=;
        b=yjACiQmb/PKrdFqXS/mutr6kBPsP1vGmCYqLSE97eXboBzbviACN/BujKGlE7x1Ndf
         mQOozTdjoXimTbRYLMcxVD47jQiA8hZkiQOi0P4Eb6fZCfLIVHeyY9KUC9NeI8Mxk1zU
         bSQihymHqpiucthKPUf75/FDSQ83Ex6n3rizJzs4qNkLXnDjly0FppZsFGLfjU6pMT87
         nqIa24UonGOBw/vVYYr3lRkdUvgjx8FegLKMaPkb0KpNwHPqCtP9pgPmMrkfA+MTFHnq
         6mvNBZcWpKrM/ropu7l4jcZ3beMOaA7D1bMhEfU5kCfi8ics0H2RAp1I6fWJJZAi0b6g
         WqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795742187; x=1796346987;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oPod1KuFvBWGJsle2l5lTHqLGq3m5KHrsHkxQ2HP+ns=;
        b=lJBLEJiqzTa2SnwitrGGq9vgLT1nCe5Po6UDgDfZw7MXrHGFfUZiAYX+ZkE2x/VfAP
         ZJMpuAXQNhSvaHZ8JmMhoRdK6dOPEkfaGbiG7SyuVM1/nLrbG/EDNAQKTLaFrlKMSUS2
         vu1gUkYv7haz3OiGtjPoEXrLMezIW7t179O/VzMuEEk3jj/JaBY11VRcu9cHIgciSpmN
         E3sRccI1/0yzS3Yb62/NoL+0FcO9BAmD2Kt16L9+3G84o+lrvYDEwCIPgtkknUB9+cYP
         v/EDhqlRIh4X1RIbZ3fZ4lurT8kKgfP/LbblWBDiEmZvTWFy+Bzkmyx178UkD4K8ZW3s
         AzNA==
X-Forwarded-Encrypted: i=1; AL+hErECnsUO7BL0KjOPiBzb1ganvg4Hc21DJjUM4a9xjTzzv7232DfbeIugl1+up8nGj8bK1jbrLCzanqVoNw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+4fQ4AT4YiFd0CBWGXNEUVFK5S6qlGcVGeyu5+skxJvanJa+CR
	R0+1gMbZpvqLMCsJ9f8j6YBbhiCsu6prVsY9wA5Tq1hyQd0iW/CWFRF9tQlulklm3tetshFnibC
	JEwuFR7iom27D35yLSXtU3MzlVz01wJ4=
X-Gm-Gg: AZFdTZfmpWcQNPMqi0yz8xCTm7qE1GjbJgb+LvQXLRbaBGHAZbgTZZz1qSHg4d5z8nq
	CuQ+bdklTkSCHBMDrWKT8rpOZ/+M8am6Wxl7SREYZd6fwAHGVnrbC/kxUOdPlGfmjdvDCBwawQg
	ayA2jUpCILegaq9QRKZybQRY+EOnkqfiUJXBQtMaEYnh3AvtC6R1UHP+Q9MSCMd+p4i8jmCDH9r
	POBW42uFH7bwzqYXMRsmz6d0Fq07PFc56AHFjlaip4RdUM4MVMt+7f78iHagTj9iTcMRhmKlwSp
	pdSMf/UxNrby26+KmZHYTmIXEOxtm833zypDFIdjbOKb3z1eIIfxInPjQrfkUlUXlNiR4TA2km0
	dTHUTYggxu/UMQWkamYoyngSw9o0EgYa1qz1d
X-Received: by 2002:a05:7022:1715:b0:144:f089:b189 with SMTP id
 a92af1059eb24-1b55691a623mr20952158c88.36.1795742187259; Thu, 26 Nov 2026
 17:16:27 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-legion-lighting-rfc-v2-0-845726afb71c@gmail.com>
 <20261110-legion-lighting-rfc-v2-2-845726afb71c@gmail.com>
 <9002537db845b7a0a900612fe3a4a3638f06cd37.camel@rong.moe> <CAPKD0HfHuv4vKWeff_uhGxXosuU279qB+kkmXNPXJYL2kxFR2w@mail.gmail.com>
 <47e0364e0de6b9c22b21019d3d7e506defe58964.camel@rong.moe>
In-Reply-To: <47e0364e0de6b9c22b21019d3d7e506defe58964.camel@rong.moe>
From: Ciro Pedrini <ciro.pedrini@gmail.com>
Date: Thu, 26 Nov 2026 22:16:15 -0300
X-Gm-Features: Aa3M54om4nbMxSWNQWs_ctJIhvW8looc3McNT0nMJFNk8E5-YxztbEXgt1ad9pI
Message-ID: <CAPKD0HdL19j1CuTKJT2E0mQbYxkwPzX6=m7kmVx0ZLKp-mJ1og@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] HID: lenovo-legion: Add keyboard backlight driver
 for Legion Gen 10
To: Rong Zhang <i@rong.moe>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Ike Panhc <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Werner Sembach <wse@tuxedocomputers.com>, Aaron Erhardt <aer@tuxedocomputers.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rong,

On Thu, 2026-11-12 at 01:36 +0800, Rong Zhang wrote:
> ...though I won't insist if you still prefer kbd_backlight, as long as
> others are not opposed to it.

Thanks. I kept kbd_backlight in v3, mostly so UPower and the desktops
pick it up:
https://lore.kernel.org/r/20261127-legion-lighting-rfc-v3-0-15c55d9f15b7@gmail.com

> In this case you don't need the pre-allocated buffer, too. Let's allocate
> a tiny buffer on stack.

The pre-allocated buffer is gone, but I allocate it per exchange instead
of putting it on the stack: usbhid passes the buffer to usb_control_msg(),
and the USB core refuses stack buffers for DMA (with VMAP_STACK they
aren't DMA-able). Other HID drivers do the same for hid_hw_raw_request().

The short reports are in v3 as well, without the msleep(). The rest of
your v2 comments are done too (raw_command/simple_command, the
static_assert, errors instead of clamping, devm, comments, Kconfig).

One more thing I found while testing: the controller sends 05 02 B after
every brightness set, the host's own ones too, and also when the level
doesn't change (Fn+Space sends it the same way). v2 passed all of those
to brightness_hw_changed, so v3 only reports a level that differs from
the last one the driver knows.

Thanks,
Ciro
