From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Zeroing the report before setting fields
Date: Tue, 9 Mar 2010 13:41:24 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003091340250.17799@pobox.suse.cz>
References: <20100304143349.2d861ec6@redhat.com> <20100305082901.GA20245@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:38227 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987Ab0CIMlZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 07:41:25 -0500
In-Reply-To: <20100305082901.GA20245@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-input@vger.kernel.org

On Fri, 5 Mar 2010, Dmitry Torokhov wrote:

> > the end of the byte. But in case of, say, my keyboard, NumLock is mask
> > 0x01 and CapsLock is 0x02. Invoking hid_output_field for NumLock
> > definitely zeroes across CapsLock. The only reason this works is that
> > the fields are sorted by the offset.
> > 
> > I am not sure it's safe at all times, so why don't we pull the
> > zeroing outside and do it once per report? Please see the attached.
> > I tested it with various keyboards (including those that blow up
> > on RHEL 5), and it works, but the question is, do we want it?
> > 
> 
> I think Jiri is the most qualified to answer questions like that about
> HID (CCed) buit I think what you are proposing is reasonable and would
> make the code safer indeed.

Yes, the patch looks fine to me, thanks for CCing me. 

Pete, could you please send it to me along with your Signed-off-by line, 
so that I could queue it up?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
