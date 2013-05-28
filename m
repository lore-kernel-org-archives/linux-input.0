From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: add support for Huion 580 tablet
Date: Tue, 28 May 2013 10:20:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1305281019530.3914@pobox.suse.cz>
References: <1369728716-19286-1-git-send-email-martin.rusko@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57326 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933383Ab3E1IUw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 May 2013 04:20:52 -0400
In-Reply-To: <1369728716-19286-1-git-send-email-martin.rusko@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Rusko <martin.rusko@gmail.com>
Cc: linux-input@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>

On Tue, 28 May 2013, Martin Rusko wrote:

> 
> Signed-off-by: Martin Rusko <martin.rusko@gmail.com>
> ---
>  drivers/hid/Kconfig     |    6 ++
>  drivers/hid/Makefile    |    1 +
>  drivers/hid/hid-core.c  |    1 +
>  drivers/hid/hid-huion.c |  177 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h   |    3 +
>  5 files changed, 188 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hid/hid-huion.c

Martin,

could you please provide changelog for this patch as well? What's mostly 
interesting is:

- a brief description of the device
- a brief description of the changes necessary to make it work (the 
  deviations from the HID standard)

Thanks.

-- 
Jiri Kosina
SUSE Labs
