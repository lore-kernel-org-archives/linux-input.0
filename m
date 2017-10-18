From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: rmi: Check that a device is a RMI device before
 calling RMI functions
Date: Wed, 18 Oct 2017 16:13:50 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710181612470.9294@jbgna.fhfr.qr>
References: <1508290656-18871-1-git-send-email-aduggan@synaptics.com> <20171018084803.GE24559@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171018084803.GE24559@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hendrik Langer <hendrik.langer@gmx.de>
List-Id: linux-input@vger.kernel.org

On Wed, 18 Oct 2017, Benjamin Tissoires wrote:

> > The hid-rmi driver may handle non rmi devices on composite USB devices.
> > Callbacks need to make sure that the current device is a RMI device before
> > calling RMI specific functions. Most callbacks already have this check, but
> > this patch adds checks to the remaining callbacks.
> > 
> > Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> > ---
> > This is the patch which hopefully will address the X1 tablet dock freeze:
> > http://www.spinics.net/lists/linux-input/msg53582.html
> > 
> > I was not able to test on a composite USB device so I have not tested confirmed
> > this will fix the reported issues. But, based on the description I think it will.
> > I also added a check for rmi_raw_event() since it could be possible that another
> > hid device using one of the same report IDs as an RMI device could result in calling
> > into unitialized RMI functions. It was also the only callbacl left not checking the
> > RMI_DEVICE flag. I wonder if this explains the attach crash.
> > 
> > Anyway, I would appriciate it if Hendrik or someone else with the device could test this
> > patch to confirm it fixes the reported behavior.
> 
> Shouldn't rmi_hid_reset() also get the same check?

I think so as well.

> 
> From what I can see, even if the patch doesn't fix the immediate issue, 
> such a patch should definitively go in as those checks are clearly 
> missing.

Agreed; however I'd like to get Hendrik's Tested-by: if possible in case 
this really fixes the issue, so I am not merging it right away.

Hendrik, are you by any chance able to test this patch in a reasonable 
timeframe please?

Thanks!

-- 
Jiri Kosina
SUSE Labs
