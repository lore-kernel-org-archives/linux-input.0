From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [PATCH v9] input: tablet: add Pegasus Notetaker tablet driver
Date: Thu, 23 Jun 2016 17:50:04 +0200
Message-ID: <5e4cc0e9-7c80-8ecc-6d3e-003f7def7e7c@posteo.de>
References: <1465903215-2351-1-git-send-email-martink@posteo.de>
 <1465995712-20151-1-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:39859 "EHLO mout02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbcFWPuR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 11:50:17 -0400
Received: from submission (posteo.de [89.146.220.130])
	by mout02.posteo.de (Postfix) with ESMTPS id 1C87A20B42
	for <linux-input@vger.kernel.org>; Thu, 23 Jun 2016 17:50:08 +0200 (CEST)
In-Reply-To: <1465995712-20151-1-git-send-email-martink@posteo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, kernel-testers@vger.kernel.org, linux-usb@vger.kernel.org

Am 2016-06-15 um 15:01 schrieb Martin Kepplinger:
> This adds a driver for the Pegasus Notetaker Pen. When connected,
> this uses the Pen as an input tablet.
> 
> This device was sold in various different brandings, for example
>  "Pegasus Mobile Notetaker M210",
>  "Genie e-note The Notetaker",
>  "Staedtler Digital ballpoint pen 990 01",
>  "IRISnotes Express" or
>  "NEWLink Digital Note Taker".
> 
> Here's an example, so that you know what we are talking about:
> http://www.genie-online.de/genie-e-note-2/
> 
> https://pegatech.blogspot.com/ seems to be a remaining official resource.
> 
> This device can also transfer saved (offline recorded handwritten) data and
> there are userspace programs that do this, see https://launchpad.net/m210
> (Well, alternatively there are really fast scanners out there :)
> 
> It's *really* fun to use as an input tablet though! So let's support this
> for everybody.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
> Hi Dmitry. I append this just in case you want to replace the driver you
> took.
> 

Hi Dmitry,

This finishes up the driver for now. Any objections or advice from your
side?

thanks
                          martin

