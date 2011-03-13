From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] hid-ntrig: sysfs nodes for modes
Date: Sat, 12 Mar 2011 22:27:00 -0800
Message-ID: <20110313062700.GC31566@core.coreip.homeip.net>
References: <1299829072-19489-1-git-send-email-rafi@seas.upenn.edu>
 <20110311081843.GE10807@core.coreip.homeip.net>
 <4D79F1DD.10009@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50410 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab1CMG1H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Mar 2011 01:27:07 -0500
Content-Disposition: inline
In-Reply-To: <4D79F1DD.10009@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, micki@n-trig.com, rydberg@euromail.se, chatty@enac.fr

On Fri, Mar 11, 2011 at 04:56:45AM -0500, Rafi Rubin wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> User desires aren't exactly my specialty.  I just know the ntrig windows control
> panel gives the user that control with cute little radio buttons.
> 
> Would it be cleaner to expose the control with an ioctrl or some other mechanism?
> 
> I do have user space tools for mode and calibration, but that requires unbinding
> the device, and just seems sloppier.  But if this really is inappropriate to add
> the sysfs nodes, at least there's still some solution.

No, this is not inappropriate, I was just musing how useful they are. Do
we foresee users really using them or if is it more "we export because we can".
I.e. in which cases the default mode is not suitable?

> 
> Since you brought it up, I am thinking of removing some of the other nodes soon.
>  I've learned the physical and logical ranges are already exposed both through
> the event nodes and debugfs.  Also, I have better filtering that so far seems
> not to need as many parameters so I should be able to remove those nodes as well.
>

Well, that's the issue with sysfs - it really forms kernel ABI so
removing something that was once added is hard.

Thanks.

-- 
Dmitry
