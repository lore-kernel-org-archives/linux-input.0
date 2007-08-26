From: "Alfred E. Heggestad" <aeh@db.org>
Subject: Re: USB: driver for CM109 chipset
Date: Sun, 26 Aug 2007 20:51:03 +0200
Message-ID: <46D1CB97.5030000@db.org>
References: <7f45d9390708252128p48c30b38we59ca2b6496997dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <7f45d9390708252128p48c30b38we59ca2b6496997dd@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Shaun Jackman <sjackman@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Shaun Jackman wrote:
> I am testing your cm109 driver with my Genius G-Talk USB phone. It
> identifies itself as a cm109 device (0d8c:000e C-Media Electronics,
> Inc.). I compiled and loaded the cm109 module. However when I plug the
> phone in the, the usbhid driver grabs the device rather than the cm109
> driver. The following snippet is from /proc/bus/usb/devices and shows
> the Class/Subclass/Protocol 3/0/0 device is nabbed by the usbhid
> driver. Why isn't the cm109 driver grabbing the device?
> 

I have made a new version of the CM109 driver which updates the
usb hid-quirks.c blacklist, please find it here:

   http://aeh.db.org/patch/cm109-20070826.patch

(All versions here: http://aeh.db.org/patch/)


You can also try to unload the usbhid.ko module (while the USB phone
is plugged in), and then manually load the cm109.ko driver

Another outstanding issue with the CM109 driver is that it seems
like all phone vendors have different key-mappings. That means
that the keymapping defined in my version of the cm109 driver
works with the KIP-1000 USB phone. I have got reports from other
users with other phones, that the keymapping is different. It
would be very interesting to see which keymapping your phone
(Genius G-talk) has.

I am not sure how to fix this problem, does anyone on this list
have any good suggestions?


/alfred

> Thanks for writing the driver, and I hope I can get it to work!
> Shaun
> 
> T:  Bus=01 Lev=02 Prnt=02 Port=01 Cnt=02 Dev#=  7 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=0d8c ProdID=000e Rev= 1.00
> S:  Product=Generic USB Audio Device
> C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=snd-usb-audio
> I:* If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
> I:  If#= 1 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
> E:  Ad=01(O) Atr=09(Isoc) MxPS= 200 Ivl=1ms
> I:* If#= 2 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
> I:  If#= 2 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
> E:  Ad=82(I) Atr=05(Isoc) MxPS= 100 Ivl=1ms
> I:* If#= 3 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
> E:  Ad=83(I) Atr=03(Int.) MxPS=   4 Ivl=32ms
