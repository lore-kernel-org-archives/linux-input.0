From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH] input synaptics-rmi4: elliminate multiple sensor support
 from rmi_f11.c
Date: Sun, 8 Dec 2013 16:11:18 -0800
Message-ID: <52A50AA6.8040700@synaptics.com>
References: <1386295167-866-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:20234 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760116Ab3LIALT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Dec 2013 19:11:19 -0500
In-Reply-To: <1386295167-866-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On 12/05/2013 05:59 PM, Andrew Duggan wrote:
> This patch implements changes to the synaptics-rmi4 branch of
> Dmitry's input tree.  The base for the patch is commit
> 8ca01dc61a42b6f7bcba052a8c084000f7057a34.
> 
> This patch elliminates support for multiple sensors in rmi_f11. This feature
> has been removed from the RMI4 spec and no devices have every used multiple
> F11 sensors on a single device.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>


Sign-off-by: Christopher Heiny <cheiny@synaptics.com>
