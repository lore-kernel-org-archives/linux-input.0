From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: get rid of HID_QUIRK_NO_INIT_REPORTS
Date: Mon, 6 Mar 2017 13:15:27 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703061310380.31814@cbobk.fhfr.pm>
References: <20170105092144.17120-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53907 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752807AbdCFMbC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Mar 2017 07:31:02 -0500
In-Reply-To: <20170105092144.17120-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@googlemail.com>, Oliver Neukum <oneukum@suse.de>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Thu, 5 Jan 2017, Benjamin Tissoires wrote:

> For case 1, the hiddev documentation provides an ioctl to do the
> init manually. A solution could be to retrieve the requested report
> when EVIOCGUSAGE is called, in the same way hidraw does. I would be
> tempted to not change the behavior and hope that we won't break any
> userspace tool.

I'd like to be applying the HID_QUIRK_NO_INIT_REPORTS removal as soon as 
possible so that it gets exposure in linux-next over the whole development 
cycle.

I am however too conservative to ignore the potential hiddev breakage, I 
am afraid. This has a real potential of breaking systems, and 
administrators having hard time figuring out of happened; essentialy, this 
is userspace-visible behavior change (regression) for which we haven't 
done any long-term depreciation (such as printing a warning "please talk 
to your hiddev driver vendor" in case the driver seems to assume 
initialized reports) at least for a few years.

I think that either doing it at a connect time, or during first 
EVIOCGUSAGE ioctl() call is a must.

Otherwise, I'd be super-happy to finally get rid of this giant PITA.

Thanks!

-- 
Jiri Kosina
SUSE Labs

