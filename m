From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] HID: multitouch: Do not fetch initial feature reports
 for Win8 devices
Date: Fri, 25 Sep 2015 17:23:45 +0300
Message-ID: <20150925142345.GR1536@lahna.fi.intel.com>
References: <1443089571-16561-1-git-send-email-mika.westerberg@linux.intel.com>
 <20150925011601.GA16273@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65014 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756452AbbIYOZ5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Sep 2015 10:25:57 -0400
Content-Disposition: inline
In-Reply-To: <20150925011601.GA16273@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 24, 2015 at 09:16:01PM -0400, Benjamin Tissoires wrote:
> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> > index 426b2f1a3450..1911f7698511 100644
> > --- a/drivers/hid/hid-multitouch.c
> > +++ b/drivers/hid/hid-multitouch.c
> > @@ -1020,14 +1020,16 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  	/*
> >  	 * Handle special quirks for Windows 8 certified devices.
> >  	 */
> > -	if (id->group == HID_GROUP_MULTITOUCH_WIN_8)
> > +	if (id->group == HID_GROUP_MULTITOUCH_WIN_8) {
> >  		/*
> >  		 * Some multitouch screens do not like to be polled for input
> > -		 * reports. Fortunately, the Win8 spec says that all touches
> > -		 * should be sent during each report, making the initialization
> > -		 * of input reports unnecessary.
> > +		 * and feature reports. Fortunately, the Win8 spec says that all
> > +		 * touches should be sent during each report, making the
> > +		 * initialization of input reports unnecessary.
> >  		 */
> >  		hdev->quirks |= HID_QUIRK_NO_INIT_INPUT_REPORTS;
> > +		hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
> 
> Problem is that with this quirk, event the features we are interested in
> (and that the device should support or Microsoft would complain) are not
> pre-read. I think we should set HID_QUIRK_NO_INIT_REPORTS (and remove
> HID_QUIRK_NO_INIT_INPUT_REPORTS BTW), and set up a quirk to actually
> retrieve the value of the feature in mt_feature_mapping. This way, we
> would be sure to only probe for features that are supported (contact
> count is the most important one).

Good point. I didn't realize that we actually use those features --
somehow I missed the whole mt_feature_mapping() function :-/

I'll try to implement what you suggested instead. Thanks.
