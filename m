From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] Input: serio: make HYPERV_KEYBOARD depend on
 SERIO_I8042=y
Date: Thu, 14 Aug 2014 06:07:11 +0000
Message-ID: <EE124450C0AAF944A40DD71E61F878C9929597@SINEX14MBXC417.southpacific.corp.microsoft.com>
References: <1407814240-4275-1-git-send-email-decui@microsoft.com>
 <20140812032148.GB6867@kroah.com>
 <EE124450C0AAF944A40DD71E61F878C9920A1C@SINEX14MBXC417.southpacific.corp.microsoft.com>
 <20140812060108.GA13231@kroah.com>
 <EE124450C0AAF944A40DD71E61F878C9920EAF@SINEX14MBXC417.southpacific.corp.microsoft.com>
 <20140812175435.GA22386@core.coreip.homeip.net>
 <EE124450C0AAF944A40DD71E61F878C9925D21@SINEX14MBXC417.southpacific.corp.microsoft.com>
 <20140813155644.GA6940@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1blp0187.outbound.protection.outlook.com ([207.46.163.187]:54894
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752450AbaHNGIc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Aug 2014 02:08:32 -0400
In-Reply-To: <20140813155644.GA6940@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com" <jasowang@redhat.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>

> -----Original Message-----
> From: Dmitry Torokhov
> > How about this:
> > in libps2.c let's add  and export a function pointer
> > i8042_lock_chip_if_port_owner: it is used to replace the current
> > 	if (i8042_check_port_owner(ps2dev->serio))
> > 		i8042_lock_chip();
> > The function pointer has a default value NULL, and in i8042.c: i8042_init()
> > we set the function pointer if an i8042 device is found?
> 
> Hmm, that would make i8042 depend on libps2, which might be OK, but how
> do you deal with the locking here? I.e. what happens if you unload i8042
> right when we go through this sequence?
Ok, I got it.

> Maybe we need to split i8042_lock_chip() and friends into a separate
> module that always loads, even if i8042 is not present.
> Dmitry
Good idea!

However the more difficult thing is 
i8042_check_port_owner() -- used by  libps2.c too.
Then  the separate module will also have to include and EXPORT
	DEFINE_SPINLOCK(i8042_lock);
	struct i8042_port i8042_ports[I8042_NUM_PORTS];
?

This seems a non-trivial change... :-(

Thanks,
-- Dexuan
