Received: from hades.hosts.managarm.org (hades.hosts.managarm.org [195.201.36.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D331E82E;
	Fri, 20 Mar 2026 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.36.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014837; cv=none; b=CPTfj4DZ14ZY0T6zQfyh5Y/wdDcJiVSJAQPpZkgMB4KAEb/Ik5qDY+Ytrt85u2vt/srH5w4GV/DgHU1iv09Fpctn0NsUUIU8Uv2WfUPlYsJaY2DKOqsYmfYNCFrPIe8rkWhNCz2HAd8gRybfcaGzjVXsN6Fx/5PMi4xmLMtPJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014837; c=relaxed/simple;
	bh=PR6EGXVTIw5sq576Ai+yk7UfGQsbIqIM6X4n12obkEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTseQmByMssOY9uABpJxwo0uKaK4V9uV4SE8tvHBRa+2Ncj029xdRwz4ncWYs/dycgaAXpE078OAU3OHauMbURqF7ucFf8EMs3AA2PJ2xkLLCnNNAyP1uWVTmChSrXf7FWi8mwNj7ljmC8TByGYNutKN3qfqeQ0LeontN8dhXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=managarm.org; spf=pass smtp.mailfrom=managarm.org; dkim=pass (2048-bit key) header.d=managarm.org header.i=@managarm.org header.b=pxmbu7um; arc=none smtp.client-ip=195.201.36.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=managarm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=managarm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=managarm.org header.i=@managarm.org header.b="pxmbu7um"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=managarm.org; s=2021;
	t=1774014826; bh=PR6EGXVTIw5sq576Ai+yk7UfGQsbIqIM6X4n12obkEA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pxmbu7umDsk2pFvyHbY7M6TT+T1OEhNGIYAX38CrI/ZVYgtvDa68hOfq1idla/yW4
	 MMV73L9NLD3yleEvYgSRkf54Et306WFg+Z6g6mXFVcmgabKiauCyyW3CfVeR2GYqas
	 jerGfeEtJ1JZgp50Fa+lwRSMYHxWctTWsvGRaUOahLIkxCz4TzGBcDzLg21qO0k744
	 3W9jk7gLeU7IHU95kaG+LObVDFJ8rc6+42x8pNlsM+lDNp06/1exrJTKitOgZ19x/W
	 AU6GHsugwhj+G6/IvIrF1R9BlclMkyojP0QSnPwQ/JirFC8KKi5RWAVepL36iFt889
	 9fQTCr3HarYeg==
Received: from [192.168.1.169] (p54a79cbb.dip0.t-ipconnect.de [84.167.156.187])
	by hades.hosts.managarm.org (Postfix) with ESMTPSA id 7D7583FAC5;
	Fri, 20 Mar 2026 13:53:46 +0000 (UTC)
Message-ID: <bfb2bcd2-d484-40b3-a548-ccdb6c88a75d@managarm.org>
Date: Fri, 20 Mar 2026 14:53:45 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: pulsar: add driver for Pulsar gaming mice
To: Nikolas Koesling <nikolas@koesling.info>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260318205503.64420-1-nikolas@koesling.info>
 <8590f544-9146-4e8e-9ea6-a3ed9ed9fa1f@managarm.org>
 <2344095.iZASKD2KPV@nk-eos>
Content-Language: en-US
From: Leo <leo@managarm.org>
In-Reply-To: <2344095.iZASKD2KPV@nk-eos>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

> With three vendors sharing the same protocol, a vendor-neutral name would make
> sense. Any suggestions? Something like hid-paw3395-battery (sensor),
> hid-nrf52840-mouse (SoC), or is there a better identifier for this protocol?

I did some digging into the protocol, and from what I can tell it is
not necessarily associated with the specific sensor, as multiple mice
with differing sensors speak the same protocol (PAW3950 to name one).
The nrf52840 also does not seem to be limited to this protocol. I can't
find a public name for the protocol. Given that and that I'm not sure
what the subsystem's policy on module naming is, but I would assume
that changing them after the fact is not ideal. Probably (?) the
optimal solution would be to integrate your patch (thank you!) with the
existing hid-kysona driver; maybe a maintainer should weigh in on that.

I added my mouse's ID (3554:F58F) to the list and tested the patch.
Everything behaved as expected, UPower output looks reasonable. If you
like, you can amend the device ID to your patch. The `model_id` for it
is reported as 0x0220, and the model format string should be
"ATK VXE R1 SE+ (%s)". My 2.4 GHz receiver seems to not report a model
ID; the web configuration utility uses a different command to identify
the mouse model. Given that it uses a different idVendor anyway, I'm
not worried about that for now.

Tested-by: Leo <leo@managarm.org>

Cheers,
Leo
