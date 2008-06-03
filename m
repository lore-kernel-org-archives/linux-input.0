From: "Phil Endecott" <spam_from_linux_input@chezphil.org>
Subject: Re: Apple bluetooth keyboard
Date: Tue, 03 Jun 2008 18:40:24 +0100
Message-ID: <1212514824121@dmwebmail.dmwebmail.chezphil.org>
References: <1211721864274@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; format="flowed"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from japan.chezphil.org ([77.240.5.4]:4331 "EHLO japan.chezphil.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbYFCRk0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Jun 2008 13:40:26 -0400
Received: from localhost ([127.0.0.1] helo=chezphil.org)
	by japan.chezphil.org with esmtp (Exim 4.67)
	(envelope-from <spam_from_linux_input@chezphil.org>)
	id 1K3aUj-0006P6-4j
	for linux-input@vger.kernel.org; Tue, 03 Jun 2008 18:40:25 +0100
In-Reply-To: <1211721864274@dmwebmail.dmwebmail.chezphil.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux-input <linux-input@vger.kernel.org>

Phil Endecott wrote:
> - I have no delete key, so I can't type ctrl-alt-del!  (I have to keep 
> another keyboard plugged in just for this!)  I'd like to use the eject 
> key, which is immediately above the backspace key, for this.

I eventually discovered that loadkeys can make any key combination 
trigger the ctrl-alt-del action without any kernel changes:

keycode 161 = Remove
         Control Alt keycode 161 = Boot

This also made me wonder why HID_QUIRK_APPLE_HAS_FN has been 
implemented in the kernel, rather than in custom keymaps.  If it were 
in custom keymaps then it would be easier for a user to:
> - The FN key and the left Ctrl key are the same size and the keycaps 
> can easily be exchanged. The order of these keys is often something 
> that people complain about, e.g. if they're used to pressing 
> the bottom-left key on their desktop keyboard for ctrl but now find 
> that it isn't. Often there is nothing that can be done about this 
> because the logic for the FN key is inside the keyboard and not 
> fixable in software, but in the case of this keyboard I believe it 
> could be changed

I have written some of this up for the benefit of anyone else trying to 
get this device working properly: 
http://chezphil.org/apple-alu-bluetooth-kb-linux/ - hopefully the 
search engines will find that and the next users will waste less time 
on it.

Phil.




