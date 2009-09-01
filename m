From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add support for Rotronic silver/white handset
	in cm109 driver
Date: Mon, 31 Aug 2009 18:37:38 -0700
Message-ID: <20090901021017.26A96526EA5@mailhub.coreip.homeip.net>
References: <4A9ACD69.5030501@unixsol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f175.google.com ([209.85.222.175]:59000 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbZIABhn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Aug 2009 21:37:43 -0400
Content-Disposition: inline
In-Reply-To: <4A9ACD69.5030501@unixsol.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Georgi Chorbadzhiyski <gf@unixsol.org>
Cc: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Georgi,

On Sun, Aug 30, 2009 at 10:05:13PM +0300, Georgi Chorbadzhiyski wrote:
> The following patch adds support for yet another keymap in
> cm109 driver. Rotronic silver/white is USB "Skype" handset
> sold in Bulgaria and Serbia (according to Google). With this
> cheap stuff a picture is the only way to identify what you've
> got, so here is one:
>    http://www.reset.bg/catalog/images/skyphoneusbbelihcek.jpg
> 

While there is nothing wrong with the patch I am hesitant to apply it.
Any chance we could push it onto HAL or maybe have your application to
load appropriate keymap? I know we can't do it automatically because
vendor and product IDs are the same for all these devices... It's just
putting every keymap into the kernel is not sustainable.

-- 
Dmitry
