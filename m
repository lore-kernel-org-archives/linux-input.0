From: Keith Rutkowski <rutkowski@signatureresearchinc.com>
Subject: Re: [Bugme-new] [Bug 14421] New: CH Products joystick detected but
 not functional
Date: Mon, 19 Oct 2009 09:55:49 -0400
Message-ID: <4ADC6FE5.2000706@signatureresearchinc.com>
References: <200910191526.30825.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta21.charter.net ([216.33.127.81]:55607 "EHLO
	mta21.charter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756156AbZJSNz5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2009 09:55:57 -0400
In-Reply-To: <200910191526.30825.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org

On 10/19/2009 09:26 AM, Oliver Neukum wrote:
> Did you see the patches which added a quirk for your device,
> if I am not mistaken?
>
> 	Regards
> 		Oliver
>
> .
>
>    
I have not found any patches for this specific device.  It is an 
industrial class joystick, so probably not as common as the CH Products 
consumer class joysticks.

However, this patch seems to address a similar issue with other more 
common CH Products joysticks:

commit efee69d7e0f1ddfec97549eee0a8b63750eb67f7
Author: Alan Stern<stern@rowland.harvard.edu>
Date:   Wed May 6 15:48:49 2009 -0400

     HID: add NOGET quirk for devices from CH Products

     commit b820aabf6cb987fd03d85b0b5f599685051e0426 upstream.

     This patch (as1240) adds the NOGET quirk for three devices from CH
     Products: the Pro pedals, the Combatstick joystick, and the Flight-Sim
     yoke.  Without these quirks, the devices haven't worked for many
     kernel releases.  Sometimes replugging them after boot-up would get
     them to work and sometimes they wouldn't work at all.

     Signed-off-by: Alan Stern<stern@rowland.harvard.edu>
     Reported-by: Sean Hildebrand<silverwraithii@gmail.com>
     Reported-by: Sid Boyce<sboyce@blueyonder.co.uk>
     Tested-by: Sean Hildebrand<silverwraithii@gmail.com>
     Tested-by: Sid Boyce<sboyce@blueyonder.co.uk>
     Signed-off-by: Jiri Kosina<jkosina@suse.cz>
     Signed-off-by: Greg Kroah-Hartman<gregkh@suse.de>


Thanks,
Keith

-- 

Keith Rutkowski
Software Engineer

Signature Research, Inc
www.signatureresearchinc.com

Email: rutkowski@signatureresearchinc.com
Phone: (906) 337-3360
Fax:   (906) 337-0023

