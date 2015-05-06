From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 1/6] hid: sony: Prevent the freeing of an unitialized
 ida value
Date: Wed, 6 May 2015 11:24:34 +0200
Message-ID: <20150506092434.GA4508@amd>
References: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
 <1430873253-11765-2-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41307 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbbEFJYm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 May 2015 05:24:42 -0400
Content-Disposition: inline
In-Reply-To: <1430873253-11765-2-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

Hi!

> sony_allocate_output_report() was being called before sony_set_device_id()
> which meant that an unallocated ida value was was freed if the output
> report allocation failed and the probe function jumped to err_stop.
> 
> Do the device ID allocation before the output report allocation to avoid
> freeing an unallocated value in case of a failure.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

The series looks good to me, thanks a lot.

Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
