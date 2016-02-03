From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid:Add missing error checking in mt_probe for creating
 sysfs_create_group
Date: Wed, 3 Feb 2016 10:14:20 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1602031013520.22727@cbobk.fhfr.pm>
References: <1454470263-29702-1-git-send-email-xerofoify@gmail.com> <20160203082355.GE12345@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40682 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbcBCJOW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Feb 2016 04:14:22 -0500
In-Reply-To: <20160203082355.GE12345@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nicholas Krause <xerofoify@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 3 Feb 2016, Benjamin Tissoires wrote:

> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> > index 296d499..46ebf06 100644
> > --- a/drivers/hid/hid-multitouch.c
> > +++ b/drivers/hid/hid-multitouch.c
> > @@ -1133,6 +1133,8 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  		return ret;
> >  
> >  	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
> > +	if (ret)
> > +		return ret;
> 
> I am not particularly happy with a hard failure here in case the sysfs
> group doesn't bind. The group is mainly used for debug, and I am not
> sure anybody but me uses it nowadays.
> 
> Could you amend the patch to put a warning in case of a failure but
> still continue?

Yeah. And also in case of hard failure, some cleanup would have to be done 
anyway (hid_hw_start() has already happened, etc).

-- 
Jiri Kosina
SUSE Labs

