From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.4
Date: Wed, 20 Jan 2010 22:27:31 +0100
Message-ID: <201001202227.31732.oliver@neukum.org>
References: <201001202047.o0KKlMTr014003@mustang.cs.nmsu.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:41750 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab0ATV04 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jan 2010 16:26:56 -0500
In-Reply-To: <201001202047.o0KKlMTr014003@mustang.cs.nmsu.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>
Cc: linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, pavel@ucw.cz, jayakumar.lkml@gmail.com, linux-fbdev@vger.kernel.org, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, jkosina@suse.cz, dmitry.torokhov@gmail.com

Am Mittwoch, 20. Januar 2010 21:47:22 schrieb Rick L. Vinyard Jr.:
> +static ssize_t g13_name_store(struct device *dev,
> +                             struct device_attribute *attr,
> +                             const char *buf, size_t count)
> +{
> +       struct g13_data *data = dev_get_drvdata(dev);
> +       size_t limit = count;
> +       char *end;
> +
> +       spin_lock(&data->lock);
> +
> +       if (data->name != NULL) {
> +               kfree(data->name);
> +               data->name = NULL;
> +       }
> +
> +       end = strpbrk(buf, "\n\r");
> +       if (end != NULL)
> +               limit = end - buf;
> +
> +       if (end != buf) {
> +
> +               if (limit > 100)
> +                       limit = 100;
> +
> +               data->name = kzalloc(limit+1, GFP_KERNEL);

While you hold a spinlock, memory allocations must be done with GFP_ATOMIC.

	Regards
		Oliver
