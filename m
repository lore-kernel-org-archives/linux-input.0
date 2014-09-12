From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] psmouse: Add support for detecting FocalTech PS/2
 touchpads
Date: Thu, 11 Sep 2014 23:14:29 -0700
Message-ID: <20140912061428.GA31165@core.coreip.homeip.net>
References: <1410425447-9575-1-git-send-email-hdegoede@redhat.com>
 <1410425447-9575-3-git-send-email-hdegoede@redhat.com>
 <20140911172619.GD13083@core.coreip.homeip.net>
 <5411DC61.2050003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:51718 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaILGOf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Sep 2014 02:14:35 -0400
Received: by mail-pa0-f43.google.com with SMTP id fa1so521938pad.30
        for <linux-input@vger.kernel.org>; Thu, 11 Sep 2014 23:14:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5411DC61.2050003@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org

On Thu, Sep 11, 2014 at 07:31:13PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 09/11/2014 07:26 PM, Dmitry Torokhov wrote:
> > Hi Hans,
> > 
> > On Thu, Sep 11, 2014 at 10:50:47AM +0200, Hans de Goede wrote:
> >> @@ -722,6 +723,13 @@ static int psmouse_extensions(struct psmouse *psmouse,
> >>  {
> >>  	bool synaptics_hardware = false;
> >>  
> >> +/* Always check for focaltech, this is safe as it uses pnp-id matching */
> >> +	if (psmouse_do_detect(focaltech_detect, psmouse, set_properties) == 0) {
> >> +		/* Not supported yet, use bare protocol */
> >> +		psmouse_max_proto = max_proto = PSMOUSE_PS2;
> >> +		goto reset_to_defaults;
> > 
> > Why do we need to jump to a new label instead of simply saying
> 
> Once we had figured out that psmouse.proto=bare at least made this
> touchpad work in mouse emulation mode, that is the first thing I did, but it
> is not enough. We also need to set psmouse_max_proto to short-circuit
> psmouse_initialize and do the reset.

I'd rather we did the reset in focal_init() then. We'll need it anyway
later.

-- 
Dmitry
