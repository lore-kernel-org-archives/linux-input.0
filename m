From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ads7846: Convert to
 devm_hwmon_device_register_with_groups
Date: Mon, 25 Nov 2013 19:03:08 -0800
Message-ID: <20131126030308.GF31517@core.coreip.homeip.net>
References: <1385242620-21719-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385242620-21719-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Guenter,

On Sat, Nov 23, 2013 at 01:37:00PM -0800, Guenter Roeck wrote:
> Simplify the code and create mandatory 'name' attribute by using
> new hwmon API.
> 
> Also use is_visible to determine visible attributes instead of creating
> several different attribute groups.

This change does not quite work without converting the rest of the
driver to devm_ resources as it makes hwmon outlive regulator and other
essential resources when unbinding driver from the device.

Thanks.

-- 
Dmitry
