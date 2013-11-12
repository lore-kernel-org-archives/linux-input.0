From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v2] input: ti_am33x_tsc: make the documentation for the ti,wire-config parameter clear
Date: Tue, 12 Nov 2013 12:26:14 -0600
Message-ID: <15DA7589-35BD-4B24-B8A1-D44429ACC888@codeaurora.org>
References: <1384273323-15329-1-git-send-email-bigeasy@linutronix.de> <5C68A2CC-A8C8-4B56-A414-B9EBE438F767@codeaurora.org> <20131112174001.GA21881@linutronix.de>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:54096 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213Ab3KLS0U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Nov 2013 13:26:20 -0500
In-Reply-To: <20131112174001.GA21881@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org, o2g.org.ru@gmail.com


On Nov 12, 2013, at 11:40 AM, Sebastian Andrzej Siewior <bigeasy@linutr=
onix.de> wrote:

> The document says "first four bits" and means the upper nibble. Most
> people would probably agree that the first four bits are bits 0=853 a=
nd
> that is the lower nibble.
> This patch updates the documentation so it is clear what is meant.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1=85v2:
> 	- use most/least significant instead of upper/ lower nibble
> 	- add an example.
>=20
> .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt    | 13 ++++=
++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)

Thanks

Acked-by: Kumar Gala <galak@codeaurora.org>

- k

--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, host=
ed by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
