From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: add missing hid usages
Date: Tue, 22 Apr 2014 17:04:57 -0700
Message-ID: <20140423000457.GA22183@core.coreip.homeip.net>
References: <1396623746-1416-1-git-send-email-ogay@logitech.com>
 <alpine.LNX.2.00.1404070949020.8157@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:38131 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbaDWAFB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 20:05:01 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so151542pab.41
        for <linux-input@vger.kernel.org>; Tue, 22 Apr 2014 17:05:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1404070949020.8157@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Olivier Gay <ogay@logitech.com>, linux-input@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, Mathieu Meisser <mmeisser@logitech.com>

On Mon, Apr 07, 2014 at 09:49:52AM +0200, Jiri Kosina wrote:
> 
> [ adding Dmitry to CC ]
> 
> On Fri, 4 Apr 2014, Olivier Gay wrote:
> 
> >  
> >  #define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
> >  
> > +#define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
> > +#define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
> > +#define KEY_JOURNAL		0x242	/* AL Log/Journal/Timecard */
> > +#define KEY_CONTROLPANEL		0x243	/* AL Control Panel */
> > +#define KEY_APPSELECT		0x244	/* AL Select Task/Application */
> > +#define KEY_SCREENSAVER		0x245	/* AL Screen Saver */
> > +#define KEY_VOICECOMMAND		0x246	/* Listening Voice Command */
> > +
> > +#define KEY_BRIGHTNESS_INC		KEY_BRIGHTNESSUP
> > +#define KEY_BRIGHTNESS_DEC		KEY_BRIGHTNESSDOWN
> > +#define KEY_BRIGHTNESS		0x250	/* Display Brightness */

What is it supposed to do exactly? Show OSD for brightness?

> > +#define KEY_BRIGHTNESS_TOGGLE		0x251	/* Backlight Toggle */

We already have KEY_DISPLAYTOGGLE, isn't this the same?

Thanks.

-- 
Dmitry
