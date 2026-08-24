Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D47352007
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550924; cv=none; b=FDcm5a9l6j+mQ3pRRpHuzlVpulXDUN80KxFVO0S4z7yqcNe9RTgnMG9//tP99R3G+umK7usZmBH0yU8LE7WvvnITvqNLMFTUfAyfqV22F2cVMXClfOPn4dKQbCTOP0yAdd3gvboxikeS5r/8Bp6JIgP1c7VA0yiJbNAhm0+O4P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550924; c=relaxed/simple;
	bh=mKzNQ20U6ysiHsGmoKLXbpaR5I0jR5MXhcAU4Su6wgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCs59JXCHZhzx2YzN/L1JzMVClAh4DcPjKdjJL4UUkR7PlAx6Gx3cjVwER2xuWclD/RJDEE/WxrZmnX8abD3O5ebHQ0p7skhORj7RohZTxRunojPnjvmizhObN9rneDyUrG1IDT/4wyNLXUNfkwcwCL5Bxwg1UtVYIH8MK+GfCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG3pcVgv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG3pcVgv"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8486ac3f347so3544259b3a.1
        for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 22:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787550923; x=1788155723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mKzNQ20U6ysiHsGmoKLXbpaR5I0jR5MXhcAU4Su6wgU=;
        b=VG3pcVgvFY11l9xdstUFtNg39XRPRbRcaf5pqQYjzR5lJ5eZUXSSc7jvwHDJMAlf5/
         Qqm7ppxACj3EzRIg7RkWPt7mGVDQT6xQDrOkmij1j/huzpJJnFlhoExaEMIIPL4/xK0T
         P5uo0ggMStzxUZIEfqPXrV3/Exa2rY0k3X+iU+noC+mZPEDlSlaWmOLzh4/EbrlQw+CJ
         H8HndZkceRmRUFQsMw3haJM7E6el4OpoxvGwAlQyg9yeq5irid8ceHm00MwIteS1o4xi
         JxZlsS92BPsT3hYnaVV6S4d16eoimcnHnmFcIlzkWIDRPWOvNkIEjfzP9im+LZG5TYEM
         jbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787550923; x=1788155723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mKzNQ20U6ysiHsGmoKLXbpaR5I0jR5MXhcAU4Su6wgU=;
        b=XNSHHrWeNzyZ43YpDnvf/u8jcOk1yuKw/4j27GgO1+V8yL1lGOkLayyCic8vsQvRmF
         cGtbfvbrROy8qEJWxHJSN0x459DKJbKetOw+B6Ydj6IhfvG8575yzZXV5v5etA47jSk/
         W5w17MNXzL5gnc6sXCn/huTOOCxrC2043EgGbAwqrp/+JGVzC0+xVWdJaepYVlvZbDvu
         owhLnYn7Nnnw487Qb2VvXS0vDPQ13lBcUJhmhq1mXHqj4HHbhmdCo3mp4XlRkFXrtNEq
         hkl9cCFfpl0Wm8BmIltKjRm6cyZaZttQilpEu+FAxflPgtU9dPZdL3dy1/IoFLVyvY+f
         kBHg==
X-Forwarded-Encrypted: i=1; AHgh+RqbPqG9G3Sm7vL/lyfzDfC0KWY+veEG6mynE7/HL4NJM3M74dTMwToixLRkiAVPlFwaA3Blf0J4qqrqVQ==@vger.kernel.org
X-Gm-Message-State: AFuF++llw1qugAAhNSIew/R4Bgi6dK+zGZrqaHXiPGnCr5a4QpN5AH0z
	wu2o7oXoX8j8X8O+hCtmnjPC7RYRiLk9SEvGeMmf8d+VfJdnDjdabS12
X-Gm-Gg: AR+sD12JuD20ngBPO6Y7z6EZIsF0oQ1fyP9tOWettMBPIFTFE4pGNCQzOZ6r0ud40yL
	FtNvZBh5rOmZHUnHVQWwDNg88ct5I9sv1J4KuwHur2SuR/eXDbBaCaJTPCg5bBnEsKJ5ftj6+0m
	HrtVN4+jcMY6J8/FAY87rR302LbwfyIPIk0DYT4+MtTxuDlHpOypEj9rXa2GMqm+r0TAs/t3Ba/
	7PaI0gX0iAPH9R8HESSIc0L1NwoZsqWD602+8F4wZet9eDIPSorlXkol/jZ5kA1gtZu+fs0+5WC
	tt4WmNoqK/l7+5p7xpqD+YTEhzAauEPEQVcmoyfOdF69TQD3wndBSE09bl5Dwi0RZGDrnT9vAW3
	Dh25j8YjsUkpFEHqYuPE4SrTNoriE3LxZpZEEQOCvZy3xLNM5nwb9eoZpxpC5Ysu61zgm4WTBPX
	Xu9OTPKdr1P80pcVuYlX+mwxKS5qvdQdt522w4kiqFsqYV8xWRy/jcoF2qn/jo5uu8QSzFW7hT/
	R5nQLIWWTft8rnu4Kj8oYI5UGPIkR0/IfkR+cyIw+ksnQqbhTRzzSrqzF4UueUacpmDiCXRqmvM
	kMeEDbrDOOYZyLz8nahZY3Vr
X-Received: by 2002:a05:6300:6bdc:b0:3ba:d7b0:fcac with SMTP id adf61e73a8af0-3cd14d2c28bmr31801074637.5.1787550922737;
        Sun, 23 Aug 2026 22:55:22 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f923f2c0sm33338447eec.30.2026.08.23.22.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 22:55:22 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: 98lawweijie@gmail.com
Cc: aduggan@synaptics.com,
	bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Input: rmi4 - fix out-of-bounds write in rmi_set_page
Date: Mon, 24 Aug 2026 13:55:17 +0800
Message-ID: <20260824055517.695525-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260822121007.153988-1-98lawweijie@gmail.com>
References: <20260822121007.153988-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Superseded by v2:
https://lore.kernel.org/linux-input/00a489f38b240624dcb5a4bae36a53fcba9cfb47.1787549195.git.98lawweijie@gmail.com/

v1's commit message claims rmi_set_page() writes one byte past the
allocation. That is wrong on any kernel since v6.1 -- check_dr_size()
rounds the devres allocation up to the whole kmalloc bucket, so
devm_kzalloc(4) is a 64-byte kmalloc and that store is in bounds. v2
corrects the reasoning and adds one more fix to the same loop.
