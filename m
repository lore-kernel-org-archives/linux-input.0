From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: HID: Allow changing not-yet-mapped usages
Date: Wed, 15 Sep 2010 00:03:57 -0700
Message-ID: <20100915070356.GA28309@core.coreip.homeip.net>
References: <20100915045822.GA21672@core.coreip.homeip.net>
 <4C906CDF.6030700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48937 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab0IOHED (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 03:04:03 -0400
Received: by pwi3 with SMTP id 3so55616pwi.19
        for <linux-input@vger.kernel.org>; Wed, 15 Sep 2010 00:04:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C906CDF.6030700@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Conder <jonno.conder@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Linux Input <linux-input@vger.kernel.org>

On Wed, Sep 15, 2010 at 06:51:11PM +1200, Jonathan Conder wrote:
>  On 15/09/10 16:58, Dmitry Torokhov wrote:
> >Jiri,
> >
> >Currently HID only allows re-mapping of usages that have already been
> >mapped by hid-input or one of the sub-drivers as keys. This,
> >unfortunately, leads to sub-drivers multiplying by the hour and many
> >of them only do initial setup of usages and waste memory once that is
> >done.
> >
> >How about we also allow EVIOCSKEYCODE to establish mapping for
> >not-yet-unmapped usages (usage->type == 0)? Then we could offload the
> >task of setting up keymaps to udev.
> >
> >This depends on the large keycode handling patches that are in my tree
> >in 'next' branch. Not tested past booting...
> >
> This is fine with me, if that matters. However, I'm not sure it
> could be a catch-all solution. For example, the five numbered keys
> on these Microsoft keyboards put the key number in the value field
> (rather than usage->hid). Maybe you could reduce the number of
> sub-drivers needed by using the vendor id alone for at least some of
> the quirks.
> 

Yeah, it obviously won't cover every "interesting" way vendors come up
with... Still should cover some.

-- 
Dmitry
