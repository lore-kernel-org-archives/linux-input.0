From: =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>
Subject: Re: [PATCH v2] input/imx_keypad: add PM support
Date: Fri, 18 Jun 2010 19:50:54 +0200
Message-ID: <4C1BB1FE.9090403@eukrea.com>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>	 <1276856186.3146.5.camel@realization>  <4C1B84A3.8080300@eukrea.com> <1276882804.3146.14.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 29.mail-out.ovh.net ([87.98.216.213]:60359 "HELO
	29.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754832Ab0FRRu6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jun 2010 13:50:58 -0400
In-Reply-To: <1276882804.3146.14.camel@realization>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org

Le 18/06/2010 19:40, Alberto Panizzo a =C3=A9crit :
> Well.. it is a surprise to me too. I have to look down the documentat=
ion
> ad soon I will try on the mx31pdk.

OK, I'm waiting for your feedback on the mx31pdk.

 From my understanding of the documentation, in order to be able to=20
wakeup the CPU, the interrupt of a peripheral and its clock should stay=
=20
enabled while going to suspend.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
