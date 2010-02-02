From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC][PATCH] HID: add NOGET quirk for Prodige Cordless Combo
Date: Tue, 2 Feb 2010 21:25:34 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002022124580.15395@pobox.suse.cz>
References: <1265129012-6023-1-git-send-email-virtuoso@slind.org> <alpine.LNX.2.00.1002022033340.15395@pobox.suse.cz> <20100202194936.GA14134@shisha.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60374 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976Ab0BBUZg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Feb 2010 15:25:36 -0500
In-Reply-To: <20100202194936.GA14134@shisha.kicks-ass.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shishkin <virtuoso@slind.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Tue, 2 Feb 2010, Alexander Shishkin wrote:

> The "0" key does not send anything, but instead, when I press "P" or "S" 
> and then without releasing press any other key, it sends that letter and 
> then a keypress for "0", which stays on up until I press something else. 
> Also, when I plug the receiver in, it immediately sends the same 
> keypress for "0" until the first actual keystroke. Or at least that's 
> how I see it in console or X (checked with xev).

Thanks. Apparently, your device doesn't describe itself as keyboard, 
otherwise the NOGET quirk would be applied automatically.

I have applied your patch now, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
