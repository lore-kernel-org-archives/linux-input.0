From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] bcm5974: Set BUTTONPAD property
Date: Wed, 11 Jan 2012 11:04:44 +0100
Message-ID: <20120111100444.GA5573@polaris.bitmath.org>
References: <20120110102211.GA7682@polaris.bitmath.org>
 <1326193009-7361-1-git-send-email-jussi.pakkanen@canonical.com>
 <20120110114212.GA2142@polaris.bitmath.org>
 <20120111073812.GB18668@core.coreip.homeip.net>
 <4F0D5521.5030808@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:46722 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757367Ab2AKKFF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 05:05:05 -0500
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 6929AD95D
	for <linux-input@vger.kernel.org>; Wed, 11 Jan 2012 11:05:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F0D5521.5030808@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jussi Pakkanen <jussi.pakkanen@canonical.com>, linux-input@vger.kernel.org

> > Applied, however I removed stable notation as this change IMO does not
> > qualify for the stable since it does not address a regression.
> 
> It's not a regression per-se, but we want to fix buttonpad support, and
> we can't do that without this patch. It's a clear bug that when the
> property was added we did not set the property in the devices that need it.

The current behavior depends on userspace and is not a kernel bug,
please stop the nonsense already.

For bcm5974 devices, extracting buttonpad properties has been possible
since early 2009 (158e9287). The mechanism, predating the input
properties interface by nearly two years, has been used in the
multitouch and mtrack X drivers ever since. To those users, the
present patch has no effect at all.

Henrik
