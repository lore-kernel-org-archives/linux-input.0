From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 0/3] hid: Enable report fixup on rebind
Date: Mon, 30 Apr 2012 14:06:41 +0200
Message-ID: <20120430120641.GA3111@polaris.bitmath.org>
References: <1335097300-11881-1-git-send-email-rydberg@euromail.se>
 <alpine.LNX.2.00.1204222325380.1856@pobox.suse.cz>
 <4F9D5F43.4000502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:52260 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849Ab2D3MCW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 08:02:22 -0400
Content-Disposition: inline
In-Reply-To: <4F9D5F43.4000502@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Nikolai,

> >>The first two patches are bug fixes found in the process. I am hoping
> >>for some test feedback on those. The third patch is the main one.
> 
> I've tested the last patch and it seems to work as required. I did a series
> of generic<->specific driver rebindings both ways in a loop and it works.
> 
> So,
> Tested-by: Nikolai Kondrashov <spbnick@gmail.com>

Great, thanks!

> I'm not sure, though, if one thing works as it should: the quirks are not
> reset when changing the driver. So, quirks set by one driver may affect
> behavior of another. I don't understand full quirks usage and ownership yet,
> so can't argue if this is right or wrong.

The common quirks are a device property, so this is fine. There are
some drivers with quirks too, but they handle those themselves.

> Regarding the code, could it be the time to fix naming of report
> descriptor-handling functions to improve distinction from report-handling
> ones? I'm attaching a patch applying on top of Henrik's changes which should
> illustrate the proposal.

The changes you propose force changes to out-of-tree-drivers, without
any obvious benefit. Also, there is already a large set of patches on
review based on this one. So although I agree that some renames and
movements could clarify things, the content and timing will need some
more thought.

Thanks,
Henrik
