From: Herbert Valerio Riedel <hvr@gnu.org>
Subject: Re: [PATCH,RFC] Input: gpio-keys - request and configure GPIOs
Date: Fri, 16 Nov 2007 11:50:48 +0000 (UTC)
Message-ID: <fhk06o$vj5$1@ger.gmane.org>
References: <1195212830-9137-1-git-send-email-hvr@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:47772 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757680AbXKPLzH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Nov 2007 06:55:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Iszmo-00069e-4d
	for linux-input@vger.kernel.org; Fri, 16 Nov 2007 11:55:02 +0000
Received: from a0024p011.ws.highway.telekom.at ([91.112.251.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 16 Nov 2007 11:55:02 +0000
Received: from hvr by a0024p011.ws.highway.telekom.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 16 Nov 2007 11:55:02 +0000
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Fri, 16 Nov 2007 12:33:50 +0100, Herbert Valerio Riedel wrote:
> Currently, gpio_keys.c assumes the GPIOs to be already properly
> configured; this patch changes gpio-keys to perform explicit calls to
> gpio_request() and gpio_configure_input().
> 
> This matches the behaviour of leds-gpio.

Signed-off-by: Herbert Valerio Riedel <hvr@gnu.org>

D'oh! :-)

