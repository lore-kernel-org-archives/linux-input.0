From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH v3 4/5] input: synaptics - make image sensors and cr48 sensors report widths
Date: Fri, 12 Jun 2015 20:39:58 +0200
Message-ID: <3450090.NTQkDvTZfO@xps13>
References: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com> <1427035436-2168-5-git-send-email-gabriele.mzt@gmail.com> <20150612004014.GC20581@dtor-pixel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:36448 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbFLSkC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Jun 2015 14:40:02 -0400
In-Reply-To: <20150612004014.GC20581@dtor-pixel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, grafi@grafi.jp, oneukum@suse.de

On Thursday 11 June 2015 17:40:14 Dmitry Torokhov wrote:
> HI Gabriele,
> 
> On Sun, Mar 22, 2015 at 03:43:55PM +0100, Gabriele Mazzotta wrote:
> > The driver was not reporting widths for image sensors and cr48 sensors
> > despite it was calculating them.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=77161
> > Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> > ---
> >  drivers/input/mouse/synaptics.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> > index ff47084..4e86ba6 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -927,6 +927,7 @@ static void synaptics_report_mt_data(struct psmouse *psmouse,
> >  		input_report_abs(dev, ABS_MT_POSITION_X, pos[i].x);
> >  		input_report_abs(dev, ABS_MT_POSITION_Y, pos[i].y);
> >  		input_report_abs(dev, ABS_MT_PRESSURE, hw[i]->z);
> > +		input_report_abs(dev, ABS_MT_TOUCH_MAJOR, hw[i]->w);
> 
> As I mentioned in the other email ABS_MT_TOUCH_MAJOR should use surface
> units for reporting.

Sorry, I didn't notice this difference between ABS_MT_TOUCH_MAJOR and
ABS_TOOL_WIDTH. This makes things a bit more complicated as I don't
see any obvious way to convert these values.

This means that also hid-rmi.c should do some sort of conversion since
Synaptics touchpads using it (such as the one of my laptop) use
ABS_MT_TOUCH_MAJOR to report abstract values that are between 0 and 15.

Gabriele

> >  	}
> >  
> >  	input_mt_drop_unused(dev);
> > @@ -1192,8 +1193,9 @@ static void set_input_params(struct psmouse *psmouse,
> >  	if (SYN_CAP_IMAGE_SENSOR(priv->ext_cap_0c)) {
> >  		set_abs_position_params(dev, priv, ABS_MT_POSITION_X,
> >  					ABS_MT_POSITION_Y);
> > -		/* Image sensors can report per-contact pressure */
> > +		/* Image sensors can report per-contact pressure and width */
> >  		input_set_abs_params(dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
> > +		input_set_abs_params(dev, ABS_MT_TOUCH_MAJOR, 4, 15, 0, 0);
> >  		input_mt_init_slots(dev, 2, INPUT_MT_POINTER | INPUT_MT_TRACK);
> >  		/* Image sensors can signal 4 and 5 finger clicks */
> >  		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
> > @@ -1202,6 +1204,7 @@ static void set_input_params(struct psmouse *psmouse,
> >  		set_abs_position_params(dev, priv, ABS_MT_POSITION_X,
> >  					ABS_MT_POSITION_Y);
> >  		input_set_abs_params(dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
> > +		input_set_abs_params(dev, ABS_MT_TOUCH_MAJOR, 4, 15, 0, 0);
> >  		/*
> >  		 * Profile sensor in CR-48 tracks contacts reasonably well,
> >  		 * other non-image sensors with AGM use semi-mt.
> 
> Thanks.
> 
> 

