From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Problems with Elantech touchpad in 3.18-rc2
Date: Thu, 30 Oct 2014 11:03:31 -0700
Message-ID: <20141030180331.GF36444@dtor-ws>
References: <545271E1.30306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:39450 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933222AbaJ3SDg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Oct 2014 14:03:36 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so5909717pab.24
        for <linux-input@vger.kernel.org>; Thu, 30 Oct 2014 11:03:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <545271E1.30306@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roel Aaij <roel.aaij@gmail.com>
Cc: linux-input@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Hi Roel,

On Thu, Oct 30, 2014 at 06:14:09PM +0100, Roel Aaij wrote:
> Dear kernel input developers,
> 
> While trying out 3.18-rc2, I noticed that the Elantech touchpad on my
> laptop didn't work as intended anymore. Mouse movement and tapping one
> finger worked, but scrolling and two finger tapping did not. X.org also
> didn't recognise the touchpad as a synaptics touchpad anymore.
> 
> After googling around I found that i8042.nomux=0 brought it back to normal.
> 
> My laptop is a Clevo model W650SH with a keyboard and a touchpad attached,
> and no touchschreen. Some output of dmesg is listed at the bottom, and the
> result of dmidecode is attached.

Argh, so quick search shows that there might be quite a few clones of
W650SH floating around, and I wonder if any of W650SF/W650SJ/W670SJQ/
W650SR/W650SZ exhibit the same behavior.

We might need to revert the nomux back to the original setting, although
I really do not want to do this: in my opinion it is better to have
touchpad revert to basic mode on affected laptops and work on
re-enabling MUX on them instead of having touchpad/keyboard completely
hosed from the get-go.

Linus, any guidance here? Can we live with such regression?

Thanks.

-- 
Dmitry
