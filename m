Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6CF33C539
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118086; cv=none; b=RRyne2YI2naC32RPJT/hPMdpV+PEUWPKdXdBcH+ae8I7T8zeC1S83umoYCrqJZsdJNyygtLWrSrcFwEdCZ74KyPoEfwG2cCtUSHg8b2a/H24lkgEYD1GBBznxkfK1gPJjdJsXX3F3565QH5q40xtF1U+FrgI9r/T2T8OBaQXF3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118086; c=relaxed/simple;
	bh=6IZnU+y/L+LsQveu74p6qd0jzd1T2CzEyiKdsjga764=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzGSmytANojVZ9mvGvn/AONnsHaqY+TMOnd4k3dAjK44iluVpu/azJQj5pEbwgmbpshzAEum6nGLKQ/nufNp53UOH2x99Uy/o1ja8K4avpBuRgg/q5vmNIiRZ11k/H7ZvQCDXh4eMzj0ZKK6HYAuIrRacqcjZrUHkOtFqqPVkQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vj2QP-0007Wx-Vu; Thu, 22 Jan 2026 22:41:10 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vj2QQ-001zG4-04;
	Thu, 22 Jan 2026 22:41:09 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vj2QP-0099vC-0j;
	Thu, 22 Jan 2026 22:41:09 +0100
Date: Thu, 22 Jan 2026 22:41:09 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: AThomas63 <andrew.thomas@touchnetix.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, mark.satterthwaite@touchnetix.com,
	kamel.bouhara@bootlin.com, kernel@pengutronix.de
Subject: Re: [PATCH 0/1] Input: Add TouchNetix aXiom touchscreen driver
Message-ID: <20260122214109.yderbsiqmfx25vn3@pengutronix.de>
References: <20260122124819.273188-1-andrew.thomas@touchnetix.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122124819.273188-1-andrew.thomas@touchnetix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org

Hi Andrew,

thanks for your patch.

A few words prior doing a very rough review. I don't like the idea of
posting two complete different patchsets, furthermore if you could have
added the missing SPI support on-top of my patchset very easily since I
used the regmap-API.

Most of my patches already got the r-b tags and I received a very good
review from Dmitry recently which I currently integrating to send a new
version.

On 26-01-22, AThomas63 wrote:
> A Summary of the added features:
>  - Add input driver support for TouchNetix aXiom touchscreen controller 
> using either I2C or SPI.
>  - Support ABS_MT touch reports in axiom_process_u41_report().
>  - Support both polling and interrupt mode (trigger low).
>  - Add basic documentation and provide example device tree bindings.
>  - Provide the basic structure to add firmware and config download in
> the future via both I2C and SPI.
> 
> I understand the process is already under way to add a driver to support 
> aXiom by Marco at Pengutronix.
> I think it would be most useful for us to attempt to combine this patch
> in order to support both his changes for config/firmware download and 
> the patch here for SPI support along with I2C. I would be happy to help 
> with this process.
> This would allow TouchNetix to support a broader range of users of the
> aXiom device family.
> 
> I also have a device tree binding however I have not added it sincec
> from my understanding this should go in a different patch:
> Documentation/devicetree/bindings/input/touchscreen/tnx,axiom.yaml
>  
> My apologies if there are any obvious mistakes in this patch, this is the
> first patch that I have submitted.

That's not a problem at least not for me, but there are contriubtion
guidelines which you could have read first.

Also I'm a bit surprised that you have sent a driver for the same device
family which is less capable than mine. Your driver is missing the
complete fw-update mechanism and therefore needs still your downstream
python tooling. The fw-update logic is a huge part, since this was hard
to get it right.

There are a few other parts, you're doing wrong (please see the patch
review).

Regards,
  Marco


> 
> Many thanks for your time,
> Andrew Thomas
> 
> AThomas63 (1):
>   Adding support for aXiom touchscreen controller
> 
>  drivers/input/touchscreen/Kconfig      |  30 ++
>  drivers/input/touchscreen/Makefile     |   3 +
>  drivers/input/touchscreen/axiom_core.c | 482 +++++++++++++++++++++++++
>  drivers/input/touchscreen/axiom_core.h | 128 +++++++
>  drivers/input/touchscreen/axiom_i2c.c  | 152 ++++++++
>  drivers/input/touchscreen/axiom_spi.c  | 159 ++++++++
>  6 files changed, 954 insertions(+)
>  create mode 100644 drivers/input/touchscreen/axiom_core.c
>  create mode 100644 drivers/input/touchscreen/axiom_core.h
>  create mode 100644 drivers/input/touchscreen/axiom_i2c.c
>  create mode 100644 drivers/input/touchscreen/axiom_spi.c
> 
> -- 
> 2.43.0
> 
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
