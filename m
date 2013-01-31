From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/5] USB: HID: SRW-S1 Gaming Wheel Driver
Date: Thu, 31 Jan 2013 16:54:16 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301311653090.23853@pobox.suse.cz>
References: <alpine.LNX.2.00.1301291057170.23853@pobox.suse.cz>    <1359644830-3274-1-git-send-email-simon@mungewell.org>    <alpine.LNX.2.00.1301311622430.23853@pobox.suse.cz> <16fadf665c1103c5f3184d9f4471d415.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44983 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342Ab3AaPyY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jan 2013 10:54:24 -0500
In-Reply-To: <16fadf665c1103c5f3184d9f4471d415.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rosegardener@freeode.co.uk

On Thu, 31 Jan 2013, simon@mungewell.org wrote:

> > I thought we converged to hid-steelseries name in the end originally?
> >
> > If you agree, I'll change it and apply.
> 
> I'd be OK with that,

Thanks. I will also apply this patch on top, otherwise we'll be corrupting 
memory in steelseries_srws1_probe() here:

	drv_data->led[SRWS1_NUMBER_LEDS] = led;



From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: steelseries: fix out of bound array access

The last field of the driver_data->leds[] array is used to store the
special toggle for setting all leds simultaneously, so we need to allocate
appropriate number of led_classdev pointers.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-steelseries.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 365bc9e..2ed995c 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -23,7 +23,8 @@
 #define SRWS1_NUMBER_LEDS 15
 struct steelseries_srws1_data {
 	__u16 led_state;
-	struct led_classdev *led[SRWS1_NUMBER_LEDS];
+	/* the last element is used for setting all leds simultaneously */
+	struct led_classdev *led[SRWS1_NUMBER_LEDS + 1];
 };
 #endif
 
-- 
Jiri Kosina
SUSE Labs
