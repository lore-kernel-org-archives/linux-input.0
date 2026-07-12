Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C94533F58D
	for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783872326; cv=none; b=VsqqqdyMg1lUw+dbkIS5voLLmqnzvkS/XBE99FA5Hdb6r66o1LPiyU8P3Bf334J5muqiKPVE8iz5ZXk7RUjtPb3SAEuMIzv3wzldykr/r6LRX7YszNjBhM5+J+wSTBzIA/pbnu63Gf3EtcPHLjbvbQXdMI4AvE2INfjzh+dok/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783872326; c=relaxed/simple;
	bh=HYdCz1xlLgU2B4rg61F8c5q4VwIZtY9jojDIygIHVSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g4DjaY5CC2EdRl9f6V/h91hkftXYb8Mnoj6NwfesMiK3UJFwCuxony7WcwmnVSNKrOvDmyoYCPCPB9NrwhDjLDF151FcGjHJlAAw83H7v9MEzWEB0IOhBOComgd+eAMgrYLn/sQ8nCeLWCaUpgoeu/P/zjCOSZGL1mbxFWbV98Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-845c92bc464so1860703b3a.2
        for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 09:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783872324; x=1784477124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qGY7taiLnmCSVR1KjiFJzcvjfx5XvByeFDnx9S/k8nE=;
        b=c8DC258NdpMq/75GByW0i2Id8JO7HFW8E5UOqnSXvlGJ207aHj2knuZygwvebxNRRE
         po3P7sDqrTYMejk7w81t9YPpVneAVsEp46rLwGidKM1N3PgDV5e12SjAjQsPay8c8hS9
         9Fx9WgX09Vibq6QZb3JQQ6M/17Xdqq8VxT5wzQg4uclfP4FkJxVtaeF4bBkL1LfyDB5y
         XIElbhLRjF9MSj8BqAyh8ZS4i+ygdzQHgyev0QmpTSvBIAkmo06baZdIFJ9qvcRrTd97
         yIIi5kt7VokwbSOmsKPG8TJwxo2txtTQ4pPqUGuTxUvfZ1lBiZeX8HkU9mILGi0nIIxK
         k/CQ==
X-Gm-Message-State: AOJu0YzhY34ayf/r2CroK2eq6cZymvTHLcpnqBSZqSojlStwnSNRzycX
	96bsOBb5VT1kAlVzrtTS0CFAVIeCr9GbqFyZ8haeTCch13BMoZsMmMg=
X-Gm-Gg: AfdE7clrlPEX6a9nXrtdLp0Oq9+eQefwtvjEw7pBAOSKHoTzib0wY/UJWA1DgqCkIcg
	fCa3cue3pn6gNRDP32QpwlU4dv1+1pA03lq+YIXUHCZ7XYtOrp3HxqIcwArq0Yagp2rEe05imc4
	69HpOpsY0sgtKOejiwhxndKwH7eAMZqzh/R+1vQ3jaXb67E2KXCv8+PT7aEMztxDBA6lhUe2xaO
	yhxkq8n1NGL8SJA6OJjHlO8+iqeLR9xI1rctVJDtjcKfkxnsMIgtA3mn2CMXZ5wkTEKgC8MI6BB
	UHMHyehMAnnIsRmsJZdMXjLmil4Y8GWkHcSFNIF+KLnog21vNk5rIQG7TYYcmBTM9GrQPSIQ3rQ
	OKgTc7kjFZuZDdFHzkt2xA5hLkN1xZrCp8WQNfXSbSpRf3rYMpta94ZIeWsfZQPDoxrQ827Bf6S
	tIhlSIDJ2ryOG3ucy/zm+sjWJGbpxuV2xsCpC8lic9ZgKpH9PKkf0Rr1rHRb6MLmtWgpfkJe8r2
	oHAOxzBKjgRbVm9naI5AWY/7EDrjewINNU8Lt7HzAMDMLbsrg==
X-Received: by 2002:a05:6a21:4cca:b0:3b4:8a40:85ed with SMTP id adf61e73a8af0-3c11077686bmr6203955637.7.1783872324462;
        Sun, 12 Jul 2026 09:05:24 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-44-142.dynamic-ip.hinet.net. [61.228.44.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3162a49sm7156667a12.15.2026.07.12.09.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 09:05:23 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: Re: [PATCH v5 0/3] Input/SPI: fixes for MacBook8,1 DMA timeout, UAF, and NULL pointer dereference
Date: Mon, 13 Jul 2026 00:05:16 +0800
Message-Id: <20260712160516.7265-1-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711055247.5412-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry, Mark, and the linux-input/linux-spi community,

Thank you for all the feedback across v1 through v5 of this series.

During further testing on the MacBook8,1 hardware, I discovered two
additional issues that change the scope of the fix:

1. The LPSS SPI controller (00:15.4) loses all private register state
   across S3 suspend/resume.  Restoring only the SSP clock on resume,
   without de-asserting LPSS_PRIV_RESETS (0x204) first, causes a PCIe
   Completion Timeout and a watchdog-triggered system reset.  Additionally,
   the IDMA block (which shares the SPI interrupt line) needs its registers
   restored to prevent spurious interrupts from masking real SPI transfers.
   This is a generic LPSS fix in spi-pxa2xx.c, not specific to MacBook8,1.

2. The applespi_remove() teardown has a use-after-free race between the
   drain_writes/drain_reads calls and the GPE handler removal.

Given these changes, the patch series has grown and now spans two
subsystems more cleanly than before:

  [input] Input: applespi - register touchpad device synchronously in probe
  [input] Input: applespi - fix use-after-free in applespi_remove()
  [spi]   spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
  [spi]   spi: pxa2xx: restore LPSS private and IDMA registers on S3 resume

I will submit these as two separate series to linux-input and linux-spi
respectively rather than continuing this thread, to keep subsystem
boundaries clean.

Thanks again for your patience and review.

Shih-Yuan Lee

-- 
2.39.5

