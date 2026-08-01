Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A3313E0D
	for <linux-input@vger.kernel.org>; Sat,  1 Aug 2026 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583055; cv=none; b=C7u5M7Bf1jGoupUyZFLieyjFibiSMjL3JMJ3bUmkClTtqDF5DfndMIUlHiFwPDZsFd3lQ6vOw0yyOu+i1olUCu4E84SH9LeFZ2G0mtmkjEVJOfiTKR+7Wzkro+koqr8ugCM1RAKB0YV3tK/h/ur2uh0rPXTQxv9FILjfkuIN/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583055; c=relaxed/simple;
	bh=AIdQLwD87MzxH8DeCnVNtXMyYJKN/E/weJYvac66iWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5pNYcgQDKrNgwJWPJJ61JYTfd9CT2K5D+8rKc4DRMNfqNqO+Mk34rx68hsaeeSs98L2nErtTU+v9PzwFmc2CuuA3FAxTRyyFqWErWIBi1eSXHyEIhp6XK2qpJo/3lIBpb3QyG1FsP6c/kslVyfkwjjaio1R+ryqZ5BrnUWbVak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbhdH+H5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbhdH+H5"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc891373e0so19809615ad.2
        for <linux-input@vger.kernel.org>; Sat, 01 Aug 2026 04:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785583054; x=1786187854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/VG+5dO4TEq8eygHl1KT4HFqoXYTY3UsQSMOo7l/YN8=;
        b=dbhdH+H5Nfej8q32+v5J89Ear5dmSvtYLH1g/wd1tyiFaj70A1HBL6W6jkXwD6W0y5
         3Xl4ALhwFAnJgSRvvIwgrDmugbZsa1bMUtV3YV88VFKQJf3zysvrjtZcPjyxOHp7RRK/
         fNDfMdNhyoZ4lnPcNe3T2hyu6dRRTPBiOGbstgieinB7yjk9HbWopM36IAp9JeSg/2rR
         2C7kzlU8JBbSqUxzTGXM8NXWBI6pPLwrGx0f02jje/466SE/E+EaAjuoShH5FhssfVJH
         xqH2IBypJaXzBEcgHtCarLbmuMAjTcIm9uNRLeIQJAmhFZQGbjuYhzDUHwrxQfoeDEgz
         fIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785583054; x=1786187854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/VG+5dO4TEq8eygHl1KT4HFqoXYTY3UsQSMOo7l/YN8=;
        b=V1b6Z+VBXofAMx4QXpNL1V6ijSRHAXIk1OU6VNC9EOs8T4gDqCv5m7daqazvmaLYIH
         V4f+ovmlGZTqIpCSioRLbsOcDXKGH1k9OVOalA1dQ/pOmdQTKi10yXOfapt1Uk0xGSS7
         FYeapOVjk/azxgBc3D/pRbR2LPp/x1z3VWu3mQj793BWK3v0kXjgB8h5e8ykZKjDubf3
         W5J3J4/s+eRDlWI3dNE9q0c/m1g2H7GwT91IujRNUf4wzzvhHDStPFKCUf1kBvrgWMQU
         bqYVKaH0RDjsNGrVuV7NGpnARGq5YQVqzBmyvcdSAvSuX28rNY5hNTWsdMlEtaz1RAmm
         KRaw==
X-Forwarded-Encrypted: i=1; AHgh+Rob/vaclCjyumDLiYL8i9/H72S6bSwHiQqQ+uWCWq+sVxFdlHMJ0Vo8uAING7ULEf4k4vkFItF84ytJTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu0cga6qnPz74sjL08MznD3jxid5VnLoWe/z90uSWw3AdNiH2x
	dPo5K8cMOrBvsNzmmnDAFxATSYYavfG+eBcH4sReO0EyVX82HUkYFdt3
X-Gm-Gg: AR+sD12gOmi8fxRsYakhFghTeUdIa8kLkjoOSHaMS45Y8804gvhiudasi4ipWAL3TyW
	SmVTC2bFUxM26v3zDAf6FliOH7MJI18z8Y6z3glqJqiwmbScWcrBvyST5/PLufYIMgi49OzAbUO
	6M4iPsuLhw6+w12X8MHaOiI4lierU9kaKyEpy4189Hv86NzGKdIxlu6X2F7qvjFgMx3UoRd59nR
	24xVuQP2pOWoIOcfdBlgJwUUD9Jq4AiS9hfUjs+kI4nsroHIvKVikrgseQeIlklMSqxSMYXBgCN
	bHXl5wNvnREGDmCmic57jH2nc6kI07tT0uZY0qhK/pmKVNdxn/bG15ZZgHRdXEhiapqnn3ort/E
	ieepuPodr50ud5usAixE0coTE2AdOHbMnjf1/6DwUf1InikShEcqHBsd9aIBgCikRKH64bwnGUL
	1NE1MnS1HTq55Jspxqj1Oxrp4vDT9ytfYV3J4wC9acRWdEsMd2x9hApwV6v7I37qmnd+9juFXiP
	wr/XpfFDinDOD73EWkQtR3IV0RP3Olu
X-Received: by 2002:a17:902:f602:b0:2ca:e3f:6a4a with SMTP id d9443c01a7336-2d05225107fmr30254785ad.21.1785583053888;
        Sat, 01 Aug 2026 04:17:33 -0700 (PDT)
Received: from XiaomiLaptop (42-3-128-140.ptr.netvigator.com. [42.3.128.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b11e69asm16540745ad.56.2026.08.01.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 04:17:33 -0700 (PDT)
From: Andrew Zhou <zhoulol888@gmail.com>
To: Zhefu Zhang <a723356@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - add Xiaomi Book Pro 14 to dumbkbd quirk list
Date: Sat,  1 Aug 2026 19:17:29 +0800
Message-ID: <20260801111729.4592-1-zhoulol888@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260801103012.4142-1-a723356@gmail.com>
References: <20260801103012.4142-1-a723356@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Zhefu,

Thanks for looking into this. Your approach is superior.

Please feel free to add:
  Reviewed-by: Andrew Zhou <zhoulol888@gmail.com>

I'll drop my patch in favor of yours.

Thanks,
Andrew
