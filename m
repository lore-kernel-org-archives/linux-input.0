From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] Support for Alps SS5 touchpad
Date: Mon, 3 Oct 2016 09:23:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1610030922340.31629@cbobk.fhfr.pm>
References: <1466500773-3470-1-git-send-email-ben@smart-cactus.org> <alpine.LRH.2.00.1607291045590.21952@gjva.wvxbf.pm> <20160829071455.GB2968@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbcJCHXd (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 3 Oct 2016 03:23:33 -0400
In-Reply-To: <20160829071455.GB2968@dhcp22.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, 29 Aug 2016, Michal Hocko wrote:

> > > Here is the third iteration of my patchset adding support for the Alps SS5
> > > touchpad used in the Dell Latitude E7470. The patch is largely unchanged except
> > > for a reorganization of the DUALPOINT flag detection logic and the addition of
> > > protocol documentation.
> > > 
> > > Thanks to everyone who has offered reviews so far.
> > 
> > Seems like this went by unnoticed. Adding Dmitry to CC.
> 
> Thanks to Jiri for pointing me to these patches. I was running with them
> for few days and they seem to be working reasonably well on my Latitude
> E7470. The only annoying thing is that the vertical scrolling mode seems
> to be hard to exit - sometimes you can get almost to the (horizontal)
> middle of the touch pad and the scrolling is still active. I haven't
> found any scrolling area width configuration knob though.
> 
> Anyway, feel free to add my
> Tested-by: Michal Hocko <mhocko@suse.com>
> 
> Btw. I've noticed that none of the patches has your signed-off-by which
> is required for any patch to be applied.

Ben, Dmitry, has this fallen in between the cracks?

Thanks,

-- 
Jiri Kosina
SUSE Labs

