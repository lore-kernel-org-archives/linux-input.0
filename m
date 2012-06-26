From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6] Touchscreen driver for FT5x06 based EDT displays
Date: Mon, 25 Jun 2012 19:06:00 -0700
Message-ID: <20120626020600.GD24705@core.coreip.homeip.net>
References: <1333564079-23893-2-git-send-email-simon.budig@kernelconcepts.de>
 <1340408898-491-1-git-send-email-simon.budig@kernelconcepts.de>
 <1340408898-491-2-git-send-email-simon.budig@kernelconcepts.de>
 <20120625085113.GA648@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37776 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757913Ab2FZCGG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 22:06:06 -0400
Received: by dady13 with SMTP id y13so6120772dad.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 19:06:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120625085113.GA648@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: simon.budig@kernelconcepts.de, linux-input@vger.kernel.org, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

On Mon, Jun 25, 2012 at 10:51:13AM +0200, Henrik Rydberg wrote:
> 
> > +The touch screens have a "factory mode" that allows access to the raw sensor
> > +data. However, the above mentioned settings are not available in this mode.
> > +In particular this limits the use of the raw data for tuning the parameters
> > +to a specific setup. Also the scan rate of the touch screen changes compared
> > +to the regular operation mode.
> > +
> > +To access the raw data switch to factory mode:
> > +    echo 1 > /sys/class/input/eventX/device/device/mode
> > +
> > +then read out the "raw_data" file. It contains X*Y big endian 16 bit values
> > +where X and Y are the number of sensor fields of the touch glass. These values
> > +are model specific and get be determined by dividing maximum x and y
> > +coordinate by 64.
> > +
> > +Note that reading raw_data gives a I/O error when the device is not in factory
> > +mode. The same happens when reading/writing to the parameter files when the
> > +device is not in regular operation mode.
> 
> Raw data is nice (and an alternative driver could output only such
> data), but extending the input interface by adding adhoc sysfs files
> is far from optimal. Several devices of this kind have appeared
> recently, so it is clear that the input interface is lacking.  I would
> prefer if the raw data be moved to debugfs, awaiting a more stable
> solution.  Dmitry, any opinion on this?

Firstly the question to Simon - what was the intent of providing access
to raw data? Was it mainly for debugging or was it truly additional
interface?

If it is debug-only then debugfs is a very good idea.

Regarding extending input interface - let's talk about what is missing.
You mentioned memory-mapped access, but I am not sure if it should be
implemented within current input structure or if it should be a
completely separate interface. If we implement it we should also make
sure we stabdardize the data stream and not simply dump raw device
data, as this would be a sep backwards.

Thanks.

-- 
Dmitry
