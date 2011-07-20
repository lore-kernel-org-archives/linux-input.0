From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] kxtj9: fix input device allocation sequence
Date: Tue, 19 Jul 2011 23:15:57 -0700
Message-ID: <20110720061557.GA28816@core.coreip.homeip.net>
References: <1310568519-28103-1-git-send-email-chris.hudson.comp.eng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60831 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab1GTGQF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2011 02:16:05 -0400
Received: by iyb12 with SMTP id 12so4728111iyb.19
        for <linux-input@vger.kernel.org>; Tue, 19 Jul 2011 23:16:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310568519-28103-1-git-send-email-chris.hudson.comp.eng@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris.hudson.comp.eng@gmail.com
Cc: linux-input@vger.kernel.org, jic23@cam.ac.uk, Chris Hudson <chudson@kionix.com>

On Wed, Jul 13, 2011 at 10:48:39AM -0400, chris.hudson.comp.eng@gmail.com wrote:
> From: Chris Hudson <chudson@kionix.com>
> 
> Small bug fix patch against the driver version in Dmitry's queue.  Resulting
> driver tested on hardware in both polled and IRQ modes.
> 

Hmm, I tried applying the patch but the version I have in my public tree
(that was committed on July 6th) already has this fix...

Oh, you did mention the correct function (kxtj9_setup_input_device) in
your first e-mail, but then in this patch you are trying to change
kxtj9_setup_polled_device for some reason.

Anyway, I just got the patch addressing this issue from Dan Carpenter so
I will aplly it.

Thanks.

-- 
Dmitry
