From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] gpiolib: handle probe deferrals better
Date: Fri, 1 Apr 2016 10:52:37 -0700
Message-ID: <20160401175237.GF8929@tuxbot>
References: <1459511048-24084-1-git-send-email-linus.walleij@linaro.org>
 <1766024.riJEdmHPZI@ws-stein>
 <CACRpkdaynNEFGhCSkd7qAgxtNoRT=pRWbB0dJmjM89UM4NG_xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaynNEFGhCSkd7qAgxtNoRT=pRWbB0dJmjM89UM4NG_xQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Linux Input <linux-input@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

On Fri 01 Apr 06:03 PDT 2016, Linus Walleij wrote:

> On Fri, Apr 1, 2016 at 2:16 PM, Alexander Stein
> <alexander.stein@systec-electronic.com> wrote:
> 
> > I noticed you fiddle with late_initcall_sync. Sorry, I did not mention it:
> > gpio_mcp23s08 as well as gpio_keys are loaded as modules, so late_initcall_*
> > should not affect it.
> 
> I don't get this. I think probe deferral is only used to defer
> initcalls used for built-in drivers.
> 

FWIW, upon matching a device to a driver you will end up in
really_probe(), which if the called probe function returns -EPROBE_DEFER
will put the device on a deferred-probe-list.

A worker is triggered upon subsequent binds that runs through this list
and retries the probes, but only once something else successfully
probes, potentially providing the missing resources.

So it does not treat builtins and modules differently.

Regards,
Bjorn
