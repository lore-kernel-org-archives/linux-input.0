From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCHv3 0/3] Sixaxis plugin for Bluez
Date: Wed, 08 Jun 2011 15:33:42 +0100
Message-ID: <1307543625.2669.180.camel@novo.hadess.net>
References: <1307538557-9287-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1307538557-9287-1-git-send-email-ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jim Paris <jim-XrPbb/hENzg@public.gmane.org>, Ranulf Doswell <ralf-fD3LYpizeBGsTnJN9+BGXg@public.gmane.org>, "Pascal A . Brisset" <pascal44973-dXI0m6hRz7k@public.gmane.org>, Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Birchinger <joker-vQrvfurPyUjk1uMJSBkQmQ@public.gmane.org>, Filipe Lopes <falktx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, Mikko Virkkila <virkkila-/1wQRMveznE@public.gmane.org>, Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 2011-06-08 at 15:09 +0200, Antonio Ospite wrote:
> 
>   - When the controller is connected via USB the led is set, but then
> it 
>     goes blinking again waiting for the PS button to be pressed,
> maybe 
>     we should wait for the PS button before setting leds, maybe with
> a 
>     simple blocking read() on the hidraw device.

One hard thing to handle is when the device is already in use via USB,
it should automatically connect via Bluetooth when unplugged. I'm not
sure this works right now (I'm a bit hazy on the interaction with the PS
button tbh).

>   - When the controller is connected via USB after it is working over 
>     BT, it is seen as a second controller and the second led it
> turned 
>     on, should we force BT disconnection on USB connection? 

As we can identify the device uniquely through its bdaddr, I'd say yes.
