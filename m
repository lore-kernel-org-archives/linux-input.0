Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423644;
	b=OUd+bzutIVic5AFwLasBgHRh0e8D3FWZze8S0Ps+ITndm0VZ2lTtFztMbFhAWTVhNv+P
	 JUG40u3kkvmA1z8RU75Kfg28ulxlKk+esI4b2+Rcke3IQrDX66q9XOggpE9WrfyN+LUFc
	 eY+89124e8SBAg0XaPdMmjMQwFG3cSBiokR5VCZ/VsVz2k3W4+Bfbvl4WcIvZNyocppL5
	 vlFL2b7F8znvdTpMBf71nLaTS6FnBp8a93h79fZma9eaDhmXX0QTsx8MfsW9MtmTrXPqq
	 c66wPyeo3OrjXLu+K3+fEzg30X/LnEtKBAhtfywmYCye/INNBc3avaVgd0M9GXYFXfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=a9avre7WPVBTm+1ssGfTak2MnTio6f4/ruqgmNL/TRE=;
	b=TTnqhStMXcFQsY9Fd+7xFeqX7gbwEBB9bMjtcFWBWJS/ISlD5grFRxHtNsCG7OOKzQHH
	 thptkgtn8rqemIE52jL90o66EQB2FuIeRinLV1z2t9grtSDwasdnegzIQWyQSvrzKKGg6
	 UCawaRBcQppeLqP297K06K3UMgST3FWJwNLEdxJ2EpBPptQxAlEIyjiltEliC7nEwewrp
	 zqJ3EkjiuVzdusbcvjH4YUbGsxby9TJ8PmRghNy6PaIWO7SDRhg7mrz7j9W9SPQyTwZwf
	 A/X/M9fROid1fllNc2UiI8pj9Bsh27VqQiLr4C1zML42E+PtE8D6ya+4I8RMTIwXP/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QEWpBz0U;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FA4606A32A
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 08:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19FA4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QEWpBz0U
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so1468570a91.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 00:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795423643; x=1796028443; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a9avre7WPVBTm+1ssGfTak2MnTio6f4/ruqgmNL/TRE=;
        b=QEWpBz0UF+1mc1fKVDkphV8Vq4Od5PrcQOIScdeTZwTHzNVAeyUZ7atmbcZwDRSx5C
         N9BE3MswpXI2ysrY0V0pC+iuFUgXVGkjHCcJZDhk/J3TfM5WJPkPVU1sdHjuMkm93WoD
         4wnmZiMs/Tj0led+OWYVnQfjkFsVsDw0SSpyr9gK7Kxr1fgpqa4VD7KGk1iblYk27dfV
         bx69GBVCacNwq6JbAY8ZKc1kQytU15PmLYTEWqSF8MJrqyy8pJwad8dcqj22RWS76bTg
         W7ddBTGFIvgJcat39+CKHAyp+puat+bN1IEcW5U9ibMNVNbanKAKvpOLobUxkD9/N9YE
         uAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795423643; x=1796028443;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a9avre7WPVBTm+1ssGfTak2MnTio6f4/ruqgmNL/TRE=;
        b=snDBQVHUc4VF+LKjrp4shj6R/YWGm7Izc341XskcrEn4gm50sJ4LS2AiXFhX9zdO6x
         rJVmdiKIsXzG3f6cCDXfPVJMnwyZ6H1Aua/dOZSTcizZx8SzoPKRPKsBNtysYshULD8K
         bMrA0VLlJb+GUtLv69STff2PB1yTP1rMEN1cobg0H6m2Mc9DzfhSRX2GQFpsRhsaVFuv
         LXulaIiivXClo5+GVLFSO4gRYUTU3vnmP3aqYNoIxvyHbgHz4I9Oz/m3fS+3OiHipTHQ
         C9tOu73HerXsZ0qU7bKwSrdW5ZSgNltZtLLA14JfbvKfPjoOLrBvZ+I5TXPc6DSrv7M/
         34tg==
