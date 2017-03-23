From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: [PATCH] Documentation: Input: Add uinput documentation
Date: Wed, 22 Mar 2017 23:54:48 -0300
Message-ID: <20170323025446.GA10447@xfiles>
References: <20170322025820.4108-1-marcos.souza.org@gmail.com>
 <20170322025820.4108-2-marcos.souza.org@gmail.com>
 <20170322040331.GA7293@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34146 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbdCWCy6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Mar 2017 22:54:58 -0400
Content-Disposition: inline
In-Reply-To: <20170322040331.GA7293@jelly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org

Hi Peter,

first of all, thanks a lot for reading this patch so quickly and to
point a lot of things to make this doc way better.

See some notes below.

On Wed, Mar 22, 2017 at 02:03:31PM +1000, Peter Hutterer wrote:
> Thanks for this, I'm getting enough questions about this, so it's nice to
> have a link :)
> 
> First comment: I don't think rst requires unwrapped lines, so please break
> those up.
> 
> Second comment: I'd really like to have a link to libevdev here. It has a
> uinput interface that's a bit more obvious and takes some of the guesswork
> out. While it's good to have documentation for the kernel module,
> application authors should really use libevdev's uinput interface.
> 
> On Tue, Mar 21, 2017 at 11:58:17PM -0300, Marcos Paulo de Souza wrote:
> > Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> > ---
> >  Documentation/input/uinput.rst | 158 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 158 insertions(+)
> >  create mode 100644 Documentation/input/uinput.rst
> > 
> > diff --git a/Documentation/input/uinput.rst b/Documentation/input/uinput.rst
> > new file mode 100644
> > index 0000000..8d59c98
> > --- /dev/null
> > +++ b/Documentation/input/uinput.rst
> > @@ -0,0 +1,158 @@
> > +=============
> > +uinput module
> > +=============
> > +
> > +Introduction
> > +============
> > +
> > +uinput is a kernel module that makes possible create and handle input
> 
> typo: "that makes it possible to ..."

Fixed here.

> 
> > devices from userspace. By using /dev/uinput (or /dev/input/uinput), a
> > process can create virtual devices and emit events like key pressing,
> > mouse movements and joystick buttons.
> 
> I'd say something like this: "By writing to the module's /dev/uinput (or
> /dev/input/uinput) file, a process can create a virtual device with specific
> capabilities. Once created, the process can send events through that virtual
> device."

Much better, fixed.

> 
> > +
> > +Interface
> > +=========
> > +
> > +::
> > +
> > +  linux/uinput.h
> > +
> > +The uinput header defines ioctl request keys to create, setup and destroy virtual devices, along with ioctls specific to uinput devices, like enabling events and keys to be send to the kernel.
> 
> 'request keys' - is this the official name for ioctl numbers? If not, let's
> just use "define ioctls" or "ioctl numbers" or something, because the term
> "keys" is heavily overloaded. And anything after "along with... " is
> superfluous.

I prefer the "define ioctls", I don't remember where I found that "keys"
definition tough...

> 
> > +
> > +Examples
> > +========
> > +
> > +1.0 Keyboard events
> > +-------------------
> > +
> > +This first example shows how to create a new virtual device and how to
> > send a key event as well as a physical keyboard. All default imports and
> 
> "as well as" in english usually means "in addition". Just skip the part
> after "send a key event".

I think you now know that I'm not an English native speaker :)
Fixed here.

> 
> > error handlers were removed for the sake of simplicity.
> > +
> > +.. code-block:: c
> > +
> > +   #include <linux/uinput.h>
> > +
> > +   int fd;
> > +
> > +   void emit(int type, int code, int val)
> > +   {
> > +        struct input_event ie;
> 
> empty line here.

Fixed.

> 
> > +        memset(&ie, 0, sizeof(ie));
> > +        ie.type = type;
> > +        ie.code = code;
> > +        ie.value = val;
> > +
> 
> memset followed by three out of five filled in seems strange. Just add
>       ie.time.tv_sec = 0;
>       ie.time.tv_usec = 0;
> 
> ideally, with a comment that states that the timestamp is ignored :)

All the code in this doc is the result of my tests using uinput, so
somethings were set in my code some time ago and were never touched
again. Yes, this makes things a way better :)

> 
> > +        if (write(fd, &ie, sizeof(ie)) < 0) {
> > +                perror("write2");
> > +                exit(1);
> > +        }
> > +   }
> > +
> > +   int main() {
> > +        struct input_id uid;
> > +        struct uinput_setup usetup;
> > +
> > +        fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
> 
> Empty line here to separate the open from the actual setup. And a comment
> explaining what this does wouldn't go amiss.

Very good, fixed here.
> 
> 
> > +        ioctl(fd, UI_SET_EVBIT, EV_KEY);
> > +        ioctl(fd, UI_SET_KEYBIT, KEY_SPACE);
> > +
> > +        memset(&uid, 0, sizeof(iod));
> > +        memset(&usetup, 0, sizeof(usetup));
> > +        usetup.id = uid;
> 
> this is a bit strange - you're memsetting the id field anyway with the
> usetup memset - it's superfluous. Given this is supposed to be example code,
> something immediately obvious would help:
>    usetup.id.bustype = BUS_USB;
>    usetup.id.vendor = 0x1234; /* sample vendor */

Good. Fixed.
>    ... 
> 
> > +        strcpy(usetup.name, "ex_device");
> 
> Surely we have enough bytes to name this "Example device" for obviousness :)
Sure, fixed :)
> 
> > +
> > +        ioctl(fd, UI_DEV_SETUP, &usetup);
> > +        ioctl(fd, UI_DEV_CREATE);
> > +
> > +        /* wait some time until the Window Manager can get the reference for the
> > +         * new virtual device to receive data from
> > +         * */
> > +        sleep(1);
> 
> This needs to be more generic, because the WM is the last thing that
> actually cares about the device.
> 
> "UI_DEV_CREATE causes the kernel to create the device nodes for this device.
> Insert a pause so that userspace has time to detect, initialize the new
> device, and can start to listen to events from this device."

