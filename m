From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] HID: autodetect USB HID sensor hubs.
Date: Wed, 12 Dec 2012 10:42:41 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1212121042100.19767@pobox.suse.cz>
References: <50C47811.7010503@ahsoftware.de> <1355053470-3939-1-git-send-email-holler@ahsoftware.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355053470-3939-1-git-send-email-holler@ahsoftware.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>, srinivas pandruvada <srinivas.pandruvada@intel.com>
List-Id: linux-input@vger.kernel.org

On Sun, 9 Dec 2012, Alexander Holler wrote:

> It should not be necessary to add IDs for HID sensor hubs to lists
> in hid-core.c and hid-sensor-hub.c. So instead of a whitelist,
> autodetect such USB HID sensor hubs, based on a collection of type
> physical inside a useage page of type sensor. If some sensor hubs
> stil must be usable as raw devices, a blacklist might be created.
> 
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>

I like this change and would like to merge it, but I'd appreciate Ack from 
Srinivas first.

Srinivas?

Thanks,

-- 
Jiri Kosina
SUSE Labs
