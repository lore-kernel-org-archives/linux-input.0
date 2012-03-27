From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC v2 1/1] HID: User-space I/O driver support for HID
 subsystem
Date: Wed, 28 Mar 2012 00:22:58 +0200
Message-ID: <1332886978.1870.122.camel@aeonflux>
References: <1332793209-2950-1-git-send-email-dh.herrmann@googlemail.com>
	 <1332793209-2950-2-git-send-email-dh.herrmann@googlemail.com>
	 <1332875632.1870.114.camel@aeonflux>
	 <CANq1E4TnjzNG4sT_qt5qmrYMHp39HAJUcG1D4w=kcWoBkrThqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANq1E4TnjzNG4sT_qt5qmrYMHp39HAJUcG1D4w=kcWoBkrThqA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, chen.ganir-l0cyMroinI0@public.gmane.org, claudio.takahasi-430g2QfJUUCGglJvpFV4uA@public.gmane.org, jprvita-430g2QfJUUCGglJvpFV4uA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, anderson.lizardo-430g2QfJUUCGglJvpFV4uA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi David,

> >> This driver allows to write I/O drivers in user-space and feed the input
> >> into the HID subsystem. It operates on the same level as USB-HID and
> >> Bluetooth-HID (HIDP). It does not provide support to write special HID
> >> device drivers but rather provides support for user-space I/O devices to
> >> feed their data into the kernel HID subsystem. The HID subsystem then
> >> loads the HID device drivers for the device and provides input-devices
> >> based on the user-space HID I/O device.
> >
> > <snip>
> >
> >> +#define UHID_NAME    "uhid"
> >> +#define UHID_BUFSIZE 32
> >> +
> >> +struct uhid_device {
> >> +     struct mutex devlock;
> >> +     bool running;
> >> +     struct device *parent;
> >> +
> >> +     __u8 *rd_data;
> >> +     uint rd_size;
> >> +
> >> +     struct hid_device *hid;
> >> +     struct uhid_event input_buf;
> >> +
> >> +     wait_queue_head_t waitq;
> >> +     spinlock_t qlock;
> >> +     struct uhid_event assemble;
> >> +     __u8 head;
> >> +     __u8 tail;
> >> +     struct uhid_event outq[UHID_BUFSIZE];
> >> +};
> >
> > The kernel has a ringbuffer structure. Would it make sense to use that
> > one?
> >
> > Or would using just a SKB queue be better?
> 
> I had a look at include/linux/circ_buf.h but it isn't really much of
> an help here. It provides 2 macros that could be used but would make
> the access to the fields more complicated so I decided to copy it from
> uinput. SKB is only for socket-related stuff and has much overhead if
> used without sockets. sizeof(struct sk_buff) is about 64KB or more and
> is really uncommon outside of ./net/.

fair enough. Then lets keep it this way.

<snip>

> >> +     strncpy(hid->name, ev->u.create.name, 128);
> >> +     hid->name[127] = 0;
> >> +     hid->ll_driver = &uhid_hid_driver;
> >> +     hid->hid_get_raw_report = uhid_hid_get_raw;
> >> +     hid->hid_output_raw_report = uhid_hid_output_raw;
> >> +     hid->bus = ev->u.create.bus;
> >> +     hid->vendor = ev->u.create.vendor;
> >> +     hid->product = ev->u.create.product;
> >> +     hid->version = ev->u.create.version;
> >> +     hid->country = ev->u.create.country;
> >> +     hid->phys[0] = 0;
> >> +     hid->uniq[0] = 0;
> >> +     hid->driver_data = uhid;
> >> +     hid->dev.parent = uhid->parent;
> >
> > Here we have to make sure that we have all required information provided
> > by userspace. Anything else that HID might require to work better. Or
> > that BR/EDR or LE provides additionally over USB.
> 
> Beside phys and uniq I have copied all information that HIDP and
> USBHID use. I haven't found any other field that could be of interest
> here. We can also always add UHID_CREATE2 with additional fields to
> allow further additions (or use a "size" field as you suggested
> below).

sounds good to me then.

<snip>

> >> +static int uhid_char_open(struct inode *inode, struct file *file)
> >> +{
> >> +     struct uhid_device *uhid;
> >> +
> >> +     uhid = kzalloc(sizeof(*uhid), GFP_KERNEL);
> >> +     if (!uhid)
> >> +             return -ENOMEM;
> >> +
> >> +     mutex_init(&uhid->devlock);
> >> +     spin_lock_init(&uhid->qlock);
> >> +     init_waitqueue_head(&uhid->waitq);
> >> +     uhid->running = false;
> >> +     uhid->parent = NULL;
> >> +
> >> +     file->private_data = uhid;
> >> +     nonseekable_open(inode, file);
> >> +
> >> +     return 0;
> >
> > return nonseekable_open().
> 
> No. See the comment in ./fs/open.c. This function is supposed to never fail
> and the only reason it returns int is that it can be used directly in
> file_operations.open = nonseekable_open
> 
> Also I need to do kfree(uhid) if nonseekable_open() fails so just ignoring
> the return value is the recommended way. See evdev.c, joydev.c and other
> input devices.
> 
> Of course, using it as constant replacement for "return 0;" works, but I
> really prefer not confusing the reader of the code ;)

Fair enough. Then the vhci Bluetooth driver should also be fixed since
that one is still doing it this way.

<snip>

> >> +#include <linux/input.h>
> >> +#include <linux/types.h>
> >> +
> >> +enum uhid_event_type {
> >
> > Can we add an UHID_UNSPEC or UHID_INVALID here for the 0 value.
> 
> I have no objections here but I didn't need it. Anyway, I can add it.

I looked at the RFKILL code and that starts at 0. So never mind. Lets
just leave it as is.

<snip>

> >> +struct uhid_event {
> >> +     __u32 type;
> >> +
> >> +     union {
> >> +             struct uhid_create_req create;
> >> +             struct uhid_input_req input;
> >> +             struct uhid_output_req output;
> >> +             struct uhid_output_ev_req output_ev;
> >> +     } u;
> >> +} __attribute__((packed));
> >
> > What about adding another __u32 len here? Just so we can do some extra
> > length checks if needed.
> 
> Then "len" field would be an overhead of 4 bytes per packet which is
> not needed at all. Of course, it would allow us to extent the
> payload-structure without adding new EVENT-types but is it really
> needed? Wouldn't it be better to add a single "version" field to
> UHID_CREATE and then the size attribute would be fixed for all the
> event-payloads?
> The "len" field would allow multiple packets per read/write, though.

We might have to run some numbers to compare the latency. It might be
good to put multiple read/write into one system call.

So I would vote for adding an extra length field. Even while we are
potentially creating a little bit of overhead, we would be a bit more
future safe with this in case we have to extend.

Regards

Marcel
