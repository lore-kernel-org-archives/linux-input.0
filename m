From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v9 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Mon, 16 Jan 2012 14:14:24 +0100
Message-ID: <20120116131424.GA6113@polaris.bitmath.org>
References: <1326508373-23444-1-git-send-email-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:42472 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab2APNOa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jan 2012 08:14:30 -0500
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 5A8DCDEF7
	for <linux-input@vger.kernel.org>; Mon, 16 Jan 2012 14:14:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326508373-23444-1-git-send-email-javier@dowhile0.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

Hi Javier,

> Cypress TrueTouch(tm) Standard Product controllers are found in
> a wide range of embedded devices. This driver add support for a
> variety of TTSP controllers.
> 
> Since the hardware is capable of tracking identifiable contacts, multi-touch
> protocol type B (stateful) is used to report contact information.
> 
> The driver is composed of a core driver that process the data sent by
> the contacts and a set of bus specific interface modules. This patch
> adds the base core TTSP driver.
> 
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> ---
> 
> Changes for v9 suggested by Henrik Rydberg:
>     - Simplify cyttsp_bl_app_valid() function
>     - Remove retry logic since is already done in ttsp[read | write]_block_data
> 
>  drivers/input/touchscreen/Kconfig       |   31 ++
>  drivers/input/touchscreen/Makefile      |    3 +
>  drivers/input/touchscreen/cyttsp_core.c |  703 +++++++++++++++++++++++++++++++
>  drivers/input/touchscreen/cyttsp_core.h |  141 ++++++
>  include/linux/input/cyttsp.h            |   69 +++
>  5 files changed, 947 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/cyttsp_core.c
>  create mode 100644 drivers/input/touchscreen/cyttsp_core.h
>  create mode 100644 include/linux/input/cyttsp.h

Looks reasonable now, so

    Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thanks for your patience.

Henrik
