From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/5] i8042: Prepare i8042 driver for DT support
Date: Tue, 3 Feb 2015 11:38:35 -0800
Message-ID: <20150203193835.GC20256@dtor-ws>
References: <1422913730-12663-1-git-send-email-v1ron@v1ros.org>
 <1422913730-12663-4-git-send-email-v1ron@v1ros.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422913730-12663-4-git-send-email-v1ron@v1ros.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Roman Volkov <v1ron@v1ros.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roman Volkov <v1ron@mail.ru>, Tony Prisk <linux@prisktech.co.nz>
List-Id: linux-input@vger.kernel.org

On Tue, Feb 03, 2015 at 12:48:49AM +0300, Roman Volkov wrote:
> Use platform_device_probe() instead of platform_create_bundle() when
> compiled with DT support, since the latter function is not suitable for
> handling the OF device tree.
> 
> The order of initialization is changed, since i8042_platform_init() for DT
> requires initialized platform_device structure. To avoid searching of the
> compatible node twice, the platform_device structure pointer must be passed
> to the i8042_platform_init() function right after initialization by
> platform_device_probe().
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> Signed-off-by: Roman Volkov <v1ron@v1ros.org>
> ---
> 
> Yes, many of these ifdefs look ugly. Suggestions on how to avoid this are
> welcome (except using of_find_compatible_node() for searching the node twice
> before calling the probe function).

I guess we need to split the dirver into part that create platform
device and the standard driver part. Then your OF code can supply most
of the needed data via resources/platform data. Yes, it is a larger
change, but the current splat of ifdefs makes my eyes water.

Thanks.

-- 
Dmitry
