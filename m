From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: usbhid: fix more Mayflash adapters
 (HID_QUIRK_MULTI_INPUT)
Date: Tue, 13 Dec 2016 09:05:27 +0100
Message-ID: <20161213080527.GB13907@mail.corp.redhat.com>
References: <20161213002305.GA30732@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932430AbcLMIFe (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Dec 2016 03:05:34 -0500
Content-Disposition: inline
In-Reply-To: <20161213002305.GA30732@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Andrew Rodland <andrew@cleverdomain.org>, robert.de.rooy@gmail.com, mahasler@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Dec 12 2016 or thereabouts, Dmitry Torokhov wrote:
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
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin
