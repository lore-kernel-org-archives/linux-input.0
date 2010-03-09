From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Zeroing the report before setting fields
Date: Tue, 9 Mar 2010 16:26:48 -0700
Message-ID: <20100309162648.289871c4@redhat.com>
References: <20100304143349.2d861ec6@redhat.com>
	<20100305082901.GA20245@core.coreip.homeip.net>
	<alpine.LNX.2.00.1003091340250.17799@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33762 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754660Ab0CIX0r (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 18:26:47 -0500
In-Reply-To: <alpine.LNX.2.00.1003091340250.17799@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, zaitcev@redhat.com

On Tue, 9 Mar 2010 13:41:24 +0100 (CET)
Jiri Kosina <jkosina@suse.cz> wrote:

> > > the end of the byte. But in case of, say, my keyboard, NumLock is mask
> > > 0x01 and CapsLock is 0x02. Invoking hid_output_field for NumLock
> > > definitely zeroes across CapsLock. The only reason this works is that
> > > the fields are sorted by the offset.

> > I think Jiri is the most qualified to answer questions like that about
> > HID (CCed) buit I think what you are proposing is reasonable and would
> > make the code safer indeed.
> 
> Yes, the patch looks fine to me, thanks for CCing me. 
> 
> Pete, could you please send it to me along with your Signed-off-by line, 
> so that I could queue it up?

Will do, thanks. I was hoping for a comment re. memset.
It is not needed for reports that consist of full bytes,
so it's a little wasteful. I aimed at simplicity, but I don't
know, what do you think?

-- Pete
