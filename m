From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] PCAP misc input driver (for 2.6.32)
Date: Sun, 28 Jun 2009 12:49:31 +0530
Message-ID: <5d5443650906280019m1e7d9343qd44875716b540e4b@mail.gmail.com>
References: <1246122592.3727.20.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:34565 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbZF1HT3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jun 2009 03:19:29 -0400
In-Reply-To: <1246122592.3727.20.camel@brutus>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, inux-kernel <linux-kernel@vger.kernel.org>, openezx-devel <openezx-devel@lists.openezx.org>, Samuel Ortiz <sameo@linux.intel.com>, Ilya Petrov <ilya.muromec@gmail.com>

Hi Daniel,

> +
> +static int __init pcap_keys_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 int err =3D -ENOMEM;
> + =A0 =A0 =A0 struct pcap_keys *pcap_keys;
> +
> + =A0 =A0 =A0 pcap_keys =3D kmalloc(sizeof(struct pcap_keys), GFP_KER=
NEL);
> + =A0 =A0 =A0 if (!pcap_keys)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 pcap_keys->pcap =3D platform_get_drvdata(pdev);
> +
> + =A0 =A0 =A0 pcap_keys->input =3D input_allocate_device();
> + =A0 =A0 =A0 if (!pcap_keys->input)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, pcap_keys);
> + =A0 =A0 =A0 pcap_keys->input->name =3D pdev->name;
> + =A0 =A0 =A0 pcap_keys->input->phys =3D "pcap-keys/input0";
> + =A0 =A0 =A0 pcap_keys->input->dev.parent =3D &pdev->dev;
> +
> + =A0 =A0 =A0 pcap_keys->input->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_M=
ASK(EV_SW);
> + =A0 =A0 =A0 set_bit(KEY_POWER, pcap_keys->input->keybit);
> + =A0 =A0 =A0 set_bit(SW_HEADPHONE_INSERT, pcap_keys->input->swbit);
> + =A0 =A0 =A0 set_bit(KEY_HP, pcap_keys->input->keybit);

__set_bit please.

> +
> + =A0 =A0 =A0 err =3D request_irq(pcap_to_irq(pcap_keys->pcap, PCAP_I=
RQ_ONOFF),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcap_keys_handler, 0, "=
Power key", pcap_keys);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_dev;
> +
> + =A0 =A0 =A0 err =3D request_irq(pcap_to_irq(pcap_keys->pcap, PCAP_I=
RQ_HS),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcap_keys_handler, 0, "=
Headphone jack", pcap_keys);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_pwrkey;
> +
> + =A0 =A0 =A0 err =3D request_irq(pcap_to_irq(pcap_keys->pcap, PCAP_I=
RQ_MIC),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcap_keys_handler, 0, "=
MIC jack/button", pcap_keys);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_jack;
> +
> + =A0 =A0 =A0 err =3D input_register_device(pcap_keys->input);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_mic;

Same comment as given in PCAP touchscreen driver.

> +
> +static int pcap_keys_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct pcap_keys *pcap_keys =3D platform_get_drvdata(pd=
ev);
> +
> + =A0 =A0 =A0 free_irq(pcap_to_irq(pcap_keys->pcap, PCAP_IRQ_ONOFF), =
pcap_keys);
> + =A0 =A0 =A0 free_irq(pcap_to_irq(pcap_keys->pcap, PCAP_IRQ_HS), pca=
p_keys);
> + =A0 =A0 =A0 free_irq(pcap_to_irq(pcap_keys->pcap, PCAP_IRQ_MIC), pc=
ap_keys);
> +
> + =A0 =A0 =A0 input_unregister_device(pcap_keys->input);
> + =A0 =A0 =A0 kfree(pcap_keys);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct platform_driver pcap_keys_device_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D pcap_keys_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D pcap_keys_remove,

__devexit_p ?

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
