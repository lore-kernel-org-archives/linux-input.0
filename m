From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] Input: serio: make HYPERV_KEYBOARD depend on
 SERIO_I8042=y
Date: Wed, 13 Aug 2014 05:27:36 +0000
Message-ID: <EE124450C0AAF944A40DD71E61F878C9925D3D@SINEX14MBXC417.southpacific.corp.microsoft.com>
References: <1407814240-4275-1-git-send-email-decui@microsoft.com>
 <20140812032148.GB6867@kroah.com>
 <EE124450C0AAF944A40DD71E61F878C9920A1C@SINEX14MBXC417.southpacific.corp.microsoft.com>
 <20140812060108.GA13231@kroah.com>
 <EE124450C0AAF944A40DD71E61F878C9920EAF@SINEX14MBXC417.southpacific.corp.microsoft.com>
 <20140812175435.GA22386@core.coreip.homeip.net>
 <423148fadd52409a95064eca25e71340@BY2PR0301MB0711.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2lp0244.outbound.protection.outlook.com ([207.46.163.244]:22076
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751137AbaHMF2r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Aug 2014 01:28:47 -0400
In-Reply-To: <423148fadd52409a95064eca25e71340@BY2PR0301MB0711.namprd03.prod.outlook.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>
Cc: Greg KH <gregkh@linuxfoundation.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Haiyang Zhang <haiyangz@microsoft.com>

> -----Original Message-----
> From: KY Srinivasan
> > The Arch users can simply select to build i8042 into the kernel as a
> > workaround.
> >
> > The proper solution is to allow loading libps2 module even if i8042 did not
> find
> > its device. I wish I could simply drop this i8042_lock_chip and stuff, but
> > unfortunately i8042 ports are not truly independent. We need to figure a
> > way for libps2 to engage locking in i8042 if the driver is loaded, otherwise
> just
> > ignore it.
> 
> When I first wrote this driver, we took the decision not to replicate all the
> code in the at keyboard driver and to
> make this  a serio based driver. I like the proposal made by Dmitry here.
> 
> K. Y

Thanks for explaining the background, KY!
I like Dmitry's proposal too.

Thanks,
-- Dexuan
