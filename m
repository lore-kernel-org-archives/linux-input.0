From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [git pull] Input updates for 3.20-rc0
Date: Tue, 10 Feb 2015 15:43:33 -0800
Message-ID: <20150210234333.GA5979@dtor-ws>
References: <20150210232326.GD26472@dtor-ws>
 <1423611442.8772.14.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34992 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453AbbBJXnh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Feb 2015 18:43:37 -0500
Received: by iebtr6 with SMTP id tr6so276371ieb.2
        for <linux-input@vger.kernel.org>; Tue, 10 Feb 2015 15:43:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1423611442.8772.14.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

Hi Bastien,

On Wed, Feb 11, 2015 at 12:37:22AM +0100, Bastien Nocera wrote:
> Hey Dmitry,
> 
> On Tue, 2015-02-10 at 15:23 -0800, Dmitry Torokhov wrote:
> > Hi Linus,
> > 
> > Please pull from:
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> > or
> > 	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus
> > 
> > to receive first round of updates for the input subsystem. You will get
> > a few new drivers (power button handler for AXP20x PMIC, tps65218 power
> > button driver, sun4i keys driver, regulator haptic driver, NI Ettus
> > Research USRP E3x0 button, Alwinner A10/A20 PS/2 controller), updates to
> > Synaptics and ALPS touchpad drivers (with more to come later), brand
> > new Focaltech PS/2 support, update to Cypress driver to handle Gen5 (in
> > addition to Gen3) devices, and number of other fixups to various drivers
> > as well as input core.
> 
> Could you look at:
> http://thread.gmane.org/gmane.linux.kernel.input/41095
> to get merged in rc1?

I'll get it in.

Thanks.

-- 
Dmitry
