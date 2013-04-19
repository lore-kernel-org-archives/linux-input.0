From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC 00/21] Nintendo Wii Remote Extension Hotplugging
Date: Fri, 19 Apr 2013 12:38:44 -0700 (PDT)
Message-ID: <alpine.LNX.2.00.1304191234580.27945@deuxcents.site>
References: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52815 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598Ab3DSTiy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Apr 2013 15:38:54 -0400
In-Reply-To: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org

On Sat, 13 Apr 2013, David Herrmann wrote:

> Also please don't merge it, yet. I still have to remove hid-wiimote-ext.c as it
> is no longer needed, but I haven't tested how this affects
> backwards-compatibility. I did my best to not break existing user-space, but I
> want to do some more tests. So if there are no comments on this series, I will
> resend in about 1 week with a ready-to-merge series. But I wanted to see whether
> anyone has issues with the patches, first.

Hi David,

thanks a lot for this non-trivial amount of work you have done on the 
wiimote driver.

I admit I haven't performed a full and 100% proper review of the patchset 
yet, but on a first sight it seemed quite fine to me. So please proceed 
with sending the respin ready for merge, as far as I am concerned.

> Some sidenotes:
>  - Marcel already ACK'ed my Bluetooth HIDP rewrite which finally gives us
>    working Bluetooth HID without any kernel oops. Gustavo is currently applying
>    the patches. This series doesn't exactly depend on it, but you cannot test
>    Bluetooth device hotplugging without it, because the kernel just breaks.

Awesome, didn't know that this is happening.

> Last but not least I noticed that we duplicate the HID Boot Protocol in usbhid
> and Bluetooth HID. The Wifi-Display HID also provides some similar protocol. So
> I currently look into creating a hid-boot.c so we have a central place that
> implements it.

Makes sense to me as well.

Thanks a lot, David.

-- 
Jiri Kosina
SUSE Labs

