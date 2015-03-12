From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v4] HID: multitouch: Add support for button type usage
Date: Thu, 12 Mar 2015 00:06:06 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1503120005500.24876@pobox.suse.cz>
References: <20150311215523.GC136254@ubuntu-hedt> <1426112801-120860-1-git-send-email-seth.forshee@canonical.com> <20150312011318.GE19872@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37986 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbbCLEGJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Mar 2015 00:06:09 -0400
In-Reply-To: <20150312011318.GE19872@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Seth Forshee <seth.forshee@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 11 Mar 2015, Benjamin Tissoires wrote:

> On Mar 11 2015 or thereabouts, Seth Forshee wrote:
> > According to [1], Windows Precision Touchpad devices must supply
> > a button type usage in the device capabilities feature report. A
> > value of 0 indicates that the device contains a depressible
> > button (i.e. it's a click-pad) whereas a value of 1 indicates
> > a non-depressible button. Add support for this usage and set
> > INPUT_PROP_BUTTONPAD on the touchpad input device whenever a
> > depressible button is present.
> > 
> > [1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn467314(v=vs.85).aspx
> > 
> > Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> > ---
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Thanks for the quick re-spin

Applied to for-4.1/multitouch.

-- 
Jiri Kosina
SUSE Labs
