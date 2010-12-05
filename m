From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH 0/8] input: gpio_keys_polled fixes
Date: Sun, 05 Dec 2010 10:11:10 +0100
Message-ID: <4CFB572E.9010105@openwrt.org>
References: <4CF541ED.80905@openwrt.org>	<1291142663-1011-1-git-send-email-juhosg@openwrt.org> <AANLkTi=fYLTEkws+R+9PFtrgUzujQrOuN2PQcGoG7X=v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:33388 "EHLO
	phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab0LEJLN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Dec 2010 04:11:13 -0500
In-Reply-To: <AANLkTi=fYLTEkws+R+9PFtrgUzujQrOuN2PQcGoG7X=v@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, nsekhar@ti.com

Hi Ben,

> <...>
> I have tested this series with the "da850-evm: add gpio-{keys,leds}
> for UI and BB expanders" on top of your "[PATCH 09/18] input:  add
> input driver for polled GPIO buttons" patch, my "[PATCH WIP 0/6]
> suggested changes to gpio_buttons driver" series and Dmitry's "Input:
> gpio-buttons - misc changes"  patch.
> 
> Only minimal changes were needed in the later patches of the da850-evm
> series. They can be summarized by:
> s/gpio_keys_polled\.h/gpio_keys.\h/g and
> s/gpio_keys_polled_platform_data/gpio_keys_platform_data/g.
> 
> With those changes I observed the expected input events with evtest.

Superb.

> Tested-by: Ben Gardiner <bengardiner@nanometrics.ca>

Thank you for the continuous testing.

Regards,
Gabor
