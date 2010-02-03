From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: add multi-input quirk for eGalax Touchcontroller
Date: Wed, 3 Feb 2010 11:53:20 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002031152370.15395@pobox.suse.cz>
References: <20100202034040.GA16880@barra.bne.redhat.com> <alpine.LNX.2.00.1002022129380.15395@pobox.suse.cz> <20100203033914.GA23850@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51895 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab0BCKxV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Feb 2010 05:53:21 -0500
In-Reply-To: <20100203033914.GA23850@barra.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 3 Feb 2010, Peter Hutterer wrote:

> > Does looking at the HID report descriptor and looking at the actual 
> > raw HID reports coming out from the device give any clue? (in recent 
> > kernels, you can just use 'hid' directory in debugfs to gather all 
> > this information).
> 
> Thanks. The hid descriptor table is attached, but tbh I'm not well-versed
> enough in the HID protocol to even tell what format I can give you. I've
> attached a simple hexdump of two presses, one with a finger, one with the
> stylus. Let me know what format you need or what how I can start to decypher
> this myself (are there any parsing tools around?).

It shouldn't be necesarry to run hexdump on the 'events' node, the data 
coming from it are supposed to already be parsed and human-readable.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
