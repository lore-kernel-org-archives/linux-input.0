From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] HID: i2c-hid: add reset gpio property
Date: Fri, 3 Nov 2017 19:29:35 -0700
Message-ID: <20171104022934.GA110548@google.com>
References: <1509418996-25348-1-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1509418996-25348-1-git-send-email-hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 31, 2017 at 11:03:15AM +0800, Lin Huang wrote:
> some i2c hid devices have reset gpio, need to control
> it in the driver.
> 
> Signed-off-by: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> Changes in v2:
> - Add 10us in usleep_range() upper range
> - reuse post_power_delay_ms as deassert reset delay
> - delete deassert_reset_us property
> 
>  drivers/hid/i2c-hid/i2c-hid.c         | 61 +++++++++++++++++++++++++++--------
>  include/linux/platform_data/i2c-hid.h |  3 ++
>  2 files changed, 50 insertions(+), 14 deletions(-)

Reviewed-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