X-Forwarded-Encrypted: i=1; AL+hErHGpKdUl6/bFXzs3hEVVY+gOdnSrOVFzni8NERZVfnWkXr/TaIapsPnM9RtU6V3X8f+u1GShs0jLPp5rw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/CDYUs8XR05ycKpKeV1onHfQNqP0l3aVFHYisdhn2sX7GCFuRG
	oGbVDMn89n+/yCenbDecNhzsBRdpg/lrGkz3l4KiUjy6epma4hYGGgkJ
X-Gm-Gg: AZFdTZf7oS+aeR1zN5+Ykm3tKzRCWicqIypgWBKoroZ87fdwKYui/MbTKKQ/22Qmuem
	FvNYv8NzTK/CLb1P/MgsWNBahe7KKVGhQna3YeLmXjB5/ezb6uMTNfUa3Vnd4dYi9ms9H7WLucg
	dOBulHCX1owrpreyyVqwP5i1q6nxHm1OVIaIqC/y+GJop59dR4EYEuZhguaLSxr/4govTGV7NGc
	JqWeNsTc1oF7gwe63TsXdp9HK+HBaHgTMK8UFt9oWoeP4zea/DuPEBFcex9qBtwJILaitL/3b/l
	9KTwuake4wMQgwGhIE/9ioSOsF14lppHHzOis6GVKD7adgWYmTxJ58cx3biduJe+auJlN7wMasG
	+tCgTt3RWEX++VJYjel9HdmX1sjORQMR+OjT4OUglyN5ydELBwEWryKBlKdF7/KDEuSUshNy49D
	h6oLg12eN0OO+64DOj8bC7q+vf5OObuIV/lK0aH1pxBSBYX6S9WJYycGdzFVoGRtD0z3Fonu6Kt
	/WhKiMt81FMgAf3fdvevtRxF2VIb3nPO3XWIWvtmqJbAaIT6zJpxJ3k92elsDv/pM2CqxZzRIQJ
	lTVo5548Oph3xxpmOquHSTqMZJsbvbgfguRuXZzN/FUITq/j
X-Received: by 2002:a17:90b:1cc4:b0:3ac:ffb8:1809 with SMTP id 98e67ed59e1d1-3b41caea9e3mr8391385a91.39.1795423643465;
        Mon, 23 Nov 2026 00:47:23 -0800 (PST)
Received: from [169.254.42.106] ([113.200.174.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm18558082a91.3.2026.11.23.00.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:47:23 -0800 (PST)
From: Zheng Shuhao <viennaoffh@gmail.com>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: kapoorarnav43@gmail.com, jikos@kernel.org, bentiss@kernel.org,
 srinivas.pandruvada@linux.intel.com, jic23@kernel.org, lee@kernel.org,
 heiko@sntech.de, lixu.zhang@intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] HID: hid-sensor-hub: avoid lock inversion in
 sensor_hub_remove()
Date: Mon, 23 Nov 2026 16:47:15 +0800
Message-ID: <179542363584.4684.890797902249469950@gmail.com>
In-Reply-To:
 <CAJi8Lv-orD3VA1NJ71L1Qcw6=AWuBZesVFOHe5Y+bwzWxT8KRg@mail.gmail.com>
References: <20261120210317.184756-1-kapoorarnav43@gmail.com>
 <179526830578.567.7445109567862298713@viennaoffh.gmail.com>
 <CAJi8Lv-orD3VA1NJ71L1Qcw6=AWuBZesVFOHe5Y+bwzWxT8KRg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Ayaan,

OK, I think it would be better if you sent v3.

Thanks,
Zheng

> Hi Zheng,
>
> I'm fine with merging the fixes into a single version. I've just now
> read the other mail thread.
> If you can, please send the v3; else let me know and i'll do it.
>
> Thanks,
> Ayaan
>
>
>
> On Sat, Nov 21, 2026 at 7:08 PM Zheng Shuhao <viennaoffh@gmail.com> wrote:
> >
> > Hi Ayaan,
> >
> > Hmm, I overlooked the latest discussion, which caused some overlap
> > between our patches. Sorry for the confusion.
> >
> > We can merge the fixes into a single version or find another
> > compromise. Either way works for me.
> >
> > Thanks,
> > Zheng
