From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: [PATCH, v2] input/imx2x: generic keypad handler for i.MX SoCs
Date: Fri, 17 Apr 2009 16:55:46 +0200
Message-ID: <200904171655.46515.hs4233@mail.mn-solutions.de>
References: <200904171640.14294.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx51.mymxserver.com ([85.199.173.110]:45703 "EHLO
	mx51.mymxserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbZDQO4L (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Apr 2009 10:56:11 -0400
In-Reply-To: <200904171640.14294.hs4233@mail.mn-solutions.de>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Little notes:

* I forgot dmitry.torokhov@gmail.com, but sent him the mail
  afterwards.
* Sascha, can you ack?  If you want, I can can split that patch
  into the driver/Kconfig/Makefile and another one for the
  stuff in arch/arm/mach-mx2. That might reduce merge conflicts.
