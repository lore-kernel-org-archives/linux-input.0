From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] i2c: Prevent runtime suspend of adapter when Host Notify
 is required
Date: Tue, 30 Apr 2019 17:42:52 +0200
Message-ID: <CAJZ5v0gimPdVY8FbzNPZQK=pMGzynpxJqUR_ypSh9OTAsObfrw@mail.gmail.com>
References: <20190430142322.15013-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190430142322.15013-1-jarkko.nikula@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Keijo Vaara <ferdasyn@rocketmail.com>, linux-input@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Stable <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Apr 30, 2019 at 4:23 PM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> Multiple users have reported their Synaptics touchpad has stopped
> working between v4.20.1 and v4.20.2 when using SMBus interface.
>
> The culprit for this appeared to be commit c5eb1190074c ("PCI / PM: Allow
> runtime PM without callback functions") that fixed the runtime PM for
> i2c-i801 SMBus adapter. Those Synaptics touchpad are using i2c-i801
> for SMBus communication and testing showed they are able to get back
> working by preventing the runtime suspend of adapter.
>
> Normally when i2c-i801 SMBus adapter transmits with the client it resumes
> before operation and autosuspends after.
>
> However, if client requires SMBus Host Notify protocol, what those
> Synaptics touchpads do, then the host adapter must not go to runtime
> suspend since then it cannot process incoming SMBus Host Notify commands
> the client may send.
>
> Fix this by keeping I2C/SMBus adapter active in case client requires
> Host Notify.
>
> Reported-by: Keijo Vaara <ferdasyn@rocketmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203297
> Fixes: c5eb1190074c ("PCI / PM: Allow runtime PM without callback functions")
> Cc: stable@vger.kernel.org # v4.20+
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or please let me know if you want me to take this.

> ---
> Keijo: could you test this does it fix the issue you reported? This is
> practically the same diff I sent earlier what you probably haven't tested yet.
> I wanted to send a commitable fix in case it works since I'll be out of
> office in a few coming days.
> ---
>  drivers/i2c/i2c-core-base.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 38af18645133..8149c9e32b69 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -327,6 +327,8 @@ static int i2c_device_probe(struct device *dev)
>
>                 if (client->flags & I2C_CLIENT_HOST_NOTIFY) {
>                         dev_dbg(dev, "Using Host Notify IRQ\n");
> +                       /* Keep adapter active when Host Notify is required */
> +                       pm_runtime_get_sync(&client->adapter->dev);
>                         irq = i2c_smbus_host_notify_to_irq(client);
>                 } else if (dev->of_node) {
>                         irq = of_irq_get_byname(dev->of_node, "irq");
> @@ -431,6 +433,8 @@ static int i2c_device_remove(struct device *dev)
>         device_init_wakeup(&client->dev, false);
>
>         client->irq = client->init_irq;
> +       if (client->flags & I2C_CLIENT_HOST_NOTIFY)
> +               pm_runtime_put(&client->adapter->dev);
>
>         return status;
>  }
> --
> 2.20.1
>
