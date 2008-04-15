From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2.6.25-rc8] omap-keypad: fix build warning
Date: Tue, 15 Apr 2008 01:36:31 -0400
Message-ID: <20080415053631.GB24870@anvil.corenet.prv>
References: <200804110109.19349.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:1416 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941AbYDOFgf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Apr 2008 01:36:35 -0400
Received: by an-out-0708.google.com with SMTP id d31so500317and.103
        for <linux-input@vger.kernel.org>; Mon, 14 Apr 2008 22:36:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200804110109.19349.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-input@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz

On Fri, Apr 11, 2008 at 01:09:18AM -0700, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Build fixes:
> 
> drivers/input/keyboard/omap-keypad.c: In function 'omap_kp_probe':
> drivers/input/keyboard/omap-keypad.c:418: warning: 'row_idx' is used uninitialized in this function
> drivers/input/keyboard/omap-keypad.c:421: warning: 'col_idx' is used uninitialized in this function
> 
> These variables are useful when cpu_is_omap24xx(), and otherwise just
> for useless cleanup.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied, thank you David.

-- 
Dmitry
