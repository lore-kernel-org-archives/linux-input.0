From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] input synaptics-rmi4: elliminate multiple sensor support
 from rmi_f11.c
Date: Mon, 09 Dec 2013 16:03:23 -0500
Message-ID: <52A6301B.1090507@redhat.com>
References: <1386295167-866-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:61013 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755833Ab3LIVFM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Dec 2013 16:05:12 -0500
In-Reply-To: <1386295167-866-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>

On 05/12/13 20:59, Andrew Duggan wrote:
> This patch implements changes to the synaptics-rmi4 branch of
> Dmitry's input tree.  The base for the patch is commit
> 8ca01dc61a42b6f7bcba052a8c084000f7057a34.

FWIW, these three lines above could (should) go after the very first
"---" before the stats. This way, you will tell the list which base is
the patch based, but this will not go into Linus' tree (which would be
irrelevant).

> 
> This patch elliminates support for multiple sensors in rmi_f11. This feature
> has been removed from the RMI4 spec and no devices have every used multiple
> F11 sensors on a single device.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---

I did not saw anything but what the commit message claims. So:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin
