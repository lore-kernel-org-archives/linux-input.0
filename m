From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2] HID: leave dev_rdesc unmodified and use it for
 comparisons
Date: Wed, 19 Sep 2012 20:32:31 +0200
Message-ID: <20120919183231.GA603@polaris.bitmath.org>
References: <50592FB1.7000800@kdau.com>
 <50597CAD.7010801@suse.cz>
 <5059F872.3080203@kdau.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:34949 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208Ab2ISScd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Sep 2012 14:32:33 -0400
Content-Disposition: inline
In-Reply-To: <5059F872.3080203@kdau.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Daughtridge <kevin@kdau.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Kevin,

Thanks for looking to this.

> Hmm. I hadn't noticed that the other drivers are returning a static
> structure. In that case, it seems that report_fixup itself is broken
> from a memory perspective, in that it returns pointers to
> inconsistent storage types depending on the driver.

The driver can either modify the existing buffer, of return a pointer
to a buffer managed by the driver. The former requires a kmemdup
before, the latter a kmemdup after.

> 1. Ugly workaround: make a temporary copy of the dev_rdesc, give it
> to report_fixup, make a copy of the return, store that copy in
> rdesc, free the temporary copy. Though ugly, this would at least
> involve the smallest diff.

Yes, it is correct and ugly, in no particular order.

> 2. Standardize the behavior of the drivers' report_fixup
> implementations. Given that some of them need to change the size of
> the descriptor, modifying the passed structure is not an option.
> Probably all of them should return a newly allocated structure,
> either a modified copy of the input or a copy of their static, that
> can then be stored directly in rdesc. Especially since report_fixup
> is only ever called right before a copy is going to be taken anyway.

Relying on the returned pointer to be properly alloc'd is not a good
idea, in particular since it changes semantics rather drastically.

Since the current function performs two different things, perhaps
there should be two different functions instead.

> (Adding constness to a parameter isn't considered a severe ABI
> break, is it?)

Inside the kernel there is no ABI. Go wild.

Thanks,
Henrik
