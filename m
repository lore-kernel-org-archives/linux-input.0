From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] HID: uhid: Fixes a bug with userspace bluetooth stacks,
 which causes hangs during certain operations
Date: Tue, 31 May 2016 14:59:07 -0700
Message-ID: <20160531215907.GB30197@kroah.com>
References: <1463602269-19844-1-git-send-email-roderick.colenbrander@sony.com>
 <1DD62093774CEE42AFC16E785A1088045F496A74@USCULXMSG04.am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1DD62093774CEE42AFC16E785A1088045F496A74@USCULXMSG04.am.sony.com>
Sender: stable-owner@vger.kernel.org
To: "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>
Cc: "dh.herrmann@googlemail.com" <dh.herrmann@googlemail.com>, "jikos@kernel.org" <jikos@kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "roderick@gaikai.com" <roderick@gaikai.com>
List-Id: linux-input@vger.kernel.org

On Tue, May 31, 2016 at 09:10:36PM +0000, Colenbrander, Roelof wrote:
> Hi,
> 
> The patch in this thread is part of input work I'm doing with my team
> and will hopefully be the first of many, but we are new to the
> linux-input project. We shared this patch first in April and again
> about 2 weeks ago in May, but we haven't received any feedback so far.

It's been the middle of the merge window for the past 2 weeks, where no
new code is usually reviewed or handled at all.  Give the maintainers a
bit of time to catch up.

thanks,

greg k-h
