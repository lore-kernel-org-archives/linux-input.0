From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] Reset ps/2 port should      psmouse_probe   fail   
	before  retrying
Date: Sat, 24 Apr 2010 03:22:05 +0200
Message-ID: <1272072125.4341.10.camel@lovely>
References: <1271723857.6652.6.camel@lovely>
	 <20100422215517.GB28213@core.coreip.homeip.net>
	 <1271983668.16254.44.camel@lovely>
	 <201004230953.52447.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:60507 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475Ab0DXBQb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Apr 2010 21:16:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so503675fgg.1
        for <linux-input@vger.kernel.org>; Fri, 23 Apr 2010 18:16:30 -0700 (PDT)
In-Reply-To: <201004230953.52447.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Peter M. Petrakis" <peter.petrakis@canonical.com>, linux-input@vger.kernel.org, rubini <rubini@cvml.unipv.it>

On Fri, 2010-04-23 at 09:53 -0700, Dmitry Torokhov wrote:
> On Thursday 22 April 2010 05:47:48 pm Christoph Fritz wrote:

> > in conclusion:
> >  If a Synaptics touchpad can't be initialized (synaptics_init) and falls
> > back to PS/2, it doesn't get a psmouse_reset() after resuming from
> > suspend as it would get with a synaptics driver.
> 
> Yes, you are right. Maybe we should just reset psmouse unconditionally in 
> psmouse_reconnect() before actually doing any protocol reconnect/reprobe. That 
> should help in cases when users not enable Synaptics support; also it is 
> probably unlikely that mouse that was there gets unplugged after resume.

Yes, this would solve that case too. Maybe if we take that
"unconditionally-reset-step", what about taking the full step and
getting rid of the whole i8042_dmi_reset_table quirk stuff and doing
unconditionally resets there too?


