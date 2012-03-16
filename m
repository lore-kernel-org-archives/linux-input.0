From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [RFC 1/1] HID: User-space I/O driver support for HID subsystem
Date: Fri, 16 Mar 2012 20:01:52 +0100
Message-ID: <CANq1E4T9pYucb=h=UrAwcJCvpy92fNqiOtzkQyL6R81Qz58UeQ@mail.gmail.com>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
	<1331909617-22106-2-git-send-email-dh.herrmann@googlemail.com>
	<CACJA=fVLRuRvvOTkDmuxVckW7oqM_4vk+NCN5fP1WtkGMV-NDw@mail.gmail.com>
	<1331918148.14217.173.camel@aeonflux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34681 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756287Ab2CPTB4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Mar 2012 15:01:56 -0400
In-Reply-To: <1331918148.14217.173.camel@aeonflux>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andre Guedes <andre.guedes@openbossa.org>, linux-input@vger.kernel.org, jkosina@suse.cz, chen.ganir@ti.com, claudio.takahasi@openbossa.org, jprvita@openbossa.org, linux-bluetooth@vger.kernel.org, Vijaykumar.Dadmode@csr.com

Hi Andre

On Fri, Mar 16, 2012 at 6:15 PM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
> Hi Andre,
>
>> > This driver allows to write I/O drivers in user-space and feed the=
 input
>> > into the HID subsystem. It operates on the same level as USB-HID a=
nd
>> > Bluetooth-HID (HIDP). It does not provide support to write special=
 HID
>> > device drivers but rather provides support for user-space I/O devi=
ces to
>> > feed their data into the kernel HID subsystem. The HID subsystem t=
hen
>> > loads the HID device drivers for the device and provides input-dev=
ices
>> > based on the user-space HID I/O device.
>> >
>> > This driver register a new char-device (/dev/uhid). A user-space p=
rocess
>> > has to open this file for each device that it wants to provide to =
the
>> > kernel. It can then use write/read to communicate with the UHID dr=
iver.
>> > Both input and output data is sent with a uhid_event structure. Th=
e "type"
>> > field of the structure specifies what kind of event is sent. There=
 is a
>> > file in Documentation/ explaining the ABI.
>> >
>> > Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
>> > ---
>> > =A0Documentation/hid/uhid.txt | =A0 95 +++++++++
>> > =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0| =A0 21 ++
>> > =A0drivers/hid/Makefile =A0 =A0 =A0 | =A0 =A02 +-
>> > =A0drivers/hid/uhid.c =A0 =A0 =A0 =A0 | =A0502 +++++++++++++++++++=
+++++++++++++++++++++++++
>> > =A0include/linux/uhid.h =A0 =A0 =A0 | =A0 71 +++++++
>> > =A05 files changed, 690 insertions(+), 1 deletion(-)
>> > =A0create mode 100644 Documentation/hid/uhid.txt
>> > =A0create mode 100644 drivers/hid/uhid.c
>> > =A0create mode 100644 include/linux/uhid.h
>> >
>> > diff --git a/Documentation/hid/uhid.txt b/Documentation/hid/uhid.t=
xt
>> > new file mode 100644
>> > index 0000000..67b138d
>> > --- /dev/null
>> > +++ b/Documentation/hid/uhid.txt
>> > @@ -0,0 +1,95 @@
>> > + =A0 =A0 =A0UHID - User-space I/O driver support for HID subsyste=
m
>> > + =A0 =A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > +
>> > +The UHID driver provides an interface for user-space I/O drivers =
to feed their
>> > +data into the HID subsystem. The HID subsystem then parses the HI=
D reports and
>> > +loads the corresponding HID device driver which then provides the=
 parsed data
>> > +via input-devices to user-space.
>> > +
>> > +This allows user-space to operate on the same level as USB-HID, B=
luetooth-HID
>> > +and similar. It does not provide a way to write HID device driver=
s, though! Use
>> > +HIDRAW for this purpose.
>> > +
>> > +UHID dynamically allocates the minor/major number, meaning that y=
ou should rely
>> > +on udev to create the UHID device node. Typically this is created=
 as /dev/uhid.
>> > +
>> > +The UHID API
>> > +------------
>> > +
>> > +For each device that you want to register with the HID core, you =
need to open a
>> > +separate file-descriptor on /dev/uhid. All communication is done =
by read()'ing
>> > +or write()'ing "struct uhid_event" objects to the file. Non-block=
ing operations
>> > +via O_NONBLOCK are supported.
>> > +
>> > +struct uhid_event {
>> > + =A0 =A0 =A0 =A0__u32 type;
>> > + =A0 =A0 =A0 =A0... payload ...
>> > +};
>> > +
>> > +write()
>> > +-------
>> > +write() allows you to modify the state of the device and feed inp=
ut data into
>> > +the kernel. The following types are supported: UHID_CREATE, UHID_=
DESTROY and
>> > +UHID_INPUT.
>> > +
>> > + =A0UHID_CREATE:
>> > + =A0This creates the internal HID device. No I/O is possible unti=
l you send this
>> > + =A0event to the kernel. The payload is of type struct uhid_creat=
e_req and
>> > + =A0contains information about your device.
>> > +
>> > + =A0UHID_DESTROY:
>> > + =A0This destroys the internal HID device. No further I/O will be=
 accepted. There
