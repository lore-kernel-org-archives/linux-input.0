From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] HID: hiddev: store hiddev's minor number when hiddev
 is connected
Date: Thu, 2 Mar 2017 15:13:06 +0100
Message-ID: <20170302141306.GO7064@mail.corp.redhat.com>
References: <1488462330-12349-1-git-send-email-climbbb.kim@gmail.com>
 <1488462330-12349-3-git-send-email-climbbb.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1488462330-12349-3-git-send-email-climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mar 02 2017 or thereabouts, Jaejoong Kim wrote:
> The hid-core announces kernel message which driver is loaded if there is
> a hiddev, but hiddev's minor number is always zero even though it's not
> zero.
> 
> So, we need to store the minor number asked from usb core and do some
> refactoring work(move from hiddev.c to hiddev.h) to access hiddev in
> hid-core.
> 
> Signed-off-by: Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/hid/hid-core.c      |  2 +-
>  drivers/hid/usbhid/hiddev.c | 26 +++-----------------------
>  include/linux/hiddev.h      | 24 ++++++++++++++++++++++++
>  3 files changed, 28 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index e9e87d3..1a0b910 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1695,7 +1695,7 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
>  		len += sprintf(buf + len, "input");
>  	if (hdev->claimed & HID_CLAIMED_HIDDEV)
>  		len += sprintf(buf + len, "%shiddev%d", len ? "," : "",
> -				hdev->minor);
> +				((struct hiddev *)hdev->hiddev)->minor);
>  	if (hdev->claimed & HID_CLAIMED_HIDRAW)
>  		len += sprintf(buf + len, "%shidraw%d", len ? "," : "",
>  				((struct hidraw *)hdev->hidraw)->minor);
> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> index 5c2c489..ef83d68 100644
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -44,29 +44,6 @@
>  #define HIDDEV_MINOR_BASE	96
>  #define HIDDEV_MINORS		16
>  #endif
> -#define HIDDEV_BUFFER_SIZE	2048
> -
> -struct hiddev {
> -	int minor;
> -	int exist;
> -	int open;
> -	struct mutex existancelock;
> -	wait_queue_head_t wait;
> -	struct hid_device *hid;
> -	struct list_head list;
> -	spinlock_t list_lock;
> -};
> -
> -struct hiddev_list {
> -	struct hiddev_usage_ref buffer[HIDDEV_BUFFER_SIZE];
> -	int head;
> -	int tail;
> -	unsigned flags;
> -	struct fasync_struct *fasync;
> -	struct hiddev *hiddev;
> -	struct list_head node;
> -	struct mutex thread_lock;
> -};
>  
>  /*
>   * Find a report, given the report's type and ID.  The ID can be specified
> @@ -911,6 +888,9 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
>  		kfree(hiddev);
>  		return -1;
>  	}
> +
> +	hiddev->minor = usbhid->intf->minor;
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/hiddev.h b/include/linux/hiddev.h
> index a5dd814..ff3701b 100644
> --- a/include/linux/hiddev.h
> +++ b/include/linux/hiddev.h
> @@ -32,6 +32,30 @@
>   * In-kernel definitions.
>   */
>  
> +#define HIDDEV_BUFFER_SIZE      2048
> +
> +struct hiddev {
> +	int minor;
> +	int exist;
> +	int open;
> +	struct mutex existancelock;
> +	wait_queue_head_t wait;
> +	struct hid_device *hid;
> +	struct list_head list;
> +	spinlock_t list_lock;
> +};
> +
> +struct hiddev_list {
> +	struct hiddev_usage_ref buffer[HIDDEV_BUFFER_SIZE];
> +	int head;
> +	int tail;
> +	unsigned flags;
> +	struct fasync_struct *fasync;
> +	struct hiddev *hiddev;
> +	struct list_head node;
> +	struct mutex thread_lock;
> +};

Why do you need to also export struct hiddev_list? Unless I am missing
something we don't need it elsewhere but in hiddev.c, and so there is no
point exporting this struct to the world.

With this change amended, the end result looks good and the series
should be ready to be integrated IMO.

Cheers,
Benjamin

> +
>  struct hid_device;
>  struct hid_usage;
>  struct hid_field;
> -- 
> 2.7.4
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