Fixed.

> 
> > +
> > +        /* send key press, report the event, send key release, and report again */
> > +        emit(EV_KEY, KEY_SPACE, 1);
> > +        emit(EV_SYN, SYN_REPORT, 0);
> > +        emit(EV_KEY, KEY_SPACE, 0);
> > +        emit(EV_SYN, SYN_REPORT, 0);
> 
> UI_DEV_DESTROY is missing
Fixed.

> 
> > +
> > +        close(fd);
> > +
> > +        return 0;
> > +   }
> > +
> > +2.0 Mouse movements
> > +-------------------
> > +
> > +This example shows how to create a virtual device who behaves like a physical mouse.
> 
> s/who/that/
Fixed.

> 
> > +
> > +.. code-block:: c
> > +
> > +    int i = 50;
> > +
> > +    /* emit function is the same of the example above */
> 
> s/the same of/identical to/
Fixed.

> 
> > +
> > +    void emit_rel(int code, int val, int syn)
> > +    {
> > +            emit(EV_REL, code, val);
> > +            if (syn)
> > +                    emit(EV_SYN, SYN_REPORT, 0);
> > +    }
> 
> No to this bit, see below ***
> 
> > +
> > +    /* ...open uinput file as shown in the previous example... */
> > +
> > +    /* enable mouse button left and relative events. This makes the Window Manager to interpret this
> > +     * device as a physical mouse
> > +     */
> 
> skip the second sentence, it's not accurate enough
Fixed.

> 
> > +    if (ioctl(fd, UI_SET_EVBIT, EV_KEY) == -1) {
> > +            perror("ioctl0");
> > +            exit(1);
> > +    }
> 
> you didn't check for errors above, but you're doing so here. This is a tad
> confusing, especially with the ioctl0.1 naming. Just skip the error checking
> for this example as well.

I was in a hurry yesterday, so it went this way...
Fixed.

> 
> > +
> > +    if (ioctl(fd, UI_SET_KEYBIT, BTN_LEFT) == -1) {
> > +            perror("ioctl0.1");
> > +            exit(1);
> > +    }
> > +
> > +    if (ioctl(fd, UI_SET_EVBIT, EV_REL) == -1) {
> > +            perror("ioctl1");
> > +            exit(1);
> > +    }
> > +
> > +    if (ioctl(fd, UI_SET_RELBIT, REL_X) == -1) {
> > +            perror("ioctl2");
> > +            exit(1);
> > +    }
> > +
> > +    if (ioctl(fd, UI_SET_RELBIT, REL_Y) == -1) {
> > +            perror("ioctl3");
> > +            exit(1);
> > +    }
> > +
> > +    /* ...device setup, device create... */
> 
> you're skipping 5 lines or so here, at the cost of making the example not
> self-contained...
Yes, horrible. All examples are now self-contained, just mentioning the
emit function in the first example.
> 
> > +
> > +    /* Give some time for the Window Manager to get events of the new virtual device */
> > +    sleep(1);
> 
> same as in the other example
Fixed.

> 
> > +
> > +    /* moves the mouse diagonally, 5 units per axis */
> > +    while (i--) {
> > +                emit_rel(REL_X, 5, 0);
> > +                emit_rel(REL_Y, 5, 1);
> 
> *** (continuation): just use emit three times for x/y and syn. the helper
> function does almost nothing but make the code more convoluted.
yes, much more clear. Fixed.
> 
> > +                usleep(15000);
> > +    }
> > +
> > +    /* device destroy, device close */
> 
> same here, this is 2 lines you're skipping here...
> 
> > +    return 0;
> > +
> > +3.0 uinput old interface
> > +------------------------
> > +
> > +Before kernel 4.5, uinput didn't have an ioctl to setup a virtual device. When running a version prior to 4.5, the user needs to fill a different struct and call write on the uinput file descriptor.
> 
> this was merged in 4.5 (can't remember, didn't check) but the version
> that matters is what's returned from UI_GET_VERSION (version 5). Though then
> you should add that UI_GET_VERSION itself wasn't added until version 5 :)

Nice, I will add some code testng the uinput version. Thanks for the
suggestion!

> 
> > +
> > +.. code-block:: c
> > +
> > +        /* add include of uinput header */
> > +        struct uinput_user_dev uud;
> > +
> > +        /* open uinput device, and set the proper events */
> > +
> > +        memset(&uud, 0 sizeof(uud));
> > +        snprintf(uud.name, UINPUT_MAX_NAME_SIZE, "uinput_old_style");
> > +        write(fd, &uud, sizeof(uud));
> > +
> > +        /* call DEV_CREATE ioctl, and emit the events */
> 
> again, a complete example should be the minimum here, otherwise it's too
> hard to piece things together.
yes, much better this way.

> 
> Cheers,
>    Peter

I fixed a lot of things today, the things that are still missing are the
libevdev example, and the version check. I do think that I can send a
new version tomorrow.

So, thanks again for your time reviewing this doc!

-- 
Thanks,
	Marcos
