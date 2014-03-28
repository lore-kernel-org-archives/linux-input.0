From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: synaptics-rmi4 - add capabilities for
 touchpads
Date: Fri, 28 Mar 2014 09:15:05 -0700
Message-ID: <20140328161505.GC22658@core.coreip.homeip.net>
References: <1395191031-3144-1-git-send-email-cheiny@synaptics.com>
 <5329A9CE.1080504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:37289 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaC1QPK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Mar 2014 12:15:10 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so5257603pab.27
        for <linux-input@vger.kernel.org>; Fri, 28 Mar 2014 09:15:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5329A9CE.1080504@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Christopher Heiny <cheiny@synaptics.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Wed, Mar 19, 2014 at 10:29:34AM -0400, Benjamin Tissoires wrote:
> Hi Chris,
> 
> On 03/18/2014 09:03 PM, Christopher Heiny wrote:
> >When the device is a touchpad additional capabilities need to
> >be set and reported.
> >
> 
> We have a problem here. While this patch would have been fine in the
> pre-v3.8 era, it is not true anymore.
> However, the current branch where synaptics-rmi4 is attached is v3.4.
> 
> So if you use the right API (the current one), it will not compile :(
> 
> Dmitry, would it be possible to update the branch to at least v3.8
> to get the new input-mt API? (if the Synaptics guys are ok).

If we are getting ready to pull it into mainline (and I think we are
for F01 and F11 support) then I think I should simply uprev to the
latest released kernel.

Thanks.

-- 
Dmitry
