From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3] Support for Alps SS5 touchpad
Date: Mon, 29 Aug 2016 09:14:55 +0200
Message-ID: <20160829071455.GB2968@dhcp22.suse.cz>
References: <1466500773-3470-1-git-send-email-ben@smart-cactus.org>
 <alpine.LRH.2.00.1607291045590.21952@gjva.wvxbf.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36656 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbcH2HO5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 Aug 2016 03:14:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so8211162wmf.3
        for <linux-input@vger.kernel.org>; Mon, 29 Aug 2016 00:14:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1607291045590.21952@gjva.wvxbf.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Fri 29-07-16 10:46:31, Jiri Kosina wrote:
> On Tue, 21 Jun 2016, Ben Gamari wrote:
> 
> > Hello all,
> > 
> > Here is the third iteration of my patchset adding support for the Alps SS5
> > touchpad used in the Dell Latitude E7470. The patch is largely unchanged except
> > for a reorganization of the DUALPOINT flag detection logic and the addition of
> > protocol documentation.
> > 
> > Thanks to everyone who has offered reviews so far.
> 
> Seems like this went by unnoticed. Adding Dmitry to CC.

Thanks to Jiri for pointing me to these patches. I was running with them
for few days and they seem to be working reasonably well on my Latitude
E7470. The only annoying thing is that the vertical scrolling mode seems
to be hard to exit - sometimes you can get almost to the (horizontal)
middle of the touch pad and the scrolling is still active. I haven't
found any scrolling area width configuration knob though.

Anyway, feel free to add my
Tested-by: Michal Hocko <mhocko@suse.com>

Btw. I've noticed that none of the patches has your signed-off-by which
is required for any patch to be applied.

Thanks!
-- 
Michal Hocko
SUSE Labs
