From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 0/8] Second patchset for LPC32xx device tree conversion
Date: Wed, 18 Apr 2012 11:00:39 +0000
Message-ID: <201204181100.40123.arnd@arndb.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de> <201204180806.16848.arnd@arndb.de> <20120418093604.GL6498@mwanda>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59756 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab2DRLAy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Apr 2012 07:00:54 -0400
In-Reply-To: <20120418093604.GL6498@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Roland Stigge <stigge@antcom.de>, devel@driverdev.osuosl.org, srinivas.bakki@nxp.com, linux-usb@vger.kernel.org, broonie@opensource.wolfsonmicro.com, gregkh@linuxfoundation.org, thierry.reding@avionic-design.de, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, marek.vasut@gmail.com, arm@kernel.org, linux-input@vger.kernel.org, axel.lin@gmail.com, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org

On Wednesday 18 April 2012, Dan Carpenter wrote:
> I'm not sure I understand.  I thought everyone used the develop
> against linux-next and backport the fixes model.  Are we going to
> try merge these in 3.4?  It will still spend some time in linux-next
> before we submit it, right?

Correct, but the point is that you cannot add patches on top of -next
and have them included in a future -next version, because they never
merge cleanly.

The ideal workflow is:

1. develop on -rc
2. merge with latest -next, test and make sure it works there
3. submit for review against -rc
4. have patches included in -next once reviewed, but based on -rc
5. when merge window opens, have patches sent for upstream inclusion

The last two steps are slightly different for your own subsystem
compared to someone else's subsystem: In this case, Roland is the
author and sends the patches to me to have them included in -next
and I send them to Linus in the next merge window.

	Arnd
