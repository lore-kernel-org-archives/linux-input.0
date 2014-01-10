From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input synaptics-rmi4: PDT scan cleanup
Date: Fri, 10 Jan 2014 12:31:33 -0800
Message-ID: <1754181.lppeTWGTml@dtor-d630.eng.vmware.com>
References: <1389126821-4066-1-git-send-email-cheiny@synaptics.com> <52D056B3.406@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:41175 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758282AbaAJUbi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jan 2014 15:31:38 -0500
Received: by mail-pb0-f47.google.com with SMTP id um1so4909686pbc.20
        for <linux-input@vger.kernel.org>; Fri, 10 Jan 2014 12:31:37 -0800 (PST)
In-Reply-To: <52D056B3.406@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Friday, January 10, 2014 12:23:15 PM Christopher Heiny wrote:
> On 01/07/2014 12:33 PM, Christopher Heiny wrote:
> > Eliminates copy-paste code that handled scans of the Page Descriptor
> > Table,
> > replacing it with a single PDT scan routine that invokes a callback
> > function. The scan routine is not static so that it can be used by the
> > firmware update code (under development, not yet submitted).
> > 
> > Updated the copyright dates while we were at it.
> 
> Hi Dmitry,
> 
> Could you apply this or provide some feedback on it?  We've got a
> pending patch that depends on it, and that pending work will bring the
> driver back to a working (if not necessarily beautiful) state.  I don't
> want to submit it if this change isn't satisfactory, though.

Speaking of the devil. I was just thinking about it and I wanted to ask
you to send me an example of how it is used as I can;t make my mind about
it.

In general it is OK to submit a few patches at a time even if they are
depend on each other - it gives me better context (as long as there
aren't 80 of those so that I down in them ;) ).

Thanks.

-- 
Dmitry
