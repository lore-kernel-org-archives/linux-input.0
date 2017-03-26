From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v2] Documentation: Input: Add uinput documentation
Date: Mon, 27 Mar 2017 08:52:58 +1000
Message-ID: <20170326225258.GA14405@jelly>
References: <20170324033502.17398-1-marcos.souza.org@gmail.com>
 <20170324033502.17398-2-marcos.souza.org@gmail.com>
 <20170324043913.GA31232@jelly>
 <20170326162112.GA2267@xfiles.domain.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:55199 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbdCZWxU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 26 Mar 2017 18:53:20 -0400
Content-Disposition: inline
In-Reply-To: <20170326162112.GA2267@xfiles.domain.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org

On Sun, Mar 26, 2017 at 01:21:14PM -0300, Marcos Paulo de Souza wrote:
> On Fri, Mar 24, 2017 at 02:39:13PM +1000, Peter Hutterer wrote:
> > as usual, reading through these things multiple times means one spots a
> > couple of different things. sorry about that.
> > 
> > On Fri, Mar 24, 2017 at 12:34:59AM -0300, Marcos Paulo de Souza wrote:
> > > Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> > > ---
> > >  Documentation/input/uinput.rst | 196 +++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 196 insertions(+)
> > >  create mode 100644 Documentation/input/uinput.rst
> > > 
> > > diff --git a/Documentation/input/uinput.rst b/Documentation/input/uinput.rst
> > > new file mode 100644
> > > index 0000000..eb79b77
> > > --- /dev/null
> > > +++ b/Documentation/input/uinput.rst
> > > @@ -0,0 +1,196 @@
> > > +=============
> > > +uinput module
> > > +=============
> > > +
> > > +Introduction
> > > +============
> > > +
> > > +uinput is a kernel module that makes possible to create and handle input devices
> > 
> > typo: makes *it* possible.
> > 
> > replace "to create and handle" with "to emulate", the rest is in the next
> > sentence anyway
> 
> Fixed.
> 
> > 
> > > +from userspace. By writing to the module's /dev/uinput (or /dev/input/uinput), a
> > > +process can create a virtual device with specific capabilities.
> > > +Once created, the process can send events through that virtual device.
> > > +
> > > +Interface
> > > +=========
> > > +
> > > +::
> > > +
> > > +  linux/uinput.h
> > > +
> > > +The uinput header defines ioctls to create, setup and destroy virtual devices.
> > > +
> > > +libevdev
> > > +========
> > > +
> > > +libevdev is a wrapper library for evdev devices, making uinput setup easier
> > > +by skipping a lot of ioctl calls. When dealing with uinput, libevdev is the best
> > > +alternative over accessing uinput directly, and it is less error prone.
> > 
> > "libevdev is a wrapper library for evdev devices that provides interfaces to
> > create uinput devices and send events. libevdev is less error-prone than
> > accessing uinput directly and should be considered for new software".
> 
> Much better. Fixed.
> 
> > 
> > > +
> > > +For examples and more information about libevdev:
> > > +https://cgit.freedesktop.org/libevdev
> > > +
> > 
> > Please use https://www.freedesktop.org/software/libevdev/doc/latest/
> > (which needs a link to the git repo, I'll fix that in a minute)
> 
> Fixed.
> 
> > 
> > > +Examples
> > > +========
> > > +
> > > +1.0 Keyboard events
> > > +-------------------
> > > +
> > > +This first example shows how to create a new virtual device and how to send a
> > > +key event. All default imports and error handlers were removed for the sake of
> > > +simplicity.
> > > +
> > > +.. code-block:: c
> > > +
> > > +   #include <linux/uinput.h>
> > > +
> > > +   int fd;
> > > +
> > > +   void emit(int type, int code, int val)
> > > +   {
> > > +        struct input_event ie;
> > > +
> > > +        ie.type = type;
> > > +        ie.code = code;
> > > +        ie.value = val;
> > > +        /* below timestamp values are ignored */
> > > +        ie.time.tv_sec = 0;
> > > +        ie.time.tv_usec = 0;
> > > +
> > > +        write(fd, &ie, sizeof(ie));
> > > +   }
> > > +
> > > +   int main() {
> > > +        struct uinput_setup usetup;
> > > +
> > > +        fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
> > > +
> > > +        /* the ioctls below enables the to be created device to key
> > > +         * events, in this case the space key
> > > +         **/
> > 
> > the comment terminator doesn't look right
> 
> Fixed.
> 
> > 
> > > +        ioctl(fd, UI_SET_EVBIT, EV_KEY);
> > > +        ioctl(fd, UI_SET_KEYBIT, KEY_SPACE);
> > > +
> > > +        memset(&usetup, 0, sizeof(usetup));
> > > +        usetup.id.bustype = BUS_USB;
> > > +        usetup.id.vendor = 0x1234; /* sample vendor */
> > 
> > add a sample product id too please
> Added.
> 
> > 
> > > +        strcpy(usetup.name, "Example device");
> > > +
> > > +        ioctl(fd, UI_DEV_SETUP, &usetup);
> > > +        ioctl(fd, UI_DEV_CREATE);
> > > +
> > > +        /* UI_DEV_CREATE causes the kernel to create the device nodes for this
> > 
> > "On UI_DEV_CREATE the kernel creates the device nodes..."
> Fixed.
> 
> > 
> > > +         * device. Insert a pause so that userspace has time to detect,
> > > +         * initialize the new device, and can start to listen to events from
> > > +         * this device
> > > +         **/
> > 
> > the comment terminator doesn't look right
> > 
> > note: the actual pause is missing now :)
> 
> I thought you wanted just the warning, but ok, I added back the sleep
> call :)

