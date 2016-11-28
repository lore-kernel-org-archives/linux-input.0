From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 0/2] more quirks for hid-sensor-hub
Date: Mon, 28 Nov 2016 08:53:17 -0800
Message-ID: <1480351997.6544.236.camel@linux.intel.com>
References: <1480068224-32224-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480068224-32224-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

On Fri, 2016-11-25 at 11:03 +0100, Benjamin Tissoires wrote:
> Hi Jiri,
> 
> here are 2 more quirks for the sensor-hub.
> 
> Srinivas, I am wondering if we can not detect those automatically.
> Looking at the report_fixup, it looks like the buggy report
> descriptors have
> a logical max of 5 (which would correspond to an enum of 0 to 5). But
> there
> are 6 fields in the enum, so that means the report descriptor is just
> wrong.
> 
> Given that Microsoft's driver requires a min of 1, wouldn't it be too
> much
> assumption to say that we need to fix the report descriptor anyway
> when we
> see a range of 0..5 instead of 1..6?

The problem is that they should have also changed logical minimum,
which vendors didn't do as Windows driver will always assume
enumeration base as 1.

As far as I can tell there was only Windows platform where base was 0,
but I am sure that Windows update and BIOS update would have fixed that
by now after 3 years.

I am in opinion to change this to match this with Windows driver, so
that we don't need this quirks. This is a small change in IIO sensor
hub driver.

If nobody has objection, I can submit a trivial change for this.

Thanks,
Srinivas


> 
> Cheers,
> Benjamin
> 
> Benjamin Tissoires (2):
>   HID: sensor-hub add quirk for Microsoft Surface 3
>   HID: sensor-hub: add quirk for Microchip MM7150
> 
>  drivers/hid/hid-sensor-hub.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
