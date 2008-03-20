From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Patch to add NOGET for DMI/Acomdata
Date: Thu, 20 Mar 2008 09:58:23 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803200955500.30831@jikos.suse.cz>
References: <20080319154331.c670489d.zaitcev@redhat.com>
 <Pine.LNX.4.64.0803200010200.19269@twin.jikos.cz> <20080319165132.f831c344.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:47112 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753481AbYCTI6Y (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Mar 2008 04:58:24 -0400
In-Reply-To: <20080319165132.f831c344.zaitcev@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-input@vger.kernel.org

On Wed, 19 Mar 2008, Pete Zaitcev wrote:

> To tell you the truth, I just now noticed that the button does not
> work. Kernel prints this:
> hiddev96hidraw0: USB HID v1.10 Device [DMI      WD5000AAKB-00UKA] on usb-0000:00:13.5-3
> But then the events do not get delivered. This is what happens
> with DEBUG enabled in hid-core.c:
> usb 2-3.2: new high speed USB device using address 3
>   INPUT[INPUT]
>     Field(0)
>       Usage(2)
>         ffa0.00a6
>         ffa0.00a7
>       Logical Minimum(-128)
>       Logical Maximum(127)
>       Report Size(8)
>       Report Count(2)
>       Report Offset(0)
>       Flags( Variable Absolute )

Hi Pete,

yes, so the device doesn't provide any application we handle in HID <-> 
input mapping, it contains only vendor-speicific usages from 0xffa0 page.

hiddev/hidraw device surely is created for this device (as it is not 
handled by hid-input), so a userspace driver can be written easily to 
handle this button.

So your patch makes sense, I will apply it to my tree, thanks.

-- 
Jiri Kosina
SUSE Labs
