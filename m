From: Li Yu <raise.sail@gmail.com>
Subject: Re: [PATCH 0/7] usbhid: add load-time and run-time USB HID quirks
 configuration
Date: Wed, 21 Mar 2007 18:14:39 +0800
Message-ID: <4601058F.1070405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Linux Input Mail List <linux-input@atrey.karlin.mff.cuni.cz>, Jiri Kosina <jikos@jikos.cz>
List-Id: linux-input@vger.kernel.org

On Mon, 19 Mar 2007, Jiri Kosina wrote:

>I agree that current quirk handling in usbhid is not the best thing on
>earth and needs improving - this should be acomplished in future by
>converting HID layer to bus.

Hi, Jiri,

I find this mail list just now :D

I am try to make HID busize. Here is the design overview and progress:

--------------------------------------
    HID bus design overview.
--------------------------------------

A. Terms.

    The device of an driver: this mean the device that this driver matched.

B. Design.

    As we discussed before, The entire HID subsystem is divided into
three layers:
   
    1. HID Driver Layer (HIDDL).
       
        This layer is composite of all HID drivers, however, these
drivers are not equal each other, there are divided into three kinds:
       
        1.1 Fundamental driver.
               
        This is the most natural driver for us, they control hardware or
other something that can effect hardware directly. In most cases, each
of this kind driver is one standard and extendible implementation of HID
specification for specific HID transport layer. For example, usbhid.ko
for HID/USB or hidp.ko for Bluetooth/HID. This should alway input-able
driver, i.e, it is able to allow HIDAL register input device for its device.
                   
        1.2 Shadow driver.
       
        These driver is created for those buggy/strange/extended HID
device which fundamental driver can't handle rightly/completely. this
driver does not share HID information with related fundamental driver,
but the HID information of their devices is derived from other device of
fundamental driver. These may not be input-able driver. The shadow
driver does not share the input device with the related fundamental
driver, even shadow driver is input-able, it have new input device in
such case.
       
        1.3 HIDDEV drvier.
       
        In fact, This isn't one public kind of driver. it just is one
optionally flag parameter while register driver (also include shadow
driver). When turn on this feature, the HIDAL will create one hiddev for
each device of driver, so the every such device also have one hiddev buddy.
   
    2. HID Abstract Layer (HIDAL).       
   
        This layer maintain HID bus, HID driver, HID device, HID hiddev
such logical feature, and interact with input subsystem.

    3. HID Transport Layer (HIDTL).

        This layer may be rather thin. Up to now, we should have two
implementation of transport layer, one for USB, one for Bluetooth.

C. Progress.

Status: USB Fundamental driver works for new HID API now.
Working: Shadow driver support.
TODO:
    1. Shadow driver support.
    2. Port some drivers to new HID API, includes:
        1) All HID ff drivers.
        2) iBook/PowerBook special keys driver.
    3. Bluetooth fundamental driver.
    4. Bluetooth transport layer.
    5. Port Other drivers.
    6. HIDDEV/USB driver support.
    7. HIDDEV/Bluetooth driver support.

I think that post this text earlier is better decision, well, I guess
the new controversy about HID may begin ...
 
PS: In my words, the hiddev is same with rawdev, is it right in your words?
    I cann't acquire the support for this from my corporation,  :(  So, I
    must complete this in my spare time, it may take longer time.

Good luck.

- Li Yu
