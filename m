From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: ATMEL camera interface
Date: Thu, 29 Apr 2010 18:35:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1004291824200.4666@axis700.grange>
References: <4BD9AA8A.7030306@atmel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:60950 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932997Ab0D3RfC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Apr 2010 13:35:02 -0400
In-Reply-To: <4BD9AA8A.7030306@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, linux-input@vger.kernel.org

Hi Sedji

On Thu, 29 Apr 2010, Sedji Gaouaou wrote:

> Hi,
> 
> I need to re-work my driver so I could commit it to the community.
> Is there a git tree that I can use?

Nice to hear that! As far as soc-camera is concerned, the present APIs are 
pretty stable. Just use the Linus' git tree, or, if you like, you can use 
the v4l-dvb git tree at git://linuxtv.org/v4l-dvb.git. In fact, you don't 
have to use the soc-camera API these days, you can just write a complete 
v4l2-device driver, using the v4l2-subdev API to interface to video 
clients (sensors, decoders, etc.) However, you can still write your driver 
as an soc-camera host driver, which would make your task a bit easier at 
the cost of some reduced flexibility, it's up to you to decide.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
