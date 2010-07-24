From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv3] input: gpio_keys: polling mode support
Date: Sat, 24 Jul 2010 00:46:46 -0700
Message-ID: <20100724074646.GA3615@core.coreip.homeip.net>
References: <20100706190128.GB24655@chipmunk>
 <20100712192950.GR6976@chipmunk>
 <20100713011707.GA12728@linux-sh.org>
 <20100713012819.GA15800@core.coreip.homeip.net>
 <20100713072605.GS6976@chipmunk>
 <20100713195745.GJ2428@chipmunk>
 <20100713200455.GK2428@chipmunk>
 <87fwzf40yo.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55703 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab0GXHqv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Jul 2010 03:46:51 -0400
Received: by pwi5 with SMTP id 5so3829353pwi.19
        for <linux-input@vger.kernel.org>; Sat, 24 Jul 2010 00:46:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87fwzf40yo.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: Alexander Clouter <alex@digriz.org.uk>, linux-input@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

On Mon, Jul 19, 2010 at 11:26:55PM +0200, Ferenc Wagner wrote:
> Hi,
> 
> Just in case you didn't know: there's an alternate implementation at
> https://dev.openwrt.org/browser/trunk/target/linux/generic-2.6/files/drivers/input/misc/gpio_buttons.c?rev=21436

Hmm, I might like this option best of all. We just need to rename the
driver so that we can have both polled and interrupt driven compiled,
Then we'd bind based on device name creatd for us.

Can you submit it officially?

Thanks.

-- 
Dmitry
