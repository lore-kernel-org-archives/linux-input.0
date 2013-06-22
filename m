From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v1 02/12] input: matrix-keymap: func call coding style nit
Date: Sat, 22 Jun 2013 15:23:15 +0200
Message-ID: <201306221523.15431.marex@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de> <201306220418.59722.marex@denx.de> <20130622082207.GC24305@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:50107 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024Ab3FVNXY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Jun 2013 09:23:24 -0400
In-Reply-To: <20130622082207.GC24305@book.gsilab.sittig.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gerhard Sittig <gsi@denx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Anatolij Gustschin <agust@denx.de>, Detlev Zundel <dzu@denx.de>

Dear Gerhard Sittig,

> On Sat, Jun 22, 2013 at 04:18 +0200, Marek Vasut wrote:
> > ret = matrix_keypad_map_key(input_dev, rows, cols, row_shift, key);
> > if (ret)
> > 
> > 	return ret;
> > 
> > Now that you return correct error codes from above, you should propagate
> > them through.
> 
> Will do, queued for v2.  Thank you for reviewing this.

Wait a little bit for some more feedback, esp. from the marvell guys ;-)

Best regards,
Marek Vasut
