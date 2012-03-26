From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [RFC 1/1] HID: User-space I/O driver support for HID subsystem
Date: Mon, 26 Mar 2012 19:38:50 +0200
Message-ID: <CANq1E4Qbf_nOczz5KGupxa=AUzNB8gJKLuyoUiU6TX-w6WN7OA@mail.gmail.com>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
	<1331909617-22106-2-git-send-email-dh.herrmann@googlemail.com>
	<CACJA=fVLRuRvvOTkDmuxVckW7oqM_4vk+NCN5fP1WtkGMV-NDw@mail.gmail.com>
	<1331918148.14217.173.camel@aeonflux>
	<CANq1E4T9pYucb=h=UrAwcJCvpy92fNqiOtzkQyL6R81Qz58UeQ@mail.gmail.com>
	<1331930743.14217.187.camel@aeonflux>
	<20120316233857.GA23369@samus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37340 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933122Ab2CZRiw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Mar 2012 13:38:52 -0400
In-Reply-To: <20120316233857.GA23369@samus>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Andre Guedes <andre.guedes@openbossa.org>, linux-input@vger.kernel.org, jkosina@suse.cz, chen.ganir@ti.com, claudio.takahasi@openbossa.org, jprvita@openbossa.org, linux-bluetooth@vger.kernel.org, Vijaykumar.Dadmode@csr.com

Hi

On Sat, Mar 17, 2012 at 12:38 AM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Marcel,
>
> On 13:45 Fri 16 Mar, Marcel Holtmann wrote:
>> Hi David,
>>
>> > >> > This driver allows to write I/O drivers in user-space and fee=
d the input
>> > >> > into the HID subsystem. It operates on the same level as USB-=
HID and
>> > >> > Bluetooth-HID (HIDP). It does not provide support to write sp=
ecial HID
>> > >> > device drivers but rather provides support for user-space I/O=
 devices to
>> > >> > feed their data into the kernel HID subsystem. The HID subsys=
tem then
>> > >> > loads the HID device drivers for the device and provides inpu=
t-devices
>> > >> > based on the user-space HID I/O device.
>> > >> >
>> > >> > This driver register a new char-device (/dev/uhid). A user-sp=
ace process
>> > >> > has to open this file for each device that it wants to provid=
e to the
>> > >> > kernel. It can then use write/read to communicate with the UH=
ID driver.
>> > >> > Both input and output data is sent with a uhid_event structur=
e. The "type"
>> > >> > field of the structure specifies what kind of event is sent. =
There is a
>> > >> > file in Documentation/ explaining the ABI.
>> > >> >
>> > >> > Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
>> > >> > ---
>> > >> > =A0Documentation/hid/uhid.txt | =A0 95 +++++++++
>> > >> > =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0| =A0 21 ++
>> > >> > =A0drivers/hid/Makefile =A0 =A0 =A0 | =A0 =A02 +-
>> > >> > =A0drivers/hid/uhid.c =A0 =A0 =A0 =A0 | =A0502 ++++++++++++++=
++++++++++++++++++++++++++++++
>> > >> > =A0include/linux/uhid.h =A0 =A0 =A0 | =A0 71 +++++++
>> > >> > =A05 files changed, 690 insertions(+), 1 deletion(-)
>> > >> > =A0create mode 100644 Documentation/hid/uhid.txt
>> > >> > =A0create mode 100644 drivers/hid/uhid.c
>> > >> > =A0create mode 100644 include/linux/uhid.h
>> > >> >
>> > >> > diff --git a/Documentation/hid/uhid.txt b/Documentation/hid/u=
hid.txt
>> > >> > new file mode 100644
>> > >> > index 0000000..67b138d
>> > >> > --- /dev/null
>> > >> > +++ b/Documentation/hid/uhid.txt
>> > >> > @@ -0,0 +1,95 @@
>> > >> > + =A0 =A0 =A0UHID - User-space I/O driver support for HID sub=
system
>> > >> > + =A0 =A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >> > +
>> > >> > +The UHID driver provides an interface for user-space I/O dri=
vers to feed their
>> > >> > +data into the HID subsystem. The HID subsystem then parses t=
he HID reports and
>> > >> > +loads the corresponding HID device driver which then provide=
s the parsed data
>> > >> > +via input-devices to user-space.
>> > >> > +
>> > >> > +This allows user-space to operate on the same level as USB-H=
ID, Bluetooth-HID
>> > >> > +and similar. It does not provide a way to write HID device d=
rivers, though! Use
>> > >> > +HIDRAW for this purpose.
>> > >> > +
>> > >> > +UHID dynamically allocates the minor/major number, meaning t=
hat you should rely
>> > >> > +on udev to create the UHID device node. Typically this is cr=
eated as /dev/uhid.
>> > >> > +
>> > >> > +The UHID API
>> > >> > +------------
>> > >> > +
>> > >> > +For each device that you want to register with the HID core,=
 you need to open a
