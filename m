From: "J.R. Mauro" <jrm8005@gmail.com>
Subject: Re: [PATCH] input: Add a detailed multi-touch finger data report protocol
Date: Fri, 7 Nov 2008 09:36:57 -0500
Message-ID: <3aaafc130811070636g681accf5qae252679c2edcdb9@mail.gmail.com>
References: <49142351.9080805@euromail.se>
	 <3aaafc130811070534p54eebeb6q9b57d3e847ed859a@mail.gmail.com>
	 <49145016.7090206@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:27715 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbYKGOg6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Nov 2008 09:36:58 -0500
In-Reply-To: <49145016.7090206@euromail.se>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 7, 2008 at 9:26 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
> J.R. Mauro wrote:
>> On Fri, Nov 7, 2008 at 6:15 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
>>> In order to utilize the full power of the new multi-touch devices, a
>>> way to report detailed finger data to user space is needed. This patch
>>> adds a multi-touch (MT) protocol which allows drivers to report details
>>> for an arbitrary number of fingers.
>>
>> This is a great idea, Henrik. How will things like X11 go about
>> leveraging this functionality?
>
> What I have in mind is this:
>
> 1. Add support for the MT interface in the trackpad drivers, to the extent
> they support the information. First out is bcm5974, for which the interface
> is designed. A patch is prepared, but I will keep it on hold for a little
> while longer.
>
> 2. Add support for the MT protocol in Xorg synaptics and/or a new Xorg
> multitouch driver. As you might have guessed, I have an experimental
> driver, utilizing the MT protocol. It uses proper matching techniques
> to obtain smooth multi-finger actions. My plan is to launch this in user
> space as soon as there is kernel support.
>
> Henrik
>

Have you worked with MPX? Or was a vanilla-X11 driver simple enough?
How does this all get presented to userspace applications? Multiple
mouse inputs or special stuff that applications would need a rewrite
to leverage?
