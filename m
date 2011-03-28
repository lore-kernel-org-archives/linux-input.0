From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Wacom Intuos4 LED and OLED support
Date: Mon, 28 Mar 2011 10:30:58 +0200
Message-ID: <20110328083058.GA7368@polaris.bitmath.org>
References: <1301225280-5642-1-git-send-email-eduard@hasenleithner.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp04.sth.basefarm.net ([80.76.153.5]:40558 "EHLO
	ch-smtp04.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752005Ab1C1I1U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Mar 2011 04:27:20 -0400
Content-Disposition: inline
In-Reply-To: <1301225280-5642-1-git-send-email-eduard@hasenleithner.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eduard Hasenleithner <eduard@hasenleithner.at>
Cc: linux-input@vger.kernel.org

On Sun, Mar 27, 2011 at 01:28:00PM +0200, Eduard Hasenleithner wrote:
> This commit enables control of the LEDs and OLED displays found
> on the Wacom Intuos4 M, L, and XL. For this purpose, an IOCTL
> interface is added to the wacom input driver. The IOCTLs can be
> issued on the raw USB device of the tablet.
> 
> Summary of changes:
> * A new ioctl-number (0xB2) for the Wacom IOCTL is allocated.
> * A new header file for the IOCTLs is introduced
> 	(include/linux/usb/wacom-dev.h)
> * Implementation of LED and OLED control in wacom_wac.c
> 
> Signed-off-by: Eduard Hasenleithner <eduard@hasenleithner.at>

Hi Eduard,

Did you consider using the LED input interface? Implement the
input_dev event hook and write EV_LED events to the device node.

Thanks,
Henrik
