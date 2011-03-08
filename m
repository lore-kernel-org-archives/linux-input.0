From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC] Port of hid-egalax to the unified hid-multitouch driver
Date: Tue, 8 Mar 2011 14:14:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103081413220.19969@pobox.suse.cz>
References: <1299417883.9645.494.camel@itzy> <AANLkTikWm3iBwqSTsQZWsLZ4b_q2aScUEo4dW9GJ9Kcz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:36565 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753589Ab1CHNOu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Mar 2011 08:14:50 -0500
In-Reply-To: <AANLkTikWm3iBwqSTsQZWsLZ4b_q2aScUEo4dW9GJ9Kcz@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Richard Nauber <richard.nauber@googlemail.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

On Mon, 7 Mar 2011, Benjamin Tissoires wrote:

> Thank you very much for this work. 

Indeed, thanks a lot Richard.

> This reminds me that we have to switch the other drivers to 
> hid-multitouch too.

That would be nice. I don't see this really being done for the upcoming 
merge window, right Benjamin?

> Actually, I was not in favor of porting this driver into hid-multitouch. 
> eGalax has two differents protocols: one for resistive technology (which 
> is compatible with hid-multitouch in its current form), and one for 
> capacitive technology (which requires the "corrupt packet length" 
> quirk).
> 
> Apparently, according to the kernel logs the Samsung MB30 is a resistive 
> technology (correct me if I'm wrong). This means that we also need 
> testings for the capacitive one.
> 
> I'll let the community decide whether we should include this in 
> hid-multitouch. Henrik, Jiri, any idea?

Either directly hid-multitouch, or hid-multitouch-capacitive sub-module 
should be fine.

Thanks for the efforts,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
