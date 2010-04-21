From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Add support for the Wacom Intuos 4 wireless
Date: Wed, 21 Apr 2010 15:07:46 +0100
Message-ID: <1271858866.17421.3575.camel@localhost.localdomain>
References: <1271857920.1960.5.camel@localhost.localdomain>
	 <alpine.LNX.2.00.1004211553220.7579@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-v.mail.gandi.net ([217.70.178.76]:38869 "EHLO
	relay2-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652Ab0DUOHv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 10:07:51 -0400
In-Reply-To: <alpine.LNX.2.00.1004211553220.7579@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Wed, 2010-04-21 at 15:53 +0200, Jiri Kosina wrote:
<snip>
> Hi Bastien,
> 
> has this particular patch been tested?

ENOHARDWARE :(

But the specs I have say so.

> How about addition of this VID/PID combination to hid_blacklist[]?

My mistake, that needs to be done as well obviously.

Will send an updated patch shortly.

Cheers

