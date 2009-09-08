From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Tue, 8 Sep 2009 13:49:06 -0700
Message-ID: <20090908212238.19CFB526EC9@mailhub.coreip.homeip.net>
References: <bfb1bb1f0909061357m4006a61co1c1b4dfa483b947b@mail.gmail.com> <alpine.LNX.2.00.0909071731120.23856@wotan.suse.de> <bfb1bb1f0909071047h1a4cbc3dx175f89ecedc3555d@mail.gmail.com> <alpine.LNX.2.00.0909081931360.23856@wotan.suse.de> <bfb1bb1f0909081304y708b037bw1c82288d6457c254@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f177.google.com ([209.85.216.177]:41061 "EHLO
	mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbZIHUtN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Sep 2009 16:49:13 -0400
Received: by pxi7 with SMTP id 7so3622593pxi.1
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2009 13:49:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <bfb1bb1f0909081304y708b037bw1c82288d6457c254@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sergey Kolesnikov <rockingdemon@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Tim Cole <tim.cole@canonical.com>, Tim Gardner <tim.gardner@canonical.com>, Amit Kucheria <amit.kucheria@canonical.com>, Stefan Bader <stefan.bader@canonical.com>

On Wed, Sep 09, 2009 at 12:04:44AM +0400, Sergey Kolesnikov wrote:
> 2009/9/8 Jiri Kosina <jkosina@suse.cz>
> 
> >
> > Sergey, I believe that reverting commit d07a9cba6b (you can do so using
> > git revert d07a9cba6b) will fix your joystick, is that correct?
> >
> >
> Yes, reverting this commit helps.
> I've tried jstest and succeeded to change the state of each available
> button/axis.
> 
> May be there is another way to distinguish between such joysticks and
> digitizers?
> 

No, Saitek should not used digitizer's buttons, the same way it should
not use standard keyboard keys (KEY_A, KEY_B, etc).

-- 
Dmitry
