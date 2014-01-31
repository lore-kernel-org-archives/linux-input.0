From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 6/6] HID: Update the hidraw sample with the usage of HIDIOCGRAWCLIENTADDR
Date: Fri, 31 Jan 2014 14:18:00 -0500
Message-ID: <CAN+gG=GtVBGrm+mPZ3kp1JVoapf6t-XZYjCf4t1k5aQpioRZjA@mail.gmail.com>
References: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
	<1391189573-2591-7-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33555 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932281AbaAaTSC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 14:18:02 -0500
Received: by mail-lb0-f171.google.com with SMTP id c11so3719771lbj.2
        for <linux-input@vger.kernel.org>; Fri, 31 Jan 2014 11:18:00 -0800 (PST)
In-Reply-To: <1391189573-2591-7-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

On Fri, Jan 31, 2014 at 12:32 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> Add the HIDIOCGRAWCLIENTADDR ioctl to the hidraw sample program.
>

I would personally squash this one with the previous one, but this is
more a matter of taste IMO.

> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
>  samples/hidraw/hid-example.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/samples/hidraw/hid-example.c b/samples/hidraw/hid-example.c
> index 512a7e5..dbf072d 100644
> --- a/samples/hidraw/hid-example.c
> +++ b/samples/hidraw/hid-example.c
> @@ -23,6 +23,10 @@
>  #define HIDIOCSFEATURE(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x06, len)
>  #define HIDIOCGFEATURE(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x07, len)
>  #endif
> +#ifndef HIDIOCGRAWCLIENTADDR
> +#warning Please have your distro update the userspace kernel headers
> +#define HIDIOCGRAWCLIENTADDR(len) _IOC(_IOC_READ, 'H', 0x08, len)
> +#endif
>
>  /* Unix */
>  #include <sys/ioctl.h>
> @@ -93,6 +97,13 @@ int main(int argc, char **argv)
>         else
>                 printf("Raw Phys: %s\n", buf);
>
> +       /* Get Client Address */
> +       res = ioctl(fd, HIDIOCGRAWCLIENTADDR(256), buf);
> +       if (res < 0)
> +               perror("HIDIOCGRAWCLIENTADDR");
> +       else
> +               printf("Raw Client Address: %s\n", buf);
> +
>         /* Get Raw Info */
>         res = ioctl(fd, HIDIOCGRAWINFO, &info);
>         if (res < 0) {
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
