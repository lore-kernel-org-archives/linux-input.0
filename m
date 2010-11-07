From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ir-core and default IR maps
Date: Sat, 6 Nov 2010 23:01:47 -0700
Message-ID: <20101107060147.GC3823@core.coreip.homeip.net>
References: <AANLkTikfeu4DnV8E7rKahUdu2k_d08BOFZjLzBMRA2o+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54175 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab0KGGBx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Nov 2010 01:01:53 -0500
Received: by pvb32 with SMTP id 32so1052117pvb.19
        for <linux-input@vger.kernel.org>; Sat, 06 Nov 2010 23:01:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikfeu4DnV8E7rKahUdu2k_d08BOFZjLzBMRA2o+@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Mauro Carvalho Chehab <mchehab@redhat.com>, Jarod Wilson <jarod@redhat.com>

On Sat, Nov 06, 2010 at 06:08:57PM -0400, jonsmirl@gmail.com wrote:
> I thought about this some more and I think the default maps should
> stay in the drivers. The maps are marked __init so they don't take any
> room after they are loaded. This is an important piece and plug and
> play and we should keep it. Only the keymaps for default remote
> controls that ship with the specific hardware should be included in
> the driver. All other keymaps are in user space.
> 

Plug and play does not have to be implemented in kernel and udev is
perfectly capable doing it in userspace for us. Embedded products that
absolutely not want to ship udev and want to limit themselves to a
single vendor-supplied remote will have to adjust their startup scripts
to load the proper keymap.

Keymap in the kernel are needed for devices that are required to boot
(keyboards) - and even then it might be only basic keymap, not the full
multimedia goodness with 300+ distinct keys. I am not accepting any new
mappings for AT keyboard driver and I believe both I and Jiri would like
to delete bunch of HID sub-drivers that only do key remapping.

Attempting to keep keymaps in several places will likely cause them to
diverge, makes user confused where changes should be applied and who is
the authoritative source is, that is why it makes sense to remove them
from the kernel.

Thanks.

-- 
Dmitry
