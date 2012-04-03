From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Tue, 3 Apr 2012 19:11:41 +0200
Message-ID: <20120403171141.GA17280@polaris.bitmath.org>
References: <20120403144644.GA16506@polaris.bitmath.org>
 <alpine.LNX.2.00.1204030807220.9041@pobox.suse.cz>
 <20120403163752.GA17048@polaris.bitmath.org>
 <alpine.LNX.2.00.1204031000100.9041@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:40777 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab2DCRKI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Apr 2012 13:10:08 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 9817ACD2A
	for <linux-input@vger.kernel.org>; Tue,  3 Apr 2012 19:10:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1204031000100.9041@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, linux-input@vger.kernel.org

On Tue, Apr 03, 2012 at 10:01:37AM -0700, Jiri Kosina wrote:
> On Tue, 3 Apr 2012, Henrik Rydberg wrote:
> 
> > > It probably should, yes. One of the reasons supporting this is that during 
> > > USB reset (for example), the descriptors are reread from the device, which 
> > > has a potential to cause a mismatch if a full rebind cycle is not 
> > > performed. (I have a patch in my queue that tries to fix this, but moving 
> > > the fixups to ll drivers is still something I will be considering).
> > 
> > Sounds good, it will also pave the way for the modalias patches.
> 
> A proper and clean implementation will have to be thought about though.
> 
> I specifically want to avoid situation when we'll be heading towards 
> "let's put all quirk handling into one driver under giant VID/PID-based 
> switch", as getting rid of that was the very original pulse to have HID 
> bus introduced.

Absolutely. Less in-kernel lookups, less complex switches and more modularity.

Henrik
