From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Mon, 12 May 2014 18:17:47 -0700
Message-ID: <20140513011747.GC26152@core.coreip.homeip.net>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org>
 <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com>
 <536963A0.4060506@wwwdotorg.org>
 <536BAA5A.1010809@itdev.co.uk>
 <536BB3C9.8070908@wwwdotorg.org>
 <20140508172635.GD11672@core.coreip.homeip.net>
 <536BE154.2090701@itdev.co.uk>
 <20140509184908.GX12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:44664 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbaEMBRt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 May 2014 21:17:49 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so9508210pab.31
        for <linux-input@vger.kernel.org>; Mon, 12 May 2014 18:17:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140509184908.GX12304@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nick Dyer <nick.dyer@itdev.co.uk>, Stephen Warren <swarren@wwwdotorg.org>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

On Fri, May 09, 2014 at 07:49:08PM +0100, Mark Brown wrote:
> On Thu, May 08, 2014 at 08:56:04PM +0100, Nick Dyer wrote:
> 
> > Thanks! I had wondered why you had left it, you never communicated this to
> > me unfortunately. Would it be preferable for me to switch to
> > request_firmware_nowait() and complete the probe asynchronously after it
> > returns?
> 
> Another common option is to defer the firmware request/load until the
> device is opened, but that doesn't work for all devices.  That should
> mean that userspace is up and running.

That would not work for input devices as firmware quite often defines
capabilities of the devices and we need them before registering input
device (which is the object that userspace opens).

Thanks.

-- 
Dmitry
