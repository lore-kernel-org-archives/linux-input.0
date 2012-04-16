From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH v8] input: Add Synaptics NavPoint (PXA27x SSP/SPI) driver
Date: Mon, 16 Apr 2012 22:16:56 +0200
Message-ID: <1334607416.30492.2.camel@flow>
References: <1334576221.72161.YahooMailClassic@web29005.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43398 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970Ab2DPURC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Apr 2012 16:17:02 -0400
Received: by bkcik5 with SMTP id ik5so3991589bkc.19
        for <linux-input@vger.kernel.org>; Mon, 16 Apr 2012 13:17:00 -0700 (PDT)
In-Reply-To: <1334576221.72161.YahooMailClassic@web29005.mail.ird.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Am Montag, den 16.04.2012, 12:37 +0100 schrieb Paul Parsons:
> This driver adds support for the Synaptics NavPoint touchpad connected
> to a PXA27x SSP port in SPI slave mode. The device emulates a mouse;
> a tap or tap-and-a-half drag gesture emulates the left mouse button.
> For example, use the xf86-input-evdev driver for an X pointing device.
> 
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>

Tested-by: Philipp Zabel <philipp.zabel@gmail.com>


