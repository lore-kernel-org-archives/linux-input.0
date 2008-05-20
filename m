From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add support for HTC Shift Touchscreen
Date: Mon, 19 May 2008 21:49:37 -0400
Message-ID: <20080520014937.GA23247@anvil.corenet.prv>
References: <482ED31E.2000009@eslack.org> <483198F8.3000201@eslack.org> <20080519112104.ZZRA012@mailhub.coreip.homeip.net> <4832087C.6060009@eslack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:10655 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbYETBtu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 May 2008 21:49:50 -0400
Received: by py-out-1112.google.com with SMTP id u52so2198635pyb.10
        for <linux-input@vger.kernel.org>; Mon, 19 May 2008 18:49:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4832087C.6060009@eslack.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pau Oliva Fora <pau@eslack.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, May 20, 2008 at 01:08:44AM +0200, Pau Oliva Fora wrote:
> +
> +static int htcpen_open(struct input_dev *dev)
> +{
> +	outb_p(DEVICE_ENABLE, HTCPEN_PORT_INIT);
> +	return 0;
> +}
> +
> +static void htcpen_close(struct input_dev *dev)
> +{
> +	free_irq(HTCPEN_IRQ, dev);
> +}
> +

No, this will not work.. next time you open the device you won't have
IRQ anymore. You need the opposite of outb_p(DEVICE_ENABLE,
HTCPEN_PORT_INIT); here.


-- 
Dmitry
