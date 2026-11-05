Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.247.164.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884133;
	b=nfhdRusYzjOpD1sBEr2ZvJ+7LfWE8xlQm4g6/UBpzBapiGPh7N/icSxpCb4tZwFPDNsw
	 cjQaLgX5POZUqUJow8tBj4/YY9zt0RWiee9do2Wb2zvYlPeFPeTkurRF0KwKS3NGTiBSJ
	 TWA8A6T+WN3k0wMGpq96oFmxNL8etquABdE88B+JjTxz5agbnvn6Vwby+JPELAJo5ILlD
	 5uBJ0SyOV9n/npMI/+/+CwCBw/8Y3hsBdb8zOyh6YUcytWrJ6Gzay2g7zdOg992oiNBHp
	 2g409OvzGkqgFQajTySIwgmH4TdyB1WRUtR1lNYtUxlEkBiXZQd6iqlqWYSlkzJeo2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884133;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Last-TLS-Session-Version;
	bh=+3Gb1cybkRKoeLL2kGZWTIitMvdzJGlJP6G6wh553rY=;
	b=KuIDnQFZ16AJLLJpl6TCxt2ED2DHO48HWZZrP90r1bdlkw+PVWwChxPeuEQr792Q4Ymk
	 ekyWe4jdYehsUdykQxdT1HtaUvCabBJZX5X9pBriKMi8kq8qZWusbr/C2te8Ukppz9CMX
	 6j5Lh4D1P+Jar1swg+OZ2FF2L0K0PpJDAYW3vdHqovu64Rmsv97G4yGnXkE42h75qBo+N
	 pUC59A5nO44uk1/sYHnl+ZSeRv5HjGeW5NHtsAFXDFf/hYpU3NhDxQ6BGYUtTarrrizIU
	 Dxl0ZBv3TEp2P6xh8CPp26DhSxBxu2nelCcz5bip++mm7j+EEGCe4LpsLFmH/722XhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=koesling.info;
	spf=none smtp.mailfrom=koesling.info;
	dkim=pass header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=LQWI2NqQ;
	arc=none smtp.remote-ip=84.247.164.36
Received: from mail.koesling.network (mail.koesling.network [84.247.164.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98C8606A338;
	Thu,  5 Nov 2026 13:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C98C8606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=LQWI2NqQ
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B65601320F85;
	Thu, 05 Nov 2026 14:08:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1793884123;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+3Gb1cybkRKoeLL2kGZWTIitMvdzJGlJP6G6wh553rY=;
	b=LQWI2NqQIReu4FdhsO+Szn2fvUqPFXXl661BptJlohyhlnpD/Nt3WxwWDT2XD7j9qw8FuJ
	bmVMe1ApXM/5Jz3LgSgnOII2ak+8XxtqlGuWLP5KkTk8o/VnOqTd8wN6fX0GDlUet651yW
	awVctEyMfsXOVN3caSN/9iJu/0NDwQ1ZPyeQTyAQZ1VtqftlTo4jCLkyT9qVjC9EJqd2pT
	GO3I1bkwzdxaghejudVlmbPTyOKdZLDcw1wLUdZ5OQyuN8Dx2x54pyjX9S3gHFVqaY0WiA
	EmDLpnsv8ZQnRLw3fhLSBMzNfAVKrKOYueno71t4COJ5XNhUHlzR9Wc8wIPaIQ==
From: Nikolas Koesling <nikolas@koesling.info>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Aryan Sinha <sinha.aryan03@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aryan Sinha <sinha.aryan03@gmail.com>
Subject: Re: [PATCH] HID: pulsar: print the battery error with %pe
Date: Thu, 05 Nov 2026 14:08:37 +0100
Message-ID: <ldaTdNN0R-CJNS6mWTaQdg@koesling.info>
In-Reply-To: <20261104150055.33028-1-sinha.aryan03@gmail.com>
References: <20261104150055.33028-1-sinha.aryan03@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi Aryan,

thanks for the patch, the change itself looks good.
However, it only converts one of the error prints in the driver. The remaining
ones still print the plain errno with %d. they can use %pe with ERR_PTR(ret)
as well.
Could you send a v2 that converts all of them, so the driver reports errors
consistently?

Thanks,
Nikolas



