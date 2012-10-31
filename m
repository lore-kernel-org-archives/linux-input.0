From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add support for the MacBook Pro 10,2 keyboard / touchpad
Date: Tue, 30 Oct 2012 22:48:54 -0700
Message-ID: <20121031054854.GA31983@core.coreip.homeip.net>
References: <20121030222211.GA20026@polaris.bitmath.org>
 <13ab3c9f72c.2202.2747.dirk@hohndel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36344 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396Ab2JaFs6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 01:48:58 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so711810pad.19
        for <linux-input@vger.kernel.org>; Tue, 30 Oct 2012 22:48:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <13ab3c9f72c.2202.2747.dirk@hohndel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Hohndel <dirk@hohndel.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Dirk,

On Tue, Oct 30, 2012 at 03:28:08PM -0700, Dirk Hohndel wrote:
> On October 30, 2012 3:22:11 PM "Henrik Rydberg" <rydberg@euromail.se> wrote:
> >Hi Dirk,
> >
> >
> >
> >The entry in hid_mouse_ignore_list seems to be missing.
> 
> Correct. It works fine without that.

Pure luck I think as entries for bcm5974 get sorted before entries for
HID. To be safe and make sure it works if hid is built-in we need to add
the new devices to hid_mouse_ignore_list.

> 
> I'm on my phone but I think there's a comment somewhere that for
> certain multi-touch devices the ignore wasn't needed.

That for devices driven by hid-multitouch, so not applicable to this
case.

> 
> The keyboard definitely needs it, though.
> 
> Let me phrase it this way: the patch, as submitted, happily works on my rMBP 13

By pure luck.

Thanks.

-- 
Dmitry
