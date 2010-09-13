From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-pm] wacom + runtime PM = AA deadlock
Date: Mon, 13 Sep 2010 21:20:23 +0200
Message-ID: <201009132120.23372.oliver@neukum.org>
References: <4C8E180D.4020309@suse.cz> <201009131656.18199.oneukum@suse.de> <20100913171046.GA23116@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:56864 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab0IMTT4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 15:19:56 -0400
In-Reply-To: <20100913171046.GA23116@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, pingc@wacom.com, Jiri Slaby <jslaby@suse.cz>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Am Montag, 13. September 2010, 19:10:47 schrieb Dmitry Torokhov:

> I think this introduces significant change in behavior though - before
> we did not do usb_autopm_put_interface() on successful open, basically
> disabling autopm facilities, right?

Right. Which makes no sense at all. You'd better remove anything related
to runtime PM and not set supports_autosuspend for that.

	Regards
		Oliver
