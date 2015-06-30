From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH][RFC] usbhid: enable autosuspend for internal devices
Date: Tue, 30 Jun 2015 11:21:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1506301103200.1324-100000@iolanthe.rowland.org>
References: <20150627153130.GA19417@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150627153130.GA19417@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Tom Gundersen <teg@jklm.no>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 27 Jun 2015, Greg Kroah-Hartman wrote:

> On Fri, Jun 26, 2015 at 09:20:19PM -0400, Alan Stern wrote:
> > My Apple keyboard isn't here at the moment, and I don't remember
> > exactly what its hub descriptor contains.  In theory, it _should_ mark
> > the permanently attached port as non-removable.
> > 
> > I can test it next week, if you would like to see the actual values.
> 
> That would be great.

Here we go:

# lsusb -v -s 3:4

Bus 003 Device 004: ID 05ac:1002 Apple, Inc. Extended Keyboard Hub [Mitsumi]
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0         8
  idVendor           0x05ac Apple, Inc.
  idProduct          0x1002 Extended Keyboard Hub [Mitsumi]
  bcdDevice            1.22
  iManufacturer           1 Mitsumi Electric
  iProduct                2 Hub in Apple Extended USB Keyboard
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower               50mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             3
  wHubCharacteristic 0x0004
    Ganged power switching
    Compound device
    Ganged overcurrent protection
  bPwrOn2PwrGood       22 * 2 milli seconds
  bHubContrCurrent     50 milli Ampere
  DeviceRemovable    0x02
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
Device Status:     0x0000
  (Bus Powered)

As you can see, the hub descriptor says that the hub is part of a 
compound device.  Port 1 is attached to the internal keyboard 
controller, so it is connected and enabled, whereas the other two ports 
don't have anything plugged in right now.

Most importantly, the DeviceRemovable bitmask is set to 0x02.  Since 
bit 0 is reserved, the bit that is set corresponds to port 1.  It is 
set to indicate that the port is non-removable (i.e., the meaning is 
the opposite of what the name suggests).  And sure enough:

$ cat /sys/bus/usb/devices/3-1.4.1/removable
fixed

(The internal hub is 3-1.4, and the keyboard controller is therefore 
3-1.4.1.)

I don't have any computers with a device permanently attached to an 
xHCI root-hub port.  If someone else does, maybe they can check what 
happens when these two lines:

	if (!(wHubCharacteristics & HUB_CHAR_COMPOUND))
		return;

are deleted from drivers/usb/core/hub.c:set_usb_port_removable().  
Deleting those lines may cause the device to show up as "fixed" rather 
than "removable".

Alan Stern
