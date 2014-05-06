From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] elantech: Fix elantech on Gigabyte U2442
Date: Mon, 5 May 2014 21:18:49 -0700
Message-ID: <20140506041849.GB32144@core.coreip.homeip.net>
References: <1399293293-32482-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399293293-32482-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, Philipp Wolfer <ph.wolfer@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, May 05, 2014 at 02:34:53PM +0200, Hans de Goede wrote:
> The hw_version 3 elantech touchpad on the Gigabyte U2442 does not accept
> 0x0b as initialization value for r10, this stand-alone version of the driver:
> http://planet76.com/drivers/elantech/psmouse-elantech-v6.tar.bz2
> 
> Uses 0x03 which does work, so this means not setting bit 3 of r10 which sets:
> "Enable Real H/W Resolution In Absolute mode"
> 
> Which will result in half the x and y resolution we get with that bit set,
> so simply not setting it everywhere is not a solution. We've been unable
> to find a way to identifty touchpads where setting the bit will fail, so this
> patch uses a dmi based blacklist for this.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=61151
> 
> Cc: stable@vger.kernel.org
> Reported-by: Philipp Wolfer <ph.wolfer@gmail.com>
> Tested-by: Philipp Wolfer <ph.wolfer@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

-- 
Dmitry
