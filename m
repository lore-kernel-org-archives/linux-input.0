Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370116;
	b=3jLwU5ieJX/3cyaUNfT+3YJi1yVeG0VN3o0jD6BJS33GI6Q30/o5P75yu5CiDdq5rI8e
	 KgGG2ctOv4CTfUft0PLhSbmEq1J1ar6Q3+B3N86KCL8tT6pxVPmYJW2k6FwiHJEr+ATwF
	 Zv5hp9VnfMCZy/jENWABwTbwSuKO+wHhFsJ34s2KpaGn1NeryoTYfumwoODJa/GQhlbeT
	 N0mpMSyUcHKNllZvWBdttq2JZZiiTux3xPmLY8q26qOG+T1MSeeZQ2uVA66d0EQIjDNdy
	 T8S85HsA3jYYijhUgmyDyUhk/WOOfhuFNaXXA9CptwACpfY7gZqMz410Aa5YiMGNBPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Subject:From:X-Mailer:References:In-Reply-To;
	bh=1yMVaQOiv9B9KFhOF3+nr4ODmkWDhOk1vIMDXuWTipE=;
	b=q6CuhtP40bHAPPnSwnoafi2245Z+Shpy4UwTCqLL7ldo/zgrThnJxlf6N7N2t9UKHpDu
	 lYJQwd6NvpTXfwV3ag5MZJdNnq5ygNC3i8O7AvJ3EuJTNcp+akdfBt1s+mxnWgIIhVS8Y
	 GaBLiHZU6lFkV9/wpWAJ2ues/IDoGj+NmKjwLQ31FEaS0KDIXkN5GrF1D5Ub8yrlEbLOw
	 MBpJx2atR2hfykKju+bHFndE1R+3HP+hrMB8T4OSD/NA92ZgaCGc2f/GZc220gdCMwkmo
	 0nmFjYEzcN2HJp6cjkxH5Zkbf2z523n6XxW5F2iipyDo6L3L5SAbp6R/4kGIYJF7hSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="F8aupT1/";
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBD4606A32C
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 17:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DBD4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F8aupT1/
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so761085866b.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 09:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795370115; x=1795974915; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1yMVaQOiv9B9KFhOF3+nr4ODmkWDhOk1vIMDXuWTipE=;
        b=F8aupT1/AXXLqFRYnFG9Wa4oKDTm+nQiKVJJpHAjGD/m8srnDYHjHTuG7VJUL6jgTU
         0LshakNGtPggj2pbNgWhkM6Bv3c+6fydnUaJ8nqhmnpdvE7ZKJtQxTy4zukzH4aBsjc8
         cS9lkJBW8SapYNQ0UdfwaqI18nSj0t0fkfsqW8rIUt4aQh7cRwRn4F4+bFYhBjwcwK1Z
         y12l7sKn7AfbwbnERzZ4fsWTbscrrEIr7IUW4+j2Mg6oPYWF8POyv4tPa+yqONcKI8nW
         W34hZbcsp6T/oRvaNKsVtTPv88SzVAxAOlNJaZ6UOMQ7mS6DpM9Yjw6iQmFvlB2kyO1U
         p6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795370115; x=1795974915;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1yMVaQOiv9B9KFhOF3+nr4ODmkWDhOk1vIMDXuWTipE=;
        b=autmOo05A3RuOT27r6RC0/Wgv/r2qcJKWNd+0IUMPL+vtV2+Zl6pdWb3wpq2ErlQP8
         8aSqqcXNuZfvDN8eVI+pp2j9Psi+LtGXsy4zbYuf2vfeuSTFX84scrEAROgb7/X5XbZH
         QeP9pP+Uw+KMEeOd05LTCPuLRUO/kZbvCpJ5d+5N0UpUod0XwUvZuJQHFIFHIcqkHZH6
         zHUkpMOdM4qNxy7sW4TN7Y5wJp/jOWYRRc1BVJ745vuEs59yr7Q9/Knq+zmM1UcuWa0T
         0s3y26SEbex/3YxdkmJnDWCt+OdtVs4KJwk1cnOxOBwPatbMGM31Qzi2LtPTHzABGo5y
         PxIw==
X-Forwarded-Encrypted: i=1; AL+hErGXd3NxbU8mKM6pKV5vcNglx7dcmFQwPvBrm68kO4+jdp1kPCGWCyHj0T+Qb1wdohB9PsiMBIMczdjCbg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8yIG6jsnDO/0PPo3yWjFpk9Ad1tYc9pWLmU8WnX/QGnQ9g2dk9
	07GiNTrvkcHMgQ+PcJJhxx4GCjNxPLKO7guWdl0iAaLyZMVTyp0dc4ey
X-Gm-Gg: AZFdTZc0d00tpDtKsscPdBaSFzMHuOGGiAY/AzO+zQeQbaB4O2inQJm0NKluZ7u5cRs
	3ACB4nv04+cLw3Pd2YIAa00KatJ/+qwr2iy/9ZWnqo425dZwO5Vrr4EjaUmBVNajlT8CSR+9UoX
	+3HHwNnJQMZh1xe9vNmzuZKlVrh5tMmRxfnivcGi/9aju3XuTyjpCoa1fSOzz5tBY5M25PS5fWL
	aNQMEQNGKCpsAmSdv/8Aj1mmixPPspbRewUqsC5jYIzzHRkWrFGS766D7myXmHsZxp3LhKsjg9C
	zaQKEBCbJgU++Heuk3FImxoRG8uGaE2LV6Ej5Wxjbp2dKBJE3/A+HuhqyZBPChEpHPyLnmnG2eQ
	l2rWh/2Lo/tUtlZLFTdKWbnqAMwPHO/AjkLQCujkNTNGH1o96QX8D/8jn8gaBarMjG0/ThciL3l
	rYvasUB0iHPNNCDySEB+0sTxymMEvTpO+Rlvv4e78yMUGgIe/iz6B0h6Ue8+Z63VympQFIGWbfo
	adahhLzfgY/crcVj73cY4mrPcWvafv59O3H9yIQu9kFvcwuUQ92CXMpcmO+MFgtpLsE2yFJlXK3
	BKttktrh3Qu/gEs+8f1IxwPLoNP9
X-Received: by 2002:a17:907:3dac:b0:c51:249f:7215 with SMTP id a640c23a62f3a-c51317e3341mr933233966b.7.1795370114732;
        Sun, 22 Nov 2026 09:55:14 -0800 (PST)
Received: from localhost ([2001:1b81:1b55:aa00:48b3:8eff:fe5b:7d15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae6841asm340920566b.24.2026.11.22.09.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 09:55:13 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Nov 2026 18:55:12 +0100
Message-Id: <DN1XL7HI1QUD.GQ4SZXCBUK3V@gmail.com>
To: "Oleh Kuzhylnyi" <kuzhylol@gmail.com>, "Daniel Golle"
 <daniel@makrotopia.org>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] Input: hynitron-cst816x: time out gesture key
 release
From: "Oleh Kuzhylnyi" <kuzhylol@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1791233147.git.daniel@makrotopia.org>
 <d73d26d8c9d75fa230e3dd64058acb65f45da64d.1791233147.git.daniel@makrotopia.org> <DM339BDR8JE2.1FJ5827JZIBWD@gmail.com>
In-Reply-To: <DM339BDR8JE2.1FJ5827JZIBWD@gmail.com>

Looks good to me.

Reviewed-by: Oleh Kuzhylnyi <kuzhylol@gmail.com>

Best regards,
Oleh Kuzhylnyi
