From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: atmel_mxt_ts driver DTS adoption
Date: Mon, 30 Sep 2013 16:41:48 +0100
Message-ID: <52499BBC.2060801@itdev.co.uk>
References: <5241CC68.70909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:50581 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754691Ab3I3Plv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Sep 2013 11:41:51 -0400
In-Reply-To: <5241CC68.70909@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

Hi Dan-

Dan Murphy wrote:
> I have been looking around and I am finding numerous patches for the
> atmel_mxt_ts file to adopt it to DTS.
> 
> The last status I have seen was we were waiting for some re-write of 
> the file and that was in April.
> 
> Are there any recent patches for this? And are they ready?
> 
> I have not followed the input list so I am sorry for not being up to 
> date on this.

There is a big pending update to atmel_mxt_ts that I sent to linux-input on
27th June this year. It is combination of work done by the Google Chromium
guys (for the Pixel laptop) and by myself (working for Atmel UK). Dimitry
Torokhov was working on merging it as of earlier this month, I don't know
how far along he is with it.

Latest version is here:
https://github.com/ndyer/linux/commits/for-next

Supporting DTS is very high on my priority list as the next item of work,
amongst various other small features and code improvements. I should say,
some of those patches make large changes to the platform data required. If
you would like to send me a patch on top of the current set I am happy to
generalise if necessary, include it in the set of changes and manage
forwarding it to Dimitry in due course.

cheers

Nick


