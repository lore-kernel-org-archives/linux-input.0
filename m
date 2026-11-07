Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794037711;
	b=xkSvkAPOtSSNF1R0wXsEFrvDvoFcRkcSaux/RYuLKzPBNYbUTzDEcHhjNyA7reUXqt5+
	 C+O7rGIRyqN3ft5zUUM7PC/mBRYE29sWIKuIVRAfYRMUD3pCY3KJGQdEO/ctMhvMbdVvO
	 dR1XeDLXo29ComhU6GlDf/srRHwesa9QyuVIZGalQQHxnmZjHKoHWHVbe/lpHwMtt185Y
	 UYZlxQP14Vxl3hlDUxyy3m9Lph8d1D2ddKilq2xaGc7gmPB7iSftieBQfjFkq/bs+doKb
	 cyIDW6Ywc8k7OPNDQKqCXlsSbApE+TU8xEEfaMdiA4wZUOCAZ+DILaFGzkgQHSnHz8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794037711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=xws3TV4eGyEGoCj4qfjxC+3xAzbBe7+peoj+q66DzJg=;
	b=zezFxqObnXM0HQYJCojyj7phOt3zWQxjqnS89IIDY3aoaVUL4vNjcqF4bJjCtoaCpcFB
	 i2PUg0gyMwfNQAkghpt/ODPdm7kVVyq8vwbyMQluJ4fIBGsWNhEShx0pRwgZ0iL0MgnEP
	 ZnjZOq/NYROWx3aaccS58PXxUGvki0wgTgwwTzLkwWVC7HtRWtGnqNxA4jYLNZC3gzWfy
	 BLmIxRzEWEP8MjC873hXVYMPZZoHn0zHHsrehcJQEjdIqHrrFkKHP8IMfCr9DBcTc8xhh
	 cyQIIHb83WVj6Vf0lTFeYA+32n9hDIa4YredEbE4+krzWW94iO0m/gcRpY78sn8RN9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B9eUUSOc;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E9606A326
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 07:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F4E9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B9eUUSOc
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8ac1f2ff78dso169525b3a.0
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 23:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794037710; x=1794642510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xws3TV4eGyEGoCj4qfjxC+3xAzbBe7+peoj+q66DzJg=;
        b=B9eUUSOcKUFoAACEt5QdxSuu9nhnDfuBqFeWW2zij4OTiEQ9cckV/Cx0k0EWVI5rC9
         6NMoDzVMk9uudEuAVDf+YigY5dZNVUX0cHqKP9wPARLZLVlW0JnOBQcbeWCMCy8dzbqe
         nbATpZ7MoGw892OejOLoot/E+VUbd5QJtUa5zj010AfZedT3SzFzMX/lPQ1HLMIlIDsG
         FTfKGH6gECkNz/NlbWUf4Id9oiOJCQqxAni2ZrBZqvsf7uVopwfMhfCwDljDp2oZ4ON7
         9zGBHyurY0zIH9EMh53dTjqu5Q22r1xcBAq4MRgyDbVzp/IeVXanAAkLk/25m78ST5Vy
         DeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794037710; x=1794642510;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xws3TV4eGyEGoCj4qfjxC+3xAzbBe7+peoj+q66DzJg=;
        b=kozCs5iRmv1MVu+XRXlcMwbslkoehZtvyRYDqO4QPPGeA4l5BTZuL0mWlxxaz/jl+p
         TBjGhGwAeQGlNLyBHTDD76eVptxwc9H/pX5Rz2IQHz14iGDY5fp4l3weITdtOhbOQ6R6
         L3yMXGWCTxYwg0qH3spv/2iho1D1bfqJPxYTA4Hx3Ezq4wvIbPYP1sJk1CJPRBzWgG55
         Utfmg7XIPF9KiLM6tWnTfiK9EqKHDQfIDccpm1crD9qT9LItIs9AFAZyaNEtttRTURdB
         ecPUc2G9Tm7Si/bi32KxMSEnKr1P8V50YJWA+OS5PVLuZuYTbyA+7O5BVm9RkVveHaQ/
         SYjw==
