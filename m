From: Stephen Chandler Paul <cpaul@redhat.com>
Subject: Re: [PATCH] i8042: Add debug_kbd option
Date: Thu, 25 Jun 2015 18:12:40 -0400
Message-ID: <1435270360.2972.16.camel@redhat.com>
References: <1435260310-10074-1-git-send-email-cpaul@redhat.com>
	 <20150625203238.GA27620@dtor-ws> <1435267885.2972.4.camel@redhat.com>
	 <20150625213511.GB27620@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56959 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbbFYWMm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Jun 2015 18:12:42 -0400
In-Reply-To: <20150625213511.GB27620@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On Thu, 2015-06-25 at 14:35 -0700, Dmitry Torokhov wrote:
> On Thu, Jun 25, 2015 at 05:31:25PM -0400, Stephen Chandler Paul 
> wrote:
> > On Thu, 2015-06-25 at 13:32 -0700, Dmitry Torokhov wrote:
> > > On Thu, Jun 25, 2015 at 03:25:10PM -0400, cpaul@redhat.com wrote:
> > > > From: Stephen Chandler Paul <cpaul@redhat.com>
> > > > 
> > > > A big problem with the current i8042 debugging option is that 
> > > > it 
> > > > outputs
> > > > data going to and from the keyboard by default. As a result, 
> > > > many 
> > > > dmesg
> > > > logs uploaded by users will unintentionally contain sensitive 
> > > > information
> > > > such as their password, as such it's probably a good idea not 
> > > > to 
> > > > output
> > > > data coming from the keyboard unless specifically enabled by 
> > > > the 
> > > > user.
> > > > 
> > > > Signed-off-by: Stephen Chandler Paul <cpaul@redhat.com>
> > > > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > > ---
> > > >  Documentation/kernel-parameters.txt |  7 +++++++
> > > >  drivers/input/serio/i8042.c         | 25 +++++++++++++++++++++
> > > > ----
> > > >  2 files changed, 28 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/Documentation/kernel-parameters.txt 
> > > > b/Documentation/kernel-parameters.txt
> > > > index ae44749..9e00234 100644
> > > > --- a/Documentation/kernel-parameters.txt
> > > > +++ b/Documentation/kernel-parameters.txt
> > > > @@ -1304,6 +1304,13 @@ bytes respectively. Such letter suffixes 
> > > > can 
> > > > also be entirely omitted.
> > > >  			     <bus_id>,<clkrate>
> > > >  
> > > >  	i8042.debug	[HW] Toggle i8042 debug mode
> > > > +	i8042.debug_kbd [HW] Enable printing of interrupt data 
> > > > 
> > > > from the KBD port
> > > > +			     As a side effect, this option 
> > > > will 
> > > > mask some of the
> > > > +			     interrupts sent back from the 
> > > > keyboard during the
> > > > +			     initialization of the KBD port on 
> > > > the 
> > > > i8042, if you
> > > > +			     need to see this, you will need 
> > > > to 
> > > > enable this
> > > > +			     option.
> > > 
> > > Hmm, can we maybe use the bus notifier and react to
> > > BUS_NOTIFY_BOUND_DRIVER/BUS_NOTIFY_UNBIND_DRIVER to decide if we 
> > > want 
> > > to
> > > see keyboard data stream?
> > Out of curiosity, are there devices that aren't keyboards that 
> > actually
> > make use of the KBD port? It was my understanding keyboards used 
> > the
> > KBD port, and everything else uses the AUX port.
> 
> On desktops if you plug keyboard into mouse port and mouse into 
> keyboard
> port there is a chance they will work (depends on the BIOS). But I 
> was
> not talking about supporting that  necessarily, but use bus notifiers 
> to
> allow seeing KBC port stream until the driver is fully bound and when 
> it
> is to be unbound from the KBC port (whatever driver that might be).
Alright, I'm following you now. This is definitely doable, we don't
need it for our use case (this is mostly just to stop people from
accidentally giving their passwords to us), but I'll be happy to add it
and get back to you with the new version of the patch when I'm
finished.

Cheers,
	Stephen Chandler Paul

> 
> Thanks.
> 
