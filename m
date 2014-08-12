From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCHES] HID: huion: Fix "doing dma on the stack"
Date: Tue, 12 Aug 2014 11:27:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1408121126560.15220@pobox.suse.cz>
References: <1407779132-26749-1-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58899 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbaHLJ1e (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Aug 2014 05:27:34 -0400
In-Reply-To: <1407779132-26749-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On Mon, 11 Aug 2014, Nikolai Kondrashov wrote:

> Hi everyone,
> 
> These two patches work towards fixing the "doing dma on the stack" reported by
> a static analyzer (I'm not sure which one) for my recent changes to hid-huion
> driver.
> 
> The first one is easier to read with whitespace changes ingored (-w).
> 
> Both patches were tested by me with a Huion H610N tablet.
> 
> Nick

Nikolai,

thanks, I will be reviewing the patches soon and queuing for 3.17 still 
eventually.

They seem to be missing your signoff though ... is that on purpose? 
Thanks,

-- 
Jiri Kosina
SUSE Labs
