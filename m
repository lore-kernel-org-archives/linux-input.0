From: Benjamin Tissoires <btissoir@redhat.com>
Subject: Re: [PATCH v3] Input: uinput - add new UINPUT_DEV_SETUP and
 UI_ABS_SETUP ioctl
Date: Mon, 9 Nov 2015 02:50:52 -0500 (EST)
Message-ID: <46665760.4161715.1447055452531.JavaMail.zimbra@redhat.com>
References: <1440515579-5359-1-git-send-email-benjamin.tissoires@redhat.com> <CADbOyBTM0dKYik6uHAsA102hwAbhWeXM+QrFba11p+ABoMxi+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADbOyBTM0dKYik6uHAsA102hwAbhWeXM+QrFba11p+ABoMxi+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Elias Vanderstuyft <elias.vds@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org





----- Original Message -----
> From: "Elias Vanderstuyft" <elias.vds@gmail.com>
> To: "Benjamin Tissoires" <benjamin.tissoires@redhat.com>
> Cc: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "David Herrmann" <dh.herrmann@gmail.com>, "Peter Hutterer"
> <peter.hutterer@who-t.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org
> Sent: Sunday, November 8, 2015 11:55:04 AM
> Subject: Re: [PATCH v3] Input: uinput - add new UINPUT_DEV_SETUP and UI_ABS_SETUP ioctl
> 
> Hi,
> 
> On Tue, Aug 25, 2015 at 5:12 PM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > diff --git a/include/uapi/linux/uinput.h b/include/uapi/linux/uinput.h
> > index 013c9d8..ef6c9f5 100644
> > --- a/include/uapi/linux/uinput.h
> > +++ b/include/uapi/linux/uinput.h
> > @@ -20,6 +20,11 @@
> >   * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
> >   *
> >   * Changes/Revisions:
> > + *     0.5     08/13/2015 (David Herrmann <dh.herrmann@gmail.com> &
> > + *                         Benjamin Tissoires
> > <benjamin.tissoires@redhat.com>)
> > + *             - add UI_DEV_SETUP ioctl
> > + *             - add UI_ABS_SETUP ioctl
> > + *             - add UI_GET_VERSION ioctl
> >   *     0.4     01/09/2014 (Benjamin Tissoires
> >   <benjamin.tissoires@redhat.com>)
> >   *             - add UI_GET_SYSNAME ioctl
> >   *     0.3     24/05/2006 (Anssi Hannula <anssi.hannulagmail.com>)
> > @@ -37,8 +42,8 @@
> >  #include <linux/types.h>
> >  #include <linux/input.h>
> >
> > -#define UINPUT_VERSION         4
> > -
> > +#define UINPUT_VERSION         5
> > +#define UINPUT_MAX_NAME_SIZE   80
> >
> >  struct uinput_ff_upload {
> >         __u32                   request_id;
> > @@ -58,6 +63,79 @@ struct uinput_ff_erase {
> >  #define UI_DEV_CREATE          _IO(UINPUT_IOCTL_BASE, 1)
> >  #define UI_DEV_DESTROY         _IO(UINPUT_IOCTL_BASE, 2)
> >
> > +struct uinput_setup {
> > +       struct input_id id;
> > +       char name[UINPUT_MAX_NAME_SIZE];
> > +       __u32 ff_effects_max;
> > +};
> 
> Is there a reason to not follow the same field order as in struct
> uinput_user_dev?

Not really, no.

> I.e., why not:
> 
> struct uinput_setup {
>         char name[UINPUT_MAX_NAME_SIZE];
>         struct input_id id;
>         __u32 ff_effects_max;
> };
> 
> In case you would change this, also make sure to change the order in
> the documentation of UI_DEV_SETUP.
> 

Works for me.
Dmitry, how do you want to handle this change? Me re-sending the whole series or you applying the change directly on your tree?

Cheers,
Benjamin
