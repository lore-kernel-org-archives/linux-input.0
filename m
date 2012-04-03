From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Tue, 3 Apr 2012 08:09:41 -0700 (PDT)
Message-ID: <alpine.LNX.2.00.1204030807220.9041@pobox.suse.cz>
References: <20120403144644.GA16506@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36829 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769Ab2DCPJn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Apr 2012 11:09:43 -0400
In-Reply-To: <20120403144644.GA16506@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, linux-input@vger.kernel.org

On Tue, 3 Apr 2012, Henrik Rydberg wrote:

> >  include/linux/hid.h |   12 ++++++++++--
> >  1 files changed, 10 insertions(+), 2 deletions(-)
> 
> > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > index 3a95da6..f771eba 100644
> > --- a/include/linux/hid.h
> > +++ b/include/linux/hid.h
> > @@ -807,8 +807,16 @@ static inline int __must_check hid_parse(struct hid_devic> e *hdev)
> >  {
> >  	int ret;
> >  
> > -	if (hdev->status & HID_STAT_PARSED)
> > -		return 0;
> > +	if (hdev->status & HID_STAT_PARSED) {
> > +		/*
> > +		 * We want to be re-entrant to allow for dynamic driver
> > +		 * rebinding and still allow rdescs to be replaced and
> > +		 * and re-parsed once the driver has been dynamically
> > +		 * rebound
> > +		 */
> > +		kfree(hdev->rdesc);
> > +		hdev->status &= ~HID_STAT_PARSED;
> > +	}
> >  
> >  	ret = hdev->ll_driver->parse(hdev);
> >  	if (!ret)
> 
> It seems an equivalent patch would be to remove HID_STAT_PARSED
> altogether, replacing it with something like this:

Yes, that's identical.

[ ... snip ... ]
> which makes me wonder if something will break or be called
> unnecessarily often as a result?

I don't currently see how such thing could happen. Do you have anything 
particular on your mind?

> I think the main logic problem stems from viewing hid devices as being 
> on the same level as usb/bt devices.  Perhaps report fixups should be 
> part of the hid_ll_driver layer instead.

It probably should, yes. One of the reasons supporting this is that during 
USB reset (for example), the descriptors are reread from the device, which 
has a potential to cause a mismatch if a full rebind cycle is not 
performed. (I have a patch in my queue that tries to fix this, but moving 
the fixups to ll drivers is still something I will be considering).

Thanks,

-- 
Jiri Kosina
SUSE Labs
