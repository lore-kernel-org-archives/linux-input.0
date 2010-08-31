From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH 1/6] HID: magicmouse: don't allow hidinput to initialize
Date: Tue, 31 Aug 2010 07:30:18 -0400
Message-ID: <1283254218.18522.11.camel@graviton>
References: <1283188858-4839-1-git-send-email-chase.douglas@canonical.com>
	 <1283226363.14419.44.camel@graviton>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:49672 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754317Ab0HaLaX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 07:30:23 -0400
Received: by mail-vw0-f43.google.com with SMTP id 8so5436854vws.30
        for <linux-input@vger.kernel.org>; Tue, 31 Aug 2010 04:30:22 -0700 (PDT)
In-Reply-To: <1283226363.14419.44.camel@graviton>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Mon, 2010-08-30 at 23:46 -0400, Michael Poole wrote:
> On Mon, 2010-08-30 at 13:20 -0400, Chase Douglas wrote:
> > From: Chase Douglas <chase.douglas@ubuntu.com>
> > 
> > The driver listens only for raw events from the device. If we allow
> > the hidinput layer to initialize, we can hit NULL pointer dereferences
> > in the hidinput layer because disconnecting only removes the input
> > devices from the hid device while leaving the hid fields around.
> > 
> > Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> > ---
> >  drivers/hid/hid-magicmouse.c |    6 ++----
> >  1 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> > index ee78787..2d8532d 100644
> > --- a/drivers/hid/hid-magicmouse.c
> > +++ b/drivers/hid/hid-magicmouse.c
> > @@ -404,15 +404,13 @@ static int magicmouse_probe(struct hid_device *hdev,
> >  		goto err_free;
> >  	}
> >  
> > -	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> > +	/* we are handling the input ourselves */
> > +	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW | HID_CONNECT_HIDDEV);
> >  	if (ret) {
> >  		dev_err(&hdev->dev, "magicmouse hw start failed\n");
> >  		goto err_free;
> >  	}
> >  
> > -	/* we are handling the input ourselves */
> > -	hidinput_disconnect(hdev);
> > -
> >  	report = hid_register_report(hdev, HID_INPUT_REPORT, TOUCH_REPORT_ID);
> >  	if (!report) {
> >  		dev_err(&hdev->dev, "unable to register touch report\n");
> 
> This effectively reverts commit 23d021167e.  Has the HID core changed so
> that this won't cause problems when CONFIG_HIDRAW is disabled?

To answer my own question, it has not changed: If CONFIG_HIDRAW is
turned off, the device will not get attached with this change, so the
driver does not get any input to process.  Turning CONFIG_HIDRAW on
restores the expected functionality.

Maybe hidinput_disconnect() should be modified instead, to clear the
fields that were causing null pointer dereferences?

Michael

