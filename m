From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: rmi: Check that a device is a RMI device before
 calling RMI functions
Date: Wed, 18 Oct 2017 23:25:32 +0200
Message-ID: <20171018212532.GG24559@mail.corp.redhat.com>
References: <1508290656-18871-1-git-send-email-aduggan@synaptics.com>
 <20171018084803.GE24559@mail.corp.redhat.com>
 <nycvar.YFH.7.76.1710181612470.9294@jbgna.fhfr.qr>
 <37d50592-39b6-680f-6d02-1a7daa9a9208@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751325AbdJRVZi (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Oct 2017 17:25:38 -0400
Content-Disposition: inline
In-Reply-To: <37d50592-39b6-680f-6d02-1a7daa9a9208@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hendrik Langer <hendrik.langer@gmx.de>

On Oct 18 2017 or thereabouts, Andrew Duggan wrote:
> 
> 
> On 10/18/2017 07:13 AM, Jiri Kosina wrote:
> > On Wed, 18 Oct 2017, Benjamin Tissoires wrote:
> > 
> > > > The hid-rmi driver may handle non rmi devices on composite USB devices.
> > > > Callbacks need to make sure that the current device is a RMI device before
> > > > calling RMI specific functions. Most callbacks already have this check, but
> > > > this patch adds checks to the remaining callbacks.
> > > > 
> > > > Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> > > > ---
> > > > This is the patch which hopefully will address the X1 tablet dock freeze:
> > > > http://www.spinics.net/lists/linux-input/msg53582.html
> > > > 
> > > > I was not able to test on a composite USB device so I have not tested confirmed
> > > > this will fix the reported issues. But, based on the description I think it will.
> > > > I also added a check for rmi_raw_event() since it could be possible that another
> > > > hid device using one of the same report IDs as an RMI device could result in calling
> > > > into unitialized RMI functions. It was also the only callbacl left not checking the
> > > > RMI_DEVICE flag. I wonder if this explains the attach crash.
> > > > 
> > > > Anyway, I would appriciate it if Hendrik or someone else with the device could test this
> > > > patch to confirm it fixes the reported behavior.
> > > Shouldn't rmi_hid_reset() also get the same check?
> > I think so as well.
> 
> Since rmi_hid_reset() is only called from with in the RMI4 driver I didn't
> think that it needed a check. All of the functions set in struct hid_driver
> should  now check the RMI_DEVICE flag before calling into the RMI4 driver.
> But, if I am missing something we can add additional checks.

Oh, right, you are correct. I didn't paid enough attention and
overlooked the fact that this function was set in struct
rmi_transport_ops only.

Given Hendrick's Tested-by came in as well (thanks for the quick
tests!), this is:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> 
> Thanks,
> Andrew
> 
> > >  From what I can see, even if the patch doesn't fix the immediate issue,
> > > such a patch should definitively go in as those checks are clearly
> > > missing.
> > Agreed; however I'd like to get Hendrik's Tested-by: if possible in case
> > this really fixes the issue, so I am not merging it right away.
> > 
> > Hendrik, are you by any chance able to test this patch in a reasonable
> > timeframe please?
> > 
> > Thanks!
> > 
> 
