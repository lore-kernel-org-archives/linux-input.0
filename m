From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 0/2] Input misc/bma150.[ch] one fix and one improvement
Date: Fri, 15 Feb 2013 12:09:11 +0100
Message-ID: <20130215120911.f9b723973b8e7b97462241a6@studenti.unina.it>
References: <1360281506-13618-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:52785 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687Ab3BOLJO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Feb 2013 06:09:14 -0500
In-Reply-To: <1360281506-13618-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Michael Trimarchi <michael@amarulasolutions.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Albert Zhang <xu.zhang@bosch-sensortec.com>, Eric Andersson <eric.andersson@unixphere.com>, Jonathan Cameron <jic23@cam.ac.uk>, Antonio Ospite <ao2@amarulasolutions.com>

On Fri,  8 Feb 2013 00:58:23 +0100
Antonio Ospite <ospite@studenti.unina.it> wrote:

> From: Antonio Ospite <ao2@amarulasolutions.com>
> 
> Hi,
> 
> Patch 1 in the series fixes a panic Michael was experiencing.
> 
> Patch 2 makes it easier to use the actual values the implementation
> expects in the platform data.
>

Ping on this series, I forgot to Cc Dmitry in the original submission.
Dmitry, should I resend?

> Regards,
>    Antonio
> 
> Michael Trimarchi (2):
>   Input: misc/bma150.c, fix checking pm_runtime_get_sync() return value
>   Input: misc/bma150.[ch], make some defines public and fix some
>     comments
> 
>  drivers/input/misc/bma150.c |   14 +-------------
>  include/linux/bma150.h      |   16 ++++++++++++++--
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
