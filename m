From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: Add a detailed multi-touch finger data report
 protocol
Date: Fri, 07 Nov 2008 15:26:30 +0100
Message-ID: <49145016.7090206@euromail.se>
References: <49142351.9080805@euromail.se> <3aaafc130811070534p54eebeb6q9b57d3e847ed859a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:37984 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750904AbYKGO0p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Nov 2008 09:26:45 -0500
In-Reply-To: <3aaafc130811070534p54eebeb6q9b57d3e847ed859a@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "J.R. Mauro" <jrm8005@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

J.R. Mauro wrote:
> On Fri, Nov 7, 2008 at 6:15 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
>> In order to utilize the full power of the new multi-touch devices, a
>> way to report detailed finger data to user space is needed. This patch
>> adds a multi-touch (MT) protocol which allows drivers to report details
>> for an arbitrary number of fingers.
> 
> This is a great idea, Henrik. How will things like X11 go about
> leveraging this functionality?

What I have in mind is this:

1. Add support for the MT interface in the trackpad drivers, to the extent
they support the information. First out is bcm5974, for which the interface
is designed. A patch is prepared, but I will keep it on hold for a little
while longer.

2. Add support for the MT protocol in Xorg synaptics and/or a new Xorg
multitouch driver. As you might have guessed, I have an experimental
driver, utilizing the MT protocol. It uses proper matching techniques
to obtain smooth multi-finger actions. My plan is to launch this in user
space as soon as there is kernel support.

Henrik

