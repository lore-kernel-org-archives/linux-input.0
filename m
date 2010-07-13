From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] i2c: cyttsp i2c touchscreen driver init submit
Date: Tue, 13 Jul 2010 08:48:22 +0200
Message-ID: <4C3C0C36.5080608@euromail.se>
References: <Kevin McNeely <kev@cypress.com> <1278968210-6827-1-git-send-email-kev@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:50082 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751003Ab0GMGuy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jul 2010 02:50:54 -0400
In-Reply-To: <1278968210-6827-1-git-send-email-kev@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin McNeely <kev@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Brown <davidb@codeaurora.org>, Trilok Soni <tsoni@codeaurora.org>, Fred <fwk@ubuntu.linuxcertified.com>, Samuel Ortiz <sameo@linux.intel.com>, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Simtec Linux Team <linux@simtec.co.uk>, Arnaud Patard <arnaud.patard@rtp-net.org>, Antonio Ospite <ospite@studenti.unina.it>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Kevin McNeely wrote:
> From: Fred <fwk@ubuntu.linuxcertified.com>
> 
> This is a new touchscreen driver for the Cypress Semiconductor
> cyttsp family of devices.  This driver is for the i2c version
> of cyttsp parts.
> 
> Signed-off-by: Kevin McNeely <kev@cypress.com>
> ---

This driver contains too much code. I am wondering if the device actually
supports tracking id, or whether it is emulated in the driver code? If tracking
is not well supported in hardware, then please use MT protocol A and remove the
usage of ABS_MT_TRACKING_ID and the logic around it. If tracking is indeed well
supported in the hardware, then please use MT protocol B.

Thanks,
Henrik
