From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/8] HID: sony: DS4 updates
Date: Mon, 28 Nov 2016 14:56:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611281455330.29400@cbobk.fhfr.pm>
References: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41181 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932283AbcK1N44 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 08:56:56 -0500
In-Reply-To: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Wed, 23 Nov 2016, Roderick Colenbrander wrote:

> I would like to share various updates to the DS4 driver. The first
> 4 patches are bug fixes and improvements discussed in various
> discussions on linux-input:
> - Fix issue when mixing USB and Bluetooth due to failure behind
>   the scens in sony_input_configured. Benjamin suggested the
>   fix we added.
> - The touchpad is a separate device to avoid touch influencing
>   the analog sticks, which happened due to use of input_mt_sync.
> - The DS4 code now complies to the Linux game controller spec.
>   We work with SDL2, the biggest DS4 user, to make sure it can
>   handle the different mappings. If desired we could make the DS3
>   comply as well and make similar changes.
> - Make DS4 motion sensors a separate device, so applications
>   don't have to use 'non-existing' axes. Updated the event code
>   specs to allow gyroscope data when INPUT_PROP_ACCELEROMETER is
>   set as suggested by Peter Hutterer.
> 
> The next 2 patches add the unique ID to the USB device and add
> support for a new DS4 device.
> 
> The last 2 patches add calibration and timestamp to the motion
> sensors, which finally makes the motion sensors usable.
> 
> As part of the changes we started to wonder if we should drop
> HID report fixups altogether for the DS4. It is used right now
> to have the hid-core layer be able to handle events for the
> 'misbehaving' report ID 17. I'm aware though of various cross
> platform libraries parsing DS4 HID reports, which are seeing
> inconsistent views per OS. Not sure what we should do, we could
> change this in a future patch. We would need to manually report
> buttons / axes when on Bluetooth for report ID 17.

I've now applied patches 1-3 to for-4.10/sony. For the rest, I'd like to 
still see the discussion of proper interface to take place.

Thanks,

-- 
Jiri Kosina
SUSE Labs

