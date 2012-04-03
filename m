From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Tue, 3 Apr 2012 18:37:52 +0200
Message-ID: <20120403163752.GA17048@polaris.bitmath.org>
References: <20120403144644.GA16506@polaris.bitmath.org>
 <alpine.LNX.2.00.1204030807220.9041@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:40134 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926Ab2DCQgU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Apr 2012 12:36:20 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id DEBA0C6C7
	for <linux-input@vger.kernel.org>; Tue,  3 Apr 2012 18:36:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1204030807220.9041@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, linux-input@vger.kernel.org

> > which makes me wonder if something will break or be called
> > unnecessarily often as a result?
> 
> I don't currently see how such thing could happen. Do you have anything 
> particular on your mind?

Only that there ought to have been a reason the flag was added in the
first place.

> > I think the main logic problem stems from viewing hid devices as being 
> > on the same level as usb/bt devices.  Perhaps report fixups should be 
> > part of the hid_ll_driver layer instead.
> 
> It probably should, yes. One of the reasons supporting this is that during 
> USB reset (for example), the descriptors are reread from the device, which 
> has a potential to cause a mismatch if a full rebind cycle is not 
> performed. (I have a patch in my queue that tries to fix this, but moving 
> the fixups to ll drivers is still something I will be considering).

Sounds good, it will also pave the way for the modalias patches.

Thanks,
Henrik
