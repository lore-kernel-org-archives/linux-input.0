Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAAB38D68E
	for <linux-input@vger.kernel.org>; Thu, 19 Mar 2026 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930574; cv=none; b=oYv7FUcR0Qws/aYhtW4GE2DKAplXpkbYYpeTHxSJP4Lgv5PPYjmoUUWYcBfqVf1xlUKKsnZZaJmaMRB5A62ZqAvp70o9RuScNyl0lfu+IpOtccBUW7NNzWmOlT/rGBHR+K0nUtm2X2vNiYAwGZaqvbKBPwbq4ILwL7/edSlFbGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930574; c=relaxed/simple;
	bh=ClvSwmmtkzBXiXphxkK1ex8lGft+DN9Mx1wFMEacTiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=G8k3LvbEaIe5L5FWaBKwjCX7WuRlC5GEXvVA6jmxEAmpWXeMy8TIB/ezuPoApLUbueFiWM4TW5jaQ+f8XGnKUou3G7heEIQ0Oq1J43tTWc4XszP1ywuK0HBUbyRx6jsJmn5BRnOl7WwvSgePbiLi7fS0nTwgzzkL74W6wMQS4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=WPTB81GO; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="WPTB81GO"
Date: Thu, 19 Mar 2026 14:28:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1773930569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4radnMC090lS2rtEOXBuU4RadmReMtVlkQALqOTpw0=;
	b=WPTB81GOkvTgv6MgXSQu/p9DofPCBFi+MuP7JNB5Xr4QaXBAqA/R5LHSnBIrqABxc9PwMc
	o2J83KF53htQACrtWGv3/XcdQfphDE6PW7YMQmYWRpN35w34ntj5xGYHSPY+0hc/e2QZG2
	pseEC2q8kYDH7TCXeXQJl7ww7ghN7l6MG/cYJ3cey46DjZ5Dzfz6mNPFoV8RHcFuUybw8A
	HUfl6x4nLc0sWk5Ocqm5XKzn+roQQIYeLPd0fyRC2Mp9iDLEFnqPlNRqFs3yBAgsEqv7jF
	25tPCMawJX5H4AvOffgEI/0qaUji/Z2RK7la4isZW0PeWCccbmAm7KKBygAnrg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Hendrik Noack <hendrik-noack@gmx.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Hendrik Noack <hendrik-noack@gmx.de>, Ferass El Hafidi <funderscore@postmarketos.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Add support for Wacom W9000-series penabled touchscreens
References: <20260319095303.19927-1-hendrik-noack@gmx.de>
In-Reply-To: <20260319095303.19927-1-hendrik-noack@gmx.de>
Message-ID: <tc5hl0.um7mze1ddzgg@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT

On Thu, 19 Mar 2026 09:53, Hendrik Noack <hendrik-noack@gmx.de> wrote:
>Add devicetree bindings and a driver for the Wacom W9000-series penabled
>touchscreens.
>
>The driver currently only contains the information for the W9002 and
>W9007A, which I or Ferass could test on devices. It should also work with
>other chips, such as W9001 or W9010. However, I couldn't test it on these
>and the message length would need to be added.
>
>The pen-inserted-gpios is used to get if the pen is inserted in the device
>or not. It's also used as an interrupt so that the power state of the chip
>itself can be controlled depending on a change of the insertion state of
>the pen.

FYI the pen-inserted-gpios is removed in this revision.

>
>Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
>---
>Changes in v2:
>- remove pdct-gpios, as it's unnecessary
>- fix devicetree example
>- adopt to kernel coding style
>
>---
>Changes in v3:
>- fix missing include (thanks lkp@intel.com)
>
>---
>Changes in v4:
>- adopt to feedback (thanks dmitry.torokhov@gmail.com)
>- add W9002 support (thanks funderscore@postmarketos.org)
>- add reset-gpios, necessary for some chips
>- remove R-b from krzk due to changes in dt-bindings
>
>---
>Changes in v5:
>- adopt dt-bindings format to suggestion (thanks krzk@kernel.org)
>- remove pen-inserted functionality as suggested (thanks dmitry.torokhov@gmail.com)
>
>---
>Hendrik Noack (2):
>  dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
>  Input: Add support for Wacom W9000-series penabled touchscreens
>
> .../input/touchscreen/wacom,w9007a-lt03.yaml  |  73 +++
> drivers/input/touchscreen/Kconfig             |  12 +
> drivers/input/touchscreen/Makefile            |   1 +
> drivers/input/touchscreen/wacom_w9000.c       | 433 ++++++++++++++++++
> 4 files changed, 519 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/input/touchscreen/wacom,w9007a-lt03.yaml
> create mode 100644 drivers/input/touchscreen/wacom_w9000.c
>
>-- 
>2.43.0
>