>> > >> > +separate file-descriptor on /dev/uhid. All communication is =
done by read()'ing
>> > >> > +or write()'ing "struct uhid_event" objects to the file. Non-=
blocking operations
>> > >> > +via O_NONBLOCK are supported.
>> > >> > +
>> > >> > +struct uhid_event {
>> > >> > + =A0 =A0 =A0 =A0__u32 type;
>> > >> > + =A0 =A0 =A0 =A0... payload ...
>> > >> > +};
>> > >> > +
>> > >> > +write()
>> > >> > +-------
>> > >> > +write() allows you to modify the state of the device and fee=
d input data into
>> > >> > +the kernel. The following types are supported: UHID_CREATE, =
UHID_DESTROY and
>> > >> > +UHID_INPUT.
>> > >> > +
>> > >> > + =A0UHID_CREATE:
>> > >> > + =A0This creates the internal HID device. No I/O is possible=
 until you send this
>> > >> > + =A0event to the kernel. The payload is of type struct uhid_=
create_req and
>> > >> > + =A0contains information about your device.
>> > >> > +
>> > >> > + =A0UHID_DESTROY:
>> > >> > + =A0This destroys the internal HID device. No further I/O wi=
ll be accepted. There
>> > >> > + =A0may still be pending messages that you can receive with =
read() but no further
>> > >> > + =A0UHID_INPUT events can be sent to the kernel.
>> > >> > + =A0You can create a new device by sending UHID_CREATE again=
=2E There is no need to
>> > >> > + =A0reopen the character device.
>> > >> > +
>> > >> > + =A0UHID_INPUT:
>> > >> > + =A0You must send UHID_CREATE before sending input to the ke=
rnel! This event
>> > >> > + =A0contains a data-payload. This is the raw data that you r=
ead from your device.
>> > >> > + =A0The kernel will parse the HID reports and react on it.
>> > >> > +
>> > >> > +read()
>> > >> > +------
>> > >> > +read() will return a queued ouput report. These output repor=
ts can be of type
>> > >> > +UHID_START, UHID_STOP, UHID_OPEN, UHID_CLOSE, UHID_OUTPUT or=
 UHID_OUTPUT_EV. No
