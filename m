From: Jarod Wilson <jarod@redhat.com>
Subject: Re: HID: Allow changing not-yet-mapped usages
Date: Wed, 15 Sep 2010 10:36:50 -0400
Message-ID: <20100915143650.GC13030@redhat.com>
References: <20100915045822.GA21672@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26532 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186Ab0IOOg7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 10:36:59 -0400
Content-Disposition: inline
In-Reply-To: <20100915045822.GA21672@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Linux Input <linux-input@vger.kernel.org>, jonno.conder+bugs@gmail.com

On Tue, Sep 14, 2010 at 09:58:22PM -0700, Dmitry Torokhov wrote:
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
> -- 
> Dmitry
> 
> Input: hid-input - allow mapping unknown usages
> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Currently HID layer only allows to remap keycodes for known usages,
> and responds with -EINVAL when user tries to map new usage code.
> This precludes us form relying on udev/keymap for establishing correct
> mappings and forces us to write dummy HID drivers responsible only for
> setting up keymaps.
> 
> Let's allow remapping not only usages that have been set up as keys
> (usage->type == EV_KEY) but also yet-unmapped usages (usage->type == 0).
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Seems like a very good idea to me, code looks sane.

Acked-by: Jarod Wilson <jarod@redhat.com>

-- 
Jarod Wilson
jarod@redhat.com

