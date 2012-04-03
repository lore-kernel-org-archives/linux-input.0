From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Tue, 3 Apr 2012 10:01:37 -0700 (PDT)
Message-ID: <alpine.LNX.2.00.1204031000100.9041@pobox.suse.cz>
References: <20120403144644.GA16506@polaris.bitmath.org> <alpine.LNX.2.00.1204030807220.9041@pobox.suse.cz> <20120403163752.GA17048@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42940 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210Ab2DCRBi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Apr 2012 13:01:38 -0400
In-Reply-To: <20120403163752.GA17048@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, linux-input@vger.kernel.org

On Tue, 3 Apr 2012, Henrik Rydberg wrote:

> > It probably should, yes. One of the reasons supporting this is that during 
> > USB reset (for example), the descriptors are reread from the device, which 
> > has a potential to cause a mismatch if a full rebind cycle is not 
> > performed. (I have a patch in my queue that tries to fix this, but moving 
> > the fixups to ll drivers is still something I will be considering).
> 
> Sounds good, it will also pave the way for the modalias patches.

A proper and clean implementation will have to be thought about though.

I specifically want to avoid situation when we'll be heading towards 
"let's put all quirk handling into one driver under giant VID/PID-based 
switch", as getting rid of that was the very original pulse to have HID 
bus introduced.

-- 
Jiri Kosina
SUSE Labs
