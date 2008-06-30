From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add support for eGalax TouchKit USB touchscreen
	used on HP tx1305us
Date: Mon, 30 Jun 2008 16:24:09 -0400
Message-ID: <20080630162327.ZZRA012@mailhub.coreip.homeip.net>
References: <200806281719.16837.daniel.ritz-ml@swissonline.ch> <48668070.3040902@lisphacker.com> <20080630112020.ZZRA012@mailhub.coreip.homeip.net> <200806302218.37165.daniel.ritz-ml@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:3985 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685AbYF3UYU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2008 16:24:20 -0400
Received: by yw-out-2324.google.com with SMTP id 9so834784ywe.1
        for <linux-input@vger.kernel.org>; Mon, 30 Jun 2008 13:24:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200806302218.37165.daniel.ritz-ml@swissonline.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Cc: Alastair Bridgewater <nyef_sbcl@lisphacker.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Jun 30, 2008 at 10:18:36PM +0200, Daniel Ritz wrote:
> On Monday 30 June 2008 17:23:35 Dmitry Torokhov wrote:
> > Hi Alastair,
> > 
> > On Sat, Jun 28, 2008 at 02:18:24PM -0400, Alastair Bridgewater wrote:
> > >       bInterfaceClass         3 Human Interface Devices
> > >       bInterfaceSubClass      1 Boot Interface Subclass
> > >       bInterfaceProtocol      2 Mouse
> > 
> > I think we can try to make usbtouchscreen ignore eGalaxes with
> > interface class set to HID?
> > 
> 
> yeah, i was thinking of that too...something like the attached?
> it's completely untested, so no signed-off-by yet...
> 

Yeah, that looks nice. If both you guys could test it it'd be grand.

Thanks!

-- 
Dmitry
