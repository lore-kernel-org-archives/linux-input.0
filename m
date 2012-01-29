From: Marc Dietrich <marvin24@gmx.de>
Subject: Re: [RFC PATCH 0/2] Input: psmouse - new mechanism for bad packet handling
Date: Sun, 29 Jan 2012 12:11:18 +0100
Message-ID: <1472111.M4pyp9dHMJ@ax5200p>
References: <1323257924-12773-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:55947 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751220Ab2A2LLc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jan 2012 06:11:32 -0500
In-Reply-To: <1323257924-12773-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

On Wednesday 07 December 2011 19:38:42 JJ Ding wrote:
> Hi list,
> 
> The first patch adds a new way to deal with bad packets. This mechanism is
> used in our original driver. When I first sent the patches to support elan's
> v3 and v4 hardware, Dmitry suggested this should be done in psmouse core,
> so here is another try.
> 
> I am not sure if this is the prefered way to handle bad packets, so I
> introduce PSMOUSE_SHIFT_PACKET for psmouse_ret_t, and convert elan driver
> to use this.
> 
> These patches are sent to gather feedback and comments, please take a look,
> and let me know if this new mechanism is OK. Thank you very much.

what is the status of these patches? They are not it the input tree AFAICS.

Marc

> P.S. patches are against Dmitry's -next tree.
> 
> Best regards,
> -JJ
> 
> JJ Ding (2):
>   Input: psmouse - work around EC buffer
>   Input: elantech - convert v1 ~ v3 hardware to use
>     PSMOUSE_SHIFT_PACKET
> 
>  drivers/input/mouse/elantech.c     |    6 +++---
>  drivers/input/mouse/psmouse-base.c |    5 +++++
>  drivers/input/mouse/psmouse.h      |    3 ++-
>  3 files changed, 10 insertions(+), 4 deletions(-)
