From: Jonathan Conder <jonno.conder@gmail.com>
Subject: Re: HID: Allow changing not-yet-mapped usages
Date: Wed, 15 Sep 2010 18:51:11 +1200
Message-ID: <4C906CDF.6030700@gmail.com>
References: <20100915045822.GA21672@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:46987 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab0IOGva (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 02:51:30 -0400
Received: by pxi10 with SMTP id 10so2631644pxi.19
        for <linux-input@vger.kernel.org>; Tue, 14 Sep 2010 23:51:30 -0700 (PDT)
In-Reply-To: <20100915045822.GA21672@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Linux Input <linux-input@vger.kernel.org>

  On 15/09/10 16:58, Dmitry Torokhov wrote:
> Jiri,
>
> Currently HID only allows re-mapping of usages that have already been
> mapped by hid-input or one of the sub-drivers as keys. This,
> unfortunately, leads to sub-drivers multiplying by the hour and many
> of them only do initial setup of usages and waste memory once that is
> done.
>
> How about we also allow EVIOCSKEYCODE to establish mapping for
> not-yet-unmapped usages (usage->type == 0)? Then we could offload the
> task of setting up keymaps to udev.
>
> This depends on the large keycode handling patches that are in my tree
> in 'next' branch. Not tested past booting...
>
This is fine with me, if that matters. However, I'm not sure it could be 
a catch-all solution. For example, the five numbered keys on these 
Microsoft keyboards put the key number in the value field (rather than 
usage->hid). Maybe you could reduce the number of sub-drivers needed by 
using the vendor id alone for at least some of the quirks.

Jonathan
