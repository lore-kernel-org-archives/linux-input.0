From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Update Elantech touchpad driver to v5 for
	kernel 2.6.27-rc5-mm1
Date: Thu, 16 Oct 2008 00:48:54 -0400
Message-ID: <20081016044854.GB17531@anvil.corenet.prv>
References: <20080914032344.GA16228@adopmeer.homeip.net> <20080919041727.GB7594@core.corenet.prv> <20080919070530.GA7599@adopmeer.homeip.net> <20081016030515.GA28113@amd.corenet.prv> <20081016042909.GA12122@adopmeer.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:47275 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbYJPEtF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Oct 2008 00:49:05 -0400
Received: by gxk9 with SMTP id 9so7849482gxk.13
        for <linux-input@vger.kernel.org>; Wed, 15 Oct 2008 21:49:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081016042909.GA12122@adopmeer.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan Opmeer <arjan@opmeer.net>
Cc: akpm@linux-foundation.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 16, 2008 at 06:29:09AM +0200, Arjan Opmeer wrote:
> 
> Hi Dmitry,
> 
> On Wed, Oct 15, 2008 at 11:05:15PM -0400, Dmitry Torokhov wrote:
> > > 
> > > As far as I know the touchpad does not report pressure
> > 
> > I see. In this case the driver should not really report ABS_PRESSURE but
> > only BTN_TOUCH. I understand that this would require synaptics X driver
> > changes but that should be OK. I wrote a patch to the X driver which seems
> > to be working if I bastardize my synaptics touchpad but I would like to
> > have it tested with real Elantech device. I am attaching the version of
> > Elantech driver that I want to apply (there were some timy changes) and
> > the patch to teh Synaptics X driver (against recent git pull from its
> > repository). If you could give it a try that would be grand.
> 
> Well, there we have a problem. My laptop with the Elantech touchpad died. So
> I no longer have any hardware to try your changes on!
> 

Oops, sorry to hear that. It looks like i wait for too long...

> Maybe we should just put the code out there and see what happens?
> 

I suppose so, it was in Andrew's tree for a while.

> 
> As I was reading over the patch I found some small things you might want to
> change.
> 
> > dropped (users wishing to use touchpad in relative mode can use
> > standard PS/2 protocol emilation done in hardware). The driver
>                          ^^^^^^^^^ emulation
> 

OK.

> > +	case 2:
> > +		/* We don't now how to check parity in protocol v2 */
>                             ^^^ know

OK.

> 
> > +		/*
> > +		 * Read back reg 0x10. The touchpad is probably initalising
> > +		 * and not ready until we read back the value we just wrote.
> > +		 */
> 
> Although the fact that we can read back the registers contents means we
> didn't jam the touchpad EC by initialising with the wrong register values
> earlier, it occured to me that we never actually test the value we read
> back.
> 
> > +		do {
> > +			rc = elantech_read_reg(psmouse, 0x10, &val);
> > +			if (rc == 0)
> 
> Shouldn't this read
> 
>    if (rc == 0 && val == etd->reg 10)
> 
> ?
> 

If we see reports of hardware not switching to absolute mode we might
want to do this.

> > +	for (i = 1; i < 256; i++)
> > +		etd->parity[i] = (etd->parity[i & (i - 1)] ^ 1);
>                                  ^                            ^
> Why did I put these parentheses there?
> 

:)

> > +	/*
> > +	 * Assume every version greater than this is new EeePC style
> > +	 * hardware with 6 byte packets
> > +	 */
> > +	if ((etd->fw_version_maj >= 0x02) && (etd->fw_version_min >= 0x30)) {
> 
> In your quest of removing parentheses don't you want to remove these ones too?
> :)
> 

Done.

> > +/*
> > + * Try Elantech touchpad.
> > + */
> > +	if (max_proto > PSMOUSE_IMEX && 
> > +			elantech_detect(psmouse, set_properties) == 0) {
> > +		if (!set_properties || elantech_init(psmouse) == 0)
> > +			return PSMOUSE_ELANTECH;
> 
> I see you moved the Elantech detection up. I put it after the pmouse_reset
> on purpose as a safety measure because when initially developing the driver
> I managed to get the touchpad all confused and not responding properly to
> its magic knock. However this was using the serio_raw interface, so it might
> not be necessary in this case.
> 

There is psmouse_reset() call in elantech_detect() now. The reason it
was moved is the place it used to be we do "basic" protocol probes when
either user asked us to limit protocols being tested or we know that we
are working with specific hardware but native protocol failed for some
reason.

-- 
Dmitry
