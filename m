From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] Input: synaptics-rmi4 - Report slot as inactive when
 contact is a palm
Date: Fri, 17 Mar 2017 10:58:05 +1000
Message-ID: <20170317005805.GA8522@jelly>
References: <1489708591-4320-1-git-send-email-aduggan@synaptics.com>
 <20170317000450.GE2935@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317000450.GE2935@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Cameron Gutman <aicommander@gmail.com>, Thorsten Leemhuis <linux@leemhuis.info>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 16, 2017 at 05:04:50PM -0700, Dmitry Torokhov wrote:
> On Thu, Mar 16, 2017 at 04:56:31PM -0700, Andrew Duggan wrote:
> > When the firmware identifies a contact as a palm the driver sets the tool
> > type to MT_TOOL_PALM, but sets the slot state as active. Reporting the
> > palm as active results in userspace input libraries considering the palm
> > as a valid contact. Touchpads which previously were using hid-multitouch
> > are now not suppressing palms when switching to the RMI4 driver. This
> > change fixes palm rejection when using the RMI4 driver.
> > 
> > Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> > Tested-by: Cameron Gutman <aicommander@gmail.com>
> > ---
> >  drivers/input/rmi4/rmi_2d_sensor.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
> > index 8bb866c..8d1f295 100644
> > --- a/drivers/input/rmi4/rmi_2d_sensor.c
> > +++ b/drivers/input/rmi4/rmi_2d_sensor.c
> > @@ -80,7 +80,8 @@ void rmi_2d_sensor_abs_report(struct rmi_2d_sensor *sensor,
> >  		input_mt_slot(input, slot);
> >  
> >  	input_mt_report_slot_state(input, obj->mt_tool,
> > -				   obj->type != RMI_2D_OBJECT_NONE);
> > +				   (obj->type != RMI_2D_OBJECT_NONE)
> > +				   && (obj->type != RMI_2D_OBJECT_PALM));
> >  
> >  	if (obj->type != RMI_2D_OBJECT_NONE) {
> >  		obj->x = sensor->tracking_pos[slot].x;
> 
> If we are relying on hardware to do palm rejection, then we should not
> be reporting the rest of the events for palm either (i.e. the condition
> in the if statement above should also be updated).
> 
> But I do not understand why userspace doe snot do the right thing? Yes,
> the slot is active, but reported contact type is MT_TOOL_PALM, so it
> knows what it deals with.

oops, filed: https://bugs.freedesktop.org/show_bug.cgi?id=100243
until RMI4 we had no drivers setting that tool type and we still don't have
rull RMI4 in the released kernels, so it was a simple oversight.

mind you, that only applies for libinput, not hedging my bets on the
synaptics driver here.

Cheers,
   Peter
