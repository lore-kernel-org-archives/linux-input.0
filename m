From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [RFC 1/1] HID: User-space I/O driver support for HID subsystem
Date: Fri, 16 Mar 2012 20:38:57 -0300
Message-ID: <20120316233857.GA23369@samus>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
 <1331909617-22106-2-git-send-email-dh.herrmann@googlemail.com>
 <CACJA=fVLRuRvvOTkDmuxVckW7oqM_4vk+NCN5fP1WtkGMV-NDw@mail.gmail.com>
 <1331918148.14217.173.camel@aeonflux>
 <CANq1E4T9pYucb=h=UrAwcJCvpy92fNqiOtzkQyL6R81Qz58UeQ@mail.gmail.com>
 <1331930743.14217.187.camel@aeonflux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35747 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162098Ab2CPXjD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Mar 2012 19:39:03 -0400
Received: by yhmm54 with SMTP id m54so4798158yhm.19
        for <linux-input@vger.kernel.org>; Fri, 16 Mar 2012 16:39:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1331930743.14217.187.camel@aeonflux>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>, Andre Guedes <andre.guedes@openbossa.org>, linux-input@vger.kernel.org, jkosina@suse.cz, chen.ganir@ti.com, claudio.takahasi@openbossa.org, jprvita@openbossa.org, linux-bluetooth@vger.kernel.org, Vijaykumar.Dadmode@csr.com

Hi Marcel,

