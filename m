From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: synaptics - only report width on hardware
 that supports it
Date: Mon, 19 Jul 2010 09:07:12 -0700
Message-ID: <20100719160712.GA13318@core.coreip.homeip.net>
References: <1279479967-4499-1-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65359 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936228Ab0GSQHU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Jul 2010 12:07:20 -0400
Received: by pwi5 with SMTP id 5so1719345pwi.19
        for <linux-input@vger.kernel.org>; Mon, 19 Jul 2010 09:07:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279479967-4499-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org

On Sun, Jul 18, 2010 at 02:06:06PM -0500, chris@cnpbagwell.com wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
> 
> Synaptics devices report fixed value of 5 for finger/palm widths
> on devices that do not support capability and driver further
> hardcodes to 5.  Stop reporting this fixed value when its
> not supported since its not useful.
> 
> This will aid applications so they can better auto-enable
> support for multi-touch emulation and palm detection logic
> using finger width only for devices that support width detection.
> 
> I can find no applications that currently require existence
> on ABS_TOOL_WIDTH. Since only synaptics and bcm input devices
> currently support this tool, it seems they must handle it gracefully.
> 
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>

Applied both, thanks Chris.

-- 
Dmitry
