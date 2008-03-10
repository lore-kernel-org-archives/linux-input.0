From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch 01/23] fjkeyinf driver for FSC Lifebook laptops
Date: Mon, 10 Mar 2008 13:35:36 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803101334150.15209@jikos.suse.cz>
References: <200803101008.m2AA8d1N011222@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:38262 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750696AbYCJMfh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2008 08:35:37 -0400
In-Reply-To: <200803101008.m2AA8d1N011222@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: post@hendrik-sattler.de, Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org

On Mon, 10 Mar 2008, akpm@linux-foundation.org wrote:

> From: Hendrik Sattler <post@hendrik-sattler.de>
> This is another approach for FJKEYINF support for the FSC Lifebook laptop
> series.  In comparison to the apanel driver that was posted lately, it
> supports more than one entry in the table and slits off the actual handling of
> the I2C devices to seperate drivers, allowing resuse in other scenarios.

s/resuse/reuse, right?

Also, is there any effort to merge this with Stephen's apanel driver? Or 
what is the advantage of having these two drivers separately?

Thanks,

-- 
Jiri Kosina
SUSE Labs
