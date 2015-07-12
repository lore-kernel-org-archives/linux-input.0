From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add generic driver for Silead tochscreens
Date: Sat, 11 Jul 2015 23:31:22 -0700
Message-ID: <20150712063122.GB37026@dtor-ws>
References: <55A18959.7050502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36733 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbbGLGb0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jul 2015 02:31:26 -0400
Received: by ieik3 with SMTP id k3so5379178iei.3
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2015 23:31:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55A18959.7050502@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: linux-input@vger.kernel.org

On Sat, Jul 11, 2015 at 11:23:37PM +0200, Gregor Riepl wrote:
> Hello.
> 
> You beat me to it - I noticed the lack of a generic Silead driver that works
> with Baytrail tablets (and ACPI) and started writing one myself, adapting the
> code by Joe Burmeister (https://github.com/jabjoe/sunxi-gslx680). You can find
> my endeavors (so far) here: https://github.com/onitake/gslx680-acpi
> 
> While writing the driver, I noticed that my controller or the firmware (which
> I got from the Windows 8 driver for the tablet) does not seem to support
> finger tracking. If I look at the data packets, almost all of them carry 0 as
> the finger ID, while some carry 4. Lifting a finger simply removes the record,
> without providing a way to correlate it with the next data set.
> 
> The code I worked with seems to support some kind of finger tracking, but it
> still uses the ID field of each touch record as finger ID. And that does not
> work with my touchscreen.
> 
> In the meantime, I just implemented type A multitouch support, leaving the
> finger tracking out.
> 
> Can you help me look into the problem?

Input core does have facilities to perform contact tracking, see
input_mt_assign_slots().

Thanks.

-- 
Dmitry
