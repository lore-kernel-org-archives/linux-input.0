Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813570;
	b=flkc2MyRY/82car73HUfJKVyqDVSt6HdkLzIo+ehigFd8iXI6TuITnWJKjPxz0c1Wf9v
	 QH5k1yGiDSsAC4IiRAqMVuJ3J7ZKEu0guftPfHuLTqk1XotzCUBNOtRZCrUYNsSHjZBEg
	 p20v3w2KO2M40hUNxGMRffLd5S5kFmiiOgOkawf3vAMeE6h5+V+kS3nGh1eZ49yqEXYs1
	 O8J+BxnjTYm6giZ6fXswBCW+rtllgPxwzD+Ac5E59mm/B1LoTH+eFGJGwG+be4Flmlmbz
	 G8MiN5mqA3XplD9t8mI0v/8QnCNGQtngxNf89U1gaP6Q8j281LqkgonwAlJJFk09N4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hpArKDI1kvex7i5YNprU+XK4K7TRng2ZiTYQoXQGmQ0=;
	b=nZ/VSXWl2vN7AC3xWbXDH4h66j3zTzKF3tVBUUEIEBCA2kBWcUg4M65aIcGifwipVZ7n
	 JWgB2mBqxhrQM3eQLTA8mK1oycEC+wrnx32UwAV8wSoMJ/VQCb80d+UBckF78H4G3Gufx
	 KdqVZN1fdJLaEVIzPighBPMn+jKMGAqrT1yj86lVaWvrTBydbWIcuo9voRNFLtpOCKGsG
	 QDFPp7N7kJesPNgpO+bN9lW99n6e4+7G8AVPJGIDdo4GkrZgm7JXma50Td1c7c3+j6kkR
	 2UH1cqi+BXTHDYsC5+C4kV/e8HxxY7Lr8BjTBBFutcnU+eMP7aPNFL4xHKw3DDZu+Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sMP10myj;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D493606A32A
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 07:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D493606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sMP10myj
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso19686615e9.0
        for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 23:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794813568; x=1795418368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hpArKDI1kvex7i5YNprU+XK4K7TRng2ZiTYQoXQGmQ0=;
        b=sMP10myjEyJOAIwJkxpYGqqjq4g8UU4IaraQOM2Rt9WqHC1BUR/w11e3Og6qmJzAIa
         /KGjsxIq/SiHOnCAoEhlZZVUPLOndhVOkwiKl8l8v+K8nLRigmvsrsqyYfME1mew7PDb
         cbLjepnQlPI0pmAP47VvcGZGrewQPyRjE5lWocQZk5d3qK9sNimOzlA4ZEAsfxNUghQZ
         IsamjtKH8QF1ztBcIOiEvXbog0ON4mv2er3Fg+3+vT0CiCUsM3993BPYYl6NMUIiNUM1
         /6I0r8yKYdQ2461u9k0A7Ae4AaLrvIcX8a29zuActSdeZ6tPD7jb6Pd3deA/EKqlx2AS
         iChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794813568; x=1795418368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hpArKDI1kvex7i5YNprU+XK4K7TRng2ZiTYQoXQGmQ0=;
        b=zZYG3oFO+CIWgtkxV8zp+d8xAN8s6QFmAEom5pH3sOaJfydnhShUn+BZF6OfXdnq09
         itRUej/AbZdHpS0GBmt8BE0gg16C8uIFenHwknwynpx+zHfEsVqpMSGsgUawrcEWpFjM
         Qc4Yu6IwaoWN1MoITqA18nAjpZWMxaAn+r52kJxR9WJ7HSvGSU2Dz7nwvz72hJ+c1XSo
         WW1MTMDWN7f50CnCV3TP5G4b/6Wk8s7EhucyKqqEsozSEzROn8fJ9vlM3SIHPNgTz9bv
         7kVmtHid5E8HWJ8KbEt30yMpNBkNiujB/YljcQV1QTkyPpsfId7DoqmvTEsR5I3m83fz
         gtxQ==
