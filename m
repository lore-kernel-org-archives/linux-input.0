From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/3] psmouse: Add support for detecting FocalTech PS/2
 touchpads
Date: Mon, 15 Sep 2014 10:39:57 -0700
Message-ID: <20140915173957.GA14457@core.coreip.homeip.net>
References: <1410512912-11609-1-git-send-email-hdegoede@redhat.com>
 <1410512912-11609-4-git-send-email-hdegoede@redhat.com>
 <20140913002629.GA12622@core.coreip.homeip.net>
 <5413FBEF.3020101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:57911 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078AbaIORkD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Sep 2014 13:40:03 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so6853938pad.9
        for <linux-input@vger.kernel.org>; Mon, 15 Sep 2014 10:40:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5413FBEF.3020101@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org

On Sat, Sep 13, 2014 at 10:10:23AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 09/13/2014 02:26 AM, Dmitry Torokhov wrote:
> > Hi Hans,
> > 
> > On Fri, Sep 12, 2014 at 11:08:32AM +0200, Hans de Goede wrote:
> >> +/* Always check for focaltech, this is safe as it uses pnp-id matching */
> >> +	if (psmouse_do_detect(focaltech_detect, psmouse, set_properties) == 0) {
> >> +		if (!set_properties || focaltech_init(psmouse) == 0) {
> >> +			/* Not supported yet, use bare protocol */
> >> +			psmouse_max_proto = PSMOUSE_PS2;
> > 
> > I do not believe we need to muck with psmouse_max_proto here, so I'll
> > drop it and apply.
> 
> Oh, but we do need to set psmouse_max_proto, otherwise this won't work, as
> I already tried to explain in the review of v1 (but clearly failed to do so).
> 
> psmouse_initialize() checks psmouse_max_proto, and if it is not set to
> PSMOUSE_PS2 does things which upsets these touchpads.

Ouch.. so even basic set rate/set resolution messes it up? Wow...

Thanks.

-- 
Dmitry
