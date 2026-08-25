Received: from mail.koesling.network (mail.koesling.network [84.247.164.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC24930E85D;
	Tue, 25 Aug 2026 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.247.164.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675174; cv=none; b=sWgjvqc7mEeKZSK2Ykl9ZOZYoTvr5/cRvCLOrp7E5Od/lHSRAIwb8TbhghACEtIroCbgq+6k29MdrKihrNduidninOhoDrZscltLtF4lmR8zL8XKfGWRtQfdUgfGitA9ng5fo5YgYrISA/11ix+lLOKhCC/Ktqub0wkttaWbSQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675174; c=relaxed/simple;
	bh=PucNHIyGSDY8C39gvejdbVTF/GBtufeAZzeM0IDsXWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rclf55XNU6jDde9qRXVM+WpV+PhPG5w6i6rvz0WjKV915iodZ7PKNYDyXRQgfIeD59hK4asBOoHlokphhR9rb/HN+EBdjUSsbE7mVsXuYGQxPTCeGXw7cEYY9zwklnA6Q72aEMi2Wzf70wYC4y2BjDeAIwkAzqvf5Ocye4zi6nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info; spf=none smtp.mailfrom=koesling.info; dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b=KMPEE8rH; arc=none smtp.client-ip=84.247.164.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b="KMPEE8rH"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5CCED13207BD;
	Tue, 25 Aug 2026 18:16:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1787674598;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VZJy7ZEWwH8X1FVs48K4BH2TMRN7vmBY95zf/gVJhKI=;
	b=KMPEE8rHDOjxsMQu2SIgGD/vO8iR/Rk7VmtyUkhS9Qqkf/Q5HScDnwGvjdBhUIsd2H9/hC
	ItEHQ8wS1QBhHfzpKPMDpbSdqkexoH5pp1dWwSvHbMPK434QdkYRCgfGaowITf+HVeiEmN
	CrCKT82DUg1eAYE+hGsmZ/Ld3waYLXXwEiQVlh8QSB5fJtCWNJuGudXJqAEdgv1Lk8mfCL
	+h5Ze+HnnPwB2Ju08k+y8vmxWcwAffgSRMCmgKQFhKe0+336pHlbdYU2WLe+yc/Mc70QmJ
	3VTAS25GxqpGjp8Pi7jOo1voDotUpLxcuTFmI9u3udszug1BCiAb/6hRJCeRzA==
From: Nikolas Koesling <nikolas@koesling.info>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Lode Willems <me@lodewillems.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Leo <leo@managarm.org>
Subject: Re: [PATCH v6] HID: pulsar: add driver for Pulsar gaming mice
Date: Tue, 25 Aug 2026 18:16:35 +0200
Message-ID: <kkeAMDC3SWK-QpJQfKGFbA@koesling.info>
In-Reply-To: <ao1pMvF1_yXKX4D_@beelink>
References:
 <20260816105423.47305-1-nikolas@koesling.info> <ao1pMvF1_yXKX4D_@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi Benjamin,

> I'm a little bit worried that we are at version 6 when a maintainer
> made you a remark at version 3 that wasn't addressed nor replied:

sorry, I missed that. My mistake.

> About HID_KYSONA:
> "I guess that we want to just ditch that driver altogether then?"
> 
> Having 2 drivers for the same device is bad. Simply bad. If hid-kysona
> is not required, it should be dropped. Please, don't make 2 drivers for
> the same device.

I'll prepare a v7 that removes hid-kysona.
Is there anything else that needs to be adjusted?

Kind regards,
Nikolas


