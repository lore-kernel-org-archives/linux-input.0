From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] input: spi: Driver for SPI data stream driven vibrator
Date: Sun, 7 Nov 2010 23:51:57 +0000
Message-ID: <20101107235157.728ea5b6@lxorguk.ukuu.org.uk>
References: <1288013463-21722-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58949 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751990Ab0KGXx1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Nov 2010 18:53:27 -0500
In-Reply-To: <1288013463-21722-1-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net


> +	datalen = p->custom_len * sizeof(p->custom_data[0]);

signed

> +	if (datalen > MAX_EFFECT_SIZE) {

unsigned

> +	memcpy(einfo->buf, p->custom_data, datalen);

ungood


