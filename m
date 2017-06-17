From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] HID: apple: Use country code to detect ISO keyboards
Date: Sat, 17 Jun 2017 20:56:02 +0200
Message-ID: <20170617185602.GA6348@wunner.de>
References: <20170602152839.7810-1-alexhenrie24@gmail.com>
 <alpine.LSU.2.20.1706081402540.30709@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:44551 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbdFQS4F (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 17 Jun 2017 14:56:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1706081402540.30709@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Alex Henrie <alexhenrie24@gmail.com>, benjamin.tissoires@redhat.com, jirislaby@gmail.com, stefan@glasen-hardt.de, ryan@finnie.org, morbidrsa@gmail.com, dan@pwienterprises.com, andreas.krist@gmail.com, rydberg@bitmath.org, linux-input@vger.kernel.org

On Thu, Jun 08, 2017 at 02:03:14PM +0200, Jiri Kosina wrote:
> On Fri, 2 Jun 2017, Alex Henrie wrote:
> > At least on newer laptops, Apple uses the same USB ID for both ISO and
> > ANSI keyboards. However, they have been good about filling in the
> > bCountryCode field in the HID descriptor on all of their keyboards. A
> > value of 13 indicates an ISO layout and other values indicate various
> > country-specific ANSI layouts.
> > 
> > With this patch, users of Apple US keyboards will no longer have to run
> > `echo 0 > /sys/module/hid_apple/parameters/iso_layout` to get a working
> > tilde key.
> > 
> > Please test this patch and send feedback if you have a Macbook or an
> > Apple keyboard.
> > 
> > Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> 
> Applied to for-4.13/apple. Thanks,

Sorry, I'm late to the party, just wanted to report that I've been
carrying this patch on my development branch for a while now and
have not noticed any adverse effects.  This is on a MacBookPro9,1
with a German ISO keyboard (USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO),
HID bCountryCode = 0x0d.

So, FWIW,
Tested-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas
