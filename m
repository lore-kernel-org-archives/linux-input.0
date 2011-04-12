From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: Re: [PATCH] HID: roccat: fixing actual/startup profile sysfs
 attribute in koneplus
Date: Tue, 12 Apr 2011 16:14:31 +0200
Message-ID: <1302617671.2238.42.camel@neuromancer>
References: <1302444165.12514.2.camel@neuromancer>
	 <alpine.LNX.2.00.1104121326290.12035@pobox.suse.cz>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:56659 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755243Ab1DLOOf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Apr 2011 10:14:35 -0400
In-Reply-To: <alpine.LNX.2.00.1104121326290.12035@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Am Dienstag, den 12.04.2011, 13:27 +0200 schrieb Jiri Kosina:
On Sun, 10 Apr 2011, Stefan Achatz wrote:
> 
> > startup_profile and actual_profile didn't work as expected. Also
> > as the actual profile is persistent, the distinction between the
> > two was ambiguous. And the event is now propagated through chardev.
> > The userland tool has been updated to support this change.
> 
> Fortunately, this is 'testing' ABI. But still, I'd prefer to follow good 
> practices here, and minimize incompatible ABI changes.
> 
> Is the userspace tool able to handle the situations:
> 
> - too old tool running to kernel containing this patch
> - new tool running on older kernel
> 
> ?

Lets split this in the three possible actions, two of them broken in the
actual module code:

1 reading actual_profile: shows stale data.
2 reading startup_profile: ok.
3 writing startup_profile: does not work because of a wrong writelength:

> > -	return koneplus_send(usb_dev, KONEPLUS_USB_COMMAND_STARTUP_PROFILE,
> > -			&buf, sizeof(struct koneplus_profile_buttons));
> > +	return koneplus_send(usb_dev, KONEPLUS_USB_COMMAND_ACTUAL_PROFILE,
> > +			&buf, sizeof(struct koneplus_actual_profile));

My userspace tools are not in any distros package repository, I keep new
tools backward compatible and I do a rapid release approach.
With these points and the actual modules flaws it didn't make much sense
for me to keep startup_profile for compatibility, but I wouldn't
struggle against it. If you feel better with the compatibility approach,
I can have an updated patch ready within minutes on request.
Stefan

