From: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: appletouch quirk doesn't run at resume
Date: Wed, 28 Mar 2007 18:51:52 +0200
Message-ID: <460A9D28.5050703@m3y3r.de>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>	 <1174078066.13341.279.camel@localhost.localdomain>	 <1174087552.13341.332.camel@localhost.localdomain>	 <45FBBDEA.9060708@m3y3r.de> <20070318004240.GO752@stusta.de>	 <Pine.LNX.4.64.0703181934530.4195@jikos.suse.cz>	 <45FD8CA3.10405@m3y3r.de>	 <Pine.LNX.4.64.0703182020070.4195@jikos.suse.cz>	 <4609866C.4060602@m3y3r.de>	 <Pine.LNX.4.64.0703281414410.29565@twin.jikos.cz> <d120d5000703280624q62c26ffbs80e31d557bf3c72b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000703280624q62c26ffbs80e31d557bf3c72b@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@jikos.cz>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Soeren Sonnenburg <kernel@nn7.de>, linux-input@atrey.karlin.mff.cuni.cz, Peter Osterlund <petero2@telia.com>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov schrieb:
> On 3/28/07, Jiri Kosina <jikos@jikos.cz> wrote:
>> On Tue, 27 Mar 2007, Thomas Meyer wrote:
>>
>> > It seems, that after the resume all usb devices gets removed and
>> plug in
>> > again (virtually!). This results in a new input device name:
>>
>> Yes, this is what actually happens. JFYI see current thread on lkml
>> which
>> is a bit realted - http://lkml.org/lkml/2007/3/27/149 if interested.
>>
>> > This change confuses the X synaptics driver:
>> > Touchpad no synaptics event device found (checked 11 nodes)
>> > Touchpad The /dev/input/event* device nodes seem to be missing
>> > (EE) xf86OpenSerial: Cannot open device /dev/input/event2
>> >         No such file or directory.
>> > (WW) Touchpad: cannot open input device
>> > One could say that the synaptics driver rightly complains about the
>> > missing event2 device! So is this a bug in the X synaptics driver?
>>
>> You can of course work this around by adding an udev rule such as
>>
>> SUBSYSTEM=="input",KERNEL=="event*",SYSFS{name}=="appletouch",SYMLINK+="input/appletouchpad"
>>
>>
>> and the let Xorg use /dev/input/appletouchpad, which will always be a
>> symlink to the correct device.
>>
This was my first idea, too. But then i found this entry in the
Changelog of the synaptics driver:

- In the DeviceOn() function, if opening the device node fails, try to
  auto-detect the correct event device again. This fixes some problems
  which occur after a suspend/resume cycle or after rmmod/insmod-ing
  the psmouse kernel driver.

>
> I am not sure if this would help... According to the excerpt from X
> log synaptics driver attempted to scan evdev devices and locate the
> touchpad. However if this scan happen before udev had a chance to
> process the event and create new /dev/input/eventX device node it will
> fail.
Okay. This strengthens above statement. And udev is too slow to create
the devices, while the driver already scanned the directory.
>
> I wonder if we should adjust the X driver to spin for a couple of
> seconds in EventAutoDevProbe if the touchpad was already seen once...
> Peter?
>
