From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH 1/2] input/joystick: new AD7142driver
Date: Wed, 15 Jul 2009 18:01:49 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA046225E3@chinexm1.ad.analog.com>
References: <1247592827-16878-1-git-send-email-vapier@gentoo.org> <20090714180309.GC14661@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:18469 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbZGOKCp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jul 2009 06:02:45 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20090714180309.GC14661@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, "Hennerich, Michael" <Michael.Hennerich@analog.com>, linux-input@vger.kernel.org

> +
> +	/* Start workqueue for defer message transfer */
> +	INIT_WORK(&data->work, ad7142_work);
> +
> +	if (client->irq > 0) {
> +		rc = request_irq(client->irq, ad7142_interrupt,
> +				IRQF_TRIGGER_LOW, "ad7142_joystick",
data);

> Let's use threaded IRQs, they are so nice for devices like this one.
Do you mean use request_threaded_irq to request irq and return
IRQ_THREAD_WAKE in hardware interrupt to wake-up thread_fn in process
context?  But there is almost no device using this way after a grep.
Or just create a single-thread workqueue? Or just create a thread to
handle bottom-half?

-Barry


