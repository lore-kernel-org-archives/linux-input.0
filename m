From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Recent change to hid-core.c
Date: Mon, 16 Dec 2013 15:56:09 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1312161555430.12882@pobox.suse.cz>
References: <52AD3D74.90905@pobox.com> <alpine.LNX.2.00.1312161418110.12882@pobox.suse.cz> <52AF13A4.8030900@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58798 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753755Ab3LPO4M (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Dec 2013 09:56:12 -0500
In-Reply-To: <52AF13A4.8030900@pobox.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: linux-input@vger.kernel.org

On Mon, 16 Dec 2013, Mark Lord wrote:

> >> The recent update 08ec2dcc3527a20c619aca2fb36f800908256bac
> >>  "Merge branches 'for-3.11/multitouch', 'for-3.11/sony' and 'for-3.11/upstream' into for-linus"
> >> included an unexpected change to the return code handing for ->raw_event() calls.
> ,,
> >> Was this intentional?  Doesn't that have side-effects for some drivers?
> ..
> > this was intentional -- please see commit b1a1442a23 and discussion here: 
> > https://lkml.org/lkml/2013/3/21/591
> ..
> 
> Thanks Jiri.
> In that case you'll be wanting this patch (unmangled copy attached) as well
> to clean up a tiny bit of leftover logic in there.
> 
> * * * * * * SNIP * * * * * *
> 
> Recent updates to raw_event handling resulted in some leftover "dead" logic
> in hid-core.c::hid_input_report().  Nuke it.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> --- old/drivers/hid/hid-core.c	2013-12-12 01:38:07.000000000 -0500
> +++ linux/drivers/hid/hid-core.c	2013-12-16 09:48:27.339162173 -0500
> @@ -1418,10 +1418,8 @@
> 
>  	if (hdrv && hdrv->raw_event && hid_match_report(hid, report)) {
>  		ret = hdrv->raw_event(hid, report, data, size);
> -		if (ret < 0) {
> -			ret = ret < 0 ? ret : 0;
> +		if (ret < 0)
>  			goto unlock;
> -		}

Please see commit 556483e2a ("HID: remove self-assignment from 
hid_input_report") in Linus' tree.

-- 
Jiri Kosina
SUSE Labs
