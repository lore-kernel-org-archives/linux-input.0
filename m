From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Status of the plan to set i8042.nomux=1 by default ?
Date: Thu, 11 Sep 2014 10:05:23 -0700
Message-ID: <20140911170523.GB13083@core.coreip.homeip.net>
References: <54109401.4000809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:49530 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaIKRF3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Sep 2014 13:05:29 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq14so7335409pab.39
        for <linux-input@vger.kernel.org>; Thu, 11 Sep 2014 10:05:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <54109401.4000809@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-usb <linux-input@vger.kernel.org>

On Wed, Sep 10, 2014 at 08:10:09PM +0200, Hans de Goede wrote:
> Hi Dmitry,
> 
> I wonder what the status of $subject is ?
> 
> I'm asking because a user joined the discussion here:
> https://bugzilla.kernel.org/show_bug.cgi?id=77391
> 
> And I ended up debugging his problem a bit, and his laptop
> needs i8042.nomux=1 .
> 
> I've asked him for dmi strings for adding a quirk, but as discussed
> a while back, it may be better to just flip the default.

I'll queue your patch for 3.17 and work on flipping the default for 3.18
then.

Thanks.

-- 
Dmitry
