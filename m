From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-lg: make array cbuf static const to shink object
 code size
Date: Wed, 6 Sep 2017 10:59:04 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709061058560.4077@jbgna.fhfr.qr>
References: <20170825171250.23988-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53785 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752111AbdIFI7G (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 6 Sep 2017 04:59:06 -0400
In-Reply-To: <20170825171250.23988-1-colin.king@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 25 Aug 2017, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate array cbuf on the stack, instead make it static.
> Makes the object code smaller by over 110 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   15096	   3504	    128	  18728	   4928	drivers/hid/hid-lg.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   14884	   3600	    128	  18612	   48b4	drivers/hid/hid-lg.o
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

