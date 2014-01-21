From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] drivers/hid/wacom: fixed coding style issues
Date: Tue, 21 Jan 2014 13:25:54 -0800
Message-ID: <1390339554.31946.6.camel@joe-AO722>
References: <20140121195153.GA4198@fedora.fritz.box>
	 <20140121200645.GC29615@core.coreip.homeip.net>
	 <20140121202944.GA4554@fedora.fritz.box>
	 <20140121211823.GD29615@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0019.hostedemail.com ([216.40.44.19]:33805 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754196AbaAUVZ6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jan 2014 16:25:58 -0500
In-Reply-To: <20140121211823.GD29615@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Schroer <sulamiification@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2014-01-21 at 13:18 -0800, Dmitry Torokhov wrote:
> On Tue, Jan 21, 2014 at 09:29:44PM +0100, Rob Schroer wrote:
> > As far as I can see, kstrtoXXX() might be an alternative, but I was just
> > fixing coding style issues, no need to break anything IMO.
> 
> You could do the breaking in a follow up patch ;)

Yes please.

Include the breaking of multiple statements
into multiple lines too please like

from:
	case USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH:
		rep_data[0] = 0x03; rep_data[1] = 0x00;

to:
	case USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH:
		rep_data[0] = 0x03;
		rep_data[1] = 0x00;


