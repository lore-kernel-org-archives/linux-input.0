From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC] Port of hid-egalax to the unified hid-multitouch driver
Date: Tue, 8 Mar 2011 14:29:25 +0100
Message-ID: <20110308132925.GA19098@polaris.bitmath.org>
References: <1299417883.9645.494.camel@itzy>
 <AANLkTikWm3iBwqSTsQZWsLZ4b_q2aScUEo4dW9GJ9Kcz@mail.gmail.com>
 <alpine.LNX.2.00.1103081413220.19969@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:34935 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754416Ab1CHN1S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Mar 2011 08:27:18 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1103081413220.19969@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Richard Nauber <richard.nauber@googlemail.com>, linux-input@vger.kernel.org

> > This reminds me that we have to switch the other drivers to 
> > hid-multitouch too.
> 
> That would be nice. I don't see this really being done for the upcoming 
> merge window, right Benjamin?

There has been no activity in that direction here either...

> > Actually, I was not in favor of porting this driver into hid-multitouch. 
> > eGalax has two differents protocols: one for resistive technology (which 
> > is compatible with hid-multitouch in its current form), and one for 
> > capacitive technology (which requires the "corrupt packet length" 
> > quirk).
> > 
> > Apparently, according to the kernel logs the Samsung MB30 is a resistive 
> > technology (correct me if I'm wrong). This means that we also need 
> > testings for the capacitive one.
> > 
> > I'll let the community decide whether we should include this in 
> > hid-multitouch. Henrik, Jiri, any idea?
> 
> Either directly hid-multitouch, or hid-multitouch-capacitive sub-module 
> should be fine.

Maybe it is obvious already, but I think the patch is great. There is
really no reason to split the driver - in particular given that the
manufacturer has ensured similar behavior from both types.

Thanks,
Henrik
