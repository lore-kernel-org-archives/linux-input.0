From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] hid: Complete support for the new unibody macbooks
Date: Thu, 20 Nov 2008 01:41:32 +0100
Message-ID: <4924B23C.6050300@euromail.se>
References: <49109C91.6090207@euromail.se> <alpine.LNX.1.10.0811111835540.24889@jikos.suse.cz> <4919C979.3000501@euromail.se> <alpine.LNX.1.10.0811112347260.24889@jikos.suse.cz> <20081119113753.ZZRA012@mailhub.coreip.homeip.net> <alpine.LNX.1.10.0811191803320.19853@jikos.suse.cz> <49249431.9040104@euromail.se> <alpine.LNX.1.10.0811192339560.19853@jikos.suse.cz> <49249CCB.7060807@euromail.se> <alpine.LNX.1.10.0811200056240.19853@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:60278 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752297AbYKTAlh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Nov 2008 19:41:37 -0500
In-Reply-To: <alpine.LNX.1.10.0811200056240.19853@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Jiri Kosina wrote:
> On Thu, 20 Nov 2008, Henrik Rydberg wrote:
> 
>>> Therefore my memory must have been wrong -- I thought that you told me 
>>> when I was merging f89bd95c5c that the devices are not standard HID 
>>> devices at all, and therefore they can be safely ignored by the driver 
>>> right away, as they can't be driven by HID driver anyway.
>> These usb devices provide several different functions through the same
>> interface. By default, it looks like a regular mouse interface, which
>> HID will claim. This is why we need the quirks.
> 
> That I fully understand. But I though that the device is so much HID 
> standard non-compliant, that even basic functionality is not possible with 
> the generic HID driver, and therefore blacklisting it immediately can't do 
> any harm. That's what I understood previously. But if this is wrong, and 
> the HID code can get at least basic functionality from the device, I will 
> revert the blacklist addition.

Basic functionality is possible with the generic HID driver.

Thanks,
Henrik