On 13:45 Fri 16 Mar, Marcel Holtmann wrote:
> Hi David,
> 
> > >> > This driver allows to write I/O drivers in user-space and feed the input
> > >> > into the HID subsystem. It operates on the same level as USB-HID and
> > >> > Bluetooth-HID (HIDP). It does not provide support to write special HID
> > >> > device drivers but rather provides support for user-space I/O devices to
> > >> > feed their data into the kernel HID subsystem. The HID subsystem then
> > >> > loads the HID device drivers for the device and provides input-devices
> > >> > based on the user-space HID I/O device.
> > >> >
> > >> > This driver register a new char-device (/dev/uhid). A user-space process
> > >> > has to open this file for each device that it wants to provide to the
> > >> > kernel. It can then use write/read to communicate with the UHID driver.
> > >> > Both input and output data is sent with a uhid_event structure. The "type"
> > >> > field of the structure specifies what kind of event is sent. There is a
> > >> > file in Documentation/ explaining the ABI.
> > >> >
> > >> > Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> > >> > ---
> > >> >  Documentation/hid/uhid.txt |   95 +++++++++
> > >> >  drivers/hid/Kconfig        |   21 ++
> > >> >  drivers/hid/Makefile       |    2 +-
> > >> >  drivers/hid/uhid.c         |  502 ++++++++++++++++++++++++++++++++++++++++++++
> > >> >  include/linux/uhid.h       |   71 +++++++
> > >> >  5 files changed, 690 insertions(+), 1 deletion(-)
> > >> >  create mode 100644 Documentation/hid/uhid.txt
> > >> >  create mode 100644 drivers/hid/uhid.c
> > >> >  create mode 100644 include/linux/uhid.h
> > >> >
> > >> > diff --git a/Documentation/hid/uhid.txt b/Documentation/hid/uhid.txt
> > >> > new file mode 100644
> > >> > index 0000000..67b138d
> > >> > --- /dev/null
> > >> > +++ b/Documentation/hid/uhid.txt
> > >> > @@ -0,0 +1,95 @@
> > >> > +      UHID - User-space I/O driver support for HID subsystem
> > >> > +     ========================================================
> > >> > +
> > >> > +The UHID driver provides an interface for user-space I/O drivers to feed their
> > >> > +data into the HID subsystem. The HID subsystem then parses the HID reports and
> > >> > +loads the corresponding HID device driver which then provides the parsed data
> > >> > +via input-devices to user-space.
> > >> > +
> > >> > +This allows user-space to operate on the same level as USB-HID, Bluetooth-HID
> > >> > +and similar. It does not provide a way to write HID device drivers, though! Use
> > >> > +HIDRAW for this purpose.
> > >> > +
> > >> > +UHID dynamically allocates the minor/major number, meaning that you should rely
> > >> > +on udev to create the UHID device node. Typically this is created as /dev/uhid.
> > >> > +
> > >> > +The UHID API
> > >> > +------------
> > >> > +
> > >> > +For each device that you want to register with the HID core, you need to open a
> > >> > +separate file-descriptor on /dev/uhid. All communication is done by read()'ing
> > >> > +or write()'ing "struct uhid_event" objects to the file. Non-blocking operations
> > >> > +via O_NONBLOCK are supported.
> > >> > +
> > >> > +struct uhid_event {
> > >> > +        __u32 type;
> > >> > +        ... payload ...
> > >> > +};
> > >> > +
> > >> > +write()
> > >> > +-------
> > >> > +write() allows you to modify the state of the device and feed input data into
> > >> > +the kernel. The following types are supported: UHID_CREATE, UHID_DESTROY and
> > >> > +UHID_INPUT.
> > >> > +
> > >> > +  UHID_CREATE:
> > >> > +  This creates the internal HID device. No I/O is possible until you send this
> > >> > +  event to the kernel. The payload is of type struct uhid_create_req and
> > >> > +  contains information about your device.
> > >> > +
> > >> > +  UHID_DESTROY:
> > >> > +  This destroys the internal HID device. No further I/O will be accepted. There
> > >> > +  may still be pending messages that you can receive with read() but no further
> > >> > +  UHID_INPUT events can be sent to the kernel.
> > >> > +  You can create a new device by sending UHID_CREATE again. There is no need to
> > >> > +  reopen the character device.
> > >> > +
> > >> > +  UHID_INPUT:
> > >> > +  You must send UHID_CREATE before sending input to the kernel! This event
> > >> > +  contains a data-payload. This is the raw data that you read from your device.
> > >> > +  The kernel will parse the HID reports and react on it.
> > >> > +
> > >> > +read()
> > >> > +------
> > >> > +read() will return a queued ouput report. These output reports can be of type
> > >> > +UHID_START, UHID_STOP, UHID_OPEN, UHID_CLOSE, UHID_OUTPUT or UHID_OUTPUT_EV. No
> > >> > +reaction is required to any of them but you should handle them according to your
> > >> > +needs. Only UHID_OUTPUT and UHID_OUTPUT_EV have payloads.
> > >> > +
> > >> > +  UHID_START:
> > >> > +  This is sent when the HID device is started. Consider this as an answer to
> > >> > +  UHID_CREATE. This is always the first event that is sent. No I/O is possible
> > >> > +  before you read this.
> > >> > +
> > >> > +  UHID_STOP:
> > >> > +  This is sent when the HID device is stopped. Consider this as an answer to
> > >> > +  UHID_DESTROY. No further I/O will be possible after receiving this.
> > >> > +  If the kernel HID device driver closes the device manually (that is, you
> > >> > +  didn't send UHID_DESTROY) then you should consider this device closed and send
> > >> > +  an UHID_DESTROY event. You may want to reregister your device, though.
> > >> > +
> > >> > +  UHID_OPEN:
> > >> > +  This is sent when the HID device is opened. That is, the data that the HID
> > >> > +  device provides is read by some other process. You may ignore this event but
> > >> > +  it is useful for power-management. As long as you haven't received this event
> > >> > +  there is actually no other process that reads your data so there is no need to
> > >> > +  send UHID_INPUT events to the kernel.
> > >> > +
> > >> > +  UHID_CLOSE:
> > >> > +  This is sent when there are no more processes which read the HID data. It is
> > >> > +  the counterpart of UHID_OPEN and you may as well ignore this event.
> > >> > +
> > >> > +  UHID_OUTPUT:
> > >> > +  This is sent if the HID device driver wants to send raw data to the I/O
> > >> > +  device. You should read the payload and forward it to the device. The payload
> > >> > +  is of type "struct uhid_data_req".
> > >> > +  This may be received even though you haven't received UHID_OPEN, yet.
> > >> > +
> > >> > +  UHID_OUTPUT_EV:
> > >> > +  Same as UHID_OUTPUT but this contains a "struct input_event" as payload. This
> > >> > +  is called for force-feedback, LED or similar events which are received through
> > >> > +  an input device by the HID subsystem. You should convert this into raw reports
> > >> > +  and send them to your device similar to events of type UHID_OUTPUT.
> > >> > +
> > >> > +Document by:
> > >> > +  David Herrmann <dh.herrmann@googlemail.com>
> > >>
> > >> What do you think about using ioctl() to handle creating, destroying
> > >> and configuring internal hid devices and leave read() and write() to
> > >> handle HID reports?
> > 
> > I need to notify user-space about START/STOP/OPEN/CLOSE/... signals so read()
> > will always need some event-structure. Therefore, I thought it would be more
> > consistent if write() would use the same structure. We can also avoid using
> > ioctl()'s entirely, they're ugly anyway.
> 
> I like it this way. Just make sure the header is fixed length all the
> time and we only give one header + data per read() / write().
> 
> That way we can nicely use scatter gather and avoid complex data copy in
> userspace for report data.
> 
> We still have to do some measurement with the latency, but we might just
> even run HIDP in userspace in the end.
> 
> > >> This way, at user-space, we wouldn't need to build uhid_event messages
> > >> for every HID report we get. We would just write() the HID report
> > >> right away.
> > >
> > > we could also just use scatter gather writes and reads. So that is not
> > > really a problem as long as the "header" has a fixed length.
> > 
> > What is the problem with building uhid_event structures? Is it performance?
> > Do you really think one single memcpy() is that important?
> 
> We have a latency here already and I rather avoid any memcpy if we do
> not have to. And scatter gather is a nice way to avoid this here.
> 
> > If the size of the uhid_event structure is a problem, you should have a look at
> > the internal handling. You can crop the structure if you want. For events like
> > UHID_CREATE you can simply send a single struct { __u16 type; }; object. You
> > just need to make sure that if the event-type requires a payload, then
> > the payload
> > must be included.
> > However, I also considered using a pointer instead of the 4096-bytes array so we
> > would avoid that heavy payload for lazy programmers. I am open for suggestions.
> 
> I am not following this one. Maybe I confused with word scatter gather,
> I wanna use recvmsg and sendmsg with iovec. But coming to think about it
> now, I am not sure that it is actually supported by character devices.
> Maybe I am just spoiled by sockets.

>From the readv/writev manpage:
"The readv() system call works just like read(2) except that multiple 
buffers are filled.

The writev() system call works just like write(2) except that 
multiple buffers are written out."

>From this one may expect that it would work on anything that plain
read() and write() work. But in the end, I guess that we have to try.

> 
> Regards
> 
> Marcel
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-- 
Vinicius
