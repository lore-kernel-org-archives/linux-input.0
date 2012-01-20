From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: convert drivers/input/* to use
 module_i2c_driver()
Date: Fri, 20 Jan 2012 08:53:22 -0800
Message-ID: <20120120165322.GB6520@core.coreip.homeip.net>
References: <1327064484.15205.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37445 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab2ATQxb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jan 2012 11:53:31 -0500
Content-Disposition: inline
In-Reply-To: <1327064484.15205.1.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Fabien Marteau <fabien.marteau@armadeus.com>, Michael Hennerich <hennerich@blackfin.uclinux.org>, Felipe Balbi <balbi@ti.com>, Kim Kyuwon <q1.kim@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Zhang Jiejing <jiejing.zhang@freescale.com>, Bo Shen <voice.shen@atmel.com>, Raphael Derosso Pereira <raphaelpereira@gmail.com>, Barry Song <21cnbao@gmail.com>, Albert Zhang <xu.zhang@bosch-sensortec.com>, Hemanth V <hemanthv@ti.com>, Chris Hudson <chudson@kionix.com>, Samuli Konttila <samuli.konttila@aavamobile.com>, Mike Rapoport <mike@compulab.co.il>, Daniel Mack <daniel@caiaq.de>, Magnus Damm <damm@opensource.se>, Jianchun Bian <jcbian@pixcir.com.cn>, Dequan Meng <dqmeng@pixcir.com.cn>, Tony SIM <chinyeow.sim.xt@renesas.com>, Kwangwoo Lee <kwlee@mtekvision.com>, linux-input@vger.kernel.org

Hi Axel,

On Fri, Jan 20, 2012 at 09:01:24PM +0800, Axel Lin wrote:
> This patch converts the drivers in drivers/input/* to use the
> module_i2c_driver() macro which makes the code smaller and a bit simpler.
> 

I ialready have your patch in my queue, I am just waiting for -rc3 to
merge winth mainline and bring module_i2c_driver() and module_spi_driver()
in and will merge your patches at that time.

Thanks.

-- 
Dmitry
