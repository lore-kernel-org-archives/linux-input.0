From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: add another quirk for Chicony PixArt mouse
Date: Wed, 26 Jun 2019 13:40:47 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1906261340350.27227@cbobk.fhfr.pm>
References: <20190621091736.14503-1-oleksandr@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190621091736.14503-1-oleksandr@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Oleksandr Natalenko <oleksandr@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dave Young <dyoung@redhat.com>, "Herton R . Krzesinski" <herton@redhat.com>, Oliver Neukum <oneukum@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Sebastian Parschauer <s.parschauer@gmx.de>
List-Id: linux-input@vger.kernel.org

On Fri, 21 Jun 2019, Oleksandr Natalenko wrote:

> I've spotted another Chicony PixArt mouse in the wild, which requires
> HID_QUIRK_ALWAYS_POLL quirk, otherwise it disconnects each minute.
> 
> USB ID of this device is 0x04f2:0x0939.
> 
> We've introduced quirks like this for other models before, so lets add
> this mouse too.
> 
> Link: https://github.com/sriemer/fix-linux-mouse#usb-mouse-disconnectsreconnects-every-minute-on-linux
> Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
