From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: eGalax touchscreen regression
Date: Wed, 24 Apr 2013 09:06:52 +0300
Message-ID: <1366783612.21369.5.camel@sauron.fi.intel.com>
References: <1366708088.9823.16.camel@sauron.fi.intel.com>
	 <20130423154007.GB4104@core.coreip.homeip.net>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62110 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924Ab3DXGEo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Apr 2013 02:04:44 -0400
In-Reply-To: <20130423154007.GB4104@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hui Wang <jason77.wang@gmail.com>, Zhang Jiejing <jiejing.zhang@freescale.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hofemeier, Ulf" <ulf.hofemeier@intel.com>

On Tue, 2013-04-23 at 08:40 -0700, Dmitry Torokhov wrote:
> > the eGalax driver now requires OF. For us this is a regression because
> > we do not have OF: https://bugs.tizen.org/jira/browse/TIVI-740
> 
> I see. In this case we need to come up with a platform data to pass
> wakeup gpio in case platform does not support OF. irq_to_gpio() is not
> supported on many platforms, causing compilation errors.
> 
> Is the platform that you are trying to use the touchscreen upstream?

Unfortunately I do not really know about it, but once I learn, I'll come
back. Thanks!

-- 
Best Regards,
Artem Bityutskiy

