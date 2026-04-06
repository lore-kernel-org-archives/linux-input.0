Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6108E1A4F2F
	for <linux-input@vger.kernel.org>; Mon,  6 Apr 2026 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508005; cv=none; b=pkTrXSdQyF94SCo8qQO5zZ5VfJI65mh92kshXl73suBAnH0KL367FnnAZ0+E8tnxr5AFsgtU5QxIVQmpLZQ1LvlOuc8Z2dnipXqwExb0DDvOhgOTeIACsxYrhSyrg8gWLGTROvBgQOHDhgjs7Lz+SP58cXKYs2+2sCeY/amulpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508005; c=relaxed/simple;
	bh=wAzUYiyC/qldYt3rtR7GC71JBuh0zXTtX8/OPm0uo3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KefsoF+xIbYyjoxLxCBVOIcnlMDsJRLfkbcdXHRhalpFxbxn8j2SYl5WJttGKfMvqosPuQldsBDdSResCCN71ZJrW1Dw2AYtzr277QbG1EFsilvk5H7bpgLeQnu5J5bEQHhoDbFd8hyZCMCb9WL9KqE28IAGtEYgU1LlJw6P6Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVpXn8c/; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVpXn8c/"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1271195d2a7so9343382c88.0
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775508003; x=1776112803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAzUYiyC/qldYt3rtR7GC71JBuh0zXTtX8/OPm0uo3I=;
        b=QVpXn8c/MTjWnvFPqXpOAe0WFVaNfMQ/aD5WcT+C4J6dzbz/+NMHE/MtBN1fgr+GNx
         cZTGQiJmv7ZKCyJmCQLITSXhNE/otq0XL5auoJMi4yh1Jl34l3Qx+hpnVe788dmGwZCQ
         CpVyBF4O5fTdmQ8jgPHUbqLjsffMuxAHn1Yg5ac2ufFmdwo3Y9lIJRVHHdXc/sbNXhuX
         cM4FHmbrvST/Pqvnf2/q2qXpDL04n4kmNjJIKM5YeOAI468xjG0H5aKzGelWr+06SQ90
         bwZtfTx2iJ8Qd5GSb2kJbIpwkIKorW287QBzjg//74Qb07UccRMTUzk6yiBxU8NF9Wqd
         2BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775508003; x=1776112803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wAzUYiyC/qldYt3rtR7GC71JBuh0zXTtX8/OPm0uo3I=;
        b=Y3f9bHP7xMj7kXZH3yGBURPx+BnvXGdYTVCHu/LNy+4EfEFW/AT+YJ9rJMVWBpqA8k
         /bbYvXb3OQh4LMT6ZE0JaJpIMNcN2Ct1y+djXJVvk8LUMojEjAYOBIvxEaFi2jHAFudJ
         +dWkZIPqlwIJ+cnXyepRkru25aKHJ4XnAXSVdftvIFRyme7aIeETxR6XDeLUit0tJp1G
         9N0jAlPnJVSBiysHpv2o1uWo2Bh2eEhT1DN6Eejx++X5fqVfHnOFnk2Q2qVFvMKSe1W0
         AWRkGMebxhhn5yOQpGey1oIYGsys1HYQPFheaVzbNSHpBcdBKdzDB0lwys2ID6oGjVZL
         IpQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0RloHx5QvWTzrYm9/7vzz/uXWXnBYcmpltQ+PhqCqDqE0HzwVlaFe5mxiRgSd6KA1yZkqr6qaNJm71Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwS9XHoRcfcpaHP5cbtsH+44UejBqJizlq4kCXl/+EtT/bnqVZw
	RvHp4qDAKdv89Wj0al0Y1QuPxKpbYDz5492UwDjsMn46vdXYzLfPgyoS
X-Gm-Gg: AeBDies1PGP2gfCNrhxDaew5My7zwqJpULmqeL2arPuQ++A09zPFpnJqsEefOyZLzHm
	5/MsbhCkuEUnEy4Ttgt3ZxCs6L3iH9OYO4fPqqefZ4YBOFEzS5xLos9nJM+qmi+2Wd6/WDyViiP
	oJnAIzgBGDxwwDFNMcJ2Y1h+KlqiqeM6zaN9sH1AgcVDDd933IzO7oeIjwVwychsv0vXgQHYdP/
	KUlSkBTE5z2GnQcdAmwFQ9yfqRwdrmYrg0m3xhQCAldad2nOS3a9EEZ0fNjYZsbTVjhGRxuw4fb
	wCnE+9WvbKG7YLTR6kTaMN8yYWzBjpf+fGKlo+T/vrlxncex3InvrtTRu4G+HrFmSqIZbmS0X3f
	V5NmRdnVBCNeWiUecfF7q+hg/QIjryQrjaalJzYd/Pqm1BDxHPmZBpvGpFi/TsGCf3dvn4AhrH/
	eLApNkj26HxLWbRZxWdAHzoWBcuTJ2UR/Evd7VpiLoNV7pHtZy97yveWjjw5CBmLdSZcuYfhVY2
	/GCDhgU5xjrf/KMVEe49Zbf4lzG0yVM0d5ZX4i9P5jn/d1s05HF+pAkIss2CxCs
X-Received: by 2002:a05:7022:eacb:b0:12a:6ab7:3f8a with SMTP id a92af1059eb24-12bfb6ecb1dmr6616192c88.3.1775508003334;
        Mon, 06 Apr 2026 13:40:03 -0700 (PDT)
Received: from uf0ccb33743a85f.ant.amazon.com.com ([15.248.6.159])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bfea5f860sm11021469c88.2.2026.04.06.13.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:40:02 -0700 (PDT)
From: Armando De Leon <auribe84@gmail.com>
X-Google-Original-From: Armando De Leon <learmand@amazon.com>
To: dmitry.torokhov@gmail.com
Cc: Armando De Leon <learmand@amazon.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: gpio-keys - add hibernation support
Date: Mon,  6 Apr 2026 13:39:10 -0700
Message-ID: <20260406203932.3391600-1-learmand@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <adPdc2Z1SYxvqDmP@google.com>
References: <20260406160437.3084755-1-learmand@amazon.com> <adPdc2Z1SYxvqDmP@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry,

Thanks for the guidance. I investigated further:

The upstream GICv3 driver (irq-gic-v3.c) has no suspend/resume or
syscore_ops for the distributor - it does not save or restore any
per-IRQ configuration across power cycles. On platforms where the
GIC is re-initialized by firmware during hibernate restore, all
trigger type configurations set by consumer drivers during probe()
are lost.

The IRQ core does preserve the trigger type in irq_data
(irqd_get_trigger_type), but resume_irq() in kernel/irq/pm.c only
re-enables the interrupt without re-applying the trigger type to
hardware.

A fix in the IRQ PM resume path (having resume_irq() call
irq_set_irq_type() using the saved trigger type) would fix all
consumer drivers generically. However, such a change would have
broad consequences and impact across all platforms and interrupt
controllers, and would need very careful review and testing.

Given that the gpio-keys fix is a single irq_set_irq_type() call
in the .restore callback - minimal, self-contained, and low risk -
would it be acceptable to handle it at the driver level for now?
This avoids the risk of a sweeping IRQ core change while solving
the immediate problem for gpio-keys users with hibernation support.

Thanks,
Armando
