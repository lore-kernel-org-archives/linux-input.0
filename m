From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] PCAP touchscreen driver (for 2.6.32)
Date: Sun, 28 Jun 2009 12:45:17 +0530
Message-ID: <5d5443650906280015x4bddefa5v9dd36f888c5f2e92@mail.gmail.com>
References: <1246122138.3727.12.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:33697 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbZF1HPP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jun 2009 03:15:15 -0400
In-Reply-To: <1246122138.3727.12.camel@brutus>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, openezx-devel <openezx-devel@lists.openezx.org>, Harald Welte <laforge@gnumonks.org>, Samuel Ortiz <sameo@linux.intel.com>

Hi Daniel,

2009/6/27 Daniel Ribeiro <drwyrm@gmail.com>:
> Touchscreen driver for PCAP2 PMIC.
>

Some more description in commit text really helps.

> +static irqreturn_t pcap_ts_event_touch(int pirq, void *data)
> +{
> + =A0 =A0 =A0 struct pcap_ts *pcap_ts =3D data;
> +
> + =A0 =A0 =A0 if (pcap_ts->read_state =3D=3D PCAP_ADC_TS_M_STANDBY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcap_ts->read_state =3D PCAP_ADC_TS_M_P=
RESSURE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_delayed_work(&pcap_ts->work, 0=
);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static int __devinit pcap_ts_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct input_dev *input_dev;
> + =A0 =A0 =A0 struct pcap_ts *pcap_ts;
> + =A0 =A0 =A0 int err =3D -ENOMEM;
> +
> + =A0 =A0 =A0 pcap_ts =3D kzalloc(sizeof(*pcap_ts), GFP_KERNEL);
> + =A0 =A0 =A0 if (!pcap_ts)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 pcap_ts->pcap =3D platform_get_drvdata(pdev);
> + =A0 =A0 =A0 platform_set_drvdata(pdev, pcap_ts);
> +
> + =A0 =A0 =A0 input_dev =3D input_allocate_device();
> + =A0 =A0 =A0 if (!pcap_ts || !input_dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
> +
> + =A0 =A0 =A0 INIT_DELAYED_WORK(&pcap_ts->work, pcap_ts_work);
> +
> + =A0 =A0 =A0 pcap_ts->read_state =3D PCAP_ADC_TS_M_STANDBY;
> +
> + =A0 =A0 =A0 pcap_ts->input =3D input_dev;
> +
> + =A0 =A0 =A0 input_dev->name =3D "pcap-touchscreen";
> + =A0 =A0 =A0 input_dev->phys =3D "pcap_ts/input0";
> + =A0 =A0 =A0 input_dev->id.bustype =3D BUS_HOST;
> + =A0 =A0 =A0 input_dev->id.vendor =3D 0x0001;
> + =A0 =A0 =A0 input_dev->id.product =3D 0x0002;
> + =A0 =A0 =A0 input_dev->id.version =3D 0x0100;
> + =A0 =A0 =A0 input_dev->dev.parent =3D &pdev->dev;
> +
> + =A0 =A0 =A0 input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_=
ABS);
> + =A0 =A0 =A0 input_dev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN=
_TOUCH);
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_X, X_AXIS_MIN, X_AX=
IS_MAX, 0, 0);
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_Y, Y_AXIS_MIN, Y_AX=
IS_MAX, 0, 0);
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_PRESSURE, PRESSURE_=
MIN,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PRESSURE_MAX=
, 0, 0);
> +
> + =A0 =A0 =A0 err =3D request_irq(pcap_to_irq(pcap_ts->pcap, PCAP_IRQ=
_TS),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcap_ts_event_touch, 0,=
 "Touch Screen", pcap_ts);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
> +
> + =A0 =A0 =A0 err =3D input_register_device(pcap_ts->input);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_touch;

Please move request_irq after input_register_device, as IRQ can get
fired before input device gets available, right?

Overall driver is nice and clean.

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
