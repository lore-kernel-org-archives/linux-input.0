From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] serio: Add pnp_id to struct serio
Date: Sun, 13 Apr 2014 01:22:46 -0700
Message-ID: <20140413082246.GC7267@core.coreip.homeip.net>
References: <1397052181-22768-1-git-send-email-hdegoede@redhat.com>
 <1397052181-22768-2-git-send-email-hdegoede@redhat.com>
 <20140409180652.GA3060@core.coreip.homeip.net>
 <53465049.1070305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47434 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaDMIWt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Apr 2014 04:22:49 -0400
Received: by mail-pa0-f46.google.com with SMTP id kx10so7113467pab.33
        for <linux-input@vger.kernel.org>; Sun, 13 Apr 2014 01:22:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53465049.1070305@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

On Thu, Apr 10, 2014 at 10:03:21AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 04/09/2014 08:06 PM, Dmitry Torokhov wrote:
> > Hi Hans,
> > 
> > On Wed, Apr 09, 2014 at 04:02:59PM +0200, Hans de Goede wrote:
> >> Serio device drivers need access to the pnp_id of the serio port, windows
> >> drivers bind by the pnp-id and some drivers need to know the exact pnp-id
> >> used so they know exactly with which hardware model / revision they are
> >> dealing with.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>  include/linux/serio.h | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/include/linux/serio.h b/include/linux/serio.h
> >> index 9f779c7..6532440 100644
> >> --- a/include/linux/serio.h
> >> +++ b/include/linux/serio.h
> >> @@ -16,6 +16,7 @@
> >>  #include <linux/mutex.h>
> >>  #include <linux/device.h>
> >>  #include <linux/mod_devicetable.h>
> >> +#include <linux/pnp.h>
> >>  #include <uapi/linux/serio.h>
> >>  
> >>  struct serio {
> >> @@ -28,6 +29,7 @@ struct serio {
> >>  	bool manual_bind;
> >>  
> >>  	struct serio_device_id id;
> >> +	struct pnp_id *pnp_id;
> > 
> > Why do we need this if we are already adding generic 'firmware_id'
> > attribute?
> 
> In patch 4/4 we do pnp-id matching in synaptics.c to set the new
> INPUT_PROP_TOPBUTTONPAD property on relevant touchpads. Since the kernel
> has a special pnp_id type + pnp_id matching code, the correct thing to
> do is to use that for in kernel pnp-id matching, which means that we
> need to propagate the pnp-id to the serio drivers.

I disagree that it is good enough reason for putting platform-specific
data in a generic structure. If you really want to use generic PNP
matching code you can just convert firmware_id back to pnp_id in
Synaptics driver.

Thanks.

-- 
Dmitry
