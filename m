From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: wm831x-ts - Convert to devm_kzalloc()
Date: Thu, 11 Oct 2012 01:27:49 -0700
Message-ID: <20121011082749.GD32175@core.coreip.homeip.net>
References: <1349875236-5707-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1349875236-5707-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20121011073955.GA30395@core.coreip.homeip.net>
 <20121011080722.GE11726@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62684 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab2JKI1w (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Oct 2012 04:27:52 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1510848pad.19
        for <linux-input@vger.kernel.org>; Thu, 11 Oct 2012 01:27:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121011080722.GE11726@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org

On Thu, Oct 11, 2012 at 05:07:24PM +0900, Mark Brown wrote:
> On Thu, Oct 11, 2012 at 12:39:55AM -0700, Dmitry Torokhov wrote:
> > On Wed, Oct 10, 2012 at 10:20:35PM +0900, Mark Brown wrote:
> > > Saves a little code and eliminates the possibility of introducing some
> > > leaks.
> 
> > *sigh* OK, I guess devm_* is here to stay and I have to get on with the
> > program. I am still unhappy that half of the patches converting/using
> > devm_* APIs are wrong (not these ones), but I will apply these 3.
> 
> What's the error pattern you're seeing?  I've not noticed much of an
> issue here, but if there is one perhaps we can do something to make the
> error more obvious or harder to introduce.

int driver_probe()
{
	devm_kzalloc();
	input_allocate_device();
	...
	devm_request_irq();
	...
	input_register_device();
....
}

void driver_remove()
{
	input_unregister_device();
	/* rely on deves for cleanup */
}

The problem is that input device is freed but interrupts are still fully
functional.

-- 
Dmitry
