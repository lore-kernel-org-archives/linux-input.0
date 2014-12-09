From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 2/3] HID: wacom: Initialize MT slots for generic
 devices at post_parse_hid
Date: Tue, 9 Dec 2014 09:00:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412090900120.14413@pobox.suse.cz>
References: <1417815453-10618-1-git-send-email-killertofu@gmail.com> <CAN+gG=E5EfxzKgOBf9wAXrzwq=i8XKNk9d8oSWeQbVGVMojjJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42356 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787AbaLIIAO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Dec 2014 03:00:14 -0500
In-Reply-To: <CAN+gG=E5EfxzKgOBf9wAXrzwq=i8XKNk9d8oSWeQbVGVMojjJQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>

On Fri, 5 Dec 2014, Benjamin Tissoires wrote:

> > If a HID descriptor places HID_DG_CONTACTID before HID_DG_X and HID_DG_Y then
> > the ABS_X and ABS_Y will not be automatically initialized by the call to
> > input_mt_init_slots. To ensure that this is not a problem, we relocate that
> > call to occur after HID parsing has been completed and we've initalized all
> > the multitouch axes.
> >
> > Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> > ---
> 
> This one is
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Benjamin, does your Reviewed-by: apply to both 2/3 and 3/3?

Thanks,

-- 
Jiri Kosina
SUSE Labs
