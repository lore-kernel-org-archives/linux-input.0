From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] atkbd: Samsung NP530U3C laptop forced key release
Date: Fri, 28 Mar 2014 00:48:41 -0700
Message-ID: <20140328074841.GC22093@core.coreip.homeip.net>
References: <20140311195448.0b722ea5@sambook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:52218 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbaC1Hsp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Mar 2014 03:48:45 -0400
Received: by mail-pb0-f42.google.com with SMTP id rr13so4633233pbb.15
        for <linux-input@vger.kernel.org>; Fri, 28 Mar 2014 00:48:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140311195448.0b722ea5@sambook>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Arkadiusz,

On Tue, Mar 11, 2014 at 07:54:48PM +0100, Arkadiusz Bokowy wrote:
> atkbd: Samsung NP530U3C laptop forced key release
> 
> For Samsung NP530U3C laptop (observed on firmware P09ABH) not all Fn keys
> generates release event, which leaves key in a pressed state. This patch
> adds those keys into the "forced release" workaround. Fixed keys: WLAN,
> Settings, Fn Lock.
> 
> Patch generated for kernel version 3.13.6

This should be done by udev nowadays, please submit patch for it instead
of modifying the kernel.

Thanks!

-- 
Dmitry
