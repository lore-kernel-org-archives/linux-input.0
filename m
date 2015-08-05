From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: atmel_mxt_ts - suspend patch and minor fixes
Date: Tue, 4 Aug 2015 17:03:13 -0700
Message-ID: <20150805000313.GC20765@dtor-ws>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36612 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbbHEADR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Aug 2015 20:03:17 -0400
Received: by pdco4 with SMTP id o4so10455914pdc.3
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2015 17:03:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: linux-input@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>

Hi Nick,

On Mon, Aug 03, 2015 at 04:23:08PM +0100, Nick Dyer wrote:
> Hi Dmitry-
> 
> Here is the suspend patch for atmel_mxt_ts, again. I've tested it on Pixel
> 2 today. The code for T7 deep sleep has been widely used for years in our
> github version of the driver.
> 
> Also, several minor (but useful) fixes.
> 
> And I've added myself to MAINTAINERS because checkpatch.

Applied all but 4; 1 & 2 with minor edits.

Thanks.

-- 
Dmitry
