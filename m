From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] i2c: cros-ec-tunnel: Add of match table
Date: Tue, 30 Sep 2014 01:21:38 +0200
Message-ID: <5429E982.4050509@collabora.co.uk>
References: <1411114093-3505-1-git-send-email-sjoerd.simons@collabora.co.uk> <1411114093-3505-2-git-send-email-sjoerd.simons@collabora.co.uk> <20140929205922.GB2758@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140929205922.GB2758@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello Wolfram,

On 09/29/2014 10:59 PM, Wolfram Sang wrote:
> On Fri, Sep 19, 2014 at 10:08:12AM +0200, Sjoerd Simons wrote:
>> To enable the cros-ec-tunnel driver to be auto-loaded when build as a
>> module add an of match table (and export it) to match the modalias
>> information passed on to userspace as the Cros EC MFD driver registers
>> the MFD subdevices with an of_compatibility string.
>> 
>> Signed-off-by: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
>> Reviewed-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> 
> Applied to for-next, thanks!
> 
> However, since you are working on this driver: sparse rightfully
> complains about:
> 
> drivers/i2c/busses/i2c-cros-ec-tunnel.c:97:44: warning: cast truncates bits from constant value (10000 becomes 0)
> 
> I don't know the EC protocol, can you check?
> 

Doug posted a patch [0] to fix the issue you are reporting but it was not
picked. I tested that the patch applies on top of linux-next + the latest
cros_ec cleanups (that includes a patch for this i2c driver and was taken
by Lee. So I think is safe for you take Doug's patch through your tree
since it seems to not cause any conflict with the mfd tree.

Or if you prefer, I can re-post that patch for 3.19.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/6/23/830
