From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v6] Touchscreen driver for FT5x06 based EDT displays
Date: Tue, 26 Jun 2012 21:17:56 +0200
Message-ID: <20120626191756.GA271@polaris.bitmath.org>
References: <1333564079-23893-2-git-send-email-simon.budig@kernelconcepts.de>
 <1340408898-491-1-git-send-email-simon.budig@kernelconcepts.de>
 <1340408898-491-2-git-send-email-simon.budig@kernelconcepts.de>
 <20120625085113.GA648@polaris.bitmath.org>
 <20120626020600.GD24705@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:33712 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab2FZTOk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jun 2012 15:14:40 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id A4DA4C61D
	for <linux-input@vger.kernel.org>; Tue, 26 Jun 2012 21:14:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120626020600.GD24705@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: simon.budig@kernelconcepts.de, linux-input@vger.kernel.org, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

> Regarding extending input interface - let's talk about what is missing.
> You mentioned memory-mapped access, but I am not sure if it should be
> implemented within current input structure or if it should be a
> completely separate interface. If we implement it we should also make
> sure we stabdardize the data stream and not simply dump raw device
> data, as this would be a sep backwards.

>From a data perspective, what is missing is the notion of a large
collection of values of the same kind. The immediate usecase in mind
is of course a pressure or intensity value, mapped onto a surface. The
current (key, value) event model works in principle, but becomes
increasingly inefficient with increasing collection size. A simple way
of transporting a large collection where values change sparsely is via
a memory-mapped multi-dimensional array.

True, it is not given that such data needs to be incorporated into the
current input structure, and it may be benficial not to do so; the
memory map, be it real or device memory, serves as its own state and
there is no need to keep any other state. However, it seems reasonable
to inherit the input event semantics, since the data to transport is
not new, there are only more data points of the same kind. Other
possibilities exist, of course, such as using descriptors similar to
HID, or a more elaborate sysfs tree, but it does not seem necessary.

Therefore, what I propose initially is a model of an n-dimensional,
memory-mapped array, specififed by a set of input event types. For
example, to formulate a matrix of pressure values in the X-Y plane,
all you need to specify are the three values (ABS_PRESSURE, ABS_X,
ABS_Y), listed in the preferred loop order. The value ranges are given
by the absinfo structs, which also gives the dimension of the array.

The above does not need to be implemented using struct input_dev, it
could be its own machinery, possibly using uio. Since no event drivers
such as evdev are needed, no bus structure is needed either. The files
could simply be exported in a manner quite similar to sysfs nodes.

Thanks,
Henrik
