From: ulrik.debie-os@e2big.org
Subject: Re: PROBLEM: ETPS/2 Elantech Touchpad dies after resume from suspend
 to RAM
Date: Mon, 26 Oct 2015 20:40:15 +0100
Message-ID: <20151026194014.GA7442@lantern>
References: <BAY169-W118D215BEBF901F03D30DC1F73A0@phx.gbl>
 <20151022200616.GA11764@lantern>
 <BAY169-W27FC7ECF27DC8BAB44F081F7260@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:54059 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbbJZTko (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Oct 2015 15:40:44 -0400
Content-Disposition: inline
In-Reply-To: <BAY169-W27FC7ECF27DC8BAB44F081F7260@phx.gbl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: WangBiscuit <biscuit_2014@outlook.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

Sorry, reaction will be slow these days, I'm rather busy.


So indeed your keyboard is also serio connected but that keeps on functioning
(and you're not using an usb keyboard). 

Can you confirm that psmouse module is still loaded after the resume ? I see
no clear reason why the sysfs entry would be gone except when it is asked
to do a complete 'disconnect'. We could verify if elantech_disconnect is
called by adding a printk there for instance.
Would it be easy for you to apply a patch to the kernel and build ?

What happens if you rmmod psmouse and modprobe it again ? Does that also make
the mouse function again ? If that already gives you the mouse back, you can 
add unload/modprobe the module as a workaround to your suspend/resume scripts.

When after resume the psmouse module is still present, I expect the problem
to be within the kernel and not gnome.

Best regards,
Ulrik

