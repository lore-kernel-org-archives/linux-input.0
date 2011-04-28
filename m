From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: omap-keypad - fix a wrong free_irq() parameter
Date: Wed, 27 Apr 2011 23:26:12 -0700
Message-ID: <20110428062612.GD31734@core.coreip.homeip.net>
References: <1303961006.8127.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65197 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab1D1G0R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Apr 2011 02:26:17 -0400
Content-Disposition: inline
In-Reply-To: <1303961006.8127.2.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Timo =?iso-8859-1?Q?Ter=E4s?= <ext-timo.teras@nokia.com>, Tony Lindgren <tony@atomide.com>, linux-input@vger.kernel.org

On Thu, Apr 28, 2011 at 11:23:26AM +0800, Axel Lin wrote:
> In current implementation, free_irq() was using NULL rather than the
> driver data as the data pointer so free_irq() wouldn't have matched.
> 

Applied, thanks Axel.

-- 
Dmitry
