From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: usbhid: fix more Mayflash adapters
 (HID_QUIRK_MULTI_INPUT)
Date: Mon, 19 Dec 2016 11:19:53 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1612191119280.19203@cbobk.fhfr.pm>
References: <20161213002305.GA30732@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161213002305.GA30732@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Rodland <andrew@cleverdomain.org>, robert.de.rooy@gmail.com, mahasler@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 12 Dec 2016, Dmitry Torokhov wrote:

> From: Andrew Rodland <andrew@cleverdomain.org>
> 
> Add "Mayflash GameCube Controller Adapter for Wii U and PC USB" and
> "Mayflash PS3 Game Controller Adapter" to the list of devices needing
> HID_QUIRK_MULTI_INPUT. These devices have 4 controller ports, and without
> the quirk they all become one very large joystock device. With the quirk
> they're recognized as 4 separate joysticks.
> 
> Signed-off-by: Andrew Rodland <andrew@cleverdomain.org>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=115841
> [dtor: picked up Andrew's patch, added the PS3 controller data from
>  bugzilla info]
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This is already in as b2554000f5b ("HID: usbhid: Add quirks for 
Mayflash/Dragonrise GameCube and PS3 adapters").

Thanks,

-- 
Jiri Kosina
SUSE Labs
