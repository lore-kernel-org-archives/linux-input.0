From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: Bad change in commit 297d716f6260cc9421d971b124ca196b957ee458?
Date: Tue, 28 Jul 2015 08:46:24 +0900
Message-ID: <55B6C2D0.1050101@samsung.com>
References: <CAMe9rOrFxj3o6TgUAvthQLwR58-JPKO7top8w81FADjKTd5t3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <CAMe9rOrFxj3o6TgUAvthQLwR58-JPKO7top8w81FADjKTd5t3A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: "H.J. Lu" <hjl.tools@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Jiri Kosina <jkosina@suse.com>, linux-input@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 27.07.2015 22:10, H.J. Lu wrote:
> Hi,
> 
> This commit:
> 
> commit 297d716f6260cc9421d971b124ca196b957ee458
> Author: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Date:   Thu Mar 12 08:44:11 2015 +0100
> 
>     power_supply: Change ownership from driver to core
> 
>     Change the ownership of power_supply structure from each driver
>     implementing the class to the power supply core.
> 
> has
> 
> static void hidinput_cleanup_battery(struct hid_device *dev)
>  {
> -       if (!dev->battery.name)
> +       if (!dev->battery)
>                 return;
> 
> -       power_supply_unregister(&dev->battery);
> -       kfree(dev->battery.name);
> -       dev->battery.name = NULL;
> +       power_supply_unregister(dev->battery);
> +       kfree(dev->battery->desc->name);
> +       kfree(dev->battery->desc);
> +       dev->battery = NULL;
>  }
> 
> Is this OK to access dev->battery after calling power_supply_unregister?

(+Cc Jiri, linux-input, linux-pm, Sebastian)

Good catch, it is not safe. The final device_unregister() will free the
structure.

We should access directly psy_desc here. I'll sent a proposal of fixing
this and check other drivers for this pattern.

Best regards,
Krzysztof
