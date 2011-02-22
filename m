From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] bma023: Support for Bosch BMA023, BMA150 and SMB380
 accelerometers
Date: Tue, 22 Feb 2011 12:25:16 +0000
Message-ID: <20110222122516.532861cb@lxorguk.ukuu.org.uk>
References: <20110214100622.2282.1584.stgit@bob.linux.org.uk>
	<4D62B826.2010201@cam.ac.uk>
	<20110222112958.7802eaea@lxorguk.ukuu.org.uk>
	<4D63A8D4.2070702@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60310 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753462Ab1BVMXr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Feb 2011 07:23:47 -0500
In-Reply-To: <4D63A8D4.2070702@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-input@vger.kernel.org

> However, note that Dmitry has previously blocked merges of drivers into input
> precisely because these sysfs interfaces haven't been defined cleanly (in that
> case the relevant bits were just dropped from the driver in favour of platform
> data). He wants to see something general across all such sensors whatever
> subsystem they are actually in.

Ultimately there is a lot to be said for a common interface, but as you
yourself point out - there isn't actually anything for it to be common
with. In this case some of the user interface side is needed at runtime
so platform interfaces (or hiding ioctls in platform code to hide it from
you ;) ) doesn't help much.

It's up to Dmitry, it would be nice to have it upstream but if it ends up
only in Meego until IIO is stabilised and out of staging then thats less
ideal.

Alan
