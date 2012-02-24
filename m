From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: disable touchpad?
Date: Fri, 24 Feb 2012 14:27:06 -0800
Message-ID: <4F480EBA.7020509@canonical.com>
References: <4F47ED34.1070406@xenotime.net> <1396991.aDtuZKT2u4@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58272 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274Ab2BXW0l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Feb 2012 17:26:41 -0500
In-Reply-To: <1396991.aDtuZKT2u4@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-input@vger.kernel.org

On 02/24/2012 01:31 PM, Dmitry Torokhov wrote:
> On Friday, February 24, 2012 12:04:04 PM Randy Dunlap wrote:
>> (b) My Toshiba Portege laptop has a touchpad on/off button.  Is that
>> supported?
>
> Kernel probably emits one of KEY_TOUCHPAD_* for it; whether it is handled
> in userspace I do not know.

I have heard from some of our engineers who have looked into this that 
the interface for these buttons is not standardized. Sometimes the 
buttons turn off the touchpad in hardware. Sometimes they emit events 
that tell the OS to turn it off, and the OS needs to know how to handle it.

On top of that, LEDs are sometimes there to tell you if the trackpad is 
on or off. These are also not standardized. Sometimes they are hooked up 
to the hardware, and when the hardware is off they go off. Sometimes 
they are just a plain old LED and the OS needs to turn it on and off.

Fun...

-- Chase
