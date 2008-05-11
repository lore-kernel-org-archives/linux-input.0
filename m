From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/9] HID: hid, make parsing event driven
Date: Mon, 12 May 2008 01:20:50 +0200
Message-ID: <1210548050.16390.39.camel@violet.holtmann.net>
References: <1210536043-19812-1-git-send-email-jirislaby@gmail.com>
	 <1210536043-19812-2-git-send-email-jirislaby@gmail.com>
	 <1210536043-19812-3-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:59484 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756727AbYEKXUo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 May 2008 19:20:44 -0400
In-Reply-To: <1210536043-19812-3-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com, akpm@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>

Hi Jiri,

> Next step for complete hid bus, this patch includes:
> - call parser either from probe or from hid-core if there is no probe.
> - add ll_driver structure and centralize some stuff there (open, close...)
> - split and merge usb_hid_configure and hid_probe into several functions
>   to allow hooks/fixes between them

has the Bluetooth HIDP changes been tested. You move a lot of code
around and this might have side effects.

Regards

Marcel


