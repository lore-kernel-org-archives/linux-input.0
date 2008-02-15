From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: Sensitivity of Synaptics pointing stick
Date: Fri, 15 Feb 2008 20:40:29 +0000 (UTC)
Message-ID: <fp4tbt$6km$1@ger.gmane.org>
References: <47B486B5.8070202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:33105 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbYBOUkr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Feb 2008 15:40:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JQ7MQ-0006ew-Fe
	for linux-input@vger.kernel.org; Fri, 15 Feb 2008 20:40:42 +0000
Received: from ppp78-37-16-13.pppoe.avangarddsl.ru ([78.37.16.13])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 15 Feb 2008 20:40:42 +0000
Received: from dbaryshkov by ppp78-37-16-13.pppoe.avangarddsl.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 15 Feb 2008 20:40:42 +0000
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi, Jan,

Jan Kiszka wrote:

> Hi,
> 
> it looks like I have a Synaptics pointing stick on my Lifebook E8110,
> connected as PS/2 pass-through device via a Synaptics touchpad. It
> works, but it is horribly insensitive, making me crack my fingers
> regularly. Is anyone aware of a way to tune the sensitivity of this
> device (like one can do with Thinkpad trackpoints)?
> 

It's strange, because I have the same laptop and both touch pad and touch
stick are working very well. Try setting MinSpeed, MaxSpeed, AccelFactor
and TrackstickSpeed parameters.

-- 
With best wishes
Dmitry


