From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-multitouch: change for touch height/width
Date: Mon, 6 Mar 2017 14:48:59 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703061448270.31814@cbobk.fhfr.pm>
References: <1488771014-22856-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39857 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754009AbdCFPPk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Mar 2017 10:15:40 -0500
In-Reply-To: <1488771014-22856-1-git-send-email-hn.chen@weidahitech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: HungNien Chen <hn.chen@weidahitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, jonathan.a.clarke@gmail.com, benjamin.tissoires@redhat.com

On Mon, 6 Mar 2017, hn.chen@weidahitech.com wrote:

> From: HungNien Chen <hn.chen@weidahitech.com>
> 
> Just quote from Jonathan Clarke in previous thread(2017/01/24):
> "This division by 2 was added along with the touch width/height
> fields 6 years ago so that those fields 'match the visual scale
> of the touch' for a specific device (3M PCT)"
> "The scaling is also discarding information about touch size
> (1 bit for each of width/height) which is useful for any
> application that wants to know about it."
> 
> Jonathan mentioned just what I thought in a new project recently.
> It dosen't make sense to discard 1 bit width/height in general
> case according to the spec in multi-touch-protocol.txt so
> I would like to make a slight change here.
> 
> A quirk MT_QUIRK_TOUCH_SIZE_SCALING was added to service
> devices like 3M PCT with a special visual scale and
> the division by 2 only take effect with devices like that.

I've reformatted the changelog a bit and applied to for-4.12/multitouch. 
Thanks,

-- 
Jiri Kosina
SUSE Labs

