From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: support for Logitech Wave
Date: Mon, 28 Apr 2008 08:59:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804280851580.7756@jikos.suse.cz>
References: <200804250012.19227.linux-user@kmilburn.me.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:54271 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756168AbYD1G7Y (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Apr 2008 02:59:24 -0400
In-Reply-To: <200804250012.19227.linux-user@kmilburn.me.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Milburn <linux-user@kmilburn.me.uk>
Cc: linux-input@vger.kernel.org

On Fri, 25 Apr 2008, Kevin Milburn wrote:

> I'm having problems with a Logitech Wave (cordless) keyboard and its 
> extra keys, and am hoping the following information will help in 
> resolving the problem.

Hi Kevin,

is the device in question vendor ID 0x046d and product ID 0xc517? (you can 
find out using lsusb, for example).

If so, then that's the very same receiver that Logitech ships with S510 
keyboards, so we'll have to put this extra mappings into the 
quirk_logitech_wireless() function.

> I've tested the keyboard with evtest, and none of the extra keys are 
> recognized, and no information reported when they are pressed

Could you please be more specific here? Those keys for which there is some 
'evbug' output should definitely also appear in evtest output (if X driver 
will then receive the code or not is a different story).

> I've attached a copy of information from a debug session of the HID, and 
> information from evbug.  It also indicates which keys work (depending on 
> layout).

Thanks, this is all the information that will be needed for establishing 
proper mappings for non-working keys, but I'd like to understand first 
whether there are keys that appear in evbug output, but there is no event 
happening on evdev (as seen by evtest).

A few remarks from quick look at the output:

- what are the "Vista Flip" and "Vista Gadget" keys supposed to do?
- the keys that are labelled "works depending on layout" -- what exactly 
  does that mean? Is there still output from hid-debug, no matter the 
  layout?

Thanks,

-- 
Jiri Kosina
SUSE Labs
