From: ulrik.debie-os@e2big.org
Subject: Re: [PATCH v2 1/1] elantech: Add support for trackpoint found on
 some v3 models
Date: Thu, 12 Jun 2014 21:03:45 +0200
Message-ID: <20140612190344.GA20952@lantern>
References: <20140214205126.GB15526@lantern>
 <1402596901-28784-1-git-send-email-ulrik.debie-os@e2big.org>
 <1402596901-28784-2-git-send-email-ulrik.debie-os@e2big.org>
 <20140612184844.GA25788@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140612184844.GA25788@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, stable@vger.kernel.org, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Greg,

Without this patch the elantech.c driver will still bind to the
touchpad, and then get out of sync each time the user touches
the trackpoint or the 3 mouse buttons associated with the trackpoint.

This out of sync will result in a few dmesg lines and a few lost
touchpad input events. The fact that the trackpoint + buttons itself
do not work at all is a minor annoyance compared to the sync loss
effect on the touchpad events.

This resulted in multiple bug reports with patches:
http://tojaj.com/fedora-20-howto-fix-elantech-trackpoint-on-lenovo-thinkpad-l430/
http://permalink.gmane.org/gmane.linux.kernel.input/27763
https://bugzilla.kernel.org/show_bug.cgi?id=48161

Hans suggested me to consider a cc:stable.

Thank you,
Greetings,
Ulrik


On Thu, Jun 12, 2014 at 11:48:44AM -0700, Greg KH wrote:
> On Thu, Jun 12, 2014 at 08:15:01PM +0200, Ulrik De Bie wrote:
> > Some elantech v3 touchpad equipped laptops also have a trackpoint, before
> > this commit, these give sync errors. With this patch, the trackpoint is
> > provided as another input device: 'Elantech PS/2 TrackPoint'
> > 
> > The patch will also output messages that do not follow the expected pattern.
> > In the mean time I've seen 2 unknown packets occasionally:
> > 0x04 , 0x00 , 0x00 , 0x00 , 0x00 , 0x00
> > 0x00 , 0x00 , 0x00 , 0x02 , 0x00 , 0x00
> > I don't know what those are for, but they can be safely ignored.
> > 
> > Currently all packets that are not known to v3 touchpad and where
> > packet[3] (the fourth byte) lowest nibble is 6 are now recognized as
> > PACKET_TRACKPOINT and processed by the new elantech_report_trackpoint.
> > 
> > This has been verified to work on a laptop Lenovo L530 where the
> > touchpad/trackpoint combined identify themselves as:
> > psmouse serio1: elantech: assuming hardware version 3 (with firmware version 0x350f02)
> > psmouse serio1: elantech: Synaptics capabilities query result 0xb9, 0x15, 0x0c.
> > 
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
> > ---
> >  drivers/input/mouse/elantech.c | 104 +++++++++++++++++++++++++++++++++++++++--
> >  drivers/input/mouse/elantech.h |   4 ++
> >  2 files changed, 105 insertions(+), 3 deletions(-)
> 
> This seems like a new feature to me and not a stable kernel patch.  How
> does this fit in with the Documentation/stable_kernel_rules.txt
> requirements?
> 
> thanks,
> 
> greg k-h
