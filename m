From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: mouse: add qci touchpad driver
Date: Thu, 26 Aug 2010 07:49:37 -0700
Message-ID: <20100826144937.GA8553@core.coreip.homeip.net>
References: <1281631760-15589-1-git-send-email-nleeder@codeaurora.org>
 <20100813024912.GA2661@core.coreip.homeip.net>
 <4C65BF99.9030601@codeaurora.org>
 <201008131754.49488.dmitry.torokhov@gmail.com>
 <4C6AC393.8000109@codeaurora.org>
 <BC741E3E-377E-45BF-80E1-A60F4E0FDFC9@gmail.com>
 <4C6C52DE.4040700@codeaurora.org>
 <20100819053311.GE5832@core.coreip.homeip.net>
 <4C6DADDE.7030107@codeaurora.org>
 <4C756049.2090408@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:40153 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab0HZOtn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Aug 2010 10:49:43 -0400
Content-Disposition: inline
In-Reply-To: <4C756049.2090408@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Neil Leeder <nleeder@codeaurora.org>
Cc: Stepan Moskovchenko <stepanm@codeaurora.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Horace Fu <horace.fu@quantatw.com>, Mandeep Singh Baines <msb@chromium.org>, Trilok Soni <tsoni@codeaurora.org>

Hi Neil,

On Wed, Aug 25, 2010 at 02:26:17PM -0400, Neil Leeder wrote:
> 
> Any comment on the above alternatives?
> 
> A third suggestion might be to have a fairly general serio driver,
> and rewrite the original Quanta driver to use serio rather than
> using i2c directly. I think that has its own set of problems, but
> thought I'd mention it anyway. The nuvoTon EC doesn't present a
> fully-working and reliable PS/2 interface to the driver so I'd lean
> toward using the Quanta touchpad driver by itself.
> 

I concur that since EC firmware does not seem to support full PS/2
protocol we should got with the original driver creating an input device
rather than serio.

Please send me the latest version of your driver and I will apply it to
my .37 queue.

Thanks.

-- 
Dmitry
