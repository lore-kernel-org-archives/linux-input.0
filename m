From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1  1/1] Input: elantech - fix absolute mode setting on
 some Asus touchpads
Date: Mon, 6 Apr 2015 15:38:35 -0700
Message-ID: <20150406223835.GA37385@dtor-ws>
References: <20150325203428.GA24094@lantern>
 <1427318875-12142-1-git-send-email-ulrik.debie-os@e2big.org>
 <1427318875-12142-2-git-send-email-ulrik.debie-os@e2big.org>
 <20150325225222.GA17427@dtor-ws>
 <20150326173706.GA17738@lantern>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33965 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbbDFWik (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Apr 2015 18:38:40 -0400
Received: by iget9 with SMTP id t9so2340821ige.1
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2015 15:38:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150326173706.GA17738@lantern>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ulrik.debie-os@e2big.org
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, George Moutsopoulos <gmoutso@yahoo.co.uk>

On Thu, Mar 26, 2015 at 06:37:06PM +0100, ulrik.debie-os@e2big.org wrote:
> On Wed, Mar 25, 2015 at 03:52:22PM -0700, Dmitry Torokhov wrote:
> > Hi Ulrik,
> > 
> > On Wed, Mar 25, 2015 at 10:27:55PM +0100, Ulrik De Bie wrote:
> > > On Asus TP500LN and X750JN, the touchpad absolute mode is reset each
> > > time set_rate is done.
> > > 
> > > In order to fix this, we will verify the firmware version, and if it
> > > matches the one in those laptops, the set_rate function is overloaded
> > > with a function elantech_set_rate_restore_reg_07 that perfoms the
> > > set_rate with the original function, followed by a restore of reg_07
> > > (the register that sets the absolute mode on elantech v4 hardware).
> > > 
> > > Also the asus TP500LN and X750JN firmware version, capabilities, and
> > > button constellation is added to elantech.c
> > > 
> > > Reported-and-tested-by: George Moutsopoulos <gmoutso@yahoo.co.uk>
> > > Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
> > > ---
> > >  drivers/input/mouse/elantech.c | 22 ++++++++++++++++++++++
> > >  drivers/input/mouse/elantech.h |  1 +
> > >  2 files changed, 23 insertions(+)
> > > 
> > > diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> > > index 6e22682..991dc6b 100644
> > > --- a/drivers/input/mouse/elantech.c
> > > +++ b/drivers/input/mouse/elantech.c
> > > @@ -893,6 +893,21 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
> > >  }
> > >  
> > >  /*
> > > + * This writes the reg_07 value again to the hardware at the end of every
> > > + * set_rate call because the register loses its value. reg_07 allows setting
> > > + * absolute mode on v4 hardware
> > > + */
> > > +static void elantech_set_rate_restore_reg_07(struct psmouse *psmouse,
> > > +		unsigned int rate)
> > > +{
> > > +	struct elantech_data *etd = psmouse->private;
> > > +
> > > +	etd->original_set_rate(psmouse, rate);
> > > +	if (elantech_write_reg(psmouse, 0x07, etd->reg_07))
> > > +		psmouse_err(psmouse, "restoring reg_07 failed\n");
> > 
> > I wonder if set rate is useful for Elantech and if it would not be
> > simpler to just have an empty stub for set_rate, maybe even for all
> > Elantech devices?
> 
> 1) all Elantech devices ?
> I've considered it for all elantech devices, but I've no idea how this
> might effect all elantech devices out there.
> I did a simple test on my work laptop with elantech. Setting the rate to
> a value lower than 10 does disable the mouse, setting it to a value higher
> than 10 enables it again. I would not describe that as 'useful' but
> not performing a set_rate 100 could give issues on touchpads that do work now.
> => I think best not all elantech devices because of backwards compatibility
> issues
> 
> 2) selectivity of Elantech device
> In this patch I used the firmware version, which will probably match with
> all (and no more than the ) elantech chips out there that have this issue.
> I could go for dmi table code, but then we will probably have to extend this 
> for a couple of years with more and more rows in the table.
> => preference for firmare version above dmi
> 
> 3) empty stub instead of set_rate+fixup
> Could work, but needs verification because currently set_rate is called with
> 100 and I don't know what the default is. Of course, ideally the sysfs would
> then report back that the rate reading/writing is not supported, or the
> rate sysfs file would not exist at all.
> => small preference for actually performing the set_rate

OK, fair enough, applied, thank you.

-- 
Dmitry