X-Gm-Message-State: APuU4Z9eWfOFxmk+Ul9KiDn3ey6tlUcAFKHUqx5nTIZoV8G6svbeEmFF
	6Oo/A4ASitGMMF/X9p339Ob244aUOPGxx1JsLCG6U+Ig8rTGZ2ZJFm1I
X-Gm-Gg: AYBFou15LReW2ox0xM+L9R+yOm4QMwnk+ZA/r9nEeIKhjD+QtEMnNj5zrskqG8UfJzJ
	KFsPNjxywlgAET8pccJFIRMMdPGavXErOuqrxUMT7tdwE3oHg+cCct8eYVtuuU7UjWP9ff53rEm
	g9MjZvtJ497PdBaPKh7kuCcP5x0l1B/5EFNsxOijqnHdbAVcVN+P/fb/AXUETKHXUYkChrNBwMv
	iRR1oTEpydaEYeCyqqfm7r8qKe8IfhF/15OZwXZJ1MXijuLbK1MCGAYRaXdaSDIkZGHJJ95jB6X
	RwO+xxGuV7LK/FhqJ1J0gkW6H+Jb/Gf2IOFC3qiZUHzCZpOBJEqDpSe6Cu6aMN1dpvRSQQAeNee
	4U9Jn102r7OmY1DgP1IJ4Ej4kBPUJZKv1WuklZUwx8Q5/dsMBgD/dFO+yNgnmfECFRZ019hRhdj
	GxgdngkT9JvU2YBL63OTxmXYr78UyNMvJwQ2vYIlhC7C9T2LYgtcItF7KQ0CMLARaGIG6TidAt4
	Qz+Z5QyznpIu0O5DQ8SA9cWcmkgF/eX362INWVkP0GCJV5erIzX3B4s8lDSQSsj4YUM9DrOAMJX
	Iom07TH699SpX9vhEdWpb19mlPRBoNUp7I7IfNLRBcQ19NKeB/yGmZ92wkeF0rIcyO3Jq/4hOjA
	=
X-Received: by 2002:a05:600c:b86:b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4bb55a67c61mr213009275e9.26.1794813567855;
        Sun, 15 Nov 2026 23:19:27 -0800 (PST)
Received: from ahmad-HP-ZBook-17-G3 ([37.63.251.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb729b2801sm50506845e9.5.2026.11.15.23.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:19:27 -0800 (PST)
From: ahmad baghereslami <ahmad.b1995@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Input: synaptics - support the touchpad LED on RMI function $30
Date: Mon, 16 Nov 2026 10:49:06 +0330
Message-ID: <20261116071906.30110-1-ahmad.b1995@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <7f9d0adf1f49c5a2b3919130caf0acb7@gmail.com>
References: <7f9d0adf1f49c5a2b3919130caf0acb7@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry,

On Mon, Nov 16, 2026 at 04:41:48AM +0000, Dmitry Torokhov wrote:
> Could you please check if booting with psmouse.synaptics_intertouch=1
> switches the touchpad (and the pointing stick via F03) to RMI4 over
> SMBus on the HP ZBook 17 G3?

Yes, it does. With psmouse.synaptics_intertouch=1 the touchpad binds as
"Synaptics TM2706-002" through rmi4_smbus, and motion, taps, buttons,
scrolling and the pointing stick (F03) all work.

The reason I kept it on PS/2 is a side effect on this laptop: the
embedded controller turns the keyboard backlight back on when it sees
PS/2 input after the backlight has timed out. Over SMBus the touchpad's
traffic no longer passes through the EC, so touching the touchpad no
longer wakes the keyboard backlight; only typing does. Nothing else
differed in daily use.

If you still prefer the RMI4 route, I can send a series that adds
"SYN3040" to smbus_pnp_ids[] and implements LED class support in
rmi_f30.c, and drop the PS/2 backdoor. Or, if the backlight behaviour
is a reason to keep this touchpad on PS/2, I would keep the current
approach. Which would you prefer?

(Separately, sashiko found that v3 can leave the LED lit when a trigger
is removed at unbind; I have a fix ready for whichever version comes
next.)

Thanks,
Ahmad
