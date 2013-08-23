From: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: kernel Oops: 0003 on usbhid_submit_report
Date: Fri, 23 Aug 2013 14:32:30 +0200
Message-ID: <CAN+gG=FJSMyQNHcq=0cO1srVpRb_83YihUH0WuAPTcKAJHhv4g@mail.gmail.com>
References: <9921350AD19C46EFA70EA181A0C1F7E9@sqhead.com>
	<20130813184056.GH7740@kroah.com>
	<16FA42AC8F654C3B81924591E607B342@sqhead.com>
	<20130815063736.GF25754@kroah.com>
	<26E21BF00B944AB6B8F48B5E59B0442D@sqhead.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <26E21BF00B944AB6B8F48B5E59B0442D-nr7O5T6ryCTQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Andreas_Lilleb=C3=B8_Holm?= <andreas-nr7O5T6ryCTQT0dZR+AlfA@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Aug 23, 2013 at 12:52 PM, Andreas Lilleb=C3=B8 Holm
<andreas-nr7O5T6ryCTQT0dZR+AlfA@public.gmane.org> wrote:
> Hi,
>
> I just wanna followup this issue a bit more.
>
> We have now tested on several hardware platform, and it is only on on=
e platform it fails. The platform it fails on is Atom Intel e6xx CPU wi=
th EG20T PCH platform controller. We do not observe it on the Intel i7 =
3517UE CPU with Intel 6/7 series system controller.
>
> We see this error around 4 times over 100 boots / 2 hours runtime.
>
> After the Oops our process is in uninterruptable sleep state (D state=
). The process is not killable  when in this state. The process also us=
es around 70% CPU, maybe because it is waiting for the ioctl system cal=
l to return?
>
> We haven't found another way to recover from besides rebooting the sy=
stem.
>
> How can we proceed to fix this issue?

IIRC, Jiri fixed some paging requests with the two following patches:
http://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/commit/?h=3Df=
or-next&id=3D27ce405039bfe6d3f4143415c638f56a3df77dca
http://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/commit/?h=3Df=
or-next&id=3Dbc197eedef1ae082ec662c64c3f4aa302821fb7a

At least, these two patches are related to hid_output_report(). I
think they are scheduled for 3.12, so I can not find them in Linus'
tree.

It would worth trying them :)

Cheers,
Benjamin

>
>
> On Thursday, August 15, 2013 at 8:37 AM, Greg KH wrote:
>
>> > > > When communicating with AT90USB1287, at random intervals (1/25=
 boots)
>> > > > the linux hid_output_field Oopses and kills the communicating =
thread.
>> > > > The AT90USB1287 microcontroller uses LUFA library for usb/hid
>> > > > communication. It is trigged by a ioctl call from userspace an=
d fails
>> > > > in a kernel paging request. The system is after the oops in a =
state
>> > > > where no hid commands is sent anymore and only a boot can fix =
the
>> > > > system.
>> > > >
>> > > > Keywords: usbhid hid
>> > > >
>> > > > Kernel version: Linux version 3.8.13-03081301-generic (apw@gom=
eisa) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201305311535=
 SMP Fri May 31 19:44:30 UTC 2013
>> > > >
>> > > > Oopses:
>> > > > http://paste.debian.net/24305
>> > > > http://paste.debian.net/24306
>> > > > http://paste.debian.net/24307
>> > > >
>> > > > Code:
>> > > > The error is triggered by:
>> > > > ioctl(fd,HIDIOCSUSAGES, &ref_multi_u);
>> > > > ioctl(fd,HIDIOCSREPORT, &rep_info_u);
>> > > >
>> > > > Notes:
>> > > > It is very hard to reproduce so seems like race condition=E2=80=
=A6
>> > > >
>> > > > Any tips to resolve/workaround this issue is appreciated and p=
lease
>> > > > let me know if my information is incomplete (This is my first =
kernel
>> > > > bug report)
>> > >
>> > >
>> > > Any chance you can try a supported kernel, like 3.10.6 or 3.11-r=
c5 to
>> > > see if that also causes problems? We can't do anything with
>> > > distro-specific kernel releases like your 3.8.13 release from Ub=
untu,
>> > > sorry.
>> >
>> >
>> > I've now tried with kernel 3.10.6 (http://kernel.ubuntu.com/~kerne=
l-ppa/mainline/v3.10.6-saucy/) and I can trigger the same issue on this=
 kernel.
>> >
>> > Here is a paste from last Oops on this kernel:
>> > http://paste.debian.net/24993/
>> >
>> > I am also using usbmon to monitor the usb bus traffic, but cannot =
see anything that should cause the driver to Oops.
>> >
>> > Is there any way to find out what can trigger this issue?
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
