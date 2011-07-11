From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: TPS6507X - define MFD dependencies for touch and
 regulator unit
Date: Mon, 11 Jul 2011 23:08:23 +0900
Message-ID: <20110711140820.GA31424@opensource.wolfsonmicro.com>
References: <4E1AD56B.6080306@visionsystems.de>
 <20110711122004.GA9478@sirena.org.uk>
 <4E1AECB3.3080607@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44955 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757595Ab1GKOIe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2011 10:08:34 -0400
Content-Disposition: inline
In-Reply-To: <4E1AECB3.3080607@visionsystems.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Mon, Jul 11, 2011 at 02:29:39PM +0200, Yegor Yefremov wrote:
> Am 11.07.2011 14:20, schrieb Mark Brown:

>         tristate "TPS6507x based touchscreens"
> -       depends on I2C
> +       depends on I2C && TPS6507X

You can just remove the I2C dependency, the core won't be enabled if teh
control bus isn't there.
