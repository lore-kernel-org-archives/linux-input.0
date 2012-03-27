From: David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [RFC v2 1/1] HID: User-space I/O driver support for HID subsystem
Date: Tue, 27 Mar 2012 23:51:33 +0200
Message-ID: <CANq1E4TnjzNG4sT_qt5qmrYMHp39HAJUcG1D4w=kcWoBkrThqA@mail.gmail.com>
References: <1332793209-2950-1-git-send-email-dh.herrmann@googlemail.com>
	<1332793209-2950-2-git-send-email-dh.herrmann@googlemail.com>
	<1332875632.1870.114.camel@aeonflux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1332875632.1870.114.camel@aeonflux>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, chen.ganir-l0cyMroinI0@public.gmane.org, claudio.takahasi-430g2QfJUUCGglJvpFV4uA@public.gmane.org, jprvita-430g2QfJUUCGglJvpFV4uA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, anderson.lizardo-430g2QfJUUCGglJvpFV4uA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Marcel

On Tue, Mar 27, 2012 at 9:13 PM, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org> =
wrote:
> Hi David,
>
>> This driver allows to write I/O drivers in user-space and feed the i=
nput
>> into the HID subsystem. It operates on the same level as USB-HID and
>> Bluetooth-HID (HIDP). It does not provide support to write special H=
ID
>> device drivers but rather provides support for user-space I/O device=
s to
>> feed their data into the kernel HID subsystem. The HID subsystem the=
n
>> loads the HID device drivers for the device and provides input-devic=
es
>> based on the user-space HID I/O device.
>
> <snip>
>
>> +#define UHID_NAME =A0 =A0"uhid"
>> +#define UHID_BUFSIZE 32
>> +
>> +struct uhid_device {
>> + =A0 =A0 struct mutex devlock;
>> + =A0 =A0 bool running;
>> + =A0 =A0 struct device *parent;
>> +
>> + =A0 =A0 __u8 *rd_data;
>> + =A0 =A0 uint rd_size;
>> +
>> + =A0 =A0 struct hid_device *hid;
>> + =A0 =A0 struct uhid_event input_buf;
>> +
>> + =A0 =A0 wait_queue_head_t waitq;
>> + =A0 =A0 spinlock_t qlock;
>> + =A0 =A0 struct uhid_event assemble;
>> + =A0 =A0 __u8 head;
>> + =A0 =A0 __u8 tail;
>> + =A0 =A0 struct uhid_event outq[UHID_BUFSIZE];
>> +};
>
> The kernel has a ringbuffer structure. Would it make sense to use tha=
t
> one?
>
> Or would using just a SKB queue be better?

I had a look at include/linux/circ_buf.h but it isn't really much of
an help here. It provides 2 macros that could be used but would make
the access to the fields more complicated so I decided to copy it from
uinput. SKB is only for socket-related stuff and has much overhead if
used without sockets. sizeof(struct sk_buff) is about 64KB or more and
is really uncommon outside of ./net/.

