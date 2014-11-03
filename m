From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] HID: logitech-hidpp: leaks and NULL dereferences
Date: Mon, 3 Nov 2014 14:27:52 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411031427370.19451@pobox.suse.cz>
References: <20141031091439.GA11252@mwanda> <20141031134901.GB24511@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20141031134901.GB24511@mail.corp.redhat.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 31 Oct 2014, Benjamin Tissoires wrote:

> > Shift the allocation down a few lines to avoid a memory leak and also
> > add a check for allocation failure.
> > 
> > Fixes: 2f31c5252910 ('HID: Introduce hidpp, a module to handle Logitech hid++ devices')
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> 
> Ouch, I am ashamed of not having spot that :/
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Good catch. Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
