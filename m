From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/3] Input: db9 - store object at correct index
Date: Tue, 6 Oct 2015 15:35:50 -0700
Message-ID: <20151006223550.GB31850@dtor-ws>
References: <1443864298-20950-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20151006003205.GA30418@dtor-ws>
 <20151006053859.GG4745@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35967 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbbJFWfx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Oct 2015 18:35:53 -0400
Content-Disposition: inline
In-Reply-To: <20151006053859.GG4745@sudip-pc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Oct 06, 2015 at 11:08:59AM +0530, Sudip Mukherjee wrote:
> On Mon, Oct 05, 2015 at 05:32:05PM -0700, Dmitry Torokhov wrote:
> > On Sat, Oct 03, 2015 at 02:54:56PM +0530, Sudip Mukherjee wrote:
> > > The variable i is used to check the port to attach to and we are
> > > supposed to save the reference of struct db9 in the location given by
> > > db9_base[i]. But after finding out the index, i is getting modified again
> > > so we saved in a wrong index.
> > > While at it mark db9_base[i] as NULL after it is freed.
> > > 
> > > Fixes: 2260c419b52b ("Input: db9 - use parallel port device model")
> > > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > 
> > Applied the lot, thank you.
> 
> Thanks. And the change for serio/parkbd was pending. You said it was
> clashing with other changs.  Do i need to rebase and send you?

No, I applied it now.

Thanks.

-- 
Dmitry
