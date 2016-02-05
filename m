From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid:Add warning message if sysfs group is not created
 for passed kobject in the function, mt_probe
Date: Fri, 5 Feb 2016 14:37:58 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1602051437370.22727@cbobk.fhfr.pm>
References: <1454601160-21966-1-git-send-email-xerofoify@gmail.com> <20160205074804.GF12345@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44630 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752471AbcBENiA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 5 Feb 2016 08:38:00 -0500
In-Reply-To: <20160205074804.GF12345@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nicholas Krause <xerofoify@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 5 Feb 2016, Benjamin Tissoires wrote:

> > This adds a warning message stating that the sysfs group was not
> > able to be created for the passed hid_device structure pointer
> > with dev_warn.
> > 
> > Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> > ---
> >  drivers/hid/hid-multitouch.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> > index 296d499..b2b2451 100644
> > --- a/drivers/hid/hid-multitouch.c
> > +++ b/drivers/hid/hid-multitouch.c
> > @@ -1133,6 +1133,8 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  		return ret;
> >  
> >  	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
> > +	if (ret)
> > +		dev_warn(&hdev->dev, "Cannot allocate sysfs group for %s\n", hdev->name);
> 
> Just nitpicking here. Checkpatch.pl complains about a line over 80
> characters here. Could you (or maybe just Jiri) fix that?
> 
> Otherwise:
> Reviewed-by: Benjamin Tissoires <benajmin.tissoires@redhat.com>

Thanks. I've reformatted the source (and also changelog a bit) and 
applied.

-- 
Jiri Kosina
SUSE Labs

