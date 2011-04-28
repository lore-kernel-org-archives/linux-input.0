From: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
Subject: Re: [v4 1/3] 1/3 Touchscreen: Cypress TTSP G3 Core Driver
Date: Thu, 28 Apr 2011 13:47:09 +0530
Message-ID: <20110428080631.GA26730@bnru02>
References: <kev@cypress.com>
 <1294188847-24728-1-git-send-email-kev@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:47603 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754546Ab1D1IRl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Apr 2011 04:17:41 -0400
Content-Disposition: inline
In-Reply-To: <1294188847-24728-1-git-send-email-kev@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Brown <davidb@codeaurora.org>, Trilok Soni <tsoni@codeaurora.org>, Henrik Rydberg <rydberg@euromail.se>, Samuel Ortiz <sameo@linux.intel.com>

Hi Kevin,

On Wed, Jan 05, 2011 at 01:54:04 +0100, Kevin McNeely wrote:
> Cypress TTSP Gen3 Core Driver.
> Core Driver includes platform data definition file,
> core driver definition file, and core touchscreen
> touch handling of device data. Generates
> multi-touch input events.
> 
> Signed-off-by: Kevin McNeely <kev@cypress.com>
> ---
> Changes since v3:
> - Removed unused items
> - replace EIO with EINVAL
> - add x[], y[] and loop on mt signaling
> - removed uninitialized use of ts->dev
> 
>  drivers/input/touchscreen/Kconfig       |    5 +
>  drivers/input/touchscreen/Makefile      |    1 +
>  drivers/input/touchscreen/cyttsp_core.c |  794 +++++++++++++++++++++++++++++++
>  drivers/input/touchscreen/cyttsp_core.h |   55 +++
>  include/linux/input/cyttsp.h            |   68 +++
>  5 files changed, 923 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/cyttsp_core.c
>  create mode 100644 drivers/input/touchscreen/cyttsp_core.h
>  create mode 100644 include/linux/input/cyttsp.h

I did not find any further updates on this driver, any 
development ongoing to support type B as suggested?

we badly in need of this driver, and so wondering if
you have plans to take up this further?

srinidhi
