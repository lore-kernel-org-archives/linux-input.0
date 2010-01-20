From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.4
Date: Wed, 20 Jan 2010 22:19:12 +0100
Message-ID: <201001202219.12058.oliver@neukum.org>
References: <201001202047.o0KKlMTr014003@mustang.cs.nmsu.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:50488 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab0ATVSh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jan 2010 16:18:37 -0500
In-Reply-To: <201001202047.o0KKlMTr014003@mustang.cs.nmsu.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>
Cc: linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, pavel@ucw.cz, jayakumar.lkml@gmail.com, linux-fbdev@vger.kernel.org, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, jkosina@suse.cz, dmitry.torokhov@gmail.com

Am Mittwoch, 20. Januar 2010 21:47:22 schrieb Rick L. Vinyard Jr.:
> +       if (copy_from_user(dst, buf, count))
> +               err = -EFAULT;
> +
> +       if (!err)
> +               *ppos += count;
> +
> +       g13_fb_update(par);
> +
> +       return (err) ? err : count;

Do you really want to go on if you get -EFAULT?

	Regards
		Oliver
