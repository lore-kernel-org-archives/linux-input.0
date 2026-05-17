Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9552D0292;
	Sun, 17 May 2026 04:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778992405; cv=pass; b=GmA+M3/5FwYy0MmRz+ViKKknG8xpMlUpgelKADX/0ZvfcrHsYg35jGGtQtGru4MxnTe++pjIEZ7b5efyh6pL0m8lwSJR2qgtEfi/Iedrr6koiHQGngQyx/V0Gl2XVgJkEk1sD+bUHlV2PViXgzogxO5hX/JEmYvxuqvTYOlBLzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778992405; c=relaxed/simple;
	bh=ZL8CbwP2c1JXLJIt/TXg9xpQCitcZJ1JEWa4++759wk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=P0FI1B5gJrq4FWD3QQYxxitCTrJRMFtUGaAIfgsw7DMagJXC6VeQerKxy17F/sD72fhULekEZOYcmol9KPdR0ir+izdM2TIfDuOEddCYxkyUbSoLS/H8VFFCYdCBXHWDdm96Lnc9PNGvmPuQ/QMW9hCGlQjZBti0rBlJvc/l/lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dennisfoster.us; spf=pass smtp.mailfrom=dennisfoster.us; dkim=pass (1024-bit key) header.d=dennisfoster.us header.i=mail@dennisfoster.us header.b=DxZeT1Op; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dennisfoster.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dennisfoster.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dennisfoster.us header.i=mail@dennisfoster.us header.b="DxZeT1Op"
ARC-Seal: i=1; a=rsa-sha256; t=1778992400; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vpj9QSVNq5kfg7sqQqffYOcpomldmq8UQBc/7WDhA7ar+YAqNrJQP92KxG6aPlLYwJ/w641V5iIwlsB7xhhtqtQ5oLwY9I2onzq9cNpRkLkxHh0t9vQPBjEWEnlSZi9mz8MZI2Dg+PlYkLvKzPqy/cCVG1054+eMaINIwwgW1KM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778992400; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dUlRtNPNglnRzx8VYnkqHSWrCDJb6x0BQ6x2vmJa+D8=; 
	b=iIH4tQJtGzf6/G32gZCBpiSQdeU8nqWCU2wuhfs7OFqFPR2FDrFgv4BQ8JZLR3nOuk2a9tJtclt50Lg6zp3HgIHfWDPygEvG1pzQbei11e47h5+jTkiZQhg5lo7lLs0255F7475ESZekyJC7usJoBBwaZ2Cfuc603bKJV09zSGQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=dennisfoster.us;
	spf=pass  smtp.mailfrom=mail@dennisfoster.us;
	dmarc=pass header.from=<mail@dennisfoster.us>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778992400;
	s=zmail; d=dennisfoster.us; i=mail@dennisfoster.us;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dUlRtNPNglnRzx8VYnkqHSWrCDJb6x0BQ6x2vmJa+D8=;
	b=DxZeT1Op1/xU9TJ8DkRlanMgRW/XLgweBp0HVgZ6ZLXBTpBHNIpZcq/EdF0XhvdX
	nr+kC8p9aJ24O3L319aL0TsWpEYBy7tO1ZHbbHghx6qfXaqmgTEsRREtQgG77H6d6EK
	5byHZmde78HmLzD4BEOgq93bvi5GgpcFtKHg39Zs=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1778992398392282.67181596166824; Sat, 16 May 2026 21:33:18 -0700 (PDT)
Date: Sun, 17 May 2026 00:33:18 -0400
From: Dennis Foster <mail@dennisfoster.us>
To: "linux-input" <linux-input@vger.kernel.org>
Cc: "linux-i2c" <linux-i2c@vger.kernel.org>,
	"benjamintissoires" <benjamin.tissoires@gmail.com>,
	"jikos" <jikos@kernel.org>
Message-ID: <19e3435bff9.5159b6ff3377555.4429246136901518864@dennisfoster.us>
In-Reply-To: 
Subject: i2c_hid_acpi: ELAN2514 touchscreen causes IRQ flood on HP Omnibook
 X 14 (Lunar Lake)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi,

I'm seeing a continuous IRQ flood from the ELAN2514 touchscreen on an HP Omnibook X 14 (Intel Core Ultra 5 226V, Lunar Lake). With the driver bound, IRQ 20 fires non-stop and keeps one CPU core at ~30% load with the machine otherwise idle.

Kernel: 7.0.8-arch1-1
Machine: HP Omnibook X 14, Intel Core Ultra 5 226V
Touchscreen: ELAN2514, 04F3:43F4, ACPI \_SB_.PC00.I2C4.TPL1
Controller: i2c_designware.2 on IRQ 20 (IR-IO-APIC 20-fasteoi)

At boot, i2c_hid_acpi logs this once during probe (rate-limited):

[    5.042325] i2c_hid_acpi i2c-ELAN2514:00: i2c_hid_get_input: IRQ triggered but there's no data

The device registers successfully after that, but the interrupt line never deasserts. The counter on CPU5 climbs without bound:

    20:    0    0    0    0    0    19537    0    0   IR-IO-APIC   20-fasteoi   i2c_designware.2

Also worth noting - the device registers an unusual set of input nodes, including several labeled UNKNOWN:

ELAN2514:00 04F3:43F4 Touchscreen
ELAN2514:00 04F3:43F4 Stylus
ELAN2514:00 04F3:43F4 Keyboard
ELAN2514:00 04F3:43F4 Mouse
ELAN2514:00 04F3:43F4 UNKNOWN  (x5)

As a workaround I'm unbinding the driver via udev immediately after probe completes:

ACTION=="bind", DRIVER=="i2c_hid_acpi", KERNEL=="i2c-ELAN2514:00", \
    RUN+="/bin/sh -c 'echo i2c-ELAN2514:00 > /sys/bus/i2c/drivers/i2c_hid_acpi/unbind'"

This stops the flood but obviously leaves the touchscreen non-functional.

--
Dennis
