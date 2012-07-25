From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH v4] Input: synaptics - handle out of bounds values from
 the hardware
Date: Wed, 25 Jul 2012 08:47:18 -0500
Message-ID: <20120725134718.GA5687@thinkpad-t410>
References: <CAGS+omDkgJA_wvdsGtowjpq5AJF8q2+oVefbsozTS19kxdNJGg@mail.gmail.com>
 <1343158279-25308-1-git-send-email-seth.forshee@canonical.com>
 <CAGS+omAJD9CH-1fbiWae6SDiXMaz+b09TG9wusNmD5Q_SGBLFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58066 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932917Ab2GYNrV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 09:47:21 -0400
Content-Disposition: inline
In-Reply-To: <CAGS+omAJD9CH-1fbiWae6SDiXMaz+b09TG9wusNmD5Q_SGBLFg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, Jul 25, 2012 at 10:50:15AM +0800, Daniel Kurtz wrote:
> > +       /* Convert wrap-around values to negative */
> > +       if (hw->x > X_MAX_POSITIVE)
> > +               hw->x = hw->x - (1 << ABS_POS_BITS);
> 
> Hi Seth,
> 
> Perhaps:
> hw->x -= (1 << ABS_POS_BITS);

It makes no difference to me, either way it works the same. I don't
think I'll send another patch just to change this though, unless Dmitry
asks for it :)

> Either way, it looks good, thanks!
> 
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

Thanks!

Seth
