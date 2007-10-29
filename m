From: "Torsten Kaiser" <just.for.lkml@googlemail.com>
Subject: Re: [RFC: 2.6 patch] remove the USB_STORAGE_ONETOUCH driver
Date: Mon, 29 Oct 2007 08:01:25 +0200
Message-ID: <64bb37e0710282301s1b3db994u83a7ecf4b419bb17@mail.gmail.com>
References: <20071028155212.GC7227@stusta.de>
	 <64bb37e0710281048x589ab063o8a32294e30488979@mail.gmail.com>
	 <Pine.LNX.4.64.0710282134020.18815@twin.jikos.cz>
	 <200710282238.11692.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200710282238.11692.dtor@insightbb.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Jiri Kosina <jikos@jikos.cz>, Adrian Bunk <bunk@kernel.org>, Nick Sillik <n.sillik@temple.edu>, David Brownell <david-b@pacbell.net>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

On 10/29/07, Dmitry Torokhov <dtor@insightbb.com> wrote:
> On Sunday 28 October 2007 16:39, Jiri Kosina wrote:
> > On Sun, 28 Oct 2007, Torsten Kaiser wrote:
> >
> > > But it looks like that uses another driver:
> > > hiddev0hidraw1: USB HID v1.10 Device [Western Digital External HDD] on
> > > usb-0000:00:02.1-5.2
> > > Otherwise I would be willing to try to test this, if someone would tell
> > > me how to check that the second commit did fix the suspend problem.
[snip]
> Maybe onetouch driver is not needed after all. I wonder what key/button does
> HID deriver reports when it binds to it... Torsten, could you please post
> your /proc/bus/input/devices?

I only read the mail from Adrian, because I was 100% sure that my
device is such a Maxtor Onetouch, because it's a external HDD and has
buttons. (I even compiled this driver into my kernel when it was
added...)
But after finding these two git commits and starting to write my
initial mail I looked for the exact name of my device and found that
this is not a Maxtor at all but a Western Digital.
So I'm rather unsure if this driver will work for me...

Anyway here is my /proc/bus/input/devices:
I: Bus=0019 Vendor=0000 Product=0002 Version=0000
N: Name="Power Button (FF)"
P: Phys=LNXPWRBN/button/input0
S: Sysfs=/devices/virtual/input/input0
U: Uniq=
H: Handlers=kbd event0
B: EV=3
B: KEY=10000000000000 0

I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button (CM)"
P: Phys=PNP0C0C/button/input0
S: Sysfs=/devices/virtual/input/input1
U: Uniq=
H: Handlers=kbd event1
B: EV=3
B: KEY=10000000000000 0

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/devices/platform/i8042/serio0/input/input2
U: Uniq=
H: Handlers=kbd event2
B: EV=120013
B: KEY=402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
B: MSC=10
B: LED=7

I: Bus=0010 Vendor=001f Product=0001 Version=0100
N: Name="PC Speaker"
P: Phys=isa0061/input0
S: Sysfs=/devices/platform/pcspkr/input/input3
U: Uniq=
H: Handlers=kbd event3
B: EV=40001
B: SND=6

I: Bus=0003 Vendor=062a Product=0000 Version=0110
N: Name="HID 062a:0000"
P: Phys=usb-0000:00:02.0-9/input0
S: Sysfs=/devices/pci0000:00/0000:00:02.0/usb2/2-9/2-9:1.0/input/input4
U: Uniq=
H: Handlers=mouse0 event4
B: EV=17
B: KEY=70000 0 0 0 0
B: REL=103
B: MSC=10

The button part of the device is visible in sysfs under bus/usb, but
not under class/input:
(There is also a cardreader, a hub and the hdd visible under
/sys/bus/usb/devices/1-5 )

/sys/bus/usb/devices/1-5.2:1.1
|-- driver -> ../../../../../../../bus/usb/drivers/usbhid
|-- ep_81 -> ../../../../../../../devices/pci0000:00/0000:00:02.1/usb1/1-5/1-5.2/1-5.2:1.1/usb_endpoint/usbdev1.5_ep81
|-- subsystem -> ../../../../../../../bus/usb
|-- usb
|   `-- hiddev0
|       |-- device ->
../../../../../../../../../devices/pci0000:00/0000:00:02.1/usb1/1-5/1-5.2/1-5.2:1.1
|       `-- subsystem -> ../../../../../../../../../class/usb
`-- usb_endpoint
    `-- usbdev1.5_ep81
        |-- device ->
../../../../../../../../../devices/pci0000:00/0000:00:02.1/usb1/1-5/1-5.2/1-5.2:1.1
        `-- subsystem -> ../../../../../../../../../class/usb_endpoint

Torsten
