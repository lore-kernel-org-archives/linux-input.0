From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] Input: synaptics-rmi4: Add F30 support
Date: Sun, 27 Jul 2014 00:26:24 -0700
Message-ID: <20140727072624.GA15556@core.coreip.homeip.net>
References: <1406245641-6263-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:38285 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbaG0H01 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Jul 2014 03:26:27 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so7979500pdj.35
        for <linux-input@vger.kernel.org>; Sun, 27 Jul 2014 00:26:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406245641-6263-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, Christopher Heiny <cheiny@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Allie Xiong <axiong@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Hi Andrew,


On Thu, Jul 24, 2014 at 04:47:21PM -0700, Andrew Duggan wrote:
> RMI4 Function 0x30 provides support for GPIOs, LEDs and mechanical
> buttons.  In particular, the mechanical button support is used in
> an increasing number of touchpads.
> 

I was reading the spec for F30 and it looks to me that instead instead of basic
keymap it should actually implement a gpio chip plus LED devices (probably
later). Then, if GPIOs are indeed attached to buttons one can use standard
gpio_keys driver to create input device.

Thanks.

-- 
Dmitry
