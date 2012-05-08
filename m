From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] input: keypad: move platform_data to
 <linux/platform_data>
Date: Tue, 8 May 2012 15:42:31 -0700
Message-ID: <20120508224230.GO5088@atomide.com>
References: <1331905159-11255-1-git-send-email-sourav.poddar@ti.com>
 <1331905159-11255-2-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49887 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab2EHWmf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 May 2012 18:42:35 -0400
Content-Disposition: inline
In-Reply-To: <1331905159-11255-2-git-send-email-sourav.poddar@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com

* Sourav Poddar <sourav.poddar@ti.com> [120316 06:43]:
> From: Felipe Balbi <balbi@ti.com>
> 
> This patch allows us to drop the OMAP depencendy
> from the OMAP4 keypad driver.

Seems safe to apply via linux-input:

Acked-by: Tony Lindgren <tony@atomide.com>
