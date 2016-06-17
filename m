From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Alps I2C HID Touchpad-Stick support
Date: Fri, 17 Jun 2016 23:54:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606172353250.6874@cbobk.fhfr.pm>
References: <1466070357-5315-1-git-send-email-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52060 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932486AbcFQVyz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jun 2016 17:54:55 -0400
In-Reply-To: <1466070357-5315-1-git-send-email-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: benjamin.tissorires@redhat.com, peter.hutterer@who-t.net, hdegoede@redhat.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, masaki.ota@jp.alps.com, naoki.saito@jp.alps.com

On Thu, 16 Jun 2016, Masaki Ota wrote:

> >From Masaki Ota <masaki.ota@jp.alps.com>
> 
> <ChangeList>
> - Add hid-alps.c for Support Alps I2C HID Touchpad and Stick device.
> - Add hid-alps.txt to check this device spec.
> - Add Alps-JP vendor ID to hid-idh.h for support this device. 
> - To build this module, add Alps module definition to Makefile.
> 
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> ---
>  Documentation/hid/hid-alps.txt | 139 +++++++++++
>  drivers/hid/Kconfig            |   8 +
>  drivers/hid/Makefile           |   1 +
>  drivers/hid/hid-alps.c         | 525 +++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h          |   2 +

You actually also should update hid_have_special_driver[] in hid-core.c to 
make sure that generic driver doesn't override you. Given that I've missed 
this and already applied your patch -- could you please send that as a 
followup patch as well?

Thanks,

-- 
Jiri Kosina
SUSE Labs

