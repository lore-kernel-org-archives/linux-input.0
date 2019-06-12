From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 2/3] HID: quirks: Refactor ELAN 400 and 401 handling
Date: Tue, 11 Jun 2019 17:35:07 -0700
Message-ID: <20190612003507.GG143729@dtor-ws>
References: <20190606161055.47089-1-jeffrey.l.hugo@gmail.com>
 <20190606161322.47192-1-jeffrey.l.hugo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190606161322.47192-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc: benjamin.tissoires@redhat.com, jikos@kernel.org, bjorn.andersson@linaro.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, agross@kernel.org, david.brown@linaro.org, hdegoede@redhat.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jun 06, 2019 at 09:13:22AM -0700, Jeffrey Hugo wrote:
> There needs to be coordination between hid-quirks and the elan_i2c driver
> about which devices are handled by what drivers.  Currently, both use
> whitelists, which results in valid devices being unhandled by default,
> when they should not be rejected by hid-quirks.  This is quickly becoming
> an issue.
> 
> Since elan_i2c has a maintained whitelist of what devices it will handle,
> use that to implement a blacklist in hid-quirks so that only the devices
> that need to be handled by elan_i2c get rejected by hid-quirks, and
> everything else is handled by default.  The downside is the whitelist and
> blacklist need to be kept in sync.
> 
> Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  drivers/hid/hid-quirks.c | 78 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 67 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index e5ca6fe2ca57..edebd0700e3d 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -912,8 +912,66 @@ static const struct hid_device_id hid_mouse_ignore_list[] = {
>  	{ }
>  };
>  
> +/* 
> + * List of device names that elan_i2c is handling and HID should ignore.  Must
> + * be kept in sync with elan_i2c
> + */
> +static const char *hid_elan_i2c_ignore[] = {

If this is a copy of elan whitelist, then, if we do not want to bother
with sharing it in object form (as a elan-i2c-ids module), can we at
least move it into include/linux/input/elan-i2c-ids.h and consume from
hid-quirks.c?

Thanks.

-- 
Dmitry
