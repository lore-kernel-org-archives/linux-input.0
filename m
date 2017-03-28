From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v4] Documentation: Input: Add uinput documentation
Date: Tue, 28 Mar 2017 10:34:57 +1000
Message-ID: <20170328003456.GB12967@jelly>
References: <20170328000306.6264-1-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:46676 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753276AbdC1A7P (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 20:59:15 -0400
Content-Disposition: inline
In-Reply-To: <20170328000306.6264-1-marcos.souza.org@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 27, 2017 at 09:01:19PM -0300, Marcos Paulo de Souza wrote:
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
> 
>  v3 -> v4:
>  Add comment and a sleep call before UI_DEV_DESTROY (requested by Peter)
>  On emit function, add an fd parameter, avoiding global variables
>  Check return of ioctl related to older kernels that don't have UI_GET_VERSION
>  Fix typos
> 
>  v2 -> v3
>  Changes in libevdev's description (suggested by Peter)
>  Added uinput version check when using the old interface (suggested by Peter)
>  Removed section numbers from sections, sphinx creates these indexes
>         (suggestion by Jon)
> 
>  v1 -> v2:
>  Changes all over the place, including better descriptions (suggested by Peter)
>  Added comments about the need of a sleep call (suggested by Peter)
> 
>  Documentation/input/uinput.rst | 229 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 229 insertions(+)
>  create mode 100644 Documentation/input/uinput.rst
> 
> diff --git a/Documentation/input/uinput.rst b/Documentation/input/uinput.rst
> new file mode 100644
> index 0000000..47a5c4d
> --- /dev/null
> +++ b/Documentation/input/uinput.rst
> @@ -0,0 +1,229 @@
> +=============
> +uinput module
> +=============
> +
> +Introduction
> +============
> +
> +uinput is a kernel module that makes it possible to emulate input devices from
> +userspace. By writing to the module's /dev/uinput (or /dev/input/uinput), a
> +process can create a virtual device with specific capabilities.
> +Once created, the process can send events through that virtual device.
> +
> +Interface
> +=========
> +
> +::
> +
> +  linux/uinput.h
> +
> +The uinput header defines ioctls to create, setup and destroy virtual devices.
> +
> +libevdev
> +========
> +
> +libevdev is a wrapper library for evdev devices that provides interfaces to
> +create uinput devices and send events. libevdev is less error-prone than
> +accessing uinput directly and should be considered for new software
> +
> +For examples and more information about libevdev:
> +https://www.freedesktop.org/software/libevdev/doc/latest/
> +
> +Examples
> +========
> +
> +Keyboard events
> +---------------
> +
> +This first example shows how to create a new virtual device and how to send a
> +key event. All default imports and error handlers were removed for the sake of
> +simplicity.
> +
> +.. code-block:: c
> +
> +   #include <linux/uinput.h>
> +
> +   void emit(int fd, int type, int code, int val)
> +   {
> +      struct input_event ie;
> +
> +      ie.type = type;
> +      ie.code = code;
> +      ie.value = val;
> +      /* below timestamp values are ignored */
> +      ie.time.tv_sec = 0;
> +      ie.time.tv_usec = 0;
> +
> +      write(fd, &ie, sizeof(ie));
> +   }
> +
> +   int main(void)
> +   {
> +      struct uinput_setup usetup;
> +
> +      int fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
> +
> +      /* the ioctls below enables the to be created device to send key
> +       * events, in this case the space key
> +       */
> +      ioctl(fd, UI_SET_EVBIT, EV_KEY);
> +      ioctl(fd, UI_SET_KEYBIT, KEY_SPACE);
> +
> +      memset(&usetup, 0, sizeof(usetup));
> +      usetup.id.bustype = BUS_USB;
> +      usetup.id.vendor = 0x1234; /* sample vendor */
> +      usetup.id.product = 0x5678; /* sample product */
> +      strcpy(usetup.name, "Example device");
> +
> +      ioctl(fd, UI_DEV_SETUP, &usetup);
> +      ioctl(fd, UI_DEV_CREATE);
> +
> +      /*
> +       * On UI_DEV_CREATE the kernel creates the device nodes for this device.
> +       * Insert a pause so that userspace has time to detect, initialize the
> +       * new device, and can start to listen to events from this device
> +       */
> +      sleep(1);
> +
> +      /* key press, report the event, send key release, and report again */
> +      emit(fd, EV_KEY, KEY_SPACE, 1);
> +      emit(fd, EV_SYN, SYN_REPORT, 0);
> +      emit(fd, EV_KEY, KEY_SPACE, 0);
> +      emit(fd, EV_SYN, SYN_REPORT, 0);
> +
> +      /* Give userspace some time to read the events before we destroy the
> +       * device with UI_DEV_DESTOY
> +       */
> +      sleep(1);
> +
> +      ioctl(fd, UI_DEV_DESTROY);
> +      close(fd);
> +
> +      return 0;
> +   }
> +
> +Mouse movements
> +---------------
> +
> +This example shows how to create a virtual device that behaves like a physical
> +mouse.
> +
> +.. code-block:: c
> +
> +   #include <linux/uinput.h>
> +
> +   /* emit function is identical to of the first example */
> +
> +   int main(void)
> +   {
> +      struct uinput_setup usetup;
> +      int i = 50;
> +
> +      int fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
> +
> +      /* enable mouse button left and relative events */
> +      ioctl(fd, UI_SET_EVBIT, EV_KEY);
> +      ioctl(fd, UI_SET_KEYBIT, BTN_LEFT);
> +
> +      ioctl(fd, UI_SET_EVBIT, EV_REL);
> +      ioctl(fd, UI_SET_RELBIT, REL_X);
> +      ioctl(fd, UI_SET_RELBIT, REL_Y);
> +
> +      memset(&usetup, 0, sizeof(usetup));
> +      usetup.id.bustype = BUS_USB;
> +      usetup.id.vendor = 0x1234; /* sample vendor */
> +      usetup.id.product = 0x5678; /* sample product */
> +      strcpy(usetup.name, "Example device");
> +
> +      ioctl(fd, UI_DEV_SETUP, &usetup);
> +      ioctl(fd, UI_DEV_CREATE);
> +
> +      /*
> +       * On UI_DEV_CREATE the kernel creates the device nodes for this device.
> +       * Insert a pause so that userspace has time to detect, initialize the
> +       * new device, and can start to listen to events from this device
> +       */
> +      sleep(1);
> +
> +      /* moves the mouse diagonally, 5 units per axis */
> +      while (i--) {
> +         emit(fd, EV_REL, REL_X, 5);
> +         emit(fd, EV_REL, REL_Y, 5);
> +         emit(fd, EV_SYN, SYN_REPORT, 0);
> +         usleep(15000);
> +      }
> +
> +      /* Give userspace some time to read the events before we destroy the
> +       * device with UI_DEV_DESTOY
> +       */
> +      sleep(1);
> +
> +      ioctl(fd, UI_DEV_DESTROY);
> +      close(fd);
> +
> +      return 0;
> +   }
> +
> +
> +uinput old interface
> +--------------------
> +
> +Before uinput version 5, there wasn't a proper ioctl to setup a virtual device.
> +In this case, the user needs to fill a different struct and call write o the

typo "write o" → "write to"

> +uinput file descriptor to configure the new uinput device. New code should not
> +use the old interface, and interact with uinput via ioctl calls, or using

s/, and/but/
s/using/use/

> +libevdev.
> +
> +.. code-block:: c
> +
> +   #include <linux/uinput.h>
> +
> +   /* emit function is identical to of the first example */
> +
> +   int main(void)
> +   {
> +      struct uinput_user_dev uud;
> +      int version;
> +
> +      int fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
> +      ioctl(fd, UI_GET_VERSION, &version);
> +
> +      if (version >= 4) {

sorry, you misunderstood what I meant in the last email.
You can get versions 4, 5, ... and EINVAL from the ioctl, in case of EINVAL
or version 4, you need to go with the old style, otherwise with the new
style.

The check you need here is:

   rc = ioctl(fd, UI_GET_VERSION, &version);
   if (version <= 4 || (rc == -1 && errno == EINVAL)) {
       ... old style
   }

   or even better:

   rc = ioctl(fd, UI_GET_VERSION, &version);
   if (rc == 0 && version >= 5) {
        /* use UI_DEV_SETUP */
        return;
   }

   ... old style

Cheers,
   Peter

> +         /*
> +          * the ioctls below enables the to be created device to key
> +          * events, in this case the space key
> +          */
> +         ioctl(fd, UI_SET_EVBIT, EV_KEY);
> +         ioctl(fd, UI_SET_KEYBIT, KEY_SPACE);
> +
> +         memset(&uud, 0, sizeof(uud));
> +         snprintf(uud.name, UINPUT_MAX_NAME_SIZE, "uinput old interface");
> +         write(fd, &uud, sizeof(uud));
> +
> +         ioctl(fd, UI_DEV_CREATE);
> +
> +         /*
> +          * On UI_DEV_CREATE the kernel creates the device nodes for this device
> +          * Insert a pause so that userspace has time to detect, initialize the
> +          * new device, and can start to listen to events from this device
> +          */
> +         sleep(1);
> +
> +         /* key press, report the event, send key release, and report again */
> +         emit(fd, EV_KEY, KEY_SPACE, 1);
> +         emit(fd, EV_SYN, SYN_REPORT, 0);
> +         emit(fd, EV_KEY, KEY_SPACE, 0);
> +         emit(fd, EV_SYN, SYN_REPORT, 0);
> +
> +         /* Give userspace some time to read the events before we destroy the
> +          * device with UI_DEV_DESTOY
> +          */
> +         sleep(1);
> +
> +         ioctl(fd, UI_DEV_DESTROY);
> +      }
> +
> +      close(fd);
> +      return 0;
> +   }
> +
> -- 
> 2.9.3
> 
