From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] input: push down scancode negative checking
Date: Tue, 1 Jul 2008 09:51:05 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0807010950250.4593@jikos.suse.cz>
References: <1214854426-20442-1-git-send-email-dwalker@mvista.com>  <20080630154701.ZZRA012@mailhub.coreip.homeip.net> <1214855780.5764.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:58531 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752085AbYGAHvH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Jul 2008 03:51:07 -0400
In-Reply-To: <1214855780.5764.3.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Philippe Troin <phil@fifi.org>, "Adolfo R. Brandes" <arbrandes@gmail.com>, linux-input@vger.kernel.org

On Mon, 30 Jun 2008, Daniel Walker wrote:

>> Hmm, I wonder if we just need to type these as unsigned.
> I think it would make sense, because AFAIK scancodes don't really have a
> concept of signed-ness anyway .. I almost did it that way, but I wasn't
> sure enough about the reasoning for the signed int ..

That would be the option I'd prefer too.

Thanks,

-- 
Jiri Kosina
SUSE Labs
