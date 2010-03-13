From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Zeroing the report before setting fields
Date: Sat, 13 Mar 2010 23:25:11 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003132324250.18642@pobox.suse.cz>
References: <20100304143349.2d861ec6@redhat.com> <20100305082901.GA20245@core.coreip.homeip.net> <alpine.LNX.2.00.1003091340250.17799@pobox.suse.cz> <20100309162648.289871c4@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:55369 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249Ab0CMWZN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Mar 2010 17:25:13 -0500
In-Reply-To: <20100309162648.289871c4@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-input@vger.kernel.org

On Tue, 9 Mar 2010, Pete Zaitcev wrote:

> > > > the end of the byte. But in case of, say, my keyboard, NumLock is mask
> > > > 0x01 and CapsLock is 0x02. Invoking hid_output_field for NumLock
> > > > definitely zeroes across CapsLock. The only reason this works is that
> > > > the fields are sorted by the offset.
> 
> > > I think Jiri is the most qualified to answer questions like that about
> > > HID (CCed) buit I think what you are proposing is reasonable and would
> > > make the code safer indeed.
> > 
> > Yes, the patch looks fine to me, thanks for CCing me. 
> > 
> > Pete, could you please send it to me along with your Signed-off-by line, 
> > so that I could queue it up?
> 
> Will do, thanks. I was hoping for a comment re. memset.
> It is not needed for reports that consist of full bytes,
> so it's a little wasteful. I aimed at simplicity, but I don't
> know, what do you think?

I don't think it's super important (basically nothing can be considered 
super-hot path when dealing with such slow hardware as HID devices :) ), 
but I wouldn't object to adding extra check before calling the memset.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
