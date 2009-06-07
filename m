From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: Apple Bluetooth devices: Battery level?
Date: Sun, 07 Jun 2009 17:52:13 +0200
Message-ID: <1244389933.23850.104.camel@localhost.localdomain>
References: <1244384236.30768.5690.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244384236.30768.5690.camel-MYKcRh6MmTE/Ra3EetS/fF6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Bastien,

> I just got an Apple Bluetooth Mighty Mouse, and was wondering whether
> anyone had information on how to get the battery level from the device
> (the keyboard apparently also allows that):
> http://support.apple.com/kb/TA27118?viewlocale=en_US
> 
> Anyone with an idea? An unparsed HID event? Does it need "poking"?

I think that Apple ones used an actually HID HUT conform descriptor for
that. I did reverser engineered that a long time ago, but then never got
around to do anything with it. Can't find my notes right now. Just run
hcidump and eventually you will see the report.

Regards

Marcel
