From: Christopher Heiny <Cheiny@synaptics.com>
Subject: RE: [PATCH 00/04] input: RMI4 Synaptics RMI4 Touchscreen Driver
Date: Thu, 28 Nov 2013 01:39:52 +0000
Message-ID: <BFABBC009FBA1C43B207B15FD485ABD930137015@USW-MAIL1.synaptics-inc.local>
References: <1384385972-1686-1-git-send-email-cheiny@synaptics.com>,<CAN+gG=Ev12P=p-b8O4Zq9ThJx+TuKXb_1NJAkNj6idZmncz4RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:62852 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757442Ab3K1Bjy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Nov 2013 20:39:54 -0500
In-Reply-To: <CAN+gG=Ev12P=p-b8O4Zq9ThJx+TuKXb_1NJAkNj6idZmncz4RQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <Vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>

[sorry for top posting - I'm out of the office today, and restricted to the feeble webmail interface.]

Benjamin made some excellent points in our off-line conversation.  Please disregard this particular patchset.  We'll work on doing the same thing in a series of smaller, more manageable steps.

Thanks!
Chris

________________________________________
From: Benjamin Tissoires [benjamin.tissoires@gmail.com]
Sent: Wednesday, November 27, 2013 2:20 PM
To: Christopher Heiny
Cc: Dmitry Torokhov; Linux Input; Andrew Duggan; Vincent Huang; Vivian Ly; Daniel Rosenberg; Jean Delvare; Joerie de Gram; Linus Walleij
Subject: Re: [PATCH 00/04] input: RMI4 Synaptics RMI4 Touchscreen Driver

On Wed, Nov 13, 2013 at 6:39 PM, Christopher Heiny <cheiny@synaptics.com> wrote:
> This patchset implements changes to the synaptics-rmi4 branch of
> Dmitry's input tree.  The base for the patchset is Dmitry's commit
> 4a695a01fba9bf467b3b52e124ccee6cef73b323 from 2013-01-31.
>
>
>
> Overall this patchset implements the following changes with respect to
> the Dmitry's 2013-01-31 commit:
>
> * Refactors the transport layer (rmi_i2c) to be named appropriately.
>
> * Eliminates packed struct bitfields, replacing them with masks
> and shifts.  This should make the various register definitions
> endian-independent.
>
> * Removed most or all of the sysfs and debugfs support from the driver core
> and function drivers.  These features are still critical during platform
> development, particularly on embedded systems, so there are hooks that allow
> custom modules that support these control and debug capabilities.  One result
> of this is that several .c files have a corresponding .h file (for example,
> rmi_f01.c has a corresponding rmi_f01.h).  Also, a rmi_control.h file is
> added to provide general definitions for control/debug modules.
>
> * Fixes a number of bugs in the baseline commit.
>
> * Trivial - added an rmi_version.h file, which lets the version be easily
> tweaked using a script.
>
>
> We've broken this patch into 6 parts, as follows:
>     01 - core sensor and bus implementation
>     02 - I2C physical layer driver
>     03..04 - drivers for individual RMI functions
>
>
> Hopefully this is the last time we'll have wide-ranging structural changes in
> the driver code, and future patchsets can be much smaller and confined to
> one or two areas of interest. (yeah, I've said that before...)
>
>
> Comments and other feedback on this driver are welcomed.
>
> Christopher Heiny and the Synaptics RMI4 driver team
>

I have discussed off list with Chris about this patch series. I was
interested in it because it will be a requirement for the touchpad in
the Dell XPS 12 from 2013.
Basically, I told him that the patches are hard to review because of
the huge 1/4.

a v2 should be on its way :)

Cheers,
Benjamin
