From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: twl4030-pwrbutton - fix a leak of the IRQ during
 init failure
Date: Wed, 27 Apr 2011 23:26:35 -0700
Message-ID: <20110428062635.GE31734@core.coreip.homeip.net>
References: <1303963041.2588.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65197 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab1D1G0k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Apr 2011 02:26:40 -0400
Content-Disposition: inline
In-Reply-To: <1303963041.2588.3.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter De Schrijver <peter.de-schrijver@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-input@vger.kernel.org

On Thu, Apr 28, 2011 at 11:57:21AM +0800, Axel Lin wrote:
> In twl4030_pwrbutton_probe error path, free_irq() was using NULL rather than
> the driver data as the data pointer so free_irq() wouldn't have matched.

Applied, thanks Axel.

-- 
Dmitry
