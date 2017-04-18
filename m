From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: elantech - add Fujitsu Lifebook E547 to force
 crc_enabled
Date: Tue, 18 Apr 2017 11:16:02 -0700
Message-ID: <20170418181602.GA5126@dtor-ws>
References: <c194d33b-9918-7514-d662-00d0688a7dfd@leemhuis.info>
 <20170309175058.gtodm4q525sqyfro@lantern>
 <6055ed5d-79e5-0ae7-8b91-274562c3f44a@leemhuis.info>
 <8fa42069-fa8c-e59c-f574-8fbabc6ce6d2@leemhuis.info>
 <20170324170000.GA18364@dtor-ws>
 <24d86f3c-356f-8e5b-41d7-26348b302edc@leemhuis.info>
 <c0e1c192-8a15-91eb-9d93-5fc928f6f04e@leemhuis.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33224 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdDRSQG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Apr 2017 14:16:06 -0400
Received: by mail-pg0-f68.google.com with SMTP id 63so147401pgh.0
        for <linux-input@vger.kernel.org>; Tue, 18 Apr 2017 11:16:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <c0e1c192-8a15-91eb-9d93-5fc928f6f04e@leemhuis.info>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: ulrik.debie-os@e2big.org, linux-input@vger.kernel.org

On Tue, Apr 18, 2017 at 03:42:55PM +0200, Thorsten Leemhuis wrote:
> Lo! Dmitry, did this fall through the cracks or is there any reason why
> you didn't yet apply below patch? If the latter: What is needed to get
> things moving? Ciao, Thorsten

Sorry, v2 got lost in the thread. Applied now.

> 
> On 27.03.2017 10:53, Thorsten Leemhuis wrote:
> > Hi! On 24.03.2017 18:00, Dmitry Torokhov wrote: 
> >> On Fri, Mar 24, 2017 at 11:18:51AM +0100, Thorsten Leemhuis wrote:
> >>> Lo! Dmitry, did this fall through the cracks or is there any reason why
> >>> you didn't yet apply below patch? If the latter: What is needed to get
> >>> things moving? Right now I still have access to the machine for further
> >>> tests, but that will change in a week or two. Ciao, Thorsten
> >> I was waiting for an updated version of the patch with updated info for
> >> E547. The "caps" data is coming from Synaptics caps query, so should be
> >> "50, 12, 09".
> > 
> > /me opens eyes properly and reads the output from dmesg again
> > /me wonders why he hadn't noticed the capabilities output from the
> > synaptics driver before and missed the obvious connection
> > 
> > Many thx for the pointer! Find an updated patch below.
> > 
> > Ciao, Thorsten
> > 
> > From 8feadc9af68c77c9e0fec3f85b9d5312b8f2e468 Mon Sep 17 00:00:00 2001
> > From: Thorsten Leemhuis <linux@leemhuis.info>
> > Date: Thu, 9 Mar 2017 08:13:21 +0100
> > Subject: Input: elantech - add Fujitsu Lifebook E547 to force crc_enabled
> > 
> > Temprary got a Lifebook E547 into my hands and noticed the touchpad
> > only works after running
> > 
> > echo "1" > /sys/devices/platform/i8042/serio2/crc_enabled
> > 
> > Add it to the list of machines that need this workaround.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> > Reviewed-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
> > ---
> >  drivers/input/mouse/elantech.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> > index efc8ec3..f53dad0 100644
> > --- a/drivers/input/mouse/elantech.c
> > +++ b/drivers/input/mouse/elantech.c
> > @@ -1118,6 +1118,7 @@ static int elantech_get_resolution_v4(struct psmouse *psmouse,
> >   * Asus UX32VD             0x361f02        00, 15, 0e      clickpad
> >   * Avatar AVIU-145A2       0x361f00        ?               clickpad
> >   * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw buttons
> > + * Fujitsu LIFEBOOK E547   0x470f00        50, 12, 09      2 hw buttons
> >   * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw buttons
> >   * Fujitsu T725            0x470f01        05, 12, 09      2 hw buttons
> >   * Fujitsu H730            0x570f00        c0, 14, 0c      3 hw buttons (**)
> > @@ -1524,6 +1525,13 @@ static int elantech_reconnect(struct psmouse *psmouse)
> >  		},
> >  	},
> >  	{
> > +		/* Fujitsu LIFEBOOK E547  does not work with crc_enabled == 0 */
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E547"),
> > +		},
> > +	},
> > +	{
> >  		/* Fujitsu LIFEBOOK E554  does not work with crc_enabled == 0 */
> >  		.matches = {
> >  			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> > 

-- 
Dmitry
