From: Keijo Vaara <ferdasyn@rocketmail.com>
Subject: Re: [PATCH] i2c: Prevent runtime suspend of adapter when Host
 Notify is required
Date: Thu, 2 May 2019 08:07:58 +0000 (UTC)
Message-ID: <1541197134.3231703.1556784478268@mail.yahoo.com>
References: <20190430142322.15013-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190430142322.15013-1-jarkko.nikula@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Apr 30, 2019 at 4:23 PM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> ---
> Keijo: could you test this does it fix the issue you reported? This is
> practically the same diff I sent earlier what you probably haven't tested=
 yet.
> I wanted to send a commitable fix in case it works since I'll be out of
> office in a few coming days.
> ---
>=C2=A0 drivers/i2c/i2c-core-base.c | 4 ++++
>=C2=A0 1 file changed, 4 insertions(+)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 38af18645133..8149c9e32b69 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -327,6 +327,8 @@ static int i2c_device_probe(struct device *dev)
>
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (client->flags =
& I2C_CLIENT_HOST_NOTIFY) {
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev_dbg(dev, "Using Host Notify IRQ\n");
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* Keep adapter active when Host Notify is required */
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pm_runtime_get_sync(&client->adapter->dev);
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 irq =3D i2c_smbus_host_notify_to_irq(client);
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (dev->of=
_node) {
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 irq =3D of_irq_get_byname(dev->of_node, "irq");
> @@ -431,6 +433,8 @@ static int i2c_device_remove(struct device *dev)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 device_init_wakeup(&client->dev, false);
>
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 client->irq =3D client->init_irq;
> +=C2=A0 =C2=A0 =C2=A0 if (client->flags & I2C_CLIENT_HOST_NOTIFY)
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_runtime_put(&client-=
>adapter->dev);
>
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return status;
>=C2=A0 }
> --
> 2.20.1
>

Thanks guys, I've tested the patch and can confirm it fixes the issue.
