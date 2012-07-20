From: "Henrik Rydberg" <rydberg@bitmath.se>
Subject: Re: [PATCH] HID: Make the HID bus visible in the Kconfig options
Date: Fri, 20 Jul 2012 14:20:49 +0200
Message-ID: <20120720122049.GA1199@polaris.bitmath.org>
References: <1340356731-4745-1-git-send-email-rydberg@euromail.se>
 <alpine.LNX.2.00.1207201337570.21929@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp2.one.com ([91.198.169.22]:29711 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188Ab2GTMTl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jul 2012 08:19:41 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1207201337570.21929@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

> > The HID subsystem was made a proper bus in 2008, but the config
> > options do not reflect this. Modify the HID and USB_HID entries
> > to better explain what they do.
> > 
> > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> > ---
> > Hi Jiri,
> > 
> > As the HID subsystem moves more and more towards a regular bus, the
> > config options become less and less apt. This patch, for next, only
> > scratches the surface but hopefully in the right direction.
> 
> Applied, thank you Henrik.

This patch has actually been applied already, we added it to the patch
for 3.5.

Thanks,
Henrik
