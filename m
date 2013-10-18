From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: Fix unit exponent parsing again
Date: Fri, 18 Oct 2013 14:58:59 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1310181456500.31790@pobox.suse.cz>
References: <1381666192-25309-1-git-send-email-spbnick@gmail.com> <CAN+gG=FC8Zvkt+9wcaMyo+akmqY-mm=xSPDqWOqGHEPwZx3XTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48144 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883Ab3JRM7D (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Oct 2013 08:59:03 -0400
In-Reply-To: <CAN+gG=FC8Zvkt+9wcaMyo+akmqY-mm=xSPDqWOqGHEPwZx3XTQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Thu, 17 Oct 2013, Benjamin Tissoires wrote:

> > Revert some changes done in 774638386826621c984ab6994439f474709cac5e.
> >
> > Revert all changes done in hidinput_calc_abs_res as it mistakingly used
> > "Unit" item exponent nibbles to affect resolution value. This wasn't
> > breaking resolution calculation of relevant axes of any existing
> > devices, though, as they have only one dimension to their units and thus
> > 1 in the corresponding nible.
> >
> > Revert to reading "Unit Exponent" item value as a signed integer in
> > hid_parser_global to fix reading specification-complying values. This
> > fixes resolution calculation of devices complying to the HID standard,
> > including Huion, KYE, Waltop and UC-Logic graphics tablets which have
> > their report descriptors fixed by the drivers.
> >
> > Explanations follow.
[ ... snip ... ]
> I finally understood what you mean here, and why I introduced such a change.
> I have weird report descriptors available in the field which are
> making a funny use of units:

Ok, it took me quite some time to figure this all out. Good work Nikolai, 
thanks.

I am about to apply it, just a minor thing -- you seem to have forgotten 
your Signed-off-by: line in the patch. Could you please send it to me, so 
that I can ammend it to the patch and apply it?

Thanks.

-- 
Jiri Kosina
SUSE Labs
