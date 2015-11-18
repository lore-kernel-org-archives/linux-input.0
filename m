From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Chromebook touchpad not responsive on latest kernel
Date: Wed, 18 Nov 2015 09:57:30 -0800
Message-ID: <20151118175730.GA20906@dtor-ws>
References: <CAMerc7Y5UEtTkq8aJDgSaAQZgV8Gg4muvDBy9PBFDTDkJHUPKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33560 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756530AbbKRR5g (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Nov 2015 12:57:36 -0500
Received: by pabfh17 with SMTP id fh17so53467018pab.0
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2015 09:57:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMerc7Y5UEtTkq8aJDgSaAQZgV8Gg4muvDBy9PBFDTDkJHUPKA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rich K <rgkirch@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Rich,

On Wed, Nov 18, 2015 at 11:44:03AM -0500, Rich K wrote:
> Dear Dmitry Torokhov,
> 
> I have filed a bug report on launchpad and gathered the information from
> wiki.ubuntu.com/Bugs/Upstream/kernel. I believe that you are the correct
> person to email with this concern.
> 
> https://bugs.launchpad.net/bugs/1513297

...

> XE500C12-K01US Samsung Chromebook 2 Ubuntu 16.04 touchpad not responsive
> 
> The chromebook is new and the touchpad worked great with chromiumos but not
> at all with Ubuntu.

I believe this model uses Atmel touchpad, for which we do have a driver
in mainline (even though it is not the most up-to-date one). I see that
Ubuntu has it configured to be a module, does it help if you do:

sudo modprobe atmel_mxt_ts

Thanks.

-- 
Dmitry