X-Forwarded-Encrypted: i=1; AL+hErFt+maxlD6FW4XVCSgRHFhBozkQjv4xkj4KRlRsudXB8KqTgIn1iQnEDgdsPULm8r5v4QaX7K7kuXckMg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9oCxAZv7xbFykSnU8AnmrLwWSmDmVqiCBOWLvoVcECe4MlOC94
	+0enBFyOzfuvFwAupxcCJN6NTNZovEiTLlqro3MqUBzS6s8M16xEozZg
X-Gm-Gg: AYBFou2srptIq/6QXCSI1TZOC3RS5Jg0wfdyDhnBPOFncoo9uoPSdZA11nk2WXxX3KI
	60F9HlZUFgThIOF/3YIBO/sHEXTz0yidS1D+tlWOcdZFbfEyvxLQmRApr+i7hY/xcREQqp/2Gy4
	bg4BiyMslBpr+BpFcCalMH3KbP/jyfWw11OVprxae1GrzNGyD7K2U0ElfcYm1a9SmjJX0fzPlJf
	axo9JypsrGsWhOEwLMvgEOBavQdCgEvfetjr/TtuJVNP/eEdjpvVFA/SOrX/JVP4jgxV1uc3+5J
	ow+nuQzvFOT5zv2TOl9I5WEiGokw0k5+1xqvqKb+VcTtBfciCdYE8yoGLYCr2XnlKX77AOFepta
	/ly4JEQeXSQAqkOGR9fR/AThStsbB8f/wDTE5rWWBUf2DaWAgtGOoD8W7ODmfrPR+wnCdavCLC1
	tHcJZ0X86Mtz1yI/8xiPUcY0OF3nOTmEM+SvKWwXb8+uMpe1NCU9vjSuYYW71jSsIihU6VmmvNS
	njm5eYqEV6GFPNUtqfQQzu0vPxmNIbs5zv719BC7UVyG88ZC9m4T0y6f2p6NyPAqPZh9Hb8YKS0
	TTvoZ8Sb0NN+sEjEZRijAsVj0Shyfwf+OIZv3nIb4nh8fkM1GgnBUvTRZC47Z+S2K0s+ECP0sRB
	eMJYMzPDZSUKm
X-Received: by 2002:a17:90b:1b02:b0:3ae:3b3d:c617 with SMTP id 98e67ed59e1d1-3b10637bf81mr1022182a91.29.1794037710320;
        Fri, 06 Nov 2026 23:48:30 -0800 (PST)
Received: from eggarch ([2409:40c4:100c:32b8:cdcf:1840:88f5:4e8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a80a1sm2495542a91.12.2026.11.06.23.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 23:48:29 -0800 (PST)
Date: Sat, 7 Nov 2026 13:18:23 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Jakariya Abbas <jakariya3460@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics - Add LEN205b entry to smbus_pnp_ids
 for ThinkPad T490
Message-ID: <au7RHdJGhycNmteO@eggarch>
References: <CADYJuTsGK0k5RgLrRjWjkKBO79OFH4Lfj6OtiUOKnOECzeTuxg@mail.gmail.com>
 <CADYJuTt283d74=0=WoX4yTAQT6gRt2NPvfPJ5AsEU0G8Di0aYA@mail.gmail.com>
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
In-Reply-To: <CADYJuTt283d74=0=WoX4yTAQT6gRt2NPvfPJ5AsEU0G8Di0aYA@mail.gmail.com>

Hi Jakariya,

On Sat, Nov 07, 2026 at 12:16:29PM +0600, Jakariya Abbas wrote:
> Hi Lovekesh and Dmitry,
> 
> I have a ThinkPad T490 with the same Synaptics TM3471-020 touchpad
> (LEN205B, firmware ID 3972349).
> After the SMBus/RMI4 support was added, I noticed that touchpad
> movement and scrolling work, but physical clicking and tapping become
> extremely unreliable. A click registers only after several attempts.

Could you verify again whether this bug is really there, on mainline?
Because same issue was reported a week ago but then reporter said they
were unable to reproduce it.

...For some reason I can't find their mail on lore here's the link
to thread anyways.
https://lore.kernel.org/all/audS8Nb1wnifhCpr@eggarch/T/#u

Regards,
Lovekesh
