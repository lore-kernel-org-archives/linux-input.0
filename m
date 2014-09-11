From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH] Input: atmel_mxt_ts: Add of node type to the i2c table
Date: Thu, 11 Sep 2014 10:19:54 +0100
Message-ID: <5411693A.3050300@itdev.co.uk>
References: <1410249158-18192-1-git-send-email-sjoerd.simons@collabora.co.uk>	 <540ED495.20609@collabora.co.uk> <20140910092832.GM30307@lee--X1> <1410422429.2857.16.camel@collabora.co.uk> <54115F6E.3010007@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54115F6E.3010007@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, "Bowens, Alan" <Alan.Bowens@atmel.com>
List-Id: linux-input@vger.kernel.org

On 11/09/14 09:38, Javier Martinez Canillas wrote:
> To expand on what Sjoerd already said and just to be sure everyone is on the
> same page.
> 
> The problem is that right now the driver reports the following modalias:
> 
> # cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
> i2c:maxtouch
> 
> but if you look at the module information, that is not a valid alias:
> 
> # modinfo atmel_mxt_ts | grep alias
> alias:          i2c:mXT224
> alias:          i2c:atmel_mxt_tp
> alias:          i2c:atmel_mxt_ts
> alias:          i2c:qt602240_ts
> alias:          of:N*T*Catmel,maxtouch*
> 
> which means that udev/kmod can't load the module automatically based on the
> alias information.
> 
> The aliases are filled by both MODULE_DEVICE_TABLE(i2c, mxt_id) and
> MODULE_DEVICE_TABLE(of, mxt_of_match) so after Sjoerd's patch:
> 
> # cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
> i2c:maxtouch
> 
> # modinfo atmel_mxt_ts | grep alias
> alias:          i2c:mXT224
> alias:          i2c:maxtouch
> alias:          i2c:atmel_mxt_tp
> alias:          i2c:atmel_mxt_ts
> alias:          i2c:qt602240_ts
> 
> which matches the reported uevent so the module will be auto-loaded.
> 
> This is because the I2C subsystem hardcodes i2c:<client->name>, if you look at
> drivers/i2c/i2c-core.c:
> 
> /* uevent helps with hotplug: modprobe -q $(MODALIAS) */
> static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
> {
> ...
>         if (add_uevent_var(env, "MODALIAS=%s%s",
>                            I2C_MODULE_PREFIX, client->name))
> ...
> }
> 
> I've looked at Lee's series and AFAICT that remains the same so I second
> Sjoerd that module auto-loading will continue to be broken.

Thanks for the clear explanation.

The i2c aliases are a bit confusing. The original device the driver was
written for was called qt602240, which was renamed by Atmel to mXT224 when
the chip series was called "maXTouch". The driver now actually supports
many other chips which aren't listed (more than 20 devices that I've
personally tested). I could add them all, but it would be an extremely long
list. It may be preferable to use the generic name maXTouch.

So I think the sensible thing to do here would be to add "maxtouch" to the
i2c list to fix the module autoload issue.
