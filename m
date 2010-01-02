From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: driver for BTC "Emprex 3009URF III Vista MCE
 Remote" quirky remote
Date: Fri, 1 Jan 2010 18:53:12 -0800
Message-ID: <20100102025312.GC5788@core.coreip.homeip.net>
References: <3711715e0912310013u25e921cbqe6abb7c1621109e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:33603 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab0ABCxR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Jan 2010 21:53:17 -0500
Content-Disposition: inline
In-Reply-To: <3711715e0912310013u25e921cbqe6abb7c1621109e@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wayne Thomas <waynethomas69@gmail.com>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Wayne,

On Thu, Dec 31, 2009 at 09:13:22AM +0100, Wayne Thomas wrote:
> HID: driver for BTC "Emprex 3009URF III Vista MCE Remote" quirky remote
> 
> The Behavior Tech. Computer Corp. (BTC) remote branded as "Emprex 3009URF III
> Vista Remote Controller" uses non-standard mappings for all of its 'special
> purpose' keys (0xffbc usage page).  Applies cleanly to 2.6.30 and 2.6.32
> (other versions not tested).
> scripts/scriptpatch.pl reports 13 styling errors in hid-btc.c
> ("break;" should be on trailing lines)
> but have not changed them to maintain styling consistency with existing drivers.
> 

I believe that this kind of mapping adjustment can be done via UDEV/HAL
key remapping facilities, without need for the kernel patch.

Thanks.

-- 
Dmitry
