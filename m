From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] soc_button_array: fix the issue that button device can't
 be enumerated since 3.16-rc1
Date: Wed, 9 Jul 2014 09:57:32 -0700
Message-ID: <20140709165732.GD10364@core.coreip.homeip.net>
References: <1404309504.8366.93.camel@rzhang1-toshiba>
 <1404309713.8366.94.camel@rzhang1-toshiba>
 <2556427.cdnVoQoSXY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:52387 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579AbaGIQ5g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jul 2014 12:57:36 -0400
Received: by mail-pa0-f47.google.com with SMTP id kq14so9468490pab.20
        for <linux-input@vger.kernel.org>; Wed, 09 Jul 2014 09:57:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2556427.cdnVoQoSXY@vostro.rjw.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>, yao.jin@intel.com, linux-input <linux-input@vger.kernel.org>

On Tue, Jul 08, 2014 at 10:50:04PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 02, 2014 10:01:53 PM Zhang Rui wrote:
> > From c2ee1886ba230d9d93d2ea2f350b1dc1a2d5ead5 Mon Sep 17 00:00:00 2001
> > From: Jin Yao <yao.jin@linux.intel.com>
> > Date: Thu, 26 Jun 2014 10:26:44 +0800
> > Subject: [PATCH] soc_button_array: fix the issue that button device can't be
> >  enumerated since 3.16-rc1
> 
> Hi Rui,
> 
> For 3.16 I'm afraid we need to add the missing device ID to the PNP list.
> It is too late to do the conversion at this point IMO and we can do it later.

But for 3.17 this patch is the right way of doing things, right?

Thanks.

-- 
Dmitry
