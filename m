From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2] input: add EETI eGalax I2C capacitive multi touch
 driver.
Date: Thu, 11 Aug 2011 22:34:49 +0200
Message-ID: <20110811203449.GA6162@polaris.bitmath.org>
References: <20110801063409.GB32118@core.coreip.homeip.net>
 <1312370963-24965-1-git-send-email-jiejing.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:33976 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737Ab1HKUdv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Aug 2011 16:33:51 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 9692BC28A
	for <linux-input@vger.kernel.org>; Thu, 11 Aug 2011 22:33:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1312370963-24965-1-git-send-email-jiejing.zhang@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhang Jiejing <jiejing.zhang@freescale.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, dima@android.com, kzjeef@gmail.com

Hi Zhang,

> This is the patch after change to mt Protocol-B.
> but I have a issue with test tool, in the orignal patch, I use
> android to do the test, but android still not support Protocol B.

The device seems to send finger changes sequentually, resulting in one
packet (terminated with input sync) for each finger change. Is this
the intention/necessary? Some egalax firmware (hid version) seems to
work this way.

The usage of REPORT_MODE_* is unclear to me too.

Other than that, the patch looks nice (at first glance).

Thanks,
Henrik
