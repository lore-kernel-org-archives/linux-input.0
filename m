Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.245.251.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795169460;
	b=s24f6TXBbDJ+dV7eaK9PaWU/qSbE/4lb80clh151WuCyOx7MYWol5F7qRH4ThrziK6Yi
	 yPlV29rvXI+TDYJ096Y4EHC+sEPQanQnSjucd0n++8qNKprmjSPAfQfDPyWtvgtYOLwI5
	 UM4Ld5TfYcCR2gOoKVMbS63xw6tmN+/abLUyIBP1IrpFPv5vIy6k/abjAQxJcNOeq3qfW
	 bz1wIfU5zbFiQOMotdMDlBJo/ym/ML51qq5C09gMUSAT2djOwLzfLzbGwaYXYHJ55hLsS
	 e5J1Fe1Lar7j03GmO22GsBFC4b8aVIklR9vO0i2kq1v1tGOu3xO4YMQpPy/0gmIjgPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169460;
	h=DMARC-Filter:Mime-Version:DKIM-Signature:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To;
	bh=zmfmGNg7qAeoVakdOVdrpQyQU9vKkeYYx6KvwahRegM=;
	b=2mLe9To93yBMc1EqzYt/z+bxqRaJR08P5FPg6UtfxSlU0vCKkYgkYzNxUuulNuB9zRxc
	 JhyDWBxqRtOP6ang8tD3HymU9wVlyE5hHgqLzWjGnKY8g+LhfB1wBQ9Q8Ry3pVe6M1sAu
	 lqIXU19/moDI0MJUsTXH8TFly09+YI5T/gVOzkndapDa0cA7dmuPCBbhbbrSpjdet3ud/
	 Kd8nuxN8aGlfdk1NQPvxiysoBX9rM2bN/bPwcAukM6ocFbjOmF2jEBHmsQI2DcFaj+5aK
	 FJCzmha3FvShM+vH8Sq42XVo+ftN/GNdPXlaIbbZgmtRUuOJfYFMu8f9tWFVE4eDGUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fhannenheim.net;
	spf=pass smtp.mailfrom=fhannenheim.net;
	dkim=pass header.d=fhannenheim.net header.i=@fhannenheim.net header.a=rsa-sha256 header.s=mail header.b=B7mlpcU6;
	arc=none smtp.remote-ip=188.245.251.181
Received: from mail.fhannenheim.net (mail.fhannenheim.net [188.245.251.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD055606A326;
	Fri, 20 Nov 2026 10:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD055606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fhannenheim.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fhannenheim.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=fhannenheim.net header.i=@fhannenheim.net header.a=rsa-sha256 header.s=mail header.b=B7mlpcU6
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fhannenheim.net;
	s=mail; t=1795169456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmfmGNg7qAeoVakdOVdrpQyQU9vKkeYYx6KvwahRegM=;
	b=B7mlpcU6OPTCl27w0tqCSDzNvsgIaDIbbV/GiBOPGI0VkqqI5atpmNkYWrGFDg2h1l4p5U
	xF8qZ3LQKXzHUN4raMR2zB9gnynJ23JaBlHrGQNf8J6YCZU3MYYIu6GJPuxMrJTE53WZRB
	wapPop4EJlK+ZUaLH6WPCQ2pjyY9XSM=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 11:10:53 +0100
Message-Id: <DMZYGLZHLUL9.3TCE7LHEO9AQC@fhannenheim.net>
From: "Frieder Hannenheim" <mail@fhannenheim.net>
To: "Vsevolod Nevorotov" <sevanevorotov29@gmail.com>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] Input: synaptics_tcm_i2c - add Synaptics TouchComm
 I2C touchscreen driver
Cc: "Henrik Rydberg" <rydberg@bitmath.org>, <linux-input@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260910070723.347768-1-sevanevorotov29@gmail.com>
 <20260910070723.347768-3-sevanevorotov29@gmail.com>
In-Reply-To: <20260910070723.347768-3-sevanevorotov29@gmail.com>

On Thu Sep 10, 2026 at 9:07 AM CEST, Vsevolod Nevorotov wrote:
> Add input touchscreen driver for Synaptics TouchComm (TCM) generation-1
> controllers connected over I2C that boot into application mode out of
> their own flash (such as the Synaptics S3908 fitted to the OnePlus 9RT).
>
> The driver supports:
> - Multi-touch reporting via input_mt framework
> - Configurable touch report layouts
> - Standard touchscreen properties (axis swapping/inversion)
> - Low-power wakeup gestures (double-tap to wake)
> - Deep sleep mode during system suspend
>
> Signed-off-by: Vsevolod Nevorotov <sevanevorotov29@gmail.com>
> ---
>  MAINTAINERS                                   |    7 +
>  drivers/input/touchscreen/Kconfig             |   15 +
>  drivers/input/touchscreen/Makefile            |    1 +
>  drivers/input/touchscreen/synaptics_tcm_i2c.c | 1033 +++++++++++++++++
>  4 files changed, 1056 insertions(+)
>  create mode 100644 drivers/input/touchscreen/synaptics_tcm_i2c.c

Tested-by: Frieder Hannenheim <git@fhannenheim.net>

Thanks for this. Tested on a OnePlus 8T with a S3908. Wake from suspend wor=
ks
too. Sadly no wakeup when the screen is off but the device is not suspended=
.
Maybe a similar approach to what David Heidelberg proposed here [1] could b=
e
used for that.

[1]: https://lore.kernel.org/phone-devel/20261104-ft5x06-double-tap-v1-2-5a=
1bd80449cc@ixit.cz/

Frieder
