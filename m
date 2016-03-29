From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: lenovo: Don't use stack variables for DMA buffers
Date: Tue, 29 Mar 2016 15:40:54 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1603291539180.3656@cbobk.fhfr.pm>
References: <1459171334-22943-1-git-send-email-jwboyer@fedoraproject.org> <1459171334-22943-2-git-send-email-jwboyer@fedoraproject.org> <20160329065027.GA20424@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43292 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbcC2Nk5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 09:40:57 -0400
In-Reply-To: <20160329065027.GA20424@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 29 Mar 2016, Benjamin Tissoires wrote:

> > The lenovo_send_cmd_cptkbd function uses a stack variable to submit
> > commands via hid_hw_raw_request.  Eventually this gets to the
> > usb_hcd_map_urb_for_dma function, which causes a warning to be thrown
> > if the CONFIG_DMA_API_DEBUG option is enabled.
> > 
> > Fix this by allocating a temporary buffer instead.
> > 
> > Reported-by: lejeczek <peljasz@yahoo.co.uk>
> > Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
> > ---
> 
> The patch is
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> There is just one nitpick that can be solved while committing (or not,
> depending on how Jiri handles it :-P ).

I've nuked the NULL-initialization and applied, thanks!

-- 
Jiri Kosina
SUSE Labs

