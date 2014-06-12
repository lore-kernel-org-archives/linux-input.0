From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2 1/1] elantech: Add support for trackpoint found on
 some v3 models
Date: Thu, 12 Jun 2014 11:48:44 -0700
Message-ID: <20140612184844.GA25788@kroah.com>
References: <20140214205126.GB15526@lantern>
 <1402596901-28784-1-git-send-email-ulrik.debie-os@e2big.org>
 <1402596901-28784-2-git-send-email-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34524 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751748AbaFLSoy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Jun 2014 14:44:54 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EB56C20E1C
	for <linux-input@vger.kernel.org>; Thu, 12 Jun 2014 14:44:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1402596901-28784-2-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, stable@vger.kernel.org, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>

On Thu, Jun 12, 2014 at 08:15:01PM +0200, Ulrik De Bie wrote:
> Some elantech v3 touchpad equipped laptops also have a trackpoint, before
> this commit, these give sync errors. With this patch, the trackpoint is
> provided as another input device: 'Elantech PS/2 TrackPoint'
> 
> The patch will also output messages that do not follow the expected pattern.
> In the mean time I've seen 2 unknown packets occasionally:
> 0x04 , 0x00 , 0x00 , 0x00 , 0x00 , 0x00
> 0x00 , 0x00 , 0x00 , 0x02 , 0x00 , 0x00
> I don't know what those are for, but they can be safely ignored.
> 
> Currently all packets that are not known to v3 touchpad and where
> packet[3] (the fourth byte) lowest nibble is 6 are now recognized as
> PACKET_TRACKPOINT and processed by the new elantech_report_trackpoint.
> 
> This has been verified to work on a laptop Lenovo L530 where the
> touchpad/trackpoint combined identify themselves as:
> psmouse serio1: elantech: assuming hardware version 3 (with firmware version 0x350f02)
> psmouse serio1: elantech: Synaptics capabilities query result 0xb9, 0x15, 0x0c.
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
> ---
>  drivers/input/mouse/elantech.c | 104 +++++++++++++++++++++++++++++++++++++++--
>  drivers/input/mouse/elantech.h |   4 ++
>  2 files changed, 105 insertions(+), 3 deletions(-)

This seems like a new feature to me and not a stable kernel patch.  How
does this fit in with the Documentation/stable_kernel_rules.txt
requirements?

thanks,

greg k-h
