Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010695;
	b=t1gYBGeKeTS9G+6RM8WWoWellVLv/2shrv9hn2tA7z6Oe5PuShzmC7UtTyR/htSjF1cX
	 D/0RBYbMcCbyoMN/LHSw/EIzYvxbw+mevX16zxsFMlxbtR2fnplCEINvAZllMGetDN964
	 sZv0+W5mY1j4mc2SkHBpOcNSS8iqXp1DF2ulDOK2ezlXUBBx2ParETkCzicGTzWMS1Ur0
	 dP5Liz2VJjFrbTIHnQXO9CKnHDJPXM7mXvY5yoN08I3ivoHEncYOGs3RgaNvs4llK9vRL
	 XJttn+eG33hM+Rntl2L8mfsePrdZgWkjATPArU3gUG3Xxw9+lG93NL6LaX1OpM07ZZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=mh73tfK9sDn7RbbTRMru9Vf8rP5PE3uqjzcCQ7dBz0s=;
	b=FKUq/Fh3fmak0PPFxiFurnEAcfUoPRnHqVPBq9E5EqIsmXsDKP5vZIltTluMlURfMl9C
	 YR7Kbj8BekCb+Rm+/T3Hhl8V6/B72leObi1o++2TOtfkUvJNvPcLQgI22f/30kHs7bhRC
	 h8dXTkKHVtyC+rGTrCg1ifg5Lx1vQZR8epeHckzfdW066uhtpof+nutKb3GemxyQaUtI+
	 osgToinYccV8U/vC5zWyhJchl3yZzGJtufj1caEr6gVrDhM0EYtmg+ZCnZUuiA1cOwgxP
	 HxjSFsrC8sCI3jbNE9OYeY36FUGoiWhxLEwG2uFlrPCT0ETHQdoTZ6GgLDq8jJKk29g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N24soTvd;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A2606A32A
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 14:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 346A2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N24soTvd
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so7946755e9.0
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 06:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010693; x=1795615493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mh73tfK9sDn7RbbTRMru9Vf8rP5PE3uqjzcCQ7dBz0s=;
        b=N24soTvdqlDz0PGGx5sxSUmVDBiBTW24zhrE+/wkAtZvRc7gEspfmX/lQV3jv2fAdr
         KLQuvL3HWz/HQPe0+gkzB7ITjoaPO35TLI7C+z2xTZKMLs8URTCMBDuCl2BnPdwEB5YB
         yUTmb542FNa7Q2nPm/44n/qYllq28HYUCUeBDGpuNvyH2mAsTy8/8ydF17TfeA9w6TQc
         XnsoxEtJseUXMHx4bkkmHwY6BaxTSIfCwwj0CHulQ/V8aiOh4NzDN/qTqXaqqAZWmVwo
         ULUJyqZsvWFNoz4WHGEpRmiEIWc2/WJSDye9PkG4UeJ+aKr/rGm5Z4n+JsPVIEnDBaCb
         rIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010693; x=1795615493;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mh73tfK9sDn7RbbTRMru9Vf8rP5PE3uqjzcCQ7dBz0s=;
        b=EqHKqdYO8hlBUB/wXsTzPUcJw+tBl0d9kT/9Ixo+Lu/Y82WsVswnJ4OCJFKxFkvAoX
         V4J+iNELx5bm6WPt9Tk1bmWm80LhlwgSgG+gAuICn2mPaK2EmpHb327EoUu+NCu2JcxY
         tgLTBr9kvS2GFzfdGA6rR0rvzC9jOO3jC8gHQOTkm/6Vwi0Nah2njdUSTSPxSyL8fkKC
         Cr95HkovCZEnorJbT3MyrnYdMUdbvHC5CBjWCf9knxYh6szCGiQZj2vt1LJwWfwmg0zz
         fqcJbjstuLpmivcxk8ZKxZcSiCzDLOSfiAZlht+lFPtFy8hrrTLpbFr7qtXIeEvteBS1
         LPjw==
X-Gm-Message-State: APuU4Z9dusvNNNo6slmk+NeqHg5kIHDruAeLD4q40aBrTUrEGYNBClfH
	dhOIb4OC06RcnkIc+2wE6Yl6jyskXTSsPoPvnWhP+Csm30kmIM3Hfv40
X-Gm-Gg: AYBFou1vcTDLDvUqmW9QF7BtCGbSLh3geB4IlNPMPtPfNjVkVPJhGkbafKaGJxZzOrp
	Oxe1xe3T5hgOGLN9W4l3SWyh3txfa400aoFCWnyMu5pdKr2Ge3BTFe79HhB+zs/F/fMBT7+mUDB
	o11EIRskOgeRVwUBDtfW45+onUk933VgeJXfW8crXZaiHKjHfZllrSRROsyfynNZCF3yJ4ITF3w
	TubhucELyHgcAeGJKVDSQ2gbOL58ozczVQc14gpSPQ6mHArlcOfXwvGx5iQ5ahh331sZf7u8vpD
	Fy9RBF6O8Kut9GEEExXw4PLsJfFycQPF4WBOWxhHZe31tGlbZWhIwa3/W4qR/Cy4u9ZZL28qkCz
	qIs53EUDTzgj5x5aqyE1wZzpir8KpbWB+cOrXlvitIa/XwFerRTON6th1aIgZg78Ia5av9xtluu
	QbzmFpSjNI3gUNFoT4FFKEzFOXADeARP+mHlMzipi4ExZ6CwuMWEIgIAWH1J8Qm6FZ+oYb1TgpT
	zTcX1zuhLJ1nLvlyUSDzxFi0f24xC1DxLjWzgz9/v5LnJ5gv06xIN6JJIO0c6URAXkekgxZOVJi
	wpCZHI7midYMd1wMcGDOdktdODHmVVTLRu71/eqC70InYlwPkUKdWy3Iiszc3Mzq8voD0TflkOV
	ERUIQmCmPNw40
X-Received: by 2002:a05:600c:4e44:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4bb7da12957mr49320645e9.9.1795010693113;
        Wed, 18 Nov 2026 06:04:53 -0800 (PST)
Received: from gmail.com ([2a01:e11:1403:8620:8839:c4ed:3a87:cb27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d2b74d6sm68201545e9.9.2026.11.18.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:04:52 -0800 (PST)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <denis.benato@linux.dev>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	Luke Jones <luke@ljones.dev>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Ivan Levchenko <me@livan.pro>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v4 0/7] HID: asus: ASUS Zenbook Duo keyboard support
Date: Wed, 18 Nov 2026 15:04:51 +0100
Message-ID: <20261118140451.100089-1-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020092423.36380-1-p.pisati@gmail.com>
References: <20261020092423.36380-1-p.pisati@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jiri, Benjamin,

Gentle ping on this series: all 7 patches have a Tested-by, and all
but 2/7 a Reviewed-by.

Could it go in for 7.5?

Thanks,
Paolo
