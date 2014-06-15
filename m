From: Janne Kanniainen <janne.kanniainen@gmail.com>
Subject: Re: [PATCH v5] leds: USB: HID: Add support for MSI GT683R led panels
Date: Sun, 15 Jun 2014 17:59:40 +0300
Message-ID: <CAEEjW06FJta+csEevj+AT_uUfRTwQe3TgVBErJmjygpPbgE__w@mail.gmail.com>
References: <20140612090636.GK10256@localhost>
	<1402605252-9620-1-git-send-email-janne.kanniainen@gmail.com>
	<20140613075411.GG10940@localhost>
	<CAEEjW05PL7ZqnKypCYP4SP9hzKeDii=GouHLJ2u5xtR0yCTO2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <CAEEjW05PL7ZqnKypCYP4SP9hzKeDii=GouHLJ2u5xtR0yCTO2w@mail.gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Bryan Wu <cooloney@gmail.com>, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

>> Ok, so you decided to continue setting mode on every LED brightness
>> update. That should be fine, but you never answered my question about
>> whether it is necessary?
>
> I decided to do it that way because official driver did it as well. I
> can check if it is necessary.

Ok, I checked this one and every time you update LEDs brightness you
will need to update mode also.
