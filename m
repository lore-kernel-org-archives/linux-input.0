From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: uhid: actually use the err number from userspace
Date: Tue, 13 Aug 2019 15:58:05 +0200
Message-ID: <CAO-hwJ+z0szwuQrUxpQhii2z_jwxMX91df0ynK5QbZpMhg79-g@mail.gmail.com>
References: <20190812162105.13428-1-benjamin.tissoires@redhat.com> <CADyDSO4x49GWdRVkW=cytvMc7rM3NJkJ4-Sj-FjM9Gday7C-iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADyDSO4x49GWdRVkW=cytvMc7rM3NJkJ4-Sj-FjM9Gday7C-iw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Rheinsberg <david.rheinsberg@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Aug 13, 2019 at 12:50 PM David Rheinsberg
<david.rheinsberg@gmail.com> wrote:
>
> Hey
>
> On Mon, Aug 12, 2019 at 6:21 PM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > This can help debugging the situation
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >
> > Hi,
> >
> > not entirely sure if we can use this in a such simple way.
> >
> > However, this is useful to mimic device behaviour from userspace.
> >
> > Cheers,
> > Benjamin
> >
> >  drivers/hid/uhid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> > index fa0cc0899827..2fa32e7fc733 100644
> > --- a/drivers/hid/uhid.c
> > +++ b/drivers/hid/uhid.c
> > @@ -284,7 +284,7 @@ static int uhid_hid_set_report(struct hid_device *hid, unsigned char rnum,
> >                 goto unlock;
> >
> >         if (uhid->report_buf.u.set_report_reply.err)
> > -               ret = -EIO;
> > +               ret = -uhid->report_buf.u.set_report_reply.err;
>
> I am generally in favor of this. But:
>
> 1) can you do this for both set_report *and* get_report?

right :)

>
> 2) I think you have to filter some of the error codes. For instance,
> if you return one of the -ERESTARTSYS codes, this might cause the
> syscall to restart (if auto-restart is enabled on this context). At
> the same time, this is not *that* bad. It might even be useful for the
> userspace driver to trigger an EINTR. At least we should be aware of
> this. So maybe filters are not necessary.. Mhhh. Comments?

I haven't thought at all of the side effects of letting the user
return a random error code.
I have the impression that anything below EHWPOISON (133) is
relatively safe. So maybe we should just make sure the error code is
below 134?

The ERESTARTSYS has a few warnings in the include file, so I guess the
side effects might be too much for what we want to deal with.

Cheers,
Benjamin

>
> Thanks
> David
>
> >         else
> >                 ret = count;
> >
> > --
> > 2.19.2
> >
