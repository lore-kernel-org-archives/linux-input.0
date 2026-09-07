Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9EA3644B3
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 04:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788755050; cv=none; b=XpKLRwkk2MzUfrG0fq2S74bKwNZLMWHqPEAeHv8fkmSTlGHelZ+e8V+o5QfAFX+eqUSH8mUqm9N8zrp94k6bv+FHYJUvkLu4yYz/xnTtB4KE+Y3xE0q2fP3F43P0XQYWUxqKDyOioyDUAgP0z0Tqoabn8k5TczUQBe11o70xEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788755050; c=relaxed/simple;
	bh=7xvzWPsbRUjoKFIeIpJ4LNFFnqsIGbmsPP/3C4GXOA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DU4K2Bgn8n5LTIQEy0N7V+5YP11ogYwf7/V2U7YwVTqCxHhmhuwLDF8W9FYvigvA+xc8Zwv3UUwtWl5+H3vazaPZnvIR4noeRKfFHMhSigbrbLm0cAKU3VsTLOw/uKgq22wU4FRLpCFEyhv+McQuOvEu6ZMZFrH341b4Q4QAOeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZ5L0vra; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ5L0vra"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so2697699a12.3
        for <linux-input@vger.kernel.org>; Sun, 06 Sep 2026 21:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788755049; x=1789359849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PmXzGo6t/wlmSCym3bZyWZQ//t4eHunzCgozWLux0nM=;
        b=mZ5L0vradIMILAvIhXttMqcIdmGyx1ScDZesfpP42KfjIpwlXr8bnAocNiAZ/qgDMN
         sUH0EglxahPdvR8X31cQEeLh5wz+6A0jpkFljZ3rxWki1w3V859x+llhw/njHJL2D2au
         dbvgPZvmgvFkPYwJQpqlv/4NMTznf8UwDAFDdUgQr+5GY4r7UeOMWGaQYtU3TAI7Rfq6
         x6DHfijxk8eyVUnpICnVth2FzNdOE2mkOke7ZaH89pk8t32PBtjI+XqqzqKfM1no02oA
         9Tvp5TD2lXHzQ5vgpzRZZzakjhKCz1kvKx9CWjl5sx0lOaa7UBwdTr7kpX51xGzuaPiN
         XUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788755049; x=1789359849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PmXzGo6t/wlmSCym3bZyWZQ//t4eHunzCgozWLux0nM=;
        b=iza/IQGmNq54EDcVB3QkFJUuPelz8sGVYjh6UW7bYs9iV0rgF025SWQiHqaolpH4Ec
         rHXEL/4jdSZ9TiBgPh6ygFHl1Uqjtz5y/tObS5RNj9jvek8IVl3VcrTqtqSX9KAvJk7B
         lu/OxbCBfsyZ2vxm+6/yPVrp2dYP6InlUpaIze3LqFg7hv+xESz0Wx9EjsNw/87+n9JE
         V02hd+7KxiLB3CXVptH/ycSzcVB/pIS1MhVNqa2kbxlrY1Q7zVWqz2tpDh1gs6OkU5vq
         vINl9l9+Z6C/9G2hO51AF5qm2BgXfQGLn89NcRaomL3pA4I1J2k+Zbt2Gg+Nv0uRMR6c
         xLJw==
X-Forwarded-Encrypted: i=1; AKwUvBxwtSQlXyqyE0g8RGU6HBrs7jqg93QMQvNmA96e+mByNCCSuBm8jj6mLPExXpy8NVB641orNXKjm5AfKQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m0AxmQoGvYRdrJ1QLe/FYG9KPzL+1RfEeTNZghAO0PsyxSqbxq
	eblAe5IaLdrWJPC5eadiEdQJZrkYv8jv7VJX1O7/qnHIl7ErvxElURvb
X-Gm-Gg: AYBFou0Hfn45JTLll1nxONrnIvfLMzVOte7R5AQsSP/awRI/2bm/O8YlYibkvaQuz2D
	tFvrIsNMfVmQdxDgD9AR+/YXrSzv3ocvT1/d1siX3i3eIa0cEmFCwpW3qCwQ0ft55Z5OXPFa/Cw
	/47VqWP+601emV1sTAZ30WmXzFPmwE1nL3IpAl8Y4SaoK9xUH4P3AzSdmO+I9+rtJHBf6aj1cS6
	/uMpHDFLVJqq0rHmJW4alvQeCsYxUI60g5/nMe9KuF1CB5QfAV7UVKQZ/9WHWBPJLPIJ2Z2UeAP
	7idUkeZHexHmPxMU8CdhMO0JslAOzzvNjDKsz+dpmz2Nhw99uroEH8QaABsYsumrifOzLRWxXDF
	O9qBryuGT48g6a3Z/X7RSZVjFm3A/1Jbp8dp7qNHhSGcV45vW+1kcA61h57jTGOpF6keSYopCpv
	DMqhgu28c5kspQyUAgdyjz1UwT5ewa5RsfHReXVXkmTfEsKn9uZj5TQc4jrtjy01V5bF4yW7mFI
	t5tLsDwnofbEA==
X-Received: by 2002:a05:6a21:138c:b0:3d3:afd9:6040 with SMTP id adf61e73a8af0-3da3a1f77f2mr32584655637.27.1788755048746;
        Sun, 06 Sep 2026 21:24:08 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3342af0bc08sm22629643eec.17.2026.09.06.21.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:24:08 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 2/2] input: fix repeated words in comments
Date: Mon,  7 Sep 2026 09:53:58 +0530
Message-ID: <20260907042402.12893-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904111911.32224-3-hemanth.selam@gmail.com>
References: <20260904111911.32224-3-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please drop this patch.  The sashiko bot flagged it and it is right.

  drivers/input/serio/q40kbd.c
    "It allocates the interrupt and enables in in the chip."

My patch deleted one "in" and left "enables in the chip", which has no
object.  Reading the function, what it enables is the keyboard interrupt,
so the comment should say "enables it in the chip" - a different fix from
the one I sent.

I will send that as a separate patch if you would like it; otherwise
please just drop this one.
