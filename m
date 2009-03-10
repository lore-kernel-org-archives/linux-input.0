From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input: add suspend wakeup support to sh_keysc
Date: Tue, 10 Mar 2009 13:54:00 +0530
Message-ID: <5d5443650903100124g2bbc4837gaa5d9a9f17cd56f0@mail.gmail.com>
References: <20090310062421.22328.68726.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20090310062421.22328.68726.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Magnus,

> +
> + =A0 =A0 =A0 device_init_wakeup(&pdev->dev, 1);
> =A0 =A0 =A0 =A0return 0;


Please add device_init_wakeup(&pdev->dev, 0) in sh_keysc_remove.

> =A0err5:
> =A0 =A0 =A0 =A0free_irq(irq, pdev);
> @@ -253,17 +255,36 @@ static int __devexit sh_keysc_remove(str
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static int sh_keysc_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct platform_device *pdev;
> + =A0 =A0 =A0 struct sh_keysc_priv *priv;
> + =A0 =A0 =A0 unsigned short value;
> +
> + =A0 =A0 =A0 pdev =3D container_of(dev, struct platform_device, dev)=
;
> + =A0 =A0 =A0 priv =3D platform_get_drvdata(pdev);

to_platform_device(...) ?

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
