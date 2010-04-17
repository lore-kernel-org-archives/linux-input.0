From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] Reset ps/2 port should psmouse_probe fail
	before	retrying
Date: Sat, 17 Apr 2010 18:53:15 +0200
Message-ID: <1271523195.3676.5.camel@lovely>
References: <4BC8EA42.6030507@canonical.com>
	 <1271502098.4155.27.camel@lovely>  <4BC9D444.3090802@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:44374 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab0DQQrz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Apr 2010 12:47:55 -0400
Received: by bwz25 with SMTP id 25so4111036bwz.28
        for <linux-input@vger.kernel.org>; Sat, 17 Apr 2010 09:47:53 -0700 (PDT)
In-Reply-To: <4BC9D444.3090802@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Cc: linux-input@vger.kernel.org, rubini@cvml.unipv.it

Hi

Am Samstag, den 17.04.2010, 11:31 -0400 schrieb Peter M. Petrakis:
> Hi,
> 
> i8042.reset=1 was one the first things we tried and it didn't
> improve the situation. Now looking at the code for
> i8042_controller_reset, I don't recall seeing these printks
> though I could double check.

And as far as I recall, you should see them.

>  Any other suggestions for
> resets or instrumentation?

not really, maybe you can check what windows (without vendor drivers)
does


