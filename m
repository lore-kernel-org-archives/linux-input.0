From: Christopher Heiny <christopherheiny@gmail.com>
Subject: Re: [PATCH 1/2] Input: synaptics - add second variant of two-button clickpad
Date: Thu, 01 Mar 2012 17:27:51 -0800
Message-ID: <1557704.NQD0apMTB1@brontomerus.synaptics.com>
References: <1329193273-12486-1-git-send-email-chase.douglas@canonical.com> <1480064.SeUIWcqsCr@brontomerus.synaptics.com> <4F501FEA.5020803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55150 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab2CBB1z (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Mar 2012 20:27:55 -0500
Received: by dajr28 with SMTP id r28so1391535daj.19
        for <linux-input@vger.kernel.org>; Thu, 01 Mar 2012 17:27:55 -0800 (PST)
In-Reply-To: <4F501FEA.5020803@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chasedouglas@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thursday, March 01, 2012 05:18:34 PM Chase Douglas wrote:
> On 03/01/2012 04:59 PM, Christopher Heiny wrote:
> > Chase - those capability bits look a bit wacky to me.  Can you tell me
> > the TM number or product ID info for those pads?
> 
> How do I get the TM number and product ID? What is the TM number?

Sorry for the confusing terminology.  TM number is the board number, found in 
query 0x01.  Product ID is TouchPad model ID, found in query 0x00.
