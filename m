From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: [PATCH 1/2] Input: synaptics - add second variant of two-button
 clickpad
Date: Tue, 13 Mar 2012 14:41:33 -0700
Message-ID: <4F5FBF0D.8040106@gmail.com>
References: <1329193273-12486-1-git-send-email-chase.douglas@canonical.com> <1480064.SeUIWcqsCr@brontomerus.synaptics.com> <4F501FEA.5020803@gmail.com> <1557704.NQD0apMTB1@brontomerus.synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38556 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab2CMVlP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 17:41:15 -0400
Received: by yenl12 with SMTP id l12so1079660yen.19
        for <linux-input@vger.kernel.org>; Tue, 13 Mar 2012 14:41:15 -0700 (PDT)
In-Reply-To: <1557704.NQD0apMTB1@brontomerus.synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <christopherheiny@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 03/01/2012 05:27 PM, Christopher Heiny wrote:
> On Thursday, March 01, 2012 05:18:34 PM Chase Douglas wrote:
>> On 03/01/2012 04:59 PM, Christopher Heiny wrote:
>>> Chase - those capability bits look a bit wacky to me.  Can you tell me
>>> the TM number or product ID info for those pads?
>>
>> How do I get the TM number and product ID? What is the TM number?
> 
> Sorry for the confusing terminology.  TM number is the board number, found in 
> query 0x01.  Product ID is TouchPad model ID, found in query 0x00.

Sorry for not getting back sooner. Here's the Touchpad model line:

Touchpad model: 1, fw: 7.4, id: 0x1e0b1, caps: 0xd04713/0xa40000/0x2a0000

I don't see any usage of SYN_QUE_MODES, which is query 0x01. I can hack
it up, but I don't know what the returned data format is.

Thanks!

-- Chase