better to have something that can be copy-pasted and works than expecting
people to add misc bits.

> > > +
> > > +        /* key press, report the event, send key release, and report again */
> > > +        emit(EV_KEY, KEY_SPACE, 1);
> > > +        emit(EV_SYN, SYN_REPORT, 0);
> > > +        emit(EV_KEY, KEY_SPACE, 0);
> > > +        emit(EV_SYN, SYN_REPORT, 0);
> > 
> > come to think of it, you probably need a pause here too, iirc a caller may
> > get ENODEV before reading the key events otherwise.
> 
> We need a sleep call after each emitted event?

no, I think we need a sleep between the final emit and the
UI_DEV_DESTROY, otherwise those events may not get delivered (not 100%
sure).

Cheers,
   Peter

> 
> > 
> > > +
> > > +        ioctl(fd, UI_DEV_DESTROY);
> > > +        close(fd);
> > > +
> > > +        return 0;
> > > +   }
> > > +
> > > +2.0 Mouse movements
> > > +-------------------
> > > +
> > > +This example shows how to create a virtual device that behaves like a physical
> > > +mouse.
> > > +
> > > +.. code-block:: c
> > > +
> > > +    #include <linux/uinput.h>
> > > +
> > > +    /* emit function is identical to of the first example */
> > > +
> > > +    struct uinput_setup usetup;
> > > +    int i = 50;
> > > +
> > > +    fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
> > > +
> > > +    /* enable mouse button left and relative events */
> > > +    ioctl(fd, UI_SET_EVBIT, EV_KEY);
> > > +    ioctl(fd, UI_SET_KEYBIT, BTN_LEFT);
> > > +
> > > +    ioctl(fd, UI_SET_EVBIT, EV_REL);
> > > +    ioctl(fd, UI_SET_RELBIT, REL_X);
> > > +    ioctl(fd, UI_SET_RELBIT, REL_Y);
> > > +
> > > +    memset(&usetup, 0, sizeof(usetup));
> > > +    usetup.id.bustype = BUS_USB;
> > > +    usetup.id.vendor = 0x1234; /* sample vendor */
> > > +    strcpy(usetup.name, "Example device");
> > > +
> > > +    ioctl(fd, UI_DEV_SETUP, &usetup);
> > > +    ioctl(fd, UI_DEV_CREATE);
> > > +
> > > +    /* UI_DEV_CREATE causes the kernel to create the device nodes for this
> > > +     * device. Insert a pause so that userspace has time to detect,
> > > +     * initialize the new device, and can start to listen to events from
> > > +     * this device
> > > +     **/
> > > +
> > > +    /* moves the mouse diagonally, 5 units per axis */
> > > +    while (i--) {
> > > +        emit(EV_REL, REL_X, 5);
> > > +        emit(EV_REL, REL_Y, 5);
> > > +        emit(EV_SYN, SYN_REPORT, 0);
> > > +        usleep(15000);
> > > +    }
> > > +
> > > +    ioctl(fd, UI_DEV_DESTROY);
> > > +    close(fd);
> > > +
> > > +    return 0;
> > > +
> > > +3.0 uinput old interface
> > > +------------------------
> > > +
> > > +Before kernel 4.5, uinput didn't have an ioctl to setup a virtual device. When
> > > +running a version prior to 4.5, the user needs to fill a different struct and
> > > +call write on the uinput file descriptor.
> > 
> > I think this should really include the version check.
> 
> Uhg, I forgot this one again. Fixed here.
> 
> Sending a new version soon.
> 
> > 
> > Cheers,
> >    Peter
> > 
> > > +
> > > +.. code-block:: c
> > > +
> > > +    #include <linux/uinput.h>
> > > +
> > > +    /* emit function is identical to of the first example */
> > > +
> > > +    struct uinput_user_dev uud;
> > > +
> > > +    fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
> > > +
> > > +    /* the ioctls below enables the to be created device to key
> > > +     * events, in this case the space key
> > > +     **/
> > > +    ioctl(fd, UI_SET_EVBIT, EV_KEY);
> > > +    ioctl(fd, UI_SET_KEYBIT, KEY_SPACE);
> > > +
> > > +    memset(&uud, 0, sizeof(uud));
> > > +    snprintf(uud.name, UINPUT_MAX_NAME_SIZE, "uinput old interface");
> > > +    write(fd, &uud, sizeof(uud));
> > > +
> > > +    ioctl(fd, UI_DEV_CREATE);
> > > +
> > > +    /* UI_DEV_CREATE causes the kernel to create the device nodes for this
> > > +     * device. Insert a pause so that userspace has time to detect,
> > > +     * initialize the new device, and can start to listen to events from
> > > +     * this device
> > > +     **/
> > > +
> > > +    /* key press, report the event, send key release, and report again */
> > > +    emit(EV_KEY, KEY_SPACE, 1);
> > > +    emit(EV_SYN, SYN_REPORT, 0);
> > > +    emit(EV_KEY, KEY_SPACE, 0);
> > > +    emit(EV_SYN, SYN_REPORT, 0);
> > > +
> > > +    ioctl(fd, UI_DEV_DESTROY);
> > > +    close(fd);
> > > +
> > > +    return 0;
> > > +
> > > -- 
> > > 2.9.3
> > > 
> 
> -- 
> Thanks,
> 	Marcos
