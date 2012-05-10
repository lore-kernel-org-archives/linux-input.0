From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: [PATCH] HID: wacom: Add LED selector control for Wacom Intuos4
 WL
Date: Thu, 10 May 2012 19:21:19 +0100
Message-ID: <1336674079.5170.1.camel@pldmachine>
References: <1336419611-10372-1-git-send-email-przemo@firszt.eu>
	 <alpine.LNX.2.00.1205101205430.31253@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:34049 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759371Ab2EJSVX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 May 2012 14:21:23 -0400
In-Reply-To: <alpine.LNX.2.00.1205101205430.31253@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: pinglinux@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net

Dnia 2012-05-10, czw o godzinie 12:09 +0200, Jiri Kosina pisze:
> On Mon, 7 May 2012, Przemo Firszt wrote:
> 
> > Add sysfs attribute to control LED selector on Wacom Intuos4. There are 4
[..]
> > +
> > +	for (i = 0; i < 4; ++i) {
> 
> And here as well.
> 
> Otherwise the patch looks fine, and once you fix this, I will apply it. 
> Thanks,
> 
Hi Jiri,
Thanks for catching it! New patch is on the way...
-- 
regards,
Przemo Firszt <przemo@firszt.eu>

