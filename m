From: Sean Young <sean@mess.org>
Subject: Re: [PATCH v2] HID: Add support for pressure sensitive buttons
Date: Wed, 23 Nov 2011 10:43:50 +0000
Message-ID: <20111123104350.GB18828@pip.mess.org>
References: <1321393219-19394-1-git-send-email-sean@mess.org>
 <20111121095818.GA3568@pip.mess.org>
 <20111121133428.99064g5drrymryww@www.81.fi>
 <20111122114725.GA13107@pip.mess.org>
 <alpine.LNX.2.00.1111221817070.28728@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pip.mess.org ([212.110.186.137]:54439 "EHLO pip.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782Ab1KWKnv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 05:43:51 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1111221817070.28728@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, simon@mungewell.org

On Tue, Nov 22, 2011 at 06:17:49PM +0100, Jiri Kosina wrote:
> On Tue, 22 Nov 2011, Sean Young wrote:
> Also, is there please any userspace application making use of the newly 
> added sysfs atributes already?

No, there isn't, beyond the shell scripts on my machine. However, this is 
a regular function of the playstation dualshock controllers. I guess this
is the first driver to attempt support it.


Sean
