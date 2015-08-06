From: ulrik.debie-os@e2big.org
Subject: Re: [PATCH 3/3] Input - elantech: Add special check for fw_version
 0x470f01 touchpad
Date: Thu, 6 Aug 2015 20:35:59 +0200
Message-ID: <20150806183558.GA5245@lantern>
References: <B219E7FC-4779-4793-AC4F-7D218FAC9F3C@emc.com.tw>
 <20150805180818.GD3603@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150805180818.GD3603@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: duson <dusonlin@emc.com.tw>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry, Duson,

On Wed, Aug 05, 2015 at 11:08:18AM -0700, Dmitry Torokhov wrote:
> Hi Ulrik,
> 
> On Sun, Aug 02, 2015 at 12:16:41PM +0800, duson wrote:
> > It is no need to check the packet[0] for sanity check when doing
> > elantech_packet_check_v4() function for fw_version = 0x470f01 touchpad.
> >
> 
> Are you OK with this version?

Yes, I'm OK with this version (and also with the change you suggested below).

Reviewed-by: Ulrik De Bie <ulrik.debie-os@e2big.org>

Thanks
Ulrik
> 
> Thanks!
> 
> > Signed-off by: Duson Lin <dusonlin@emc.com.tw>
> > ---
> >  drivers/input/mouse/elantech.c |   28 +++++++++++++++++++++++++---
> >  drivers/input/mouse/elantech.h |    1 +
> >  2 files changed, 26 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> > index 22b9ca9..5bc3d55 100644
> > --- a/drivers/input/mouse/elantech.c
> > +++ b/drivers/input/mouse/elantech.c
> > @@ -785,6 +785,9 @@ static int elantech_packet_check_v4(struct psmouse *psmouse)
> >  	unsigned char packet_type = packet[3] & 0x03;
> >  	bool sanity_check;
> > 
> > +	/* This represents the version of IC body. */
> > +	int ver = (etd->fw_version & 0x0f0000) >> 16;
> > +
> >  	if (etd->tp_dev && (packet[3] & 0x0f) == 0x06)
> >  		return PACKET_TRACKPOINT;
> > 
> > @@ -796,9 +799,17 @@ static int elantech_packet_check_v4(struct psmouse *psmouse)
> >  	 */
> >  	if (etd->crc_enabled)
> >  		sanity_check = ((packet[3] & 0x08) == 0x00);
> > -	else
> > -		sanity_check = ((packet[0] & 0x0c) == 0x04 &&
> > -				(packet[3] & 0x1c) == 0x10);
> > +	else {
> > +		/*
> > +		 * The sanity check only need to check packet[3]
> > +		 * when IC_body = 7 and PID = 0x2A
> > +		 */
> > +		if (ver == 7 && etd->samples[1] == 0x2A)
> > +			sanity_check = ((packet[3] & 0x1c) == 0x10);
> > +		else
> > +			sanity_check = ((packet[0] & 0x0c) == 0x04 &&
> > +					(packet[3] & 0x1c) == 0x10);
> > +	}
> 
> I'd write this as:
> 
> 	if (etd->crc_enabled)
> 		sanity_check = ((packet[3] & 0x08) == 0x00);
> 	else if (ver == 7 && etd->samples[1] == 0x2A)
> 		sanity_check = ((packet[3] & 0x1c) == 0x10);
> 	else
> 		sanity_check = ((packet[0] & 0x0c) == 0x04 &&
> 				(packet[3] & 0x1c) == 0x10);
> 
> > 
> >  	if (!sanity_check)
> >  		return PACKET_UNKNOWN;
> > @@ -1116,6 +1127,7 @@ static int elantech_get_resolution_v4(struct psmouse *psmouse,
> >   * Avatar AVIU-145A2       0x361f00        ?               clickpad
> >   * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw buttons
> >   * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw buttons
> > + * Fujitsu T725	           0x470f01        05, 12, 09      2 hw buttons
> >   * Fujitsu H730            0x570f00        c0, 14, 0c      3 hw buttons (**)
> >   * Gigabyte U2442          0x450f01        58, 17, 0c      2 hw buttons
> >   * Lenovo L430             0x350f02        b9, 15, 0c      2 hw buttons (*)
> > @@ -1651,6 +1663,16 @@ int elantech_init(struct psmouse *psmouse)
> >  		     etd->capabilities[0], etd->capabilities[1],
> >  		     etd->capabilities[2]);
> > 
> > +	if (etd->hw_version != 1) {
> > +		if (etd->send_cmd(psmouse, ETP_SAMPLE_QUERY, etd->samples)) {
> > +			psmouse_err(psmouse, "failed to query sample data\n");
> > +			goto init_fail;
> > +		}
> > +		psmouse_info(psmouse,
> > +			    "Elan sample query result %02x, %02x, %02x\n",
> > +			    etd->samples[0], etd->samples[1], etd->samples[2]);
> > +	}
> > +
> >  	if (elantech_set_absolute_mode(psmouse)) {
> >  		psmouse_err(psmouse,
> >  			    "failed to put touchpad into absolute mode.\n");
> > diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
> > index f965d15..e1cbf40 100644
> > --- a/drivers/input/mouse/elantech.h
> > +++ b/drivers/input/mouse/elantech.h
> > @@ -129,6 +129,7 @@ struct elantech_data {
> >  	unsigned char reg_26;
> >  	unsigned char debug;
> >  	unsigned char capabilities[3];
> > +	unsigned char samples[3];
> >  	bool paritycheck;
> >  	bool jumpy_cursor;
> >  	bool reports_pressure;
> > --
> > 
> 
> Thanks.
> 
> -- 
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