>> +static void uhid_queue(struct uhid_device *uhid, const struct uhid_=
event *ev)
>> +{
>> + =A0 =A0 __u8 newhead;
>> +
>> + =A0 =A0 newhead =3D (uhid->head + 1) % UHID_BUFSIZE;
>> +
>> + =A0 =A0 if (newhead !=3D uhid->tail) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&uhid->outq[uhid->head], ev, sizeof=
(struct uhid_event));
>> + =A0 =A0 =A0 =A0 =A0 =A0 uhid->head =3D newhead;
>> + =A0 =A0 =A0 =A0 =A0 =A0 wake_up_interruptible(&uhid->waitq);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("Output queue is full\n");
>> + =A0 =A0 }
>> +}
>> +
>> +static int uhid_hid_start(struct hid_device *hid)
>> +{
>> + =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&uhid->qlock, flags);
>> + =A0 =A0 memset(&uhid->assemble, 0, sizeof(uhid->assemble));
>> + =A0 =A0 uhid->assemble.type =3D UHID_START;
>> + =A0 =A0 uhid_queue(uhid, &uhid->assemble);
>> + =A0 =A0 spin_unlock_irqrestore(&uhid->qlock, flags);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void uhid_hid_stop(struct hid_device *hid)
>> +{
>> + =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&uhid->qlock, flags);
>> + =A0 =A0 memset(&uhid->assemble, 0, sizeof(uhid->assemble));
>> + =A0 =A0 uhid->assemble.type =3D UHID_STOP;
>> + =A0 =A0 uhid_queue(uhid, &uhid->assemble);
>> + =A0 =A0 spin_unlock_irqrestore(&uhid->qlock, flags);
>> +
>> + =A0 =A0 hid->claimed =3D 0;
>> +}
>> +
>> +static int uhid_hid_open(struct hid_device *hid)
>> +{
>> + =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&uhid->qlock, flags);
>> + =A0 =A0 memset(&uhid->assemble, 0, sizeof(uhid->assemble));
>> + =A0 =A0 uhid->assemble.type =3D UHID_OPEN;
>> + =A0 =A0 uhid_queue(uhid, &uhid->assemble);
>> + =A0 =A0 spin_unlock_irqrestore(&uhid->qlock, flags);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void uhid_hid_close(struct hid_device *hid)
>> +{
>> + =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&uhid->qlock, flags);
>> + =A0 =A0 memset(&uhid->assemble, 0, sizeof(uhid->assemble));
>> + =A0 =A0 uhid->assemble.type =3D UHID_CLOSE;
>> + =A0 =A0 uhid_queue(uhid, &uhid->assemble);
>> + =A0 =A0 spin_unlock_irqrestore(&uhid->qlock, flags);
>> +}
>> +
>> +static int uhid_hid_power(struct hid_device *hid, int level)
>> +{
>> + =A0 =A0 /* TODO: Handle PM-hints. This isn't mandatory so we simpl=
y return 0
>> + =A0 =A0 =A0* here.
>> + =A0 =A0 =A0*/
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int uhid_hid_input(struct input_dev *input, unsigned int typ=
e,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned i=
nt code, int value)
>> +{
>> + =A0 =A0 struct hid_device *hid =3D input_get_drvdata(input);
>> + =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&uhid->qlock, flags);
>> + =A0 =A0 memset(&uhid->assemble, 0, sizeof(uhid->assemble));
>> +
>> + =A0 =A0 uhid->assemble.type =3D UHID_OUTPUT_EV;
>> + =A0 =A0 uhid->assemble.u.output_ev.type =3D type;
>> + =A0 =A0 uhid->assemble.u.output_ev.code =3D code;
>> + =A0 =A0 uhid->assemble.u.output_ev.value =3D value;
>> +
>> + =A0 =A0 uhid_queue(uhid, &uhid->assemble);
>> + =A0 =A0 spin_unlock_irqrestore(&uhid->qlock, flags);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int uhid_hid_parse(struct hid_device *hid)
>> +{
>> + =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
>> +
>> + =A0 =A0 return hid_parse_report(hid, uhid->rd_data, uhid->rd_size)=
;
>> +}
>> +
>> +static int uhid_hid_get_raw(struct hid_device *hid, unsigned char r=
num,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __u8 *buf,=
 size_t count, unsigned char rtype)
>> +{
>> + =A0 =A0 /* TODO: we currently do not support this request. If we w=
ant this we
>> + =A0 =A0 =A0* would need some kind of stream-locking but it isn't n=
eeded by the
>> + =A0 =A0 =A0* main drivers, anyway.
>> + =A0 =A0 =A0*/
>> +
>> + =A0 =A0 return -EOPNOTSUPP;
>> +}
>> +
>> +static int uhid_hid_output_raw(struct hid_device *hid, __u8 *buf, s=
ize_t count,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned c=
har report_type)
>> +{
>> + =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
>> + =A0 =A0 __u8 rtype;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 switch (report_type) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_FEATURE_REPORT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtype =3D UHID_FEATURE_REP=
ORT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_OUTPUT_REPORT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtype =3D UHID_OUTPUT_REPO=
RT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (count < 1 || count > UHID_DATA_MAX)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 spin_lock_irqsave(&uhid->qlock, flags);
>> + =A0 =A0 memset(&uhid->assemble, 0, sizeof(uhid->assemble));
>> +
>> + =A0 =A0 uhid->assemble.type =3D UHID_OUTPUT;
>> + =A0 =A0 uhid->assemble.u.output.size =3D count;
>> + =A0 =A0 uhid->assemble.u.output.rtype =3D rtype;
>> + =A0 =A0 memcpy(uhid->assemble.u.output.data, buf, count);
>> +
>> + =A0 =A0 uhid_queue(uhid, &uhid->assemble);
>> + =A0 =A0 spin_unlock_irqrestore(&uhid->qlock, flags);
>> +
>> + =A0 =A0 return count;
>> +}
>> +
>> +static struct hid_ll_driver uhid_hid_driver =3D {
>> + =A0 =A0 .start =3D uhid_hid_start,
>> + =A0 =A0 .stop =3D uhid_hid_stop,
>> + =A0 =A0 .open =3D uhid_hid_open,
>> + =A0 =A0 .close =3D uhid_hid_close,
>> + =A0 =A0 .power =3D uhid_hid_power,
>> + =A0 =A0 .hidinput_input_event =3D uhid_hid_input,
>> + =A0 =A0 .parse =3D uhid_hid_parse,
>> +};
>> +
>> +static int uhid_dev_create(struct uhid_device *uhid,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const stru=
ct uhid_event *ev)
>> +{
>> + =A0 =A0 struct hid_device *hid;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 ret =3D mutex_lock_interruptible(&uhid->devlock);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 if (uhid->running) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EALREADY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 uhid->rd_size =3D ev->u.create.rd_size;
>> + =A0 =A0 uhid->rd_data =3D kzalloc(uhid->rd_size, GFP_KERNEL);
>> + =A0 =A0 if (!uhid->rd_data) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (copy_from_user(uhid->rd_data, ev->u.create.rd_data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uhid->rd_s=
ize)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EFAULT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 hid =3D hid_allocate_device();
>> + =A0 =A0 if (IS_ERR(hid)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(hid);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 strncpy(hid->name, ev->u.create.name, 128);
>> + =A0 =A0 hid->name[127] =3D 0;
>> + =A0 =A0 hid->ll_driver =3D &uhid_hid_driver;
>> + =A0 =A0 hid->hid_get_raw_report =3D uhid_hid_get_raw;
>> + =A0 =A0 hid->hid_output_raw_report =3D uhid_hid_output_raw;
>> + =A0 =A0 hid->bus =3D ev->u.create.bus;
>> + =A0 =A0 hid->vendor =3D ev->u.create.vendor;
>> + =A0 =A0 hid->product =3D ev->u.create.product;
>> + =A0 =A0 hid->version =3D ev->u.create.version;
>> + =A0 =A0 hid->country =3D ev->u.create.country;
>> + =A0 =A0 hid->phys[0] =3D 0;
>> + =A0 =A0 hid->uniq[0] =3D 0;
>> + =A0 =A0 hid->driver_data =3D uhid;
>> + =A0 =A0 hid->dev.parent =3D uhid->parent;
>
> Here we have to make sure that we have all required information provi=
ded
> by userspace. Anything else that HID might require to work better. Or
> that BR/EDR or LE provides additionally over USB.

Beside phys and uniq I have copied all information that HIDP and
USBHID use. I haven't found any other field that could be of interest
here. We can also always add UHID_CREATE2 with additional fields to
allow further additions (or use a "size" field as you suggested
below).

>> + =A0 =A0 uhid->hid =3D hid;
>> + =A0 =A0 uhid->running =3D true;
>> +
>> + =A0 =A0 ret =3D hid_add_device(hid);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot register HID device\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_hid;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mutex_unlock(&uhid->devlock);
>> +
>> + =A0 =A0 return 0;
>> +
>> +err_hid:
>> + =A0 =A0 hid_destroy_device(hid);
>> + =A0 =A0 uhid->hid =3D NULL;
>> + =A0 =A0 uhid->running =3D false;
>> +err_free:
>> + =A0 =A0 kfree(uhid->rd_data);
>> +unlock:
>> + =A0 =A0 mutex_unlock(&uhid->devlock);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int uhid_dev_destroy(struct uhid_device *uhid)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 ret =3D mutex_lock_interruptible(&uhid->devlock);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 if (!uhid->running) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 hid_destroy_device(uhid->hid);
>> + =A0 =A0 kfree(uhid->rd_data);
>> + =A0 =A0 uhid->running =3D false;
>> +
>> +unlock:
>> + =A0 =A0 mutex_unlock(&uhid->devlock);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int uhid_dev_input(struct uhid_device *uhid, struct uhid_eve=
nt *ev)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 ret =3D mutex_lock_interruptible(&uhid->devlock);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 if (!uhid->running) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.=
data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ev->u.inpu=
t.size, 0);
>> +
>> +unlock:
>> + =A0 =A0 mutex_unlock(&uhid->devlock);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int uhid_char_open(struct inode *inode, struct file *file)
>> +{
>> + =A0 =A0 struct uhid_device *uhid;
>> +
>> + =A0 =A0 uhid =3D kzalloc(sizeof(*uhid), GFP_KERNEL);
>> + =A0 =A0 if (!uhid)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 mutex_init(&uhid->devlock);
>> + =A0 =A0 spin_lock_init(&uhid->qlock);
>> + =A0 =A0 init_waitqueue_head(&uhid->waitq);
>> + =A0 =A0 uhid->running =3D false;
>> + =A0 =A0 uhid->parent =3D NULL;
>> +
>> + =A0 =A0 file->private_data =3D uhid;
>> + =A0 =A0 nonseekable_open(inode, file);
>> +
>> + =A0 =A0 return 0;
>
> return nonseekable_open().

No. See the comment in ./fs/open.c. This function is supposed to never =
fail
and the only reason it returns int is that it can be used directly in
file_operations.open =3D nonseekable_open

Also I need to do kfree(uhid) if nonseekable_open() fails so just ignor=
ing
the return value is the recommended way. See evdev.c, joydev.c and othe=
r
input devices.

Of course, using it as constant replacement for "return 0;" works, but =
I
really prefer not confusing the reader of the code ;)

>> +}
>> +
>> +static int uhid_char_release(struct inode *inode, struct file *file=
)
>> +{
>> + =A0 =A0 struct uhid_device *uhid =3D file->private_data;
>> +
>> + =A0 =A0 uhid_dev_destroy(uhid);
>> + =A0 =A0 kfree(uhid);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static ssize_t uhid_char_read(struct file *file, char __user *buffe=
r,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t cou=
nt, loff_t *ppos)
>> +{
>> + =A0 =A0 struct uhid_device *uhid =3D file->private_data;
>> + =A0 =A0 int ret;
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 size_t len;
>> +
>> + =A0 =A0 /* they need at least the "type" member of uhid_event */
>> + =A0 =A0 if (count < sizeof(__u32))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> +try_again:
>> + =A0 =A0 if (file->f_flags & O_NONBLOCK) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (uhid->head =3D=3D uhid->tail)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D wait_event_interruptible(uhid->wai=
tq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 uhid->head !=3D uhid->tail);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D mutex_lock_interruptible(&uhid->devlock);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 if (uhid->head =3D=3D uhid->tail) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&uhid->devlock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto try_again;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 len =3D min(count, sizeof(*uhid->outq));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (copy_to_user(buffer, &uhid->outq[uhid-=
>tail], len)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EFAULT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&uhid->q=
lock, flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uhid->tail =3D (uhid->tail=
 + 1) % UHID_BUFSIZE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&uh=
id->qlock, flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mutex_unlock(&uhid->devlock);
>> + =A0 =A0 return ret ? ret : len;
>> +}
>> +
>> +static ssize_t uhid_char_write(struct file *file, const char __user=
 *buffer,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t cou=
nt, loff_t *ppos)
>> +{
>> + =A0 =A0 struct uhid_device *uhid =3D file->private_data;
>> + =A0 =A0 int ret;
>> + =A0 =A0 size_t len;
>> +
>> + =A0 =A0 /* we need at least the "type" member of uhid_event */
>> + =A0 =A0 if (count < sizeof(__u32))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 memset(&uhid->input_buf, 0, sizeof(uhid->input_buf));
>> + =A0 =A0 len =3D min(count, sizeof(uhid->input_buf));
>> + =A0 =A0 if (copy_from_user(&uhid->input_buf, buffer, len))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> +
>> + =A0 =A0 switch (uhid->input_buf.type) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case UHID_CREATE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D uhid_dev_create(uh=
id, &uhid->input_buf);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case UHID_DESTROY:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D uhid_dev_destroy(u=
hid);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case UHID_INPUT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D uhid_dev_input(uhi=
d, &uhid->input_buf);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EOPNOTSUPP;
>
> switch and case should be on the same indentation.

Ugh, yeah, doesn't make any difference here as the lines are pretty
short but I will fix that. Thanks.

>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* return "count" not "len" to not confuse the caller */
>> + =A0 =A0 return ret ? ret : count;
>> +}
>> +
>> +static unsigned int uhid_char_poll(struct file *file, poll_table *w=
ait)
>> +{
>> + =A0 =A0 struct uhid_device *uhid =3D file->private_data;
>> +
>> + =A0 =A0 poll_wait(file, &uhid->waitq, wait);
>> +
>> + =A0 =A0 if (uhid->head !=3D uhid->tail)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return POLLIN | POLLRDNORM;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static const struct file_operations uhid_fops =3D {
>> + =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
>> + =A0 =A0 .open =A0 =A0 =A0 =A0 =A0 =3D uhid_char_open,
>> + =A0 =A0 .release =A0 =A0 =A0 =A0=3D uhid_char_release,
>> + =A0 =A0 .read =A0 =A0 =A0 =A0 =A0 =3D uhid_char_read,
>> + =A0 =A0 .write =A0 =A0 =A0 =A0 =A0=3D uhid_char_write,
>> + =A0 =A0 .poll =A0 =A0 =A0 =A0 =A0 =3D uhid_char_poll,
>> + =A0 =A0 .llseek =A0 =A0 =A0 =A0 =3D no_llseek,
>> +};
>> +
>> +static struct miscdevice uhid_misc =3D {
>> + =A0 =A0 .fops =A0 =A0 =A0 =A0 =A0 =3D &uhid_fops,
>> + =A0 =A0 .minor =A0 =A0 =A0 =A0 =A0=3D MISC_DYNAMIC_MINOR,
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D UHID_NAME,
>> +};
>> +
>> +static int __init uhid_init(void)
>> +{
>> + =A0 =A0 return misc_register(&uhid_misc);
>> +}
>> +
>> +static void __exit uhid_exit(void)
>> +{
>> + =A0 =A0 misc_deregister(&uhid_misc);
>> +}
>> +
>> +module_init(uhid_init);
>> +module_exit(uhid_exit);
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
>> +MODULE_DESCRIPTION("User-space I/O driver support for HID subsystem=
");
>> diff --git a/include/linux/Kbuild b/include/linux/Kbuild
>> index c94e717..b8d5ed0 100644
>> --- a/include/linux/Kbuild
>> +++ b/include/linux/Kbuild
>> @@ -370,6 +370,7 @@ header-y +=3D tty.h
>> =A0header-y +=3D types.h
>> =A0header-y +=3D udf_fs_i.h
>> =A0header-y +=3D udp.h
>> +header-y +=3D uhid.h
>> =A0header-y +=3D uinput.h
>> =A0header-y +=3D uio.h
>> =A0header-y +=3D ultrasound.h
>> diff --git a/include/linux/uhid.h b/include/linux/uhid.h
>> new file mode 100644
>> index 0000000..67d9c8d
>> --- /dev/null
>> +++ b/include/linux/uhid.h
>> @@ -0,0 +1,84 @@
>> +#ifndef __UHID_H_
>> +#define __UHID_H_
>> +
>> +/*
>> + * User-space I/O driver support for HID subsystem
>> + * Copyright (c) 2012 David Herrmann
>> + */
>> +
>> +/*
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License as published b=
y the Free
>> + * Software Foundation; either version 2 of the License, or (at you=
r option)
>> + * any later version.
>> + */
>> +
>> +/*
>> + * Public header for user-space communication. We try to keep every=
 structure
>> + * aligned but to be safe we also use __attribute__((packed)). Ther=
efore, the
>> + * communication should be ABI compatible even between architecture=
s.
>> + */
>> +
>> +#include <linux/input.h>
>> +#include <linux/types.h>
>> +
>> +enum uhid_event_type {
>
> Can we add an UHID_UNSPEC or UHID_INVALID here for the 0 value.

I have no objections here but I didn't need it. Anyway, I can add it.

>> + =A0 =A0 UHID_CREATE,
>> + =A0 =A0 UHID_DESTROY,
>> + =A0 =A0 UHID_START,
>> + =A0 =A0 UHID_STOP,
>> + =A0 =A0 UHID_OPEN,
>> + =A0 =A0 UHID_CLOSE,
>> + =A0 =A0 UHID_OUTPUT,
>> + =A0 =A0 UHID_OUTPUT_EV,
>> + =A0 =A0 UHID_INPUT,
>> +};
>> +
>> +struct uhid_create_req {
>> + =A0 =A0 __u8 name[128];
>> + =A0 =A0 __u8 __user *rd_data;
>> + =A0 =A0 __u16 rd_size;
>> +
>> + =A0 =A0 __u16 bus;
>> + =A0 =A0 __u32 vendor;
>> + =A0 =A0 __u32 product;
>> + =A0 =A0 __u32 version;
>> + =A0 =A0 __u32 country;
>> +} __attribute__((packed));
>
> __packed please and all others.

Thanks, I will fix that.

>> +
>> +#define UHID_DATA_MAX 4096
>> +
>> +enum uhid_report_type {
>> + =A0 =A0 UHID_FEATURE_REPORT,
>> + =A0 =A0 UHID_OUTPUT_REPORT,
>> +};
>> +
>> +struct uhid_input_req {
>> + =A0 =A0 __u8 data[UHID_DATA_MAX];
>> + =A0 =A0 __u16 size;
>> +} __attribute__((packed));
>> +
>> +struct uhid_output_req {
>> + =A0 =A0 __u8 data[UHID_DATA_MAX];
>> + =A0 =A0 __u16 size;
>> + =A0 =A0 __u8 rtype;
>> +} __attribute__((packed));
>> +
>> +struct uhid_output_ev_req {
>> + =A0 =A0 __u16 type;
>> + =A0 =A0 __u16 code;
>> + =A0 =A0 __s32 value;
>> +} __attribute__((packed));
>> +
>> +struct uhid_event {
>> + =A0 =A0 __u32 type;
>> +
>> + =A0 =A0 union {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct uhid_create_req create;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct uhid_input_req input;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct uhid_output_req output;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct uhid_output_ev_req output_ev;
>> + =A0 =A0 } u;
>> +} __attribute__((packed));
>
> What about adding another __u32 len here? Just so we can do some extr=
a
> length checks if needed.

Then "len" field would be an overhead of 4 bytes per packet which is
not needed at all. Of course, it would allow us to extent the
payload-structure without adding new EVENT-types but is it really
needed? Wouldn't it be better to add a single "version" field to
UHID_CREATE and then the size attribute would be fixed for all the
event-payloads?
The "len" field would allow multiple packets per read/write, though.

> Regards
>
> Marcel

Thanks for reviewing. I will resend an updated version in a week.
Regards
David
