From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3 00/19] Report power supply from hid-logitech-hidpp
Date: Mon, 5 Jun 2017 10:01:45 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1706050959500.30709@cbobk.fhfr.pm>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com> <0cdc8dda-de3f-c3d0-07da-65612860a70f@intel.com> <1496345185.2570.3.camel@hadess.net> <20170602072907.GK1293@mail.corp.redhat.com> <02006322-6be2-f169-497e-06fc010a4bdb@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54917 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751352AbdFEIBs (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 5 Jun 2017 04:01:48 -0400
In-Reply-To: <02006322-6be2-f169-497e-06fc010a4bdb@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2 Jun 2017, Dave Hansen wrote:

> >>>> This will allow upower to not handle those devices anymore and to
> >>>> have more
> >>>> immediate reportng of the device to the system.
> >>> FWIW, I'm on Ubuntu 14.04, and upower *is* reporting my mouse battery
> >>> as
> >>> if it were a laptop battery.  It's mostly garbage, and always reports
> >>> 0%, which makes upower always tell me my laptop is 2/3 charged (I
> >>> have 2
> >>> real batteries).
> > Well, the exported battery might be sending levels instead of
> > pourcentages. And upower needs to be upgraded to handle those :(
> 
> It sounds like there are a number of things here where newer kernels are
> breaking older userspace.  It's also causing some very end-user visible
> effects, like having folks' systems auto shut down because upower thinks
> their batteries are dead.
> 
> Old versions of upower are obviously confused here.  It would be really
> nice to ensure that newer kernels don't break it like this.
> 
> IOW, it would be really nice if this were treated like a regression,
> because it's tantalizingly close.

I agree with Dave. If there is no solution found in time for -rc5, 
reverting to previous state would be the proper way to go.

-- 
Jiri Kosina
SUSE Labs

