From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v3] Documentation: Input: Add uinput documentation
Date: Mon, 27 Mar 2017 11:06:11 +1000
Message-ID: <20170327010611.GA21915@jelly>
References: <20170326164821.10928-1-marcos.souza.org@gmail.com>
 <20170326164821.10928-2-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170326164821.10928-2-marcos.souza.org@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Mar 26, 2017 at 01:48:12PM -0300, Marcos Paulo de Souza wrote:
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  v2 -> v3:
>  Changes in libevdev's description (suggested by Peter)
>  Added uinput version check when using the old interface (suggested by Peter)
>  Removed section numbers from sections, sphinx creates these indexes
>  	(suggestion by Jon)
> 
>  v1 -> v2:
>  Changes all over the place, including better descriptions (suggested by Peter)
>  Added comments about the need of a sleep call (suggested by Peter)
>  


[...]

tested mouse/keyboard - works as expected, thanks. I found it slightly
confusing though that the mouse example wasn't wrapped in main() but still had a
return 0 at the bottom. This code will never change once it's in the doc, so
I'm not sure skipping things is really that useful here.

> +uinput old interface
> +--------------------
> +
> +Before uinput version 5, there wasn't a proper ioctl to setup a virtual device.
> +In this case, the user neesa to fill a different struct and call write o the
> +uinput file descriptor to configure the new uinput device.
> +
> +.. code-block:: c
> +
> +    #include <linux/uinput.h>
> +
> +    /* emit function is identical to of the first example */
> +
> +    struct uinput_user_dev uud;
> +    int version;
> +
> +    fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
> +    ioctl(fd, UI_GET_VERSION, &version);
> +
> +    if (version < 5) {

this won't work on all kernels. UI_GET_VERSION was added in version 4, on
kernels before you get rc == -1 and errno EINVAL. You can only check
for >= 4. Please make sure the example compiles and works on an older
kernel, otherwise there's no point shipping it.

Cheers,
   Peter

> +        /*
> +         * the ioctls below enables the to be created device to key
> +         * events, in this case the space key
> +         */
> +        ioctl(fd, UI_SET_EVBIT, EV_KEY);
> +        ioctl(fd, UI_SET_KEYBIT, KEY_SPACE);
> +
> +        memset(&uud, 0, sizeof(uud));
> +        snprintf(uud.name, UINPUT_MAX_NAME_SIZE, "uinput old interface");
> +        write(fd, &uud, sizeof(uud));
> +
> +        ioctl(fd, UI_DEV_CREATE);
> +
> +        /*
> +         * On UI_DEV_CREATE the kernel creates the device nodes for this device.
> +         * Insert a pause so that userspace has time to detect, initialize the
> +         * new device, and can start to listen to events from this device
> +         */
> +        sleep(1);
> +
> +        /* key press, report the event, send key release, and report again */
> +        emit(EV_KEY, KEY_SPACE, 1);
> +        emit(EV_SYN, SYN_REPORT, 0);
> +        emit(EV_KEY, KEY_SPACE, 0);
> +        emit(EV_SYN, SYN_REPORT, 0);
> +
> +        ioctl(fd, UI_DEV_DESTROY);
> +    }
> +
> +    close(fd);
> +
> +    return 0;
> +
> -- 
> 2.9.3
> 
