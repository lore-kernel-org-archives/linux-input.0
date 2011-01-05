From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC v2 0/10] hid-multitouch: a first step towards multitouch
 unification
Date: Wed, 5 Jan 2011 18:49:27 +0100
Message-ID: <20110105174927.GB2146@polaris.bitmath.org>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:55971 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751626Ab1AERu2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Jan 2011 12:50:28 -0500
Content-Disposition: inline
In-Reply-To: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> these patches is the set for the unified driver hid-multitouch.
> I'm putting the flag RFC as I'm still waiting some testers feedback on some devices. But I don't think they will change a lot.

This will be an interesting read, thank you very much for the patches.

> This would be great if this stuff could go into 2.6.38, if it's not too late.

The merge window just opened, which generally means the work for
2.6.38 is done. On top of that, we would expect some changes and
further testing, and limited time from everybody involved. Given that
also additional drivers should be added, which might affect the
general solution, it seems like a good idea to let this mature over
time, such that it is ready for the 2.6.39 merge window.

Thanks,
Henrik
