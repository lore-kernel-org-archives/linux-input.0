From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] macintosh/hid: keycode-mapping for left click
Date: Mon, 14 Sep 2009 23:19:28 -0700
Message-ID: <20090915061927.GA10232@core.coreip.homeip.net>
References: <80pr9tz2pb.fsf@merkur.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:38684 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756570AbZIOGT3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2009 02:19:29 -0400
Content-Disposition: inline
In-Reply-To: <80pr9tz2pb.fsf@merkur.tec.linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Franz.Sirl-kernel@lauterbach.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi John,

On Mon, Sep 14, 2009 at 10:33:20PM +0200, John Ogness wrote:
> Hi,
> 
> This patch adds support for mapping the left mouse button to a
> keycode. The driver already mapped the middle and right buttons.
> 
> Since the single mouse-button on my Apple laptop broke, I figured the
> driver might as well support all three buttons. Now I can keep using my
> laptop without problems.
> 

Thank you for the patch however I will not apply it. While kernel has a
lot of quirks to work around broken hardware those apply to the design
brokenness, not old-age brokenness.

-- 
Dmitry
