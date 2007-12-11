From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: rfkill-input understanding help
Date: Tue, 11 Dec 2007 03:33:40 +0000
Message-ID: <200712110333.40946.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [65.196.224.53] ([65.196.224.53]:36249 "EHLO
	mail.slackadelic.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbXLKDfR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Dec 2007 22:35:17 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, ivdoorn@gmail.com

Dmitry, Ivo,

I'm trying to get my head around the input part of rfkill, and failing 
miserably here.

Background:

acer-wmi (in development) controls the rfkill switches for wireless and 
bluetooth on many Acer laptops.

There are two buttons which control these, one for wireless, and one for 
bluetooth. However, the wireless and bluetooth buttons on the laptop are just 
keys - they generate KEY_WLAN and KEY_BLUETOOTH, but don't toggle the 
wireless and bluetooth themselves (this is down to acer-wmi).

I'd like to set it up so that KEY_WLAN will toggle the wireless, and 
KEY_BLUETOOTH toggles bluetooth.

I've been reading through rfkill.txt and linux/rfkill.h and the various 
discussions about rfkill and quite frankly, I'm no-where near understanding 
what it is I need to do for this particular use case.

What I've done so far:

Registered two rfkill devices - one for wireless, one for bluetooth.

Problem:

The sysfs interface works just fine - but nothing is being toggled when I 
press the wireless or bluetooth buttons (which are just generating KEY_WLAN 
and KEY_BLUETOOTH).

>From my limited understanding, rfkill_input (which is enabled in my kernel) 
_should_ just be handling these keycodes (since userspace has not claimed 
these rfkill devices), and then calling the necessary toggle function - but 
AFAICT, this is not happening.

Have I misunderstood this, am I missing something, or is this particular use 
case supposed to be handled by userspace instead (i.e. a userspace tool is 
supposed to handle the keypress, then toggle the rfkill device via sysfs)?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
