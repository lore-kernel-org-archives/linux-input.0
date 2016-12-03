From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elantech - Add a special mode for a specific FW
 The touchapd which sample ver is 0x74 and hw_version is 0x03 have a fw bug
 which will cause crush sometimes, I add some work-around for it and our
 customer ask us to upstream the patch Signed-off-by: KT Liao
 <kt.liao@emc.com.tw>
Date: Sat, 3 Dec 2016 10:47:34 -0800
Message-ID: <20161203184734.GE38119@dtor-ws>
References: <1480658357-18320-1-git-send-email-kt.liao@emc.com.tw>
 <20161202220529.jkdzy3trss2syb7x@lantern>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35143 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbcLCSrh (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 3 Dec 2016 13:47:37 -0500
Content-Disposition: inline
In-Reply-To: <20161202220529.jkdzy3trss2syb7x@lantern>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ulrik.debie-os@e2big.org
Cc: KT Liao <kt.liao@emc.com.tw>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw

On Fri, Dec 02, 2016 at 11:05:29PM +0100, ulrik.debie-os@e2big.org wrote:
> Hi,
> 
> Thank you for the patch, see below my feedback on your patch.
> Can you provide the contents of fw_verison, capabilities and samples ?
> 
> It this fw bug present on multiple laptops ?
> 
>  
> 
> On Fri, Dec 02, 2016 at 01:59:17PM +0800, KT Liao wrote:
> > Date:   Fri,  2 Dec 2016 13:59:17 +0800
> > From: KT Liao <kt.liao@emc.com.tw>
> > To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
> >  dmitry.torokhov@gmail.com
> > Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw
> > Subject: [PATCH] Input: elantech - Add a special mode for a specific FW The
> >  touchapd which sample ver is 0x74 and hw_version is 0x03 have a fw bug
> >  which will cause crush sometimes, I add some work-around for it and our
> >  customer ask us to upstream the patch Signed-off-by: KT Liao
> >  <kt.liao@emc.com.tw>
> 
> It seems that the newlines got lost when you used git-send-email. The 
> subject should be a oneliner, the remaining part should go to the mail body.

I think KT forgets to add an empty line between patch subject and body
when committing to their tree.

> 
> > X-Mailer: git-send-email 2.7.4
> > X-Mailing-List: linux-input@vger.kernel.org
> > 
> > ---
> >  drivers/input/mouse/elantech.c | 152 +++++++++++++++++++++++++++++++++++------
> >  1 file changed, 131 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> > index db7d1d6..acfe7f2 100644
> > --- a/drivers/input/mouse/elantech.c
> > +++ b/drivers/input/mouse/elantech.c
> > @@ -539,6 +539,30 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
> >  	input_sync(dev);
> >  }
> >  
> > +static psmouse_ret_t elantech_report_relative_v3(struct psmouse *psmouse)
> > +{
> > +	struct input_dev *dev = psmouse->dev;
> > +	unsigned char *packet = psmouse->packet;
> > +	int rel_x = 0, rel_y = 0;
> > +
> > +	if (psmouse->pktcnt < psmouse->pktsize)
> > +		return PSMOUSE_GOOD_DATA;
> 
> This is a duplicate of elantech_process_byte and you skipped the
> elantech_packet_dump feature of elantech_process_byte. I think it would be
> better to let elantech_process_byte call this elantech_report_relative_v3
> just like all the other reportings.
> Is it required to also disable the elantech_packet_check_v3 ? 
> 
> Can you document the typical packet format for 
> elantech_report_relative_v3 ? Something similar to elantech_report_trackpoint ?
> 
> 
> > +
> > +	input_report_rel(dev, REL_WHEEL, -(signed char)packet[3]);
> > +
> > +	rel_x = (int) packet[1] - (int) ((packet[0] << 4) & 0x100);
> > +	rel_y = (int) ((packet[0] << 3) & 0x100) - (int) packet[2];
> > +
> > +	input_report_key(dev, BTN_LEFT,    packet[0]       & 1);
> > +	input_report_key(dev, BTN_RIGHT,  (packet[0] >> 1) & 1);
> > +	input_report_rel(dev, REL_X, rel_x);
> > +	input_report_rel(dev, REL_Y, rel_y);
> > +
> > +	input_sync(dev);
> > +
> > +	return PSMOUSE_FULL_PACKET;
> > +}
> > +
> >  static void elantech_input_sync_v4(struct psmouse *psmouse)
> >  {
> >  	struct input_dev *dev = psmouse->dev;
> > @@ -696,14 +720,14 @@ static int elantech_packet_check_v1(struct psmouse *psmouse)
> >  
> >  static int elantech_debounce_check_v2(struct psmouse *psmouse)
> >  {
> > -        /*
> > -         * When we encounter packet that matches this exactly, it means the
> > -         * hardware is in debounce status. Just ignore the whole packet.
> > -         */
> > -        const u8 debounce_packet[] = { 0x84, 0xff, 0xff, 0x02, 0xff, 0xff };
> > -        unsigned char *packet = psmouse->packet;
> > -
> > -        return !memcmp(packet, debounce_packet, sizeof(debounce_packet));
> > +	/*
> > +	 * When we encounter packet that matches this exactly, it means the
> > +	 * hardware is in debounce status. Just ignore the whole packet.
> > +	 */
> > +	const u8 debounce_packet[] = { 0x84, 0xff, 0xff, 0x02, 0xff, 0xff };
> > +	unsigned char *packet = psmouse->packet;
> > +
> > +	return !memcmp(packet, debounce_packet, sizeof(debounce_packet));
> >  }
> 
> Confirmed, the lines of elantech_debounce_check_v2 do not start with tab 
> but spaces, but preferably this will be part of a separate commit.

Yes please.

> 
> >  
> >  static int elantech_packet_check_v2(struct psmouse *psmouse)
> > @@ -995,6 +1019,29 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
> >  	return rc;
> >  }
> >  
> > +/* it's the work around mode for some touchpad which has FW bug, but dont' support IAP funciton */
> 
> This line is too long, split it across multiple lines.
> 
> > +static int elantech_set_special_mode(struct psmouse *psmouse)
> > +{
> > +	unsigned char param[3];
> > +	int rc = 0;
> 
> Knowing Dmitry, he would prefer to have error as name instead of rc.
> 
> > +
> > +	param[0] = 0xc8;
> > +	param[1] = 0x64;
> > +	param[2] = 0x50;
> > +
> > +	if (elantech_ps2_command(psmouse, &param[0], PSMOUSE_CMD_SETRATE) ||
> > +	   elantech_ps2_command(psmouse, &param[1], PSMOUSE_CMD_SETRATE) ||
> > +	   elantech_ps2_command(psmouse, &param[2], PSMOUSE_CMD_SETRATE) ||
> > +	   elantech_ps2_command(psmouse, param, PSMOUSE_CMD_GETID)) {
> > +		rc = -1;
> > +	}
> 
> Hm, these do look very similar to intellimouse_detect. Is that a coincidence ?
> 
> > +
> > +	psmouse->set_rate(psmouse, 0x64);
> > +	psmouse->set_resolution(psmouse, 200);
> 
> Why hardcode set_rate and set_resolution when they are already module
> parameters with the defaults exactly the ones selected here.

This "special" mode is simply the basic PS/2 mode, right? And the issue
is that this firmware version does not really support absolute mode, at
least not in the form that current driver supports?

If it is really basic PS/2 mode you can simply return "false" from
elantech_init() and we'll reset the mouse and try the basic protocols in
psmouse-base.

Thanks.

-- 
Dmitry
