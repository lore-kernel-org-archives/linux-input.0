From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] Input: serio: make HYPERV_KEYBOARD depend on
 SERIO_I8042=y
Date: Tue, 12 Aug 2014 05:51:28 +0000
Message-ID: <EE124450C0AAF944A40DD71E61F878C9920A1C@SINEX14MBXC417.southpacific.corp.microsoft.com>
References: <1407814240-4275-1-git-send-email-decui@microsoft.com>
 <20140812032148.GB6867@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1lp0144.outbound.protection.outlook.com ([207.46.163.144]:18419
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750916AbaHLFw1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Aug 2014 01:52:27 -0400
In-Reply-To: <20140812032148.GB6867@kroah.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com" <jasowang@redhat.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>

> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Decoupling the dependency between hyperv_keyboard and i8042 needs
> > non-trivial efforts and is hence a long term goal.
> >
> > For now, let's make the dependency explicit so people can beware of this.
>
> You didn't make anyone "aware" of this, you just prevented people from
> being able to select the module unless they build the driver into the
> kernel, which isn't very nice.

Yes, exactly.

> What exactly needs to be done to fix this "correctly" that is going to
> take too much work at the moment?
Hi Greg,
The current implementation of hyperv-keyboard.c borrows
serio_interrupt() to pass the key strokes to the high level component.
serio_interrupt() actually depends on atkbd.c and i8042.c, so this doesn't
work for a Generation 2 hyper-v guest because no i8042 keyboard controller
is emulated: http://technet.microsoft.com/en-us/library/dn282285.aspx

To decouple the dependency between the hyperv-keyboard and i8042
modules, I suppose we probably have to re-implement hyperv-keyboard by
using input_allocate_device(), input_register_device(), and using
input_report_key() to pass the key strokes to the high level.

I'll have to need some time for further investigation and a new
implementation. Before the new code is completely ready, IMHO the
patch can help to avoid a bad user experience like Arch Linux working
as a Generation 2 hyper-v guest.

BTW, looks most of Linux distros (like RHEL, Ubuntu, SUSE) have
CONFIG_SERIO_I8042=y, probably because it's the result of
"make defconfig". So the patch actually doesn't affect these distros.

Thanks,
-- Dexuan
