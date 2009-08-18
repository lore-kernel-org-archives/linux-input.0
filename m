From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Rename keypad and ts platform driver for w90p910
Date: Mon, 17 Aug 2009 22:25:07 -0700
Message-ID: <20090818055620.73F65526EA5@mailhub.coreip.homeip.net>
References: <4A88D499.30302@gmail.com> <20090817084848.6720F526EA5@mailhub.coreip.homeip.net> <e68bb3470908170144w49cf2e44g56eba456424a9a4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:3785 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbZHRFZK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2009 01:25:10 -0400
Received: by rv-out-0506.google.com with SMTP id f6so929726rvb.1
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2009 22:25:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e68bb3470908170144w49cf2e44g56eba456424a9a4b@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input@vger.kernel.org

Hi Wan,

On Mon, Aug 17, 2009 at 04:44:03PM +0800, Wan ZongShun wrote:
> Dear Dmitry,
> 
> Sir, Due to only w90p910 was renamed, other CPUs of the series
> originally was named after NUC9xx,
> the ts and keypad was public use by w90p910 ,nuc950 and nuc920,

OK, I see.

 so, if
> the 'w90p910-ts' and 'w90p910-keypad' could not be renamed ,I have to
> make the platform device names of nuc920 and nuc960 named after
> 'w90p910-ts' and 'w90p910-keypad' too, Hmm, I think it is so confused.

May I suggest calling the driver/devices nuc9xx-ts and nuc9xx-ts? Then
you should have some wiggle room. Also I think you should push out the
patches changing driver names together with your platform code (and not
through subsystem trees), otheriwse there will be a period when drivers
stop binding to your devices. Just make sure you get Acks from the
maintainers and you should be set.

And please adjust the Kconfig entries to mention the other chipsets as
well.

-- 
Dmitry
