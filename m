From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: [PATCH, v2] input/imx2x: generic keypad handler for i.MX SoCs
Date: Fri, 17 Apr 2009 21:23:17 +0200
Message-ID: <200904172123.18096.hs4233@mail.mn-solutions.de>
References: <200904171640.14294.hs4233@mail.mn-solutions.de> <18920.42140.160633.645220@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx51.mymxserver.com ([85.199.173.110]:34067 "EHLO
	mx51.mymxserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbZDQTXo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Apr 2009 15:23:44 -0400
In-Reply-To: <18920.42140.160633.645220@ipc1.ka-ro>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lothar =?iso-8859-1?q?Wa=DFmann?= <LW@karo-electronics.de>
Cc: linux-input@vger.kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.arm.linux.org.uk

> Why do you invent your own error code instead of reporting the
> error that clk_get() returned?

You're total right, I should have known better :-)


This error happens so often, not only by me, that I think the 
clk_get should actually simply return NULL.
