Received: from mail.koesling.network (mail.koesling.network [84.247.164.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80FF4FDE78
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.247.164.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458516; cv=none; b=gNhPeGos4uhrcr5eS6bSM/dP5pxtTcJUynKR06/8nqpev6wL2xKVNCwwPDCCSMg0qgNQjKH73VCVtWgKE8EQKJeNPrt0zPfXgZkp2Qc2AVZYtxe8TyQG99gr4QciLbjc/uqjRd2njsjHbb1y3FfAVN9Vrk3peR+AEn38w/S55Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458516; c=relaxed/simple;
	bh=CmfXo7KicD9tgtlY07pqZ30m0z0tJNYuk23LgWpYlvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7ImSWGBTkRHCvzfewcXRR0BIlLYgNNwdhAZ0yh0NPe/nwFuLzjxA085GeUzQY1QzaO+37GHiwHXZiN7d9evtV6fHytLsmX4Of6SiLe1WPpykZ4knwocumwJTe116ctDQ5yosfOGQvY5s7erLIHNXbcPz2vTEk/emp5xbRXCRkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info; spf=none smtp.mailfrom=koesling.info; dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b=bxmjguNU; arc=none smtp.client-ip=84.247.164.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b="bxmjguNU"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E65513207AA;
	Thu, 03 Sep 2026 20:01:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1788458505;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CmfXo7KicD9tgtlY07pqZ30m0z0tJNYuk23LgWpYlvY=;
	b=bxmjguNU75thWrbLLTY1KCPxcrm8bI4hurwTLwo1oUQDU0KDD9OxhDTcvEi+gImj9C5482
	k1wof5Pv8u6oeI1cWODwhR1ZT5Z9+m356JjReSvVNbPVR7t/fQ/GytRgzGEXB2QIOqGKpe
	G84sIYUhHxrI3t+ndVEo4fa9A4lMxbKPZO5qw+ckQBjs6gSmkMDY2YDNPELsBXFN0A4IkO
	MaE90FE1P+6Ch69omMKWkC9LLshfGXXNcDwpinCdD2t1NUi1HE5YH2VtyCfTRdNUhdg6q8
	HJLteUZwTq0qZ5wU7IDQFBZVFZsfF1FLAS8WCf5ss/etIq9rsqjyMulM7UCkHA==
From: Nikolas Koesling <nikolas@koesling.info>
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: Re: [PATCH v7] HID: pulsar: add driver for Pulsar gaming mice
Date: Thu, 03 Sep 2026 20:01:40 +0200
Message-ID: <IAIrszPpQYePuj8HVxs6Og@koesling.info>
In-Reply-To: <20260902163325.130181F000E9@smtp.kernel.org>
References:
 <20260902161350.22233-1-nikolas@koesling.info>
 <20260902163325.130181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider: - [Critical] The driver leaks uninitialized kernel
> stack memory to userspace and allows a deterministic kernel crash because
> `battery_get_property` returns `1` without initializing the property value.

I could not reproduce any kernel crash, but the returns `1` issue is valid.
I'll fix it in v8.



