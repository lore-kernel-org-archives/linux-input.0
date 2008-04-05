From: Sam Liddicott <sam@liddicott.com>
Subject: RE: multi-input quirk and skip output reports quirk
Date: Sat, 5 Apr 2008 07:16:54 +0100
Message-ID: <20080405061350.D735B2FE0D2A@sam.liddicott.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sam.liddicott.com ([207.210.85.99]:50080 "EHLO
	sam.liddicott.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbYDEGNx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Apr 2008 02:13:53 -0400
content-class: 
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Anssi Hannula <anssi.hannula@gmail.com>, linux-input@vger.kernel.org

Sor for top  posting - stinkin' pocket outlook (roll-on a linux keyboard phone)

I suppose the module parameter is nearly the same thing.

If you could tell me how to use it to set quirks for a usb id then I will check it in the next hour. I have a force-feedback controler but I don't know anything that uses it which could make the test hard...

If you can show me how to ass quirks for multipe devices than I will come up with a mechanism for distros that re-generates modprobe.d contents or whatever to combine a portable list of quirks. It will be easy to have the quirks file maintained and updated.

I hope I don't appear a total slacker but my brain is suffering from stack-full syndrome - sorry, and thanks.

Sam


-----Original Message-----
From: Jiri Kosina <jkosina@suse.cz>
Sent: 05 April 2008 07:01
To: Sam Liddicott <sam@liddicott.com>
Cc: Anssi Hannula <anssi.hannula@gmail.com>; linux-input@vger.kernel.org
Subject: RE: multi-input quirk and skip output reports quirk

On Sat, 5 Apr 2008, Sam Liddicott wrote:

> I'm all for setting quirks dynamically from user space during the plug 
> event, as the delay between posting a patch and having it appear in 
> distro of choice can be well over a year which is too long to remember 
> and too long to be useful.

This can be done by using a 'quirks' module parameter to usbhid.

> I do remember that there were two quirks set for the same brand of dual 
> controller and I copied them both to the quad controller. I was asked to 
> check if both quirks were actually needed, I still haven't had the 
> required couple of hours to rebuild my kernel to do this and it became 
> simpler to use the quad controller as a single controller.

You don't have to rebuild if you have a kernel that supports dynamic 
quirks for usbhid.

-- 
Jiri Kosina
SUSE Labs

