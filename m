From: Maulik Mankad <mankad.maulik-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFT]patch to remove kernel thread for runtime pm from usbhid
Date: Tue, 12 Oct 2010 19:56:28 +0530
Message-ID: <AANLkTikSV5F8J=9orcXCej=KV2J9EjvFTYkKXMt7Rjf0@mail.gmail.com>
References: <201010121000.50465.oneukum@suse.de>
	<201010121339.49932.oneukum@suse.de>
	<AANLkTimfK2JeAf2DMV_qw3a4UiZwQKJQfF2HNNU=RWP8@mail.gmail.com>
	<201010121640.48586.oneukum@suse.de>
	<AANLkTim_RN54GrLQ7ZAodwX-GHJ2knCEK-Ugd7FE7-rz@mail.gmail.com>
	<AANLkTin7k23LbW4Lj7qJM=FZLn+AbqEJYpm_ycVUBLFa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTin7k23LbW4Lj7qJM=FZLn+AbqEJYpm_ycVUBLFa-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Oct 12, 2010 at 7:09 PM, Maulik Mankad <mankad.maulik-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:
> Seems like the below commit added that support to sysfs.
>
> commit 8d4b9d1bfef117862a2889dec4dac227068544c9
> Author: Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Date: =A0 Mon Jul 19 02:01:06 2010 +0200
>
> =A0 =A0PM / Runtime: Add runtime PM statistics (v3)
>
> I will see if I can apply this to my kernel and provide the stats you=
 need.
>

I applied the relevant patches to 2.6.35 related to runtime PM and
collected the below statistics.

cat /sys/bus/usb/devices/1-1/power/active_duration
120609

cat /sys/bus/usb/devices/1-1/power/autosuspend
0

cat /sys/bus/usb/devices/1-1/power/connected_duration
220398

cat /sys/bus/usb/devices/1-1/power/control
auto

cat /sys/bus/usb/devices/1-1/power/level
auto

cat /sys/bus/usb/devices/1-1/power/persist
1

cat /sys/bus/usb/devices/1-1/power/runtime_active_time
120523

cat /sys/bus/usb/devices/1-1/power/runtime_status
suspended

cat /sys/bus/usb/devices/1-1/power/runtime_suspended_time
159773

cat /sys/bus/usb/devices/1-1/power/wakeup
enabled

cat /sys/bus/usb/devices/1-1/power/wakeup_count
0

I am not familiar with the runtime pm statistics and can't interpret
the above values.

Let me know if this information is helpful and if you need anything els=
e.

Regards,
Maulik
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
