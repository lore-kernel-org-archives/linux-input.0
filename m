From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: [PATCH, v2] input/imx2x: generic keypad handler for i.MX SoCs
Date: Fri, 17 Apr 2009 21:26:44 +0200
Message-ID: <200904172126.45126.hs4233@mail.mn-solutions.de>
References: <200904171640.14294.hs4233@mail.mn-solutions.de> <49E8A70B.3020209@teltonika.lt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx51.mymxserver.com ([85.199.173.110]:31693 "EHLO
	mx51.mymxserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbZDQT1N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Apr 2009 15:27:13 -0400
In-Reply-To: <49E8A70B.3020209@teltonika.lt>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Cc: linux-input@vger.kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.arm.linux.org.uk

> IMO it would be better if board code would not provide
> "handle" function, but instead it would provide 'keyboard <->
> input event' map structure/array.

Not in my context.

Currently, a map can only do a stateless transposition. It cannot 
implement a cell-phone like keyboard, e.g. one press on the key 
yields a "1" input event, two presses yield a "a", three a "b", 
four a "c".

One can argue that you can do this in user-space, but for one of 
my devices (not for which this patch is) the 
kernel-implementation of this allows me to switch to vc1 
(framebuffer console) and log in and issue commands via the 
cell-phone like keyboard.
