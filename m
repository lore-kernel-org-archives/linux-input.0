From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 20:50:03 +0200
Message-ID: <20111012185003.GB10397@polaris.bitmath.org>
References: <20111012135439.GA25266@srcf.ucam.org>
 <Pine.LNX.4.44L0.1110121014550.2093-100000@iolanthe.rowland.org>
 <20111012142621.GA25803@srcf.ucam.org>
 <201110121638.38747.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:58905 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab1JLSnL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 14:43:11 -0400
Received: from iph4.telenor.se (iph4.telenor.se [195.54.127.135])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id E4B58EA3A3
	for <linux-input@vger.kernel.org>; Wed, 12 Oct 2011 20:43:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201110121638.38747.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, Oct 12, 2011 at 04:38:38PM +0200, Oliver Neukum wrote:
> Am Mittwoch, 12. Oktober 2011, 16:26:21 schrieb Matthew Garrett:
> > Sorry, yes, you're right. In that case it's probably working for me 
> > because the keyboard is another interface on the same device, so the 
> > wakeup bit is being set from there.
> 
> Very good. A mystery is solved. Indeed you may have found
> a deficiency in the USB spec.

Glad you sorted this out. So we can really only treat a device as one
(auto)power unit, due to remote wakeup being requested at the device level,
rather than at the interface level.

Thanks,
Henrik
