From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] input: add driver for EETI touchpanels [v5]
Date: Sat, 16 May 2009 20:57:19 +0200
Message-ID: <20090516205719.15fbec97@hyperion.delvare>
References: <20090516173226.GA1448@buzzloop.caiaq.de>
	<1242495290-11497-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:35327 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386AbZEPS5a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 May 2009 14:57:30 -0400
In-Reply-To: <1242495290-11497-1-git-send-email-daniel@caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org

On Sat, 16 May 2009 19:34:50 +0200, Daniel Mack wrote:
> This patch adds a driver for EETI's I2C connected touchscreens.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Tested-by: Sven Neumann <s.neumann@raumfeld.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/input/touchscreen/Kconfig   |    9 +
>  drivers/input/touchscreen/Makefile  |    1 +
>  drivers/input/touchscreen/eeti_ts.c |  286 +++++++++++++++++++++++++++++++++++
>  3 files changed, 296 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/eeti_ts.c

For the i2c part:
Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
