From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND patch 2.6.25-rc8] gpio_keys irq handling
Date: Tue, 15 Apr 2008 01:37:03 -0400
Message-ID: <20080415053702.GC24870@anvil.corenet.prv>
References: <200804110035.55510.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:2193 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbYDOFhI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Apr 2008 01:37:08 -0400
Received: by an-out-0708.google.com with SMTP id d31so500346and.103
        for <linux-input@vger.kernel.org>; Mon, 14 Apr 2008 22:37:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200804110035.55510.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-input@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, Jiri Kosina <jkosina@suse.cz>, Phil Blundell <pb@handhelds.org>

On Fri, Apr 11, 2008 at 12:35:55AM -0700, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Cleanup IRQ handling in gpio_keys:  bail after handling the IRQ, and
> report IRQ_NONE if we never handle it.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> Cc: Phil Blundell <pb@handhelds.org>
> Cc: Dmitry Torokhov <dtor@mail.ru>

Applied, thank you David.

-- 
Dmitry
