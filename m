From: Michael Welling <mwelling@ieee.org>
Subject: Re: AM335x touchscreen issues
Date: Wed, 27 May 2015 12:29:30 -0500
Message-ID: <20150527172930.GA13992@deathray>
References: <20150526183713.GU26599@saruman.tx.rr.com>
 <20150526205310.GA2104@deathray>
 <8F29D6B095ED194EA1980491A5E029710C89C445@DFLE08.ent.ti.com>
 <20150526212851.GA12224@deathray>
 <8F29D6B095ED194EA1980491A5E029710C89C4E0@DFLE08.ent.ti.com>
 <912A29987EAE174BA6CF187D7CDFA9CE270A8C43@DLEE08.ent.ti.com>
 <20150526215049.GC12224@deathray>
 <8F29D6B095ED194EA1980491A5E029710C89C70D@DFLE08.ent.ti.com>
 <20150526230649.GB24948@deathray>
 <556542CB.80106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33360 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbE0RaI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 May 2015 13:30:08 -0400
Content-Disposition: inline
In-Reply-To: <556542CB.80106@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: "Cooper Jr., Franklin" <fcooper@ti.com>, "Griffis, Brad" <bgriffis@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "GWilson@sakuraus.com" <GWilson@sakuraus.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>

On Wed, May 27, 2015 at 09:36:35AM +0530, Vignesh R wrote:
> Hi Michael,
> 
> On Wednesday 27 May 2015 04:36 AM, Michael Welling wrote:
> > On Tue, May 26, 2015 at 10:31:32PM +0000, Cooper Jr., Franklin wrote:
> >>
> 
> [snip]
> 
> > 
> > Perhaps there is coupling between the LCD lines and the ADC lines?
> 
> On Beaglebone Black with BB-View 4.3" Cape from Farnell, the LCD lines
> and TSCADC lines are placed close to one another, hence the analog
> signals are affected by digital LCD signals, leading to above issue.
> 
> This was reported when I submitted the patches in question. Please see
> http://thread.gmane.org/gmane.linux.kernel.iio/14710/focus=121321
> http://thread.gmane.org/gmane.linux.kernel.iio/14710/focus=15242
> 
> I did document this in my cover letter. Please see
> http://thread.gmane.org/gmane.linux.kernel.iio/15583
> 
> I think its the same issue that you are facing.

Sounds like it.

The threads above mention adding decoupling capacitors to the ADC lines.

Is this the suggested workaround for the workaround?

Isn't the capacitor only needed on the ADC0 line to avoid the unwanted
trigger?

Please advise.

I wish I saw this before spending a whole bunch of time debugging.
Perhaps some annotation in the driver would help people in the future.
> 
> Regards
> Vignesh
