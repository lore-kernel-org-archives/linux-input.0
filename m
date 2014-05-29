From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] gpio: removes all usage of gpiochip_remove retval
Date: Thu, 29 May 2014 16:25:34 -0700
Message-ID: <20140529232534.GA11741@kroah.com>
References: <1401400492-26175-1-git-send-email-berthe.ab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57197 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751919AbaE2XZi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2014 19:25:38 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0952721035
	for <linux-input@vger.kernel.org>; Thu, 29 May 2014 19:25:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1401400492-26175-1-git-send-email-berthe.ab@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: abdoulaye berthe <berthe.ab@gmail.com>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, m@bues.ch, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-wireless@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-media@vger.kernel.org, linux-samsungsoc@vger.kernel.org, spear-devel@list.st.com, platform-driver-x86@vger.kernel.org, netdev@vger.kernel.org, devel@driverdev.osuosl.org

On Thu, May 29, 2014 at 11:54:52PM +0200, abdoulaye berthe wrote:
> Signed-off-by: abdoulaye berthe <berthe.ab@gmail.com>

Why?
