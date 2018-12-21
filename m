From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elantech - Disable elan-i2c for P52 and P72
Date: Fri, 21 Dec 2018 00:43:28 -0800
Message-ID: <20181221084328.GH211587@dtor-ws>
References: <20181212154205.24025-1-benjamin.tissoires@redhat.com>
 <20181218081343.GA4701@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218081343.GA4701@jelly>
Sender: stable-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, kt.liao@emc.com.tw, Aaron Ma <aaron.ma@canonical.com>, Kai Heng Feng <kai.heng.feng@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Dec 18, 2018 at 06:13:43PM +1000, Peter Hutterer wrote:
> On Wed, Dec 12, 2018 at 04:42:05PM +0100, Benjamin Tissoires wrote:
> > The current implementation of elan_i2c is known to not support those
> > 2 laptops.
> > 
> > A proper fix is to tweak both elantech and elan_i2c to transmit the
> > correct information from PS/2, which would make a bad candidate for
> > stable.
> > 
> > So to give us some time for fixing the root of the problem, disable
> > elan_i2c for the devices we know are not behaving properly.
> > 
> > Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1803600
> > Link: https://bugs.archlinux.org/task/59714
> > Fixes: df077237cf55 Input: elantech - detect new ICs and setup Host Notify for them
> > 
> > Cc: stable@vger.kernel.org  # v4.18+
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Applied, thank you.

> 
> Cheers,
>    Peter
> 
> > ---
> >  drivers/input/mouse/elantech.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> > index 2d95e8d93cc7..830ae9f07045 100644
> > --- a/drivers/input/mouse/elantech.c
> > +++ b/drivers/input/mouse/elantech.c
> > @@ -1767,6 +1767,18 @@ static int elantech_smbus = IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_SMBUS) ?
> >  module_param_named(elantech_smbus, elantech_smbus, int, 0644);
> >  MODULE_PARM_DESC(elantech_smbus, "Use a secondary bus for the Elantech device.");
> >  
> > +static const char * const i2c_blacklist_pnp_ids[] = {
> > +	/*
> > +	 * these are known to not be working properly as bits are missing
> > +	 * in elan_i2c
> > +	 */
> > +	"LEN2131", /* ThinkPad P52 w/ NFC */
> > +	"LEN2132", /* ThinkPad P52 */
> > +	"LEN2133", /* ThinkPad P72 w/ NFC */
> > +	"LEN2134", /* ThinkPad P72 */
> > +	NULL
> > +};
> > +
> >  static int elantech_create_smbus(struct psmouse *psmouse,
> >  				 struct elantech_device_info *info,
> >  				 bool leave_breadcrumbs)
> > @@ -1802,10 +1814,12 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
> >  
> >  	if (elantech_smbus == ELANTECH_SMBUS_NOT_SET) {
> >  		/*
> > -		 * New ICs are enabled by default.
> > +		 * New ICs are enabled by default, unless mentioned in
> > +		 * i2c_blacklist_pnp_ids.
> >  		 * Old ICs are up to the user to decide.
> >  		 */
> > -		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
> > +		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
> > +		    psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
> >  			return -ENXIO;
> >  	}
> >  
> > -- 
> > 2.19.2
> > 

-- 
Dmitry
