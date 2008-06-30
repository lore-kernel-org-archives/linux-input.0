From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] input: push down scancode negative checking
Date: Mon, 30 Jun 2008 12:56:20 -0700
Message-ID: <1214855780.5764.3.camel@localhost.localdomain>
References: <1214854426-20442-1-git-send-email-dwalker@mvista.com>
	 <20080630154701.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:4625 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470AbYF3T4X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2008 15:56:23 -0400
In-Reply-To: <20080630154701.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Philippe Troin <phil@fifi.org>, "Adolfo R. Brandes" <arbrandes@gmail.com>, linux-input@vger.kernel.org


On Mon, 2008-06-30 at 15:47 -0400, Dmitry Torokhov wrote:
> On Mon, Jun 30, 2008 at 12:33:46PM -0700, Daniel Walker wrote:
> > The getkeycode/setkeycode calls should be able to accept "negative" values.
> > 
> > The HID layer has some scan codes of the form 0xffbc0000 for logitech
> > devices, and they get ignored by these calls. I pushed the checking
> > into the input_default_* functions since they do need non-negative
> > values.
> > 
> > I also corrected a typo in the comment for input_set_keycode
> 
> Hmm, I wonder if we just need to type these as unsigned.
> 

I think it would make sense, because AFAIK scancodes don't really have a
concept of signed-ness anyway .. I almost did it that way, but I wasn't
sure enough about the reasoning for the signed int ..

Daniel

