From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio-keys - add gpiolib debounce support
Date: Tue, 29 Jun 2010 00:06:53 -0700
Message-ID: <20100629070653.GA19712@core.coreip.homeip.net>
References: <1277573636-10345-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45489 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470Ab0F2HHF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jun 2010 03:07:05 -0400
Received: by pvg2 with SMTP id 2so2313750pvg.19
        for <linux-input@vger.kernel.org>; Tue, 29 Jun 2010 00:07:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1277573636-10345-1-git-send-email-notasas@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-input@vger.kernel.org, Felipe Balbi <me@felipebalbi.com>

On Sat, Jun 26, 2010 at 08:33:56PM +0300, Grazvydas Ignotas wrote:
> gpiolib now has debounce support added in .35, so let's make use of it.
> This allows to use hardware GPIO debouncing on some platforms like OMAP.
> 
> In case gpiolib debounce setup fails for some GPIO, the driver will fall
> back to timer based debouncing, which is what it used before.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

Applie to 'next', thank you Grazvydas.

-- 
Dmitry
