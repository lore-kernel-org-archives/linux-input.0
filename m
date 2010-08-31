From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 4/6] HID: magicmouse: remove axis data filtering
Date: Tue, 31 Aug 2010 13:57:25 -0400
Message-ID: <1283277445.2255.66.camel@mini>
References: <1283188858-4839-1-git-send-email-chase.douglas@canonical.com>
	 <1283188858-4839-4-git-send-email-chase.douglas@canonical.com>
	 <1283227160.14419.53.camel@graviton>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:50748 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab0HaR53 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 13:57:29 -0400
In-Reply-To: <1283227160.14419.53.camel@graviton>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Mon, 2010-08-30 at 23:59 -0400, Michael Poole wrote:
> On Mon, 2010-08-30 at 13:20 -0400, Chase Douglas wrote:
> > The Magic Mouse device is very precise. No driver filtering of input
> > data needs to be performed.
> > 
> > Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> 
> Acked-by: Michael Poole <mdpoole@troilus.org>
> 
> My original rationale for the fuzz setting was that the device is so
> precise that it tends to spam applications, but that is probably too
> policy-like for the kernel to enforce.

This driver should be converted to the new slotted MT protocol as well,
which will reduce the amount of data sent for each event. Hopefully I
can get to that at some point in the near future, if no one beats me to
it :).

Thanks,

-- Chase