>> > >> > +reaction is required to any of them but you should handle th=
em according to your
>> > >> > +needs. Only UHID_OUTPUT and UHID_OUTPUT_EV have payloads.
>> > >> > +
>> > >> > + =A0UHID_START:
>> > >> > + =A0This is sent when the HID device is started. Consider th=
is as an answer to
>> > >> > + =A0UHID_CREATE. This is always the first event that is sent=
=2E No I/O is possible
>> > >> > + =A0before you read this.
>> > >> > +
>> > >> > + =A0UHID_STOP:
>> > >> > + =A0This is sent when the HID device is stopped. Consider th=
is as an answer to
>> > >> > + =A0UHID_DESTROY. No further I/O will be possible after rece=
iving this.
>> > >> > + =A0If the kernel HID device driver closes the device manual=
ly (that is, you
>> > >> > + =A0didn't send UHID_DESTROY) then you should consider this =
device closed and send
>> > >> > + =A0an UHID_DESTROY event. You may want to reregister your d=
evice, though.
>> > >> > +
>> > >> > + =A0UHID_OPEN:
>> > >> > + =A0This is sent when the HID device is opened. That is, the=
 data that the HID
>> > >> > + =A0device provides is read by some other process. You may i=
gnore this event but
>> > >> > + =A0it is useful for power-management. As long as you haven'=
t received this event
>> > >> > + =A0there is actually no other process that reads your data =
so there is no need to
>> > >> > + =A0send UHID_INPUT events to the kernel.
>> > >> > +
>> > >> > + =A0UHID_CLOSE:
>> > >> > + =A0This is sent when there are no more processes which read=
 the HID data. It is
>> > >> > + =A0the counterpart of UHID_OPEN and you may as well ignore =
this event.
>> > >> > +
>> > >> > + =A0UHID_OUTPUT:
>> > >> > + =A0This is sent if the HID device driver wants to send raw =
data to the I/O
>> > >> > + =A0device. You should read the payload and forward it to th=
e device. The payload
>> > >> > + =A0is of type "struct uhid_data_req".
>> > >> > + =A0This may be received even though you haven't received UH=
ID_OPEN, yet.
>> > >> > +
>> > >> > + =A0UHID_OUTPUT_EV:
>> > >> > + =A0Same as UHID_OUTPUT but this contains a "struct input_ev=
ent" as payload. This
>> > >> > + =A0is called for force-feedback, LED or similar events whic=
h are received through
>> > >> > + =A0an input device by the HID subsystem. You should convert=
 this into raw reports
>> > >> > + =A0and send them to your device similar to events of type U=
HID_OUTPUT.
>> > >> > +
>> > >> > +Document by:
>> > >> > + =A0David Herrmann <dh.herrmann@googlemail.com>
>> > >>
>> > >> What do you think about using ioctl() to handle creating, destr=
oying
>> > >> and configuring internal hid devices and leave read() and write=
() to
>> > >> handle HID reports?
>> >
>> > I need to notify user-space about START/STOP/OPEN/CLOSE/... signal=
s so read()
>> > will always need some event-structure. Therefore, I thought it wou=
ld be more
>> > consistent if write() would use the same structure. We can also av=
oid using
>> > ioctl()'s entirely, they're ugly anyway.
>>
>> I like it this way. Just make sure the header is fixed length all th=
e
>> time and we only give one header + data per read() / write().
>>
>> That way we can nicely use scatter gather and avoid complex data cop=
y in
>> userspace for report data.
>>
>> We still have to do some measurement with the latency, but we might =
just
>> even run HIDP in userspace in the end.
>>
>> > >> This way, at user-space, we wouldn't need to build uhid_event m=
essages
>> > >> for every HID report we get. We would just write() the HID repo=
rt
>> > >> right away.
>> > >
>> > > we could also just use scatter gather writes and reads. So that =
is not
>> > > really a problem as long as the "header" has a fixed length.
>> >
>> > What is the problem with building uhid_event structures? Is it per=
formance?
>> > Do you really think one single memcpy() is that important?
>>
>> We have a latency here already and I rather avoid any memcpy if we d=
o
>> not have to. And scatter gather is a nice way to avoid this here.
>>
>> > If the size of the uhid_event structure is a problem, you should h=
ave a look at
>> > the internal handling. You can crop the structure if you want. For=
 events like
>> > UHID_CREATE you can simply send a single struct { __u16 type; }; o=
bject. You
>> > just need to make sure that if the event-type requires a payload, =
then
>> > the payload
>> > must be included.
>> > However, I also considered using a pointer instead of the 4096-byt=
es array so we
>> > would avoid that heavy payload for lazy programmers. I am open for=
 suggestions.
>>
>> I am not following this one. Maybe I confused with word scatter gath=
er,
>> I wanna use recvmsg and sendmsg with iovec. But coming to think abou=
t it
>> now, I am not sure that it is actually supported by character device=
s.
>> Maybe I am just spoiled by sockets.
>
> From the readv/writev manpage:
> "The readv() system call works just like read(2) except that multiple
> buffers are filled.
>
> The writev() system call works just like write(2) except that
> multiple buffers are written out."
>
> From this one may expect that it would work on anything that plain
> read() and write() work. But in the end, I guess that we have to try.

readv() and writev() are handled internally exactly the same as if user=
-space
would call read() and write() for every single iovec entry. Drivers may=
 provide
aio_read() and aio_write() callbacks, though, which allows them to retr=
ieve the
exact copy of the whole iovec at once. See kernel VFS layer for more
information.
Hence, everything works as expected.

Regards
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
