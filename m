From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2] Pegatron Lucid tablet accelerometer
Date: Mon, 17 Jan 2011 10:49:28 -0800
Message-ID: <20110117184927.GA27245@core.coreip.homeip.net>
References: <1295287011-12849-1-git-send-email-andy.ross@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1295287011-12849-1-git-send-email-andy.ross@windriver.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Ross <andy.ross@windriver.com>
Cc: Corentin Chary <corentincj@iksaif.net>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 17, 2011 at 09:56:49AM -0800, Andy Ross wrote:
> 
> > > +	ipdev->input->dev.release = dev_noop_release;
> > 
> > WTH is this???
> 
> It's an attempt to avoid this from drivers/base/core.c:
> 
>       WARN(1, KERN_ERR "Device '%s' does not have a release() "
>            "function, it is broken and must be fixed.\n",
>            dev_name(dev));
> 
> ...but it was in the wrong place.  The input device doesn't hit that
> path, the platform device does.  Moved to where it belongs.
> 

It does not belong anywhere. Please create platform device dynamically
(for example using platfrom_device_register_simple) and destroy it when
done.

The only time when static devices are [semi-]allowed (Greg has differing
opioon on this I believe) is in platform/arch code for devices that can
never be destroyed.

Thanks.

-- 
Dmitry
