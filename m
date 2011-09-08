From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [RFC] [BUG?] Sixaxis Value Ranges
Date: Thu, 8 Sep 2011 10:05:10 -0400
Message-ID: <CAEvUa7mtD1+ciKRn-S4gX9jWwFnecpDf_8w_NS+U55MdSxez4w@mail.gmail.com>
References: <CAEvUa7=KWnSFhWeOYf7wagRLODMNNKmdN_tpOnD1fuiwxN7aEg@mail.gmail.com>
	<376b78c42d77683e0d9a03e4e392e5e2.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46370 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933083Ab1IHOFL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Sep 2011 10:05:11 -0400
Received: by ywf7 with SMTP id 7so679470ywf.19
        for <linux-input@vger.kernel.org>; Thu, 08 Sep 2011 07:05:11 -0700 (PDT)
In-Reply-To: <376b78c42d77683e0d9a03e4e392e5e2.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

Hi,

On Wed, Sep 7, 2011 at 2:48 PM,  <simon@mungewell.org> wrote:
> Are you sure that the dead zone is being applied in the device itself, and
> not by the '/dev/input/js0' system?

Sorry if I wasn't clear; it is /dev/input/jsX that loses data.
Reading /dev/hidrawX gives results across the entire 0x000-0x3FF range
as I would expect.

I had actually been reading /dev/hidrawX to get at this data without
issue until a few weeks ago when support was added to /dev/input/jsX.
This dead zone became apparent in my applications immediately after I
tried to switch.

> You could also try to completely disable the 'dead zone' on the joystick
> sub-system.

Are you referring to the JSIOCSCORR ioctl operation here?  Perhaps I
could use this directly in my applications to ensure the
accelerometers' values are more precise whenever they are run.  I
still think too much information is lost with the default setting and
new js_corr values should be considered for these axes, but the ioctl
call should solve the issue in my case.

Thanks for your suggestion.

David
