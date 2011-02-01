From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: Elo TouchSystems touchscreen support? (04e7:0022)
Date: Tue, 1 Feb 2011 14:26:28 +0100
Message-ID: <20110201132628.GA5933@polaris.bitmath.org>
References: <1296485689.7756.9.camel@novo.hadess.net>
 <20110131212842.GB1603@polaris.bitmath.org>
 <AANLkTi=8O=p6-zTdMete7uhrT5OKODZXROKyoGPURJ3h@mail.gmail.com>
 <1296561717.15349.5.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [80.76.148.7] ([80.76.148.7]:56933 "EHLO
	ch-smtp04.sth.basefarm.net" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753722Ab1BANea (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Feb 2011 08:34:30 -0500
Content-Disposition: inline
In-Reply-To: <1296561717.15349.5.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

> > Please use the script at
> > http://lii-enac.fr/en/architecture/linux-input/report.py
> > and run, as root: python report.py > descriptors.txt
> > 
> > This will do the job. You can then send us the descriptors.txt, and we
> > will see what we can do.
> 
> Attached (with the rest of the input devices stripped).

Good good, looks like there is a digitizer in there, with tipswitch,
inrange, contactid, x, y and contactcount. Paching up hid-multitouch
(and adding the device to the hid-core special device list) might
actually do it.

Cheers,
Henrik
