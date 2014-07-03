From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/2 v5] HID: leds: move led_mode attribute to led-class
 devices in MSI GT683R driver
Date: Thu, 3 Jul 2014 10:28:30 +0200
Message-ID: <20140703082830.GB16590@localhost>
References: <20140701201627.GA30605@localhost>
 <1404322679-19521-1-git-send-email-janne.kanniainen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404322679-19521-1-git-send-email-janne.kanniainen@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Janne Kanniainen <janne.kanniainen@gmail.com>
Cc: johan@kernel.org, cooloney@gmail.com, jkosina@suse.cz, greg@kroah.com, bjorn@mork.no, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 02, 2014 at 08:37:59PM +0300, Janne Kanniainen wrote:
> Move led_mode attribute from HID device to led-class devices. This will also fix race condition by using attribute-groups.
> 
> Signed-off-by: Janne Kanniainen <janne.kanniainen@gmail.com>

Looks good now. Thanks!

Perhaps you can resend both patches as a series (call both v6) so it's
easy to figure which version that is to be applied.

I also noticed that your subject line is a bit long (will end up as the
commit summary). Using for example

	HID: gt683r: move mode attribute to led-class devices

would make it more concise.

Oh, and your commit message lacks line breaks (around 72 cols). You
could fix that as well.

Thanks again,
Johan
