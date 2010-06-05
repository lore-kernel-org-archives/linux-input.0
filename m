From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH 1/1] LEDS: leds-input, fix sleep inside atomic
Date: Sun, 6 Jun 2010 01:45:06 +0200
Message-ID: <20100605234505.GZ5358@const.famille.thibault.fr>
References: <1275772342-25094-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from solo.fdn.fr ([80.67.169.19]:55754 "EHLO solo.fdn.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933775Ab0FEXpJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 5 Jun 2010 19:45:09 -0400
Content-Disposition: inline
In-Reply-To: <1275772342-25094-1-git-send-email-jslaby@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: rpurdie@rpsys.net, akpm@linux-foundation.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com

Jiri Slaby, le Sat 05 Jun 2010 23:12:22 +0200, a =E9crit :
> Fix this by changing the spinlock to mutex as it is used only in
> input_handler->connect and ->disconnect and it is safe to sleep
> there.

Right. in a previous patch it was also used in interrupt context, but
now it should be safe indeed.

Andrew, please fold it into the leds-input patch.

> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Richard Purdie <rpurdie@rpsys.net>
Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

BTW, please also Cc authors of files when reporting bugs... :)

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
