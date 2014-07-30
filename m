From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: sony: Default initialize all elements of the LED
 max_brightness array to 1.
Date: Wed, 30 Jul 2014 11:28:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1407301127440.16390@pobox.suse.cz>
References: <1406688948-33348-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33835 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbaG3J2N (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jul 2014 05:28:13 -0400
In-Reply-To: <1406688948-33348-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org

On Tue, 29 Jul 2014, Frank Praznik wrote:

> Previously only the first element of the array was initialized to 1
> leading to potential incorrect max brightness values for the LEDs
> on the Dualshock 3 and buzzer controllers.
> 
> Use a designated initializer to initialize the whole array to the
> correct value.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
> 
> This patch is against jikos/hid.git/for-3.16/upstream-fixes
> It applies cleanly against for-3.17/sony as well

I have applied it to for-3.17/sony, as it doesn't seem to justify 3.16-rc 
pull request.

Thanks,

-- 
Jiri Kosina
SUSE Labs
