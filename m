From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] Input: hyperv-keyboard: register as a wakeup source
Date: Thu, 7 Aug 2014 00:19:56 +0000
Message-ID: <EE124450C0AAF944A40DD71E61F878C9910E57@SINEX14MBXC417.southpacific.corp.microsoft.com>
References: <1406903304-7256-1-git-send-email-decui@microsoft.com>
 <20140806203339.GA22889@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2lp0238.outbound.protection.outlook.com ([207.46.163.238]:51926
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753860AbaHGAUh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Aug 2014 20:20:37 -0400
In-Reply-To: <20140806203339.GA22889@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com" <jasowang@redhat.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Thursday, August 7, 2014 4:34 AM
> To: Dexuan Cui
> On Fri, Aug 01, 2014 at 07:28:24AM -0700, Dexuan Cui wrote:
> > With this patch, we can press a key to wake up the VM after the VM
> executes
> > "echo freeze > /sys/power/state".
> >
> > This addresses part of
> https://bugzilla.redhat.com/show_bug.cgi?id=1086100
> 
> I am sorry but this bug is not open to the public. Please avoid
> mentioning such bugs in changelogs. Otherwise I'll apply it.
Hi Dmitry,
Sorry, I didn't realize it's not public... :-)

I'll remove the line and re-send the patch.

Thanks,
-- Dexuan
