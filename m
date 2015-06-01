From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [rtc-linux] [PATCH v5 1/6] rtc: arm: imx: snvs: change use
 syscon to access register
Date: Mon, 1 Jun 2015 22:25:07 +0200
Message-ID: <20150601202507.GP4710@piout.net>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
 <1432657562-5592-2-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38520 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752417AbbFAUZK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Jun 2015 16:25:10 -0400
Content-Disposition: inline
In-Reply-To: <1432657562-5592-2-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org

On 27/05/2015 at 00:25:57 +0800, Frank.Li@freescale.com wrote :
> From: Frank Li <Frank.Li@freescale.com>
> 
> snvs included rtc, on/off key, power-off module
> change to syscon to access register
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Shawn, when applying could you please change the subject to:
rtc: snvs: use syscon to access registers

Thanks,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
