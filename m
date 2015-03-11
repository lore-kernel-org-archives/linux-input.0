From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH v3] HID: multitouch: Add support for button type usage
Date: Wed, 11 Mar 2015 16:55:23 -0500
Message-ID: <20150311215523.GC136254@ubuntu-hedt>
References: <20150311172525.GB136254@ubuntu-hedt>
 <1426094951-44489-1-git-send-email-seth.forshee@canonical.com>
 <20150311205559.GC19872@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:35233 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbbCKVzm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Mar 2015 17:55:42 -0400
Received: by obcwo20 with SMTP id wo20so12154501obc.2
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2015 14:55:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150311205559.GC19872@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 11, 2015 at 04:55:59PM -0400, Benjamin Tissoires wrote:
> Hi Seth,
> 
> On Mar 11 2015 or thereabouts, Seth Forshee wrote:
> > According to [1], Windows Precision Touchpad devices must supply
> > a button type usage in the device capabilities feature report. A
> > value of 0 indicates that the device contains a depressible
> > button (i.e. it's a click-pad) whereas a value of 1 indicates
> > a non-depressible button. Add support for this usage and set
> > INPUT_PROP_BUTTONPAD on the touchpad input device whenever a
> > depressible button is present.
> > 
> > v2: Add string for button type usage in debugfs.
> > v3: Fix conflicts with 015fdaa9f8ed ("HID: multitouch: add
> >     support of clickpads").
> > 
> > [1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn467314(v=vs.85).aspx
> > 
> > Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> > ---
> 
> [Replying to the previous thread here for convenience]
> 
> Sorry I might have overlooked your patch and forgot about it when I sent
> mine. I should definitively have looked at this in detail because that's
> a better approach IMO.
> However, the patch I sent allows to handle clickpads which are not
> following MS spec, so I think your v3 on top of mine makes sense.
> 
> I have a few bike-shedding if you don't mind:

Sure, I opted to maintain the terminology from the MS spec but I have no
problem doing it that way. I'll follow up with another patch once I get
it tested.
