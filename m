From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: [PATCH, v2] input/imx2x: generic keypad handler for i.MX SoCs
Date: Mon, 20 Apr 2009 13:08:56 +0200
Message-ID: <200904201308.56564.hs4233@mail.mn-solutions.de>
References: <200904171640.14294.hs4233@mail.mn-solutions.de> <200904172140.33542.hs4233@mail.mn-solutions.de> <20090418231549.GB32346@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx51.mymxserver.com ([85.199.173.110]:59857 "EHLO
	mx51.mymxserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948AbZDTLJZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Apr 2009 07:09:25 -0400
In-Reply-To: <20090418231549.GB32346@dtor-d630.eng.vmware.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.arm.linux.org.uk

> I see. Then I would say that you need to supply both - kemap
> and an optional function to mangle scancode if needed.

The hardware supports an keypad with up to 8x8 keys: 256 keys. So 
you want me to setup a keymap table with 256 entries in the 
driver. And then either user-space or board-support code will 
populate this table?

I won't need that for my board, but I can see how this makes the 
driver more generally usable. So I can live with that. :-)

What I'd do is: if the keymap table entry is empty, then call the 
board-specific handler function if it's defined.
