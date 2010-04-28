From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 3/3] input: handle bad parity PS/2 packets in mouse
 drivers better
Date: Wed, 28 Apr 2010 09:45:35 -0700
Message-ID: <20100428164534.GA6574@core.coreip.homeip.net>
References: <201004272112.o3RLCeTc020088@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:58185 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906Ab0D1Qpq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Apr 2010 12:45:46 -0400
Received: by wwi14 with SMTP id 14so910012wwi.19
        for <linux-input@vger.kernel.org>; Wed, 28 Apr 2010 09:45:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201004272112.o3RLCeTc020088@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, damjan.jov@gmail.com, rubini@cvml.unipv.it

On Tue, Apr 27, 2010 at 02:12:39PM -0700, akpm@linux-foundation.org wrote:
> From: Damjan Jovanovic <damjan.jov@gmail.com>
> 
> This fixes a regression introduced in Linux 2.6.2 where mice that
> sporadically produce bad parity go crazy and start jumping around and
> clicking randomly, which never happens in any version of Windows running
> on the same hardware.  The bugzilla bug is
> https://bugzilla.kernel.org/show_bug.cgi?id=6105
> 
> The patch works by always accumulating a full PS/2 packet, then ignoring
> the packet if any byte had a bad checksum.  A month of testing it against
> an affected mouse has revealed it works perfectly in practice.
> 
> Signed-off-by: Damjan Jovanovic <damjan.jov@gmail.com>
> Cc: Alessandro Rubini <rubini@cvml.unipv.it>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Andrew, an alternative path has been merged, please drop this one.

Thanks.

-- 
Dmitry
