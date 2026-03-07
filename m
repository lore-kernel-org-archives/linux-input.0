Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E5281369
	for <linux-input@vger.kernel.org>; Sat,  7 Mar 2026 02:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772851820; cv=none; b=Tf/b5QvilMuBJPeE8eKGrPd+sXtcgv5E5KdGZPDQUV72/imAuBYKGP7H3HL6ST7aA0rIAf7RAkdnZbuw82Z5g8XKIWrkgquLF/oPMHbF4WFZON33WNTBUiEEbS4P9GhIy9D/hoK5ZpX5lasY7xHyZ1T7QpkdzRXionZLaPr1+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772851820; c=relaxed/simple;
	bh=lk2h+apOO3IJRH+msqUtPdH8EFN4HRYrGLzxyBLLPJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WAtuDNvR3ihE0dQTFe9f19JD3BxE9EX3J1k8d8Pi9od8hDvwBd6WZ/9YHTAxpRFjbkACog7KvzYir06EravoZG2r3Sv7cG68lOs+CJ9rKv/13ByG7xRhxDDF49XMBpNangwy5eL66bsnIBbqB1rIiVXS9ozioSAccXhEAL1vxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxvKbsJ+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxvKbsJ+"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-829b2019b39so252734b3a.3
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 18:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772851819; x=1773456619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbPWhHn0q5436GJTGEpUj7I/Dk6nllWjPQ6fEPdh+4o=;
        b=GxvKbsJ+BZySsoevjOZfhqhytMRyrbkmrMQNbaXTjRJ5Qi3IDcPhUNxr7ebJDNPWPk
         AlceA4dlF9cUl8/h8Ww91c1i0rZ2wcRmz8LIiRbsw3FWHIWqEPaNFIQZMHksQI6klt8L
         VWxqqNREk1TicyxIWkm0JZB49vpi930RBGgMjDJqInvn1bOQpqZfoJyNUaa+O1v/dpM1
         bFXN7uh+lTVCvsS5m87CFDzYrjhOTnIow0I+fFabNzLiZH5vvbGIbvYbi3wSQ5hZSYol
         ANxL6GTEbB11PyZBpuzz2OUXYvfTZ451tbNwQSoFb4NcHA77sfv1q74AU8X0ECjjbFzf
         WObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772851819; x=1773456619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KbPWhHn0q5436GJTGEpUj7I/Dk6nllWjPQ6fEPdh+4o=;
        b=D83q6nR5Nx0ve60tdQORnrR7rWsE0z/bNA0CRykCF3ixea3fAtCXXq4FOMdSBBAUKi
         jNaeVYwipwKzzfkL8jThJPUvIaoQ3EG9QPS469pfYqWasKP+FEJQPFP0x/YRyQE76CEY
         mwVrm2wY9K/OvU/gaHTDKcG0VxxkXBkfTimuLwJ3GCcC92AnhZLKadsKUDuu20LC4jaO
         AgpeorSh2iOQS+FeU2Ha9/yqMvtxBtXkYanULLJP2JI/3ivjzjB74fS2hrovaVS2iOrU
         9bfBhHZ2Im4p0XlZda0M2/7lzZ4QyDRAzyIGlssFr3rskt0GAf0mLxS/1bKd6ytIU3kT
         jwRA==
X-Forwarded-Encrypted: i=1; AJvYcCXxXgdbuZxx+QcwQ+XPO8bSSkG4Cd0aCmDa+nOKAd/5S99A04QOKQdIXKlHZ7ZMYbVezqppljU4K2rESA==@vger.kernel.org
X-Gm-Message-State: AOJu0YytH15t6ugIEY+NG2alK54JIMjdRs77TFUhChRK2PnjgRq3LbCx
	flOxouMrL2OVmZ8xFxj1iSFW9wdiivzILr+4GAcV8C/eYLKRgUt2IICb
X-Gm-Gg: ATEYQzyYELLnFB2X2MI0nbVqSflr/LeTYJprOQqTdrFKFOMICPJZh+eytbL5VRuLp69
	uZwQARVOg7UoqPYLb8Dnc7koHIkl0Gtjh8w6O0WogB3K/aNDQech3eNY6zH3H7nco+YEc+UJN2D
	AnRS/cqk7x0FctE0Opxp/adjw86ECeH2zS/4T09V7qGh89obqS2yRyIqPiwlhv7/kY2NcWVclY8
	BQMjMPKNhGbjpfHOJqpmVTZPo/a8WUfco7nlmTRw3+4y/P1Y9+7xTIJb1Tfn73Z6bC8V3iVfO5F
	VYfDBjsjDcN1VBgtzH0My0q2zkTBYauP+TY9uEaxV7qSv0QfZ5zjC7ez9W4ptW6EUFb2OzcsKMF
	vUtdzRtQsNOTpG9SbjkQ53MXdiSWdSW85v9k4JXeev4wwXC6Ka0VzYVobK3bjbQB85bO0hIqn5k
	rzw+DqCX2fkyqp7W8EBQ/nhJIiOavSBqSbZY5LuxQ4Id12ArimEmPfoQEE/WAE/QR132vDS0j3Q
	/NBofTjvxQN3EsP+A==
X-Received: by 2002:a05:6a00:88f:b0:823:1c83:e4cb with SMTP id d2e1a72fcca58-829a30d70c8mr3467800b3a.62.1772851819244;
        Fri, 06 Mar 2026 18:50:19 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:8207:3134:c1c0:ef7d:b1c8:1597])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465b702sm3134244b3a.20.2026.03.06.18.50.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Mar 2026 18:50:18 -0800 (PST)
From: phucduc.bui@gmail.com
To: krzk@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	geert+renesas@glider.be,
	hechtb@gmail.com,
	javier.carrasco@wolfvision.net,
	jeff@labundy.com,
	krzk+dt@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	magnus.damm@gmail.com,
	phucduc.bui@gmail.com,
	robh@kernel.org,
	wsa+renesas@sang-engineering.com
Subject: Re: [PATCH v2 3/3] input: touchscreen: st1232: add system wakeup support
Date: Sat,  7 Mar 2026 09:50:12 +0700
Message-Id: <20260307025012.1539-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <ff7a9a31-2dfb-4588-83bd-1a3aa7809972@kernel.org>
References: <ff7a9a31-2dfb-4588-83bd-1a3aa7809972@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

> > +	dev_info(dev, "st1232: suspend called\n");
> > +	dev_info(dev, "st1232: irq=%d wakeup=%d\n", client->irq, 
> device_may_wakeup(dev));
> 
> No, there is no need to add success messages.
> 
> >  
> > -	if (!device_may_wakeup(&client->dev))
> > +	if (device_may_wakeup(dev)) {
> > +		ret = enable_irq_wake(client->irq);
> > +		dev_info(dev, "st1232: Supend use wakeup\n");
> > +		dev_info(dev, "enable_irq_wake ret=%d\n", ret);
> 
> Drop both
>  
> 
> > +	} else {
> > +		dev_info(dev, "st1232: Suspend Don't use wakeup\n");
> 
> Drop

My apologies. You are absolutely right. I realized these debug messages 
were unnecessary and already removed them in the v3 I sent (though I 
unfortunately messed up the threading for that version). 
I will ensure they stay removed in v4, which will be sent as a fresh 
thread.

Best regards,
Phuc
