From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: Add new driver into Input Subsystem for Synaptics
 DS4 touchscreen I2C devices
Date: Wed, 3 Oct 2012 20:01:21 +0200
Message-ID: <20121003180121.GA4198@polaris.bitmath.org>
References: <CC51EC7B5B7F984AA566DC102237848896F590C0@hkdcw-mail1.synaptics-inc.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CC51EC7B5B7F984AA566DC102237848896F590C0@hkdcw-mail1.synaptics-inc.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandra Chin <alexandra.chin@tw.synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Mahesh Srinivasan <msrinivasan@synaptics.com>, Alex Chang <alex.chang@tw.synaptics.com>, Scott Lin <scott.lin@tw.synaptics.com>, Christopher Heiny <Cheiny@synaptics.com>
List-Id: linux-input@vger.kernel.org

Hi Alexandra,

> Hi Henrik/Dmitry,
> 
> We are working on a product specific driver for Synaptics DS4 I2C touchscreen
> devices. It was submitted on Sept. 16, 2012, but has not been reviewed.
> (http://lkml.org/lkml/2012/9/16/24). 
> We found several warnings after running script/checkpatch.pl, therefore 
> an updated patch is attached.
> 
> As Chris says in https://lkml.org/lkml/2012/9/19/505, this driver will enable
> us to support all our customers effectively and provide our customers with 
> the best flexibility possible.
> Please help review attached patch, and we really appreciate your feedback :-)

It seems this driver is already present in staging. Comments and
formatting have been improved in the staging version, but that aside,
the two versions look very similar.  Why don't you submit fixes to
that driver instead?

On a general note, both versions of the driver use MT-A. Please
convert to MT-B, using the in-kernel tracking if necessary.

Thanks.
Henrik
