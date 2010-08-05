From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] i2c: cyttsp i2c and spi touchscreen driver init submit
Date: Fri, 06 Aug 2010 01:06:44 +0200
Message-ID: <4C5B4404.6010602@euromail.se>
References: <Kevin McNeely <kev@cypress.com> <1281031924-3032-1-git-send-email-kev@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:51889 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753672Ab0HEXH1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Aug 2010 19:07:27 -0400
In-Reply-To: <1281031924-3032-1-git-send-email-kev@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin McNeely <kev@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Brown <davidb@codeaurora.org>, Trilok Soni <tsoni@codeaurora.org>, Fred <fwk@ubuntu.linuxcertified.com>, Samuel Ortiz <sameo@linux.intel.com>, Eric Miao <eric.y.miao@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Simtec Linux Team <linux@simtec.co.uk>, Todd Fischer <todd.fischer@ridgerun.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/05/2010 08:12 PM, Kevin McNeely wrote:

> From: Fred <fwk@ubuntu.linuxcertified.com>
> 
> This is a new touchscreen driver for the Cypress Semiconductor
> cyttsp family of devices.  This updated driver is for both the i2c and spi
> versions of the devices. The driver code consists of common core code for
> both i2c and spi driver.  This submission is in response to review comments
> from the initial submission.
> 
> Signed-off-by: Kevin McNeely <kev@cypress.com>
> ---


General impression: There is a lot of useful code in here, but as already
pointed out, well over half of it should not be part of the kernel driver.

Suggestion 1: Clean out the internal state code and use MT protocol B instead.

Suggestion 2: Cut out the single touch calculation, as already pointed out by
Trilok. Why not submit it to the mtdev project instead? The problem is generic
to all new MT drivers, so a common solution while waiting for full MT support in
userspace could be useful.

Thanks,
Henrik
