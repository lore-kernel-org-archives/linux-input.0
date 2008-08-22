From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Usage of new KEY_NUMERIC_* codes in an existing driver
	(yealink)
Date: Fri, 22 Aug 2008 16:02:34 -0400
Message-ID: <20080822155829.ZZRA012@mailhub.coreip.homeip.net>
References: <1219424488.6684.20.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:20639 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756611AbYHVUCk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Aug 2008 16:02:40 -0400
Received: by wr-out-0506.google.com with SMTP id 69so537521wri.5
        for <linux-input@vger.kernel.org>; Fri, 22 Aug 2008 13:02:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1219424488.6684.20.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Reitmayr <treitmayr@devbase.at>
Cc: Linux-Input <linux-input@vger.kernel.org>

Hi Thomas,

On Fri, Aug 22, 2008 at 07:01:28PM +0200, Thomas Reitmayr wrote:
> Hi,
> I am in the process of extending the existing yealink driver, partly to
> support various other models. The existing driver as included in the
> current kernel uses the shift key to report the keys "*" and "#", but I
> am hesitating to do the same bad "trick" for the other models.
> 
> As I would like to eventually submit the extended driver upstream, what
> is the recommended strategy in my situation regarding usage of the new
> KEY_NUMERIC_* codes? Use them only for the new models (which would
> result in an ugly mix), or also update the codes for the existing
> USB-P1K model (which would break userspace programs but finally fix
> things for some foreign keyboard layouts), 

Do you think that we need to add more keymaps to the kernel? What I
woudl like to see is adding setkeycode/getkeycode support to yealink
so proper keymap can be loaded from userspace (udev, hal, whatever)
when a device is plugged into a box. USB-P1K coudl also get the new
keymap loaded from userspace while keeping the current legacy keymap
for existing users.

>or for the existing USB-P1K
> model report the old and the new codes (which might look like two key
> presses)?

No, that is not a good idea.

> Thanks for your advice,
> -Thomas
> 
> PS: The updated driver is available at
> http://www.devbase.at/svn/view.cgi/yealink-module/trunk/?root=voip
> (still including #if's reg. kernel versions, some comments to be
> corrected, etc.)
> 

Would you mind posting it as a patch - it is much easier to comment on
it in e-mail... Thanks!

-- 
Dmitry
