From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Keyboard problem on HP Envy 17 3D
Date: Mon, 25 Jun 2012 11:43:14 -0700
Message-ID: <2842883.2Br7QRospJ@dtor-d630.eng.vmware.com>
References: <4FE24873.8010106@texas.net> <20120622053920.GA7821@texas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61061 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145Ab2FYSnU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 14:43:20 -0400
Received: by dady13 with SMTP id y13so5694099dad.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 11:43:20 -0700 (PDT)
In-Reply-To: <20120622053920.GA7821@texas.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David VomLehn <vomlehn@texas.net>
Cc: linux-input@vger.kernel.org

On Thursday, June 21, 2012 10:39:20 PM David VomLehn wrote:
> On Wed, Jun 20, 2012 at 10:08:30PM +0000, David VomLehn wrote:
> > I have a keyboard problem that I figure *must* be a keyboard
> > hardware problem, but it doesn't really look like it.
> 
> ...
> 
> > My system is an HP Envy 17" 3D (2090nr).
> 
> So, I did what I should have done before but the results were what I
> expected--I hooked up a spare USB keyboard and there is no problem.
> Which narrows the problem down to the keyboard decoding. I would
> appreciate any help I can get with hints I can use to determine
> that this is hardware or fix the driver.

If you enable debug option of i8042:

	echo 1 > /sys/module/i8042/parameters/debug

you can save a raw stream of keyboard contorller data and analyze it.

However it could be something simpler - could your palm be brushing against
the touchpad and cause pasting of random garbage?

Thanks.

-- 
Dmitry
