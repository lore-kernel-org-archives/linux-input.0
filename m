From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: debug: improve hid_debug_event()
Date: Fri, 27 Nov 2015 00:05:17 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511270004570.20111@pobox.suse.cz>
References: <1448368427-1669-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46281 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753193AbbKZXFT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2015 18:05:19 -0500
In-Reply-To: <1448368427-1669-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 24 Nov 2015, Rasmus Villemoes wrote:

> The code in hid_debug_event() causes horrible code generation. First,
> we do a strlen() call for every byte we copy (we're doing a store to
> global memory, so gcc has no way of proving that strlen(buf) doesn't
> change). Second, since both i, list->tail and HID_DEBUG_BUFSIZE have
> signed type, the modulo computation has to take into account the
> possibility that list->tail+i is negative, so it's not just a simple
> and.
> 
> Fix the former by simply not doing strlen() at all (we have to load
> buf[i] anyway, so testing it is almost free) and the latter by
> changing i to unsigned. This cuts 29% (69 bytes) of the size of the
> function.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Agreed, this is much better. Applied to for-4.5/core, thanks Rasmus.

-- 
Jiri Kosina
SUSE Labs

