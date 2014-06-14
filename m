From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5] leds: USB: HID: Add support for MSI GT683R led panels
Date: Sun, 15 Jun 2014 00:42:22 +0200
Message-ID: <20140614224222.GE1389@xo-6d-61-c0.localdomain>
References: <20140612090636.GK10256@localhost>
 <1402605252-9620-1-git-send-email-janne.kanniainen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402605252-9620-1-git-send-email-janne.kanniainen@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Janne Kanniainen <janne.kanniainen@gmail.com>
Cc: jkosina@suse.cz, johan@kernel.org, cooloney@gmail.com, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu 2014-06-12 23:34:12, Janne Kanniainen wrote:
> This driver adds support for USB controlled led panels that exists in
> MSI GT683R laptop


Hi!

> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-hid-driver-gt683r
> @@ -0,0 +1,10 @@
> +What:		/sys/class/hidraw/<hidraw>/device/state
> +Date:		Jun 2014
> +KernelVersion:	3.15
> +Contact:	Janne Kanniainen <janne.kanniainen@gmail.com>
> +Description:
> +		Set the mode of LEDs
> +
> +		0 - normal
> +		1 - audio
> +		2 - breathing

THat's some strange interface. Don't we normally use led triggers for this?

And the mode of the LED should really be in /sys/class/leds, not in hidraw somewhere...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
