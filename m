From: Brian Masney <masneyb-1iNe0GrtECGEi8DpZVb4nw@public.gmane.org>
Subject: Re: [PATCH] HID: Add quirk for Lenovo Yoga 910 with ITE Chips
Date: Sun, 16 Jul 2017 06:23:43 -0400
Message-ID: <20170716102343.6p6blg2yzamdxeaw@basecamp>
References: <20170715122721.6908-1-ctx.xda@gmail.com>
 <af21ea47-29df-443d-0a3d-5fc36d8cf119@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <af21ea47-29df-443d-0a3d-5fc36d8cf119-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arek Burdach <arek.burdach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Patrick Pedersen <ctx.xda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Jul 16, 2017 at 09:39:19AM +0200, Arek Burdach wrote:
> Hi Patrick,
> 
> On 15.07.2017 14:27, Patrick Pedersen wrote:
> > It shall additionally be noted that the i2c-hid 'sleep' bug (present since kernel ver. 4.3)
> > still affects the driver. This means that the sensor hub will not report any movement, until
> > the device is suspended and resumed.
> > 
> Do you have workaround for that? In my case suspending and resuming doesn't
> help. Sensor reporting is backing to work in unpredictable way. What I've
> tested:
> 
> - kernel v4.13-rc1 with your patch applied
> - watch -n1 cat /sys/bus/iio/devices/iio\:device*/*_raw <- value not
> changing
> - suspend
> - resume
> - watch -n1 cat /sys/bus/iio/devices/iio\:device*/*_raw <- still not
> changing
> 
> If you have some workaround scenario please add it to bug reported be me:
> https://bugzilla.kernel.org/show_bug.cgi?id=195681

I have a Lenovo Yoga 910-13IKB and verified that the patch works
correctly for me on an upstream 4.12 kernel. The ALS sensor and
accelerometer function correctly without suspending the laptop with
this patch. The difference may be due the following kernel boot options
that I use:

	i915.enable_rc6=0 pci=noaer intel_pstate=disable

I have to disable power management for the CPU/GPU (i915.enable_rc6=0)
since I can only suspend and resume once on this laptop. Suspending a
second time will cause the laptop to hang before the suspend finishes.

The pci=noaer is likely not needed for UEFI firmware revisions 2JCN36WW
and newer. I'm stuck on UEFI firmware revision 2JCN28WW, which is what
came preinstalled on the system. Lenovo's UEFI update tool requires
Windows, which I no longer have.

I need to get on the latest UEFI revision and go through
basic-pm-debugging.txt if the power management issues are still present.

Brian
