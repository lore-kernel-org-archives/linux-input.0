From: Nick Dyer <nick@shmanahar.org>
Subject: Re: [PATCH 14/14] Input: atmel_mxt_ts - remove platform data support
Date: Fri, 16 Mar 2018 20:41:41 +0000
Message-ID: <20180316204141.GB24333@bm.shmanahar.org>
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
 <20180312190907.174301-15-dmitry.torokhov@gmail.com>
 <20180314205938.GD26353@lava.h.shmanahar.org>
 <20180316000614.GB60361@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180316000614.GB60361@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Mar 15, 2018 at 05:06:14PM -0700, Dmitry Torokhov wrote:
> On Wed, Mar 14, 2018 at 08:59:38PM +0000, Nick Dyer wrote:
> > On Mon, Mar 12, 2018 at 12:09:07PM -0700, Dmitry Torokhov wrote:
> > > -	/*
> > > -	 * Ignore ACPI devices representing bootloader mode.
> > > -	 *
> > > -	 * This is a bit of a hack: Google Chromebook BIOS creates ACPI
> > > -	 * devices for both application and bootloader modes, but we are
> > > -	 * interested in application mode only (if device is in bootloader
> > > -	 * mode we'll end up switching into application anyway). So far
> > > -	 * application mode addresses were all above 0x40, so we'll use it
> > > -	 * as a threshold.
> > > -	 */
> > > -	if (client->addr < 0x40)
> > > -		return -ENXIO;
> > 
> > Could you use 0x4a, since that's the lowest application mode address,
> > same in the other place.
> 
> OK, this is existing code though, so I'll make a separate patch.

Ah, I see now. In which case it's no big deal.

Acked-by: Nick Dyer <nick@shmanahar.org>
