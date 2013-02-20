From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 0/7] hid driver transport cleanup
Date: Wed, 20 Feb 2013 21:31:40 +0100
Message-ID: <20130220203140.GA1425@polaris.bitmath.org>
References: <1360334256-22127-1-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:33173 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934793Ab3BTUaR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Feb 2013 15:30:17 -0500
Content-Disposition: inline
In-Reply-To: <1360334256-22127-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> so, here is the hid drivers cleanup. The aim is to remove as much as possible
> direct calls to usbhid for hid drivers. Thus, other transport layers can use
> the existing hid drivers (like I2C or uhid).
> 
> Henrik, patches 1 to 5 are yours. I just rebased and double-checked them. Please
> add you Signed-off-by if you are happy with the rebase.

I wanted to Ack 4-6 as well, but I think they warrant a bit more
elaborate commit messages. Other than that, it looks all good to me.

Cheers,
Henrik
