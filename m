From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: RE: [PATCH, 3/6] HID-Sensors: Added accelerometer 3D
Date: Wed, 27 Jun 2012 17:35:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1206271733490.17549@pobox.suse.cz>
References: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com> <1340672054-16591-4-git-send-email-srinivas.pandruvada@intel.com> <4FEACE58.20008@metafoo.de> <4FA419E87744DF4DAECD5BCE1214B7A91933F4DA@ORSMSX104.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A91933F4DA-P5GAC/sN6hk64kNsxIetb7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jic23.cam.ac.uk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <jic23.cam.ac.uk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 27 Jun 2012, Pandruvada, Srinivas wrote:

> <IIO has moved out of staging in 3.5, so this won't build with the latest upstream>
>
> Can you please let me know which tree it is merged? I don't see in 
> Linus's tree. I can see in gregkh/staging.git. But don't see your latest 
> changes.

It's in Linus' tree, in drivers/iio. Commit a980e046 moved it out of 
staging. It first appeared in 3.5-rc1.

-- 
Jiri Kosina
SUSE Labs
