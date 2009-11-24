From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: Query last reported event state
Date: Tue, 24 Nov 2009 21:57:29 +0200
Message-ID: <20091124195729.GB27249@gw.healthdatacare.com>
References: <20091124173356.GB14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:55502 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932375AbZKXT50 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2009 14:57:26 -0500
Received: by bwz27 with SMTP id 27so6358544bwz.21
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2009 11:57:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091124173356.GB14091@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org

Hi Daniel,

On Tue, Nov 24, 2009 at 06:33:56PM +0100, Daniel Mack wrote:
> Hi,
> 
> is there a way to query the last state an input device reported,
> preferably even for a special key mask? When a button is pressed and a
> userspace application is started, it should be able to figure out the
> current state, especially because those GPIO signals are likely
> connected to other peripherals to report arbitrary events in the system.
> Is there any such framework for that purpose?

Not sure whether this helps, but you can look <linux/input.h> and
check what ioctl()s it provides for this purpose. At least there
seems to be:
	EVIOCGKEY - get global keystate
	EVIOCGSW - get all switch states
	EVIOCGBIT - get event bits

Maybe you can use some of these to query current status of input events.

MW
