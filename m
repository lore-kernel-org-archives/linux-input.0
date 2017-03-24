From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elantech - add Fujitsu Lifebook E547 to force
 crc_enabled
Date: Fri, 24 Mar 2017 10:00:00 -0700
Message-ID: <20170324170000.GA18364@dtor-ws>
References: <c194d33b-9918-7514-d662-00d0688a7dfd@leemhuis.info>
 <20170309175058.gtodm4q525sqyfro@lantern>
 <6055ed5d-79e5-0ae7-8b91-274562c3f44a@leemhuis.info>
 <8fa42069-fa8c-e59c-f574-8fbabc6ce6d2@leemhuis.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33083 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757404AbdCXRAE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Mar 2017 13:00:04 -0400
Received: by mail-pf0-f196.google.com with SMTP id p189so1287316pfp.0
        for <linux-input@vger.kernel.org>; Fri, 24 Mar 2017 10:00:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8fa42069-fa8c-e59c-f574-8fbabc6ce6d2@leemhuis.info>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: ulrik.debie-os@e2big.org, linux-input@vger.kernel.org

Hi Thorsten,

On Fri, Mar 24, 2017 at 11:18:51AM +0100, Thorsten Leemhuis wrote:
> Lo! Dmitry, did this fall through the cracks or is there any reason why
> you didn't yet apply below patch? If the latter: What is needed to get
> things moving? Right now I still have access to the machine for further
> tests, but that will change in a week or two. Ciao, Thorsten

I was waiting for an updated version of the patch with updated info for
E547. The "caps" data is coming from Synaptics caps query, so should be
"50, 12, 09".

Thanks.

> 
> On 10.03.2017 07:53, Thorsten Leemhuis wrote:
> > Lo! ulrik.debie-os@e2big.org wrote on 09.03.2017 18:50:
> >>
> >> Can you also provide the line equivalent for 
> >>  * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw buttons
> >> ?
> > 
> > Where do I find those three values mentioned in the third column? And is
> > that line important at all? I just did below patch as a drive-by-patch
> > and from looking at the source code I can't immediately spot how to get
> > them :-/
> > 
> > FWIW, it's a 2 hw buttons touchpad and I saw this in dmesg
> > 
> > psmouse serio2: elantech: assuming hardware version 4 (with firmware
> > version )
> > psmouse serio2: elantech: Synaptics capabilities query result 0x50,
> > 0x12, 0x09.
> > psmouse serio2: elantech: Elan sample query result 01, 27, 86
> > 
> > Are those values from "Elan sample query result" what you are looking
> > for? Then the line would be:
> > 
> > Fujitsu LIFEBOOK E547  0x470f00        01, 27, 86      2 hw buttons
> > 
> > Ciao, Thorsten
> > 
> > 
> >> On Thu, Mar 09, 2017 at 09:19:41AM +0100, Thorsten Leemhuis wrote:
> >>>
> >>> Temporary got a Fujitsu Lifebook E547 into my hands and noticed 
> >>> the touchpad only works after running
> >>>
> >>> echo "1" > /sys/devices/platform/i8042/serio2/crc_enabled
> >>>
> >>> Add it to the list of Fujitsu machines that need this workaround.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> >>> ---
> >>>  drivers/input/mouse/elantech.c | 7 +++++++
> >>>  1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> >>> index efc8ec3..c5e513b 100644
> >>> --- a/drivers/input/mouse/elantech.c
> >>> +++ b/drivers/input/mouse/elantech.c
> >>> @@ -1524,6 +1524,13 @@ static int elantech_reconnect(struct psmouse *psmouse)
> >>>  		},
> >>>  	},
> >>>  	{
> >>> +		/* Fujitsu LIFEBOOK E547  does not work with crc_enabled == 0 */
> >>> +		.matches = {
> >>> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> >>> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E547"),
> >>> +		},
> >>> +	},
> >>> +	{
> >>>  		/* Fujitsu LIFEBOOK E554  does not work with crc_enabled == 0 */
> >>>  		.matches = {
> >>>  			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> >>> -- 
> >>> 1.8.3.1
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>

-- 
Dmitry
