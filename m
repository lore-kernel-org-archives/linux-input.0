From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] i2c: cyttsp i2c and spi touchscreen driver init submit
Date: Sat, 07 Aug 2010 02:49:08 +0200
Message-ID: <4C5CAD84.2040804@euromail.se>
References: <Kevin McNeely <kev@cypress.com> <1281031924-3032-1-git-send-email-kev@cypress.com> <4C5B4404.6010602@euromail.se> <FB9C2CB29A07AB45B575A4E8D2AABC09C4860A@labamba.mis.cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:57243 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752256Ab0HGAty (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Aug 2010 20:49:54 -0400
In-Reply-To: <FB9C2CB29A07AB45B575A4E8D2AABC09C4860A@labamba.mis.cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin McNeely <Kevin.McNeely@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Brown <davidb@codeaurora.org>, Trilok Soni <tsoni@codeaurora.org>, Fred <fwk@ubuntu.linuxcertified.com>, Samuel Ortiz <sameo@linux.intel.com>, Eric Miao <eric.y.miao@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Simtec Linux Team <linux@simtec.co.uk>, Todd Fischer <todd.fischer@ridgerun.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/07/2010 02:32 AM, Kevin McNeely wrote:

[...]

> However, I would like to keep the MT Protocol A.  Our solution allows

> The platform builder to select to use MT protocol B or not as part of 
> platform_data in the board configuration. If it makes more sense,
> I can reverse the code to default to protocol B and allow the platform
> builder developer to select protocol A.


There is nothing preventing you from keeping say a dkms package somewhere with
all options intact. However, for the kernel, it is a question of
maintainability. If the driver can produce prefectly valid data using protocol
B, and by doing so several hundred lines of code can be removed, that is very
much preferred. Since both protocols can be translated to protocol B via mtdev,
which is already very much in use, there is little reason to support protocol A
when the device can do tracking.

Thanks,
Henrik
