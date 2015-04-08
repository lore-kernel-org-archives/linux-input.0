From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] alps: Non interleaved V2 dualpoint has separate stick
 button bits
Date: Wed, 8 Apr 2015 10:38:15 -0700
Message-ID: <20150408173815.GB14186@dtor-ws>
References: <1428509092-25794-1-git-send-email-hdegoede@redhat.com>
 <20150408162430.GA10344@dtor-ws>
 <55255FCD.30407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33686 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbbDHRiU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Apr 2015 13:38:20 -0400
Received: by ignm3 with SMTP id m3so33772945ign.0
        for <linux-input@vger.kernel.org>; Wed, 08 Apr 2015 10:38:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55255FCD.30407@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Hans de Bruin <jmdebruin@xmsnet.nl>, linux-input@vger.kernel.org

On Wed, Apr 08, 2015 at 07:05:17PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 08-04-15 18:24, Dmitry Torokhov wrote:
> >On Wed, Apr 08, 2015 at 06:04:52PM +0200, Hans de Goede wrote:
> >>Non interleaved V2 dualpoint touchpad / stick combos have separate stick
> >>button bits in the touchpad packets, if we do not check these then the
> >>trackpoint buttons will not work when using the touchpad, and when pressed
> >>when the user starts using the touchpad will report a release event even
> >>though the button is still pressed.
> >>
> >>This commit fixes this by checking the separate bits, note that we simply
> >>combine the buttons, since the hardware does the same when using the touchpad
> >>buttons with the trackpoint, so we do not have enough information to properly
> >>separate them.
> >
> >Hmm, if they are designated as trackstick buttons why don't we report
> >them as such (i.e. send button events out of dev2 without movement)?
> 
> Because we may then end up with having a button pressed on both
> the touchpad and trackstick evdev nodes, and if we then switch to
> getting trackstick packets, which have one combined bit for both, and
> the bit becomes 0 we end up releasing only one, which is what the commit
> message tries to say with: "we do not have enough information to properly
> separate them", I actually had an earlier version which did as you suggested,
> but that become ugly pretty quickly.

Oh, right... Do we get touchpad packets if both trackpoint and touchpad
buttons are pressed and trackpoint is moved (bit no contacts on the pad)?

Anyway, I guess it is older hardware and just mixing buttons is fine, no
need to be super-fancy.

> 
> >Also, should we make note of this in alps.txt?
> 
> Ack, I'll do a v2 when we've agreement on your first point (and I've
> some time).
> 
> Regards,
> 
> Hans
> 
> 
> 
> >
> >Thanks!
> >
> >>
> >>Reported-by: Hans de Bruin <jmdebruin@xmsnet.nl>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >>  drivers/input/mouse/alps.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >>diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> >>index 6962c26..58987b5 100644
> >>--- a/drivers/input/mouse/alps.c
> >>+++ b/drivers/input/mouse/alps.c
> >>@@ -243,6 +243,14 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
> >>  		return;
> >>  	}
> >>
> >>+	/* Non interleaved V2 dualpoint has separate stick button bits */
> >>+	if (priv->proto_version == ALPS_PROTO_V2 &&
> >>+	    priv->flags == (ALPS_PASS | ALPS_DUALPOINT)) {
> >>+		left |= packet[0] & 1;
> >>+		right |= packet[0] & 2;
> >>+		middle |= packet[0] & 4;
> >>+	}
> >>+
> >>  	alps_report_buttons(dev, dev2, left, right, middle);
> >>
> >>  	/* Convert hardware tap to a reasonable Z value */
> >>--
> >>2.3.4
> >>
> >

-- 
Dmitry
