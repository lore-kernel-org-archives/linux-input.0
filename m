From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [Patch] hid: enhance hid-saitek for use with R.A.T.5 and
 similar
Date: Thu, 28 Jan 2016 09:53:37 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601280952470.21446@cbobk.fhfr.pm>
References: <5690FEB0.4040809@unet.univie.ac.at>    <alpine.LNX.2.00.1601261527260.21446@cbobk.fhfr.pm> <9617e7c332cd0041c92ca9c95dc12fea.squirrel@webmail.univie.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59934 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754640AbcA1Ixk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jan 2016 03:53:40 -0500
In-Reply-To: <9617e7c332cd0041c92ca9c95dc12fea.squirrel@webmail.univie.ac.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Piotr Sawuk <a9702387@unet.univie.ac.at>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 28 Jan 2016, Piotr Sawuk wrote:

> >> +	hdev = container_of(dev, struct hid_device, dev);
> >
> > You can use to_hid_device() here.
> 
> sorry, didn't notice that recent addition.
> my new patch wont work against older kernel versions though...

The only thing that really matters is that it works with the kernel it's 
being applied to and pushed upstream.

If anyone wants to backport it later to some older kernel, as part of a 
backport he'd have to open-code to_hide_device() ... no big deal.

Thanks,

-- 
Jiri Kosina
SUSE Labs

