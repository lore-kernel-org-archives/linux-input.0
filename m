From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] Reset ps/2 port should      psmouse_probe   fail
	before retrying
Date: Sat, 08 May 2010 18:22:09 +0200
Message-ID: <1273335729.7427.17.camel@lovely>
References: <1271723857.6652.6.camel@lovely>
	 <20100422215517.GB28213@core.coreip.homeip.net>
	 <1271983668.16254.44.camel@lovely>
	 <201004230953.52447.dmitry.torokhov@gmail.com>
	 <1272072125.4341.10.camel@lovely> <1272103233.4666.15.camel@lovely>
	 <20100428072633.GC4232@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:34071 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518Ab0EHQQH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 May 2010 12:16:07 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1085865fga.1
        for <linux-input@vger.kernel.org>; Sat, 08 May 2010 09:16:05 -0700 (PDT)
In-Reply-To: <20100428072633.GC4232@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Peter M. Petrakis" <peter.petrakis@canonical.com>, linux-input@vger.kernel.org, rubini <rubini@cvml.unipv.it>

On Wed, 2010-04-28 at 00:26 -0700, Dmitry Torokhov wrote:

> What about simply resetting the mouse before actually trying to
> reconnect?

Isn't psmouse_reconnect() the first in psmouse-base.c that gets called
after waking up from hibernation/suspend?
And should all ps2 devices get a reset or only the one which needs it
(synaptic touchpads not handled by synaptics driver)?


