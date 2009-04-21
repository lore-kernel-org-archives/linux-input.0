From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [patch 08/14] input: PCAP2 based touchscreen driver
Date: Mon, 20 Apr 2009 23:38:41 -0300
Message-ID: <1240281521.25090.6.camel@brutus>
References: <20081121160403.073751031@dodger.lab.datenfreihafen.org>
	 <20081121170518.GA4416@USFSHXP-002051>
	 <20081122000047.GB28067@dodger.lab.datenfreihafen.org>
	 <20090421021811.GD13617@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:8080 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbZDUCi0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Apr 2009 22:38:26 -0400
In-Reply-To: <20090421021811.GD13617@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>, eric.y.miao@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ao2@openezx.org

Em Seg, 2009-04-20 =C3=A0s 19:18 -0700, Dmitry Torokhov escreveu:
> What is the status of PCAP support? Is it going to be merged in
> mainline? I am holding the touchscreen driver in my queue because
> it requires linux/mfd/ezx-pcap.h which is not in mainline yet...
>=20
> Should I drop the driver? Is it going to be merged through some
> other tree?

Hi Dmitry,

Please drop it. There is still a lot of work needed to get our core PCA=
P
driver in shape for mainline.

Thanks!

--=20
Daniel Ribeiro

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
