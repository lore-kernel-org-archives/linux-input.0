From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] input: Request threaded-only IRQs with IRQF_ONESHOT
Date: Mon, 02 Jul 2012 13:50:28 +0200
Message-ID: <4FF18B04.4040005@metafoo.de>
References: <1341229460-23732-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out-137.synserver.de ([212.40.185.137]:1043 "EHLO
	smtp-out-134.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750768Ab2GBLqj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Jul 2012 07:46:39 -0400
In-Reply-To: <1341229460-23732-1-git-send-email-lars@metafoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabien Marteau <fabien.marteau@armadeus.com>, HeungJun Kim <riverful.kim@samsung.com>, Zhang Jiejing <jiejing.zhang@freescale.com>, Bo Shen <voice.shen@atmel.com>, Sriramakrishnan <srk@ti.com>, Kyle Manna <kyle.manna@fuel7.com>, Cyril Chemparathy <cyril@ti.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Alan Cox <alan@linux.intel.com>, Jianchun Bian <jcbian@pixcir.com.cn>, Aaro Koskinen <aaro.koskinen@nokia.com>, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On 07/02/2012 01:44 PM, Lars-Peter Clausen wrote:
> Since commit 1c6c69525b ("genirq: Reject bogus threaded irq requests") threaded
> IRQs without a primary handler need to be requested with IRQF_ONESHOT, otherwise
> the request will fail. This patch adds the IRQF_ONESHOT to IIO drivers where it

oops, copy & paste error, "IIO" should obviously been "input".

> is missing. Not modified by this patch are those drivers where the requested IRQ
> will always be a nested IRQ (e.g. because it's part of an MFD), since for this
> special case IRQF_ONESHOT is not required to be specified when requesting the
> IRQ.

