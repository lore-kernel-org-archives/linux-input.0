From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Support telephony devices
Date: Fri, 5 Aug 2016 13:43:07 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1608051342360.22028@cbobk.fhfr.pm>
References: <1470214307-29441-1-git-send-email-nolsen@jabra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40171 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161147AbcHELnJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 5 Aug 2016 07:43:09 -0400
In-Reply-To: <1470214307-29441-1-git-send-email-nolsen@jabra.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Niels Skou Olsen <nolsen@jabra.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com

On Wed, 3 Aug 2016, nolsen@jabra.com wrote:

> From: Niels Skou Olsen <nolsen@jabra.com>
> 
> Add support for telephony device buttons and LEDs as described in the USB
> HID Usage Tables specification.
> 
> This allows user mode applications convenient access to telephony devices
> such as headsets, speaker phones and desk phones.
> 
> Signed-off-by: Niels Skou Olsen <nolsen@jabra.com>
> ---
>  drivers/hid/hid-debug.c                | 39 ++++++++++++++++++++-
>  drivers/hid/hid-input.c                | 63 +++++++++++++++++++++++++++++++---
>  drivers/input/input-leds.c             |  5 +++
>  include/linux/hid.h                    |  8 ++++-
>  include/linux/mod_devicetable.h        |  2 +-
>  include/uapi/linux/input-event-codes.h | 18 +++++++++-

I'd like (at least) the input-event-codes.h be acked by Dmitry. Dmitry, 
please?

Thanks,

-- 
Jiri Kosina
SUSE Labs

