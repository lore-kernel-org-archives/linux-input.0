From: Janne Kanniainen <janne.kanniainen@gmail.com>
Subject: Re: [PATCH v5] leds: USB: HID: Add support for MSI GT683R led panels
Date: Fri, 13 Jun 2014 20:19:26 +0300
Message-ID: <CAEEjW05PL7ZqnKypCYP4SP9hzKeDii=GouHLJ2u5xtR0yCTO2w@mail.gmail.com>
References: <20140612090636.GK10256@localhost>
	<1402605252-9620-1-git-send-email-janne.kanniainen@gmail.com>
	<20140613075411.GG10940@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140613075411.GG10940@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Bryan Wu <cooloney@gmail.com>, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> Ok, so you decided to continue setting mode on every LED brightness
> update. That should be fine, but you never answered my question about
> whether it is necessary?

I decided to do it that way because official driver did it as well. I
can check if it is necessary.

> You're almost done. One last update? :)

Yeah, I hope so :)
