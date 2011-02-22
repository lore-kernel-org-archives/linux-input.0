From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] bma023: Support for Bosch BMA023, BMA150 and SMB380 accelerometers
Date: Tue, 22 Feb 2011 12:38:13 +0000
Message-ID: <4D63AE35.6080005@cam.ac.uk>
References: <20110214100622.2282.1584.stgit@bob.linux.org.uk>	<4D62B826.2010201@cam.ac.uk>	<20110222112958.7802eaea@lxorguk.ukuu.org.uk>	<4D63A8D4.2070702@cam.ac.uk> <20110222122516.532861cb@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:53381 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab1BVMho (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Feb 2011 07:37:44 -0500
In-Reply-To: <20110222122516.532861cb@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org

On 02/22/11 12:25, Alan Cox wrote:
>> However, note that Dmitry has previously blocked merges of drivers into input
>> precisely because these sysfs interfaces haven't been defined cleanly (in that
>> case the relevant bits were just dropped from the driver in favour of platform
>> data). He wants to see something general across all such sensors whatever
>> subsystem they are actually in.
> 
> Ultimately there is a lot to be said for a common interface, but as you
> yourself point out - there isn't actually anything for it to be common
> with. In this case some of the user interface side is needed at runtime
> so platform interfaces (or hiding ioctls in platform code to hide it from
> you ;) ) doesn't help much.
> 
> It's up to Dmitry, it would be nice to have it upstream but if it ends up
> only in Meego until IIO is stabilised and out of staging then thats less
> ideal.
This device looks very much like one that will mainly (if not exclusively)
be used as an input device.  Hence I'd be keener to see it in input than IIO
even if IIO was already out of staging.  Still, intent is to share sysfs
interfaces in as many subsystems as possible, independent of where the
driver actually sits.
