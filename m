From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] HID: wacom: Add support for Cintiq Companion 2
Date: Thu, 08 Oct 2015 02:59:33 +0200
Message-ID: <1444265973.28661.3.camel@hadess.net>
References: <1444262144-19327-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41841 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbbJHA7n (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Oct 2015 20:59:43 -0400
In-Reply-To: <1444262144-19327-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, expiredpopsicle@gmail.com, Jason Gerecke <jason.gerecke@wacom.com>

On Wed, 2015-10-07 at 16:55 -0700, Jason Gerecke wrote:
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> Signed-off-by: Clifford Jolly <expiredpopsicle@gmail.com>

Is that support for using the Cintiq Companion 2 as an accessory (eg.
still running Windows on the machine, and plugging it in to a Linux
machine), or for the Wacom device inside the tablet when it's running
Linux (if that's possible)?

Either way, which it is should be included in the commit message.

For those who don't know about that device:
http://www.wacom.com/en-us/products/pen-displays/cintiq-companion-2

Cheers
