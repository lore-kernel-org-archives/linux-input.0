From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: udraw: Add support for the uDraw tablet for
 PS3
Date: Tue, 8 Nov 2016 14:23:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611081422170.29400@cbobk.fhfr.pm>
References: <1478274223-3633-1-git-send-email-hadess@hadess.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478274223-3633-1-git-send-email-hadess@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 4 Nov 2016, Bastien Nocera wrote:

> This adds support for the THQ uDraw tablet for the PS3, as
> 4 separate device nodes, so that user-space can easily consume
> events coming from the hardware.
> 
> Note that the touchpad two-finger support is fairly unreliable,
> and a right-click can only be achieved with a two-finger tap
> with the two fingers slightly apart (about 1cm should be enough).
> 
> Tested-by: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Bastien Nocera <hadess@hadess.net>

Hi Bastien,

overall the driver looks ok to me, thanks. Probably the only concern I'd 
have -- traditionally, we've always been naming drivers by the vendor, as 
it turned out that over time they get extended by adding support for 
multiple devices with the same vendor, and usually there is quite some 
overlap in shared code.

Hence I'd propose to call this driver hid-thq (if that's really the 
vendor's proper name, doesn't seem to be present in latest usb.ids 
release).

Thanks,

-- 
Jiri Kosina
SUSE Labs
