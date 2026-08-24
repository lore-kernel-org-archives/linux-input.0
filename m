Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3C417BF8
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575106; cv=none; b=oNFDNX5kUJy61nlQxGwmOtEuFzEUngNGe+letTFuxmTZ4Qhfl0t689m+jhloTS+R2d1GHiCPATOaOaYxCcrVo7gqgyJgbnxhtpiEdIqSo4YPFyjMVocGB8NcWKX+We8j1HXhOM7eVr3u+x2gxpUbkZZFbatIICsPRk0uVkauZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575106; c=relaxed/simple;
	bh=wzX+vFX1dcXqWbOAwypTFTWbvxhljdAMpWM2gJEV/Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tat7LLg+7UfhO3EQpjceFavKRGWbxHXaG9rCeaUcc98qd/7raPnCPSDd4mmcvrsFTejr5iiAFb/MSER3YJTbfHsIKUpsWK6iST5AzDhq2qIHvacGF0xfAC88pfcVkIVgpFNuE8sxug8tBP8V8Y3LFqecK8u1vTMSbcYe6VkbLW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oe7kIJd5; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe7kIJd5"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb787dec99so3045646a34.0
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 05:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787575104; x=1788179904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wzX+vFX1dcXqWbOAwypTFTWbvxhljdAMpWM2gJEV/Kk=;
        b=Oe7kIJd55WUzN13BTiExysnthbJPhQzfD9CCWkhR1h5d1+jWGfBz93JqlA6pIc98Jq
         KAcw21g7y90wt1Eo0E2w57osS5QuLJjRuJCJPjJ9KA8BueLQwPk1ZmT/vDeQoKS4Fna5
         JCoTkHMVI1Xwep2c8ZjFnmBZGPeTY1coCx/Jtwvq24I44MBkxnFj4lNtbFLnDXarzoSw
         upRMHHVaK9sg3Eu2gGgmqkvD6btjVyZ0ORQ1cVAOe2viCyXC4BAD57Gta6sW63bp5Z2/
         JfYadIjdCsb3uzOIk/fIMEd5eu/YAx5Ct05pWTGhHcexWjBm6cQM8Vj6KWV/t4aL/Wsh
         HhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787575104; x=1788179904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wzX+vFX1dcXqWbOAwypTFTWbvxhljdAMpWM2gJEV/Kk=;
        b=kclSucKmhd98T+8pvXWiga5I5NLHoyuDK8O94e1Q8XY+txrjRPEQ35QRaofssssNHY
         1J6znuolg24/EXFpHU9wsOykjbDVoJB1PSAGufhf8EIFDRWrGFiNuBOlzRBVg1G1+88g
         uKPk/tf/ZsPU9GcpcD2mNUxLWi939rlqjWyXWD9fMXNBF2VJCNav9o05u9KL5+B23gzb
         1ur2JHIlZC6rHLFEoQ9MxLCw4/n8vKBezuv5rDmxXWk5hfEsiWr3PRrXut7g5obIMMq3
         Dw1upqePxI257e4jcz6/VVF3B2aSBQxgd5AbnUhcaS+MMTk49LuD5VPBvGtolk5ecp6i
         Yhhg==
X-Forwarded-Encrypted: i=1; AHgh+RqJ9f7DwygKtCLs7F103kQ8gutIUzDrdu109R9m3sigAwWPmsj3fbwzZ4zqrMpd5zgyLlT7QzHvczjT2Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mAqBzoH0pD54kamhaQIfGYXBsXmzmbLPcaq4ro0uZUHj61A+IP
	zr/nXW/oNg9W4jgKJh5UMLAhS7wZ9hnCCWQ4k0/B5RSFN2MVdreb2sry
X-Gm-Gg: AR+sD10e6SFvPncWv13Io2VQSeMe+ZZoCs8ARx04QAcVOd9XSxa9UDpSiUwJPNyUse5
	supMHSLF3pac2hf00MtUAB0n0TuxJHkXUCUL9+K9JLe14hTP2fR1D7MIb/5tQRoisq/+pPUlvHg
	KkTf1hgbtlb4/lcmztnV0hj6J9JRTi9sNMUTO4A5LVwt3KAQXdtT4aD+bYUkw8Nhm6MWMO9UFOl
	uCQNEI3rucdjrHSPoILHm2iAMdh4P2plP7tNCFylqWvCvDmA4kS41xo2kMTmYH1CgVnNp00JmfX
	m787rFR6efjecNjpIi2D+xgB+jeo6KIXVihTl+O3ChiL+WAMxOv7QwAswLsX3DuPh4etAF6L/Ms
	xAsiNVh/rXLTP7tiIs1tSStSR4/D4cmZIYZX1MK7+U7re5FEjh0S1VYjQEDdfZCHEByCKjPYg65
	uFialrWrPmj34FIK9CJi7mpOT9ZIVkGXpkak/YCaqeS++ml6+k7ug85ZaTz6tUb1TpypYvNilt4
	YBbNWhRrHUA+q4N0jVANNHdH1WYVGDf5s9RCwx7nyYp5g7C8AkKcW+qbtnmqNeRo2e2cIS0HzFE
	5ayt5/WAAGgEFFriy7tM9ezc
X-Received: by 2002:a05:6820:1887:b0:6b1:59e8:6e63 with SMTP id 006d021491bc7-6b16b4ce0afmr15351708eaf.22.1787575103709;
        Mon, 24 Aug 2026 05:38:23 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46383539b74sm4832238fac.14.2026.08.24.05.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:38:22 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources
Date: Mon, 24 Aug 2026 20:38:17 +0800
Message-ID: <20260824123817.78590-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4a48122167e32a6755d9ee7033f29bf7c78be796.1787549234.git.98lawweijie@gmail.com>
References: <4a48122167e32a6755d9ee7033f29bf7c78be796.1787549234.git.98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Superseded by v2 1/2:
https://lore.kernel.org/linux-input/20260824122733.76321-2-98lawweijie@gmail.com/

This patch is unchanged in v2 -- the series was resent because of 2/2,
which disposed of a rejected struct rmi_function with put_device() at a
point where device_initialize() had not run yet.

Please mark this one superseded.

Thanks,
Wei Jie
