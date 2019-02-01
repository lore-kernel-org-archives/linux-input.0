From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: intel-ish-hid: Use VID/PID from ISH
Date: Fri, 1 Feb 2019 10:46:43 +0100
Message-ID: <CAO-hwJJBrA8i=p-LbHJJbyngoht=bBqfzBt3jzQKYjOfsCADUA@mail.gmail.com>
References: <20190130213217.8060-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130213217.8060-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jan 30, 2019 at 10:32 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The Intel ISH HID can now have other devices attached to it, not just
> sensors. Hence ISH HID transport is no longer just used for sensors.
> Currently the vendor and product id is hardcoded for sensors, but they
> can be obtained from ISH firmware for the real device. The driver already
> extract them and store as part of device_info structure in client_data.
> So use vendor id/product id obtained from the ISH firmware.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---

Applied to for-5.1/ish

Cheers,
Benjamin

>  drivers/hid/intel-ish-hid/ishtp-hid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
> index e918d78e541c..bc4c536f3c0d 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
> @@ -206,8 +206,8 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
>         hid->bus = BUS_INTEL_ISHTP;
>         hid->dev.parent = &client_data->cl_device->dev;
>         hid->version = le16_to_cpu(ISH_HID_VERSION);
> -       hid->vendor = le16_to_cpu(ISH_HID_VENDOR);
> -       hid->product = le16_to_cpu(ISH_HID_PRODUCT);
> +       hid->vendor = le16_to_cpu(client_data->hid_devices[cur_hid_dev].vid);
> +       hid->product = le16_to_cpu(client_data->hid_devices[cur_hid_dev].pid);
>         snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "hid-ishtp",
>                 hid->vendor, hid->product);
>
> --
> 2.17.2
>
