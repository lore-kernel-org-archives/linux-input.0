From: Alan Ott <alan@signal11.us>
Subject: Re: [PATCH v4 1/2] HID: Add Support for Setting and Getting Feature       Reports from hidraw
Date: Mon, 04 Oct 2010 09:37:54 -0400
Message-ID: <4CA9D8B2.2050607@signal11.us>
References: <1281442367.12579.206.camel@localhost.localdomain>	<1281990059-3562-2-git-send-email-alan@signal11.us>	<20100930015104.49fc5acf.ospite@studenti.unina.it>	<4CA40605.6080800@signal11.us>	<20101001000309.9bb53de4.ospite@studenti.unina.it>	<4CA67D2C.6060505@signal11.us> <20101002095009.ce1df06d.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:55650 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798Ab0JDNh4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Oct 2010 09:37:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 3F3021CCAA93
	for <linux-input@vger.kernel.org>; Mon,  4 Oct 2010 09:37:55 -0400 (EDT)
In-Reply-To: <20101002095009.ce1df06d.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On 10/02/2010 03:50 AM, Antonio Ospite wrote:
> Ok, I see your point and you convinced me, let it be "raw" then.
> If you are going through another iteration of the documentation patch
> maybe you can mention that buf[0] in the returned descriptor can be
> pretty much everything when dealing with deviated devices.
>
> Regards,
>     Antonio
>    

Will do. I'm sure that document will need a good scrubbing by the time 
this hidraw feature stuff is applied to the kernel.

Alan.

