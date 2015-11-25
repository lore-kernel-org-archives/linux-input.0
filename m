From: Todd E Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH] serio: delay resume error handling til PM complete
Date: Wed, 25 Nov 2015 09:25:59 -0800
Message-ID: <20151125172559.GA16799@linux.intel.com>
References: <cover.1448068686.git.todd.e.brandt@linux.intel.com>
 <d2cc800492b6d0f800d87d73a6be738e42b2023d.1448068686.git.todd.e.brandt@linux.intel.com>
 <CAKdAkRQk6xQTsY=fH7UNYbxiZeYh4rOZpL6wv6a1QzSy9i=Cpw@mail.gmail.com>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36156 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbbKYR0A (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2015 12:26:00 -0500
Content-Disposition: inline
In-Reply-To: <CAKdAkRQk6xQTsY=fH7UNYbxiZeYh4rOZpL6wv6a1QzSy9i=Cpw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, todd.e.brandt@intel.com

On Tue, Nov 24, 2015 at 05:26:15PM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 24, 2015 at 4:58 PM, Todd Brandt
> <todd.e.brandt@linux.intel.com> wrote:
> >  Delay the error rescan for serio devices until the PM
> >  complete phase. PM complete requires locking each device
> >  before checking for and executing the complete callbacks.
> >  Serio rescan also locks the device in order to reinit on
> >  error, so this can cause a conflict which will result in
> >  unnecessary delay.
> >
> >  History:
> >
> >  The issue was discovered on an ivy bridge platform with
> >  i8042 keyboard/mouse. The mouse resume fails
> 
> I'd first try to figure out why reconnect failed. What kind of
> mouse/touchpad is that?

It's an Alps PS/2 glidepoint touchpad. The actual error appears to be
a failure in alps_identify as it attempts to get the EC report using
alps_rpt_cmd. However, I don't think this is too important since
the psmouse driver is just doing what it's supposed to. It's the
fact that the error was mitigated right in the middle of the system
resume that caused the delay.

I expect that errors in input drivers will happen quite a lot. Users
don't typically care as long as the device eventually rights itself
and they don't notice. When I check the dmesg logs on new machines I
think are functional I almost always see some errors spit out. Thus
I think some preemptive action might be justified.

> 
> > and the serio
> >  driver begins a full driver rescan in the resume phase. Since
> >  the device is locked during re-initialization it conflicts
> >  with the PM subsystem's attempt to lock the device to check
> >  for a complete callback. Thus dpm_complete is delayed for
> >  almost a second.
> >
> >  I've tried to fix this by altering the PM subsystem code
> >  itself so that it doesn't have to lock a device in order to
> >  check if it has a callback, but this was too much for an
> >  isolated case. This approach attempts to fix the problem in
> >  the serio driver itself.
> 
> Hmm, there is nothing specific to serio here. Any slow-to-probe device
> might wedge the process like that.

I completely agree that serio isn't doing anything different. The issue
is with a relatively unknown quirk in the PM routines. They have to lock
the device for a check during each phase transition. Most drivers just
assume that once their resume cb is executed they're home free, but it's
not quite true.

I initially posted a patch which attempted to fix the problem at the PM 
level. My first thought was to get the PM subsystem to avoid attempting 
a lock on a device until it was sure a complete callback was actually 
registered.

Original thread on linux-pm: 
http://marc.info/?l=linux-pm&m=144503551918630&w=2

But, as Alan pointed out, it adds extra complexity to a heavily travelled 
execution path. Also, since the issue seems to be such a rare occurence 
and the current callback method is actually the safest (despite being 
potentially slower) it was suggested that I try to fix it lower down at 
the device layer.

Do you think this is too extreme a change for a single instance of an issue?

> 
> >
> >  The analyze_suspend timeline highlighting the underlying
> >  calls before and after the patch is applied is here:
> >
> >  http://01.org/suspendresume/blogs/tebrandt/2015/fixing-delay-when-errors-occur-serio-resume
> >
> > Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> > ---
> >  drivers/input/serio/serio.c | 40 ++++++++++++++++++++++++++++++++++------
> >  include/linux/serio.h       |  1 +
> >  2 files changed, 35 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> > index 8f82897..98def59 100644
> > --- a/drivers/input/serio/serio.c
> > +++ b/drivers/input/serio/serio.c
> > @@ -50,7 +50,7 @@ static DEFINE_MUTEX(serio_mutex);
> >  static LIST_HEAD(serio_list);
> >
> >  static void serio_add_port(struct serio *serio);
> > -static int serio_reconnect_port(struct serio *serio);
> > +static int serio_reconnect_port(struct serio *serio, bool in_resume);
> >  static void serio_disconnect_port(struct serio *serio);
> >  static void serio_reconnect_subtree(struct serio *serio);
> >  static void serio_attach_driver(struct serio_driver *drv);
> > @@ -148,6 +148,7 @@ static void serio_find_driver(struct serio *serio)
> >  enum serio_event_type {
> >         SERIO_RESCAN_PORT,
> >         SERIO_RECONNECT_PORT,
> > +       SERIO_RECONNECT_PORT_RESUME,
> >         SERIO_RECONNECT_SUBTREE,
> >         SERIO_REGISTER_PORT,
> >         SERIO_ATTACH_DRIVER,
> > @@ -227,7 +228,11 @@ static void serio_handle_event(struct work_struct *work)
> >                         break;
> >
> >                 case SERIO_RECONNECT_PORT:
> > -                       serio_reconnect_port(event->object);
> > +                       serio_reconnect_port(event->object, false);
> > +                       break;
> > +
> > +               case SERIO_RECONNECT_PORT_RESUME:
> > +                       serio_reconnect_port(event->object, true);
> >                         break;
> >
> >                 case SERIO_RESCAN_PORT:
> > @@ -599,11 +604,18 @@ static void serio_destroy_port(struct serio *serio)
> >   * there was no device to begin with) we do full rescan in
> >   * hope of finding a driver for the port.
> >   */
> > -static int serio_reconnect_port(struct serio *serio)
> > +static int serio_reconnect_port(struct serio *serio, bool in_resume)
> >  {
> >         int error = serio_reconnect_driver(serio);
> >
> > -       if (error) {
> > +       if (error && in_resume) {
> > +               /*
> > +                * Delay the rescan until the complete phase, since PM
> > +                * has to lock the device to check for a complete call.
> > +                * serio_find_driver locks the device for a long time.
> > +                */
> > +               serio->resume_error = true;
> > +       } else if (error) {
> >                 serio_disconnect_port(serio);
> >                 serio_find_driver(serio);
> >         }
> > @@ -621,7 +633,7 @@ static void serio_reconnect_subtree(struct serio *root)
> >         int error;
> >
> >         do {
> > -               error = serio_reconnect_port(s);
> > +               error = serio_reconnect_port(s, false);
> >                 if (!error) {
> >                         /*
> >                          * Reconnect was successful, move on to do the
> > @@ -958,14 +970,30 @@ static int serio_resume(struct device *dev)
> >          * Driver reconnect can take a while, so better let kseriod
> >          * deal with it.
> >          */
> > -       serio_queue_event(serio, NULL, SERIO_RECONNECT_PORT);
> > +       serio_queue_event(serio, NULL, SERIO_RECONNECT_PORT_RESUME);
> >
> >         return 0;
> >  }
> >
> > +static void serio_complete(struct device *dev)
> > +{
> > +       struct serio *serio = to_serio_port(dev);
> > +
> > +       if (!serio->resume_error)
> > +               return;
> > +
> > +       /*
> > +        * If an error happened in resume, issue the rescan in the
> > +        * complete phase so that it doesn't hold up the queue
> > +        */
> > +       serio->resume_error = false;
> > +       serio_queue_event(serio, NULL, SERIO_RESCAN_PORT);
> > +}
> > +
> >  static const struct dev_pm_ops serio_pm_ops = {
> >         .suspend        = serio_suspend,
> >         .resume         = serio_resume,
> > +       .complete       = serio_complete,
> >         .poweroff       = serio_suspend,
> >         .restore        = serio_resume,
> >  };
> > diff --git a/include/linux/serio.h b/include/linux/serio.h
> > index df4ab5d..df8a8eaf 100644
> > --- a/include/linux/serio.h
> > +++ b/include/linux/serio.h
> > @@ -50,6 +50,7 @@ struct serio {
> >         struct device dev;
> >
> >         struct list_head node;
> > +       bool resume_error:1;  /* an error occurred in resume */
> >  };
> >  #define to_serio_port(d)       container_of(d, struct serio, dev)
> >
> > --
> > 2.1.4
> >
> 
> 
> 
> -- 
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