>> > + =A0may still be pending messages that you can receive with read(=
) but no further
>> > + =A0UHID_INPUT events can be sent to the kernel.
>> > + =A0You can create a new device by sending UHID_CREATE again. The=
re is no need to
>> > + =A0reopen the character device.
>> > +
>> > + =A0UHID_INPUT:
>> > + =A0You must send UHID_CREATE before sending input to the kernel!=
 This event
>> > + =A0contains a data-payload. This is the raw data that you read f=
rom your device.
>> > + =A0The kernel will parse the HID reports and react on it.
>> > +
>> > +read()
>> > +------
>> > +read() will return a queued ouput report. These output reports ca=
n be of type
>> > +UHID_START, UHID_STOP, UHID_OPEN, UHID_CLOSE, UHID_OUTPUT or UHID=
_OUTPUT_EV. No
>> > +reaction is required to any of them but you should handle them ac=
cording to your
>> > +needs. Only UHID_OUTPUT and UHID_OUTPUT_EV have payloads.
>> > +
>> > + =A0UHID_START:
>> > + =A0This is sent when the HID device is started. Consider this as=
 an answer to
>> > + =A0UHID_CREATE. This is always the first event that is sent. No =
I/O is possible
>> > + =A0before you read this.
>> > +
>> > + =A0UHID_STOP:
>> > + =A0This is sent when the HID device is stopped. Consider this as=
 an answer to
>> > + =A0UHID_DESTROY. No further I/O will be possible after receiving=
 this.
>> > + =A0If the kernel HID device driver closes the device manually (t=
hat is, you
>> > + =A0didn't send UHID_DESTROY) then you should consider this devic=
e closed and send
>> > + =A0an UHID_DESTROY event. You may want to reregister your device=
, though.
>> > +
>> > + =A0UHID_OPEN:
>> > + =A0This is sent when the HID device is opened. That is, the data=
 that the HID
>> > + =A0device provides is read by some other process. You may ignore=
 this event but
>> > + =A0it is useful for power-management. As long as you haven't rec=
eived this event
>> > + =A0there is actually no other process that reads your data so th=
ere is no need to
>> > + =A0send UHID_INPUT events to the kernel.
>> > +
>> > + =A0UHID_CLOSE:
>> > + =A0This is sent when there are no more processes which read the =
HID data. It is
>> > + =A0the counterpart of UHID_OPEN and you may as well ignore this =
event.
>> > +
>> > + =A0UHID_OUTPUT:
>> > + =A0This is sent if the HID device driver wants to send raw data =
to the I/O
>> > + =A0device. You should read the payload and forward it to the dev=
ice. The payload
>> > + =A0is of type "struct uhid_data_req".
>> > + =A0This may be received even though you haven't received UHID_OP=
EN, yet.
>> > +
>> > + =A0UHID_OUTPUT_EV:
>> > + =A0Same as UHID_OUTPUT but this contains a "struct input_event" =
as payload. This
>> > + =A0is called for force-feedback, LED or similar events which are=
 received through
>> > + =A0an input device by the HID subsystem. You should convert this=
 into raw reports
>> > + =A0and send them to your device similar to events of type UHID_O=
UTPUT.
>> > +
>> > +Document by:
>> > + =A0David Herrmann <dh.herrmann@googlemail.com>
>>
>> What do you think about using ioctl() to handle creating, destroying
>> and configuring internal hid devices and leave read() and write() to
>> handle HID reports?

I need to notify user-space about START/STOP/OPEN/CLOSE/... signals so =
read()
will always need some event-structure. Therefore, I thought it would be=
 more
consistent if write() would use the same structure. We can also avoid u=
sing
ioctl()'s entirely, they're ugly anyway.

>> This way, at user-space, we wouldn't need to build uhid_event messag=
es
>> for every HID report we get. We would just write() the HID report
>> right away.
>
> we could also just use scatter gather writes and reads. So that is no=
t
> really a problem as long as the "header" has a fixed length.

What is the problem with building uhid_event structures? Is it performa=
nce?
Do you really think one single memcpy() is that important?

If the size of the uhid_event structure is a problem, you should have a=
 look at
the internal handling. You can crop the structure if you want. For even=
ts like
UHID_CREATE you can simply send a single struct { __u16 type; }; object=
=2E You
just need to make sure that if the event-type requires a payload, then
the payload
must be included.
However, I also considered using a pointer instead of the 4096-bytes ar=
ray so we
would avoid that heavy payload for lazy programmers. I am open for sugg=
estions.

> Regards
>
> Marcel

Thanks for review
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
