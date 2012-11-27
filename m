From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH RESEND 3/7] input: ti_am335x_tsc: Add variance filter
Date: Tue, 27 Nov 2012 07:07:12 +0000
Message-ID: <4CE347531D4CA947960AF71FF095B9323E96FBB2@DBDE01.ent.ti.com>
References: <1352271124-5513-1-git-send-email-rachna@ti.com>
 <1352271124-5513-4-git-send-email-rachna@ti.com>
 <20121121183350.GB18950@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121121183350.GB18950-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 22, 2012 at 00:03:50, Dmitry Torokhov wrote:
> Hi Rachna,

Hi Dmitry,

> 
> On Wed, Nov 07, 2012 at 12:22:00PM +0530, Patil, Rachna wrote:
> > Only fine tuning variance parameter present in tslib utility does not 
> > help in removing all the ADC noise.
> > This logic of filtering is necessary to get this touchscreen to work 
> > finely.
> 
> No, if filtering in tslib is not adequate please fix tslib so that your work is usable for other devices as well.

For now I will drop this patch from the patch set and send across the next version of the set with review comments on remaining patches addressed.
I will take up tslib separately.

Regards,
Rachna

> 
> Thanks.
> 
> --
> Dmitry
> 
