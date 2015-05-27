From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v5 0/6] Change snvs rtc and poweroff to use syscon add
 pwrkey driver
Date: Wed, 27 May 2015 20:10:53 +0800
Message-ID: <20150527121052.GH16165@dragon>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36720 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbbE0MLv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 May 2015 08:11:51 -0400
Received: by pdfh10 with SMTP id h10so12239122pdf.3
        for <linux-input@vger.kernel.org>; Wed, 27 May 2015 05:11:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org

On Wed, May 27, 2015 at 12:25:56AM +0800, Frank.Li@freescale.com wrote:
> Frank Li (5):
>   rtc: arm: imx: snvs: change use syscon to access register
>   Document: dt: fsl: snvs: change support syscon
>   ARM: dts: imx: update snvs to use syscon access register
>   Document: devicetree: input: imx: i.mx snvs power device tree bindings
>   ARM: dts: imx6sx: enable snvs power key
> 
> Robin Gong (1):
>   input: keyboard: imx: add snvs power key driver

The series looks fine to me now.  But I can only apply those two dts
patches after the driver and binding parts get landed on mainline.
Hopefully, you can get them in during the coming merge window through
subsystem trees, so that I can pick up dts part after v4.2-rc1 comes
out.

Shawn
