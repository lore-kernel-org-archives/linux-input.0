From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: set power sleep before shutdown
Date: Tue, 21 Jun 2016 11:49:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606211148370.6874@cbobk.fhfr.pm>
References: <1466247030-23047-1-git-send-email-ghzhong@yifangdigital.com> <20160620093457.GM24234@mail.corp.redhat.com> <5768EE41.8000900@yifangdigital.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60356 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbcFUJv5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 05:51:57 -0400
In-Reply-To: <5768EE41.8000900@yifangdigital.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ghzhong <ghzhong@yifangdigital.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Dmitry Torokhov <dtor@chromium.org>, Benson Leung <bleung@chromium.org>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 21 Jun 2016, ghzhong wrote:

> > > Some HW design is that the power to i2c hid device won't down
> > > after device shutdown. Also the i2c-hid driver do not send suspend
> > > cmd to the hid i2c device and disable its irq before shutdown.So
> > > if We touch the touchscreen or some other i2c hid device ,the power
> > > consumtion will be go up even when the device is in shutdown state.
> > Wow, that's a new one! Could you tell us which device board is behaving
> > that way (if not under NDA or such)
> Umaro, a chromebook model.

Could you please send me a v2 with updated changelog (specifying the model 
that is known to need this) and the free_irq() change?

Thanks,

-- 
Jiri Kosina
SUSE Labs

