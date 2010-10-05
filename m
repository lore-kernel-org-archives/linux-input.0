From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-pm] wacom + runtime PM = AA deadlock
Date: Tue, 5 Oct 2010 07:54:21 +0200
Message-ID: <201010050754.21158.oliver@neukum.org>
References: <4C8E180D.4020309@suse.cz> <201010042124.24253.oliver@neukum.org> <20101005054139.GC15355@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:55179 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab0JEFxX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 01:53:23 -0400
In-Reply-To: <20101005054139.GC15355@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, pingc@wacom.com, Jiri Slaby <jslaby@suse.cz>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Am Dienstag, 5. Oktober 2010, 07:41:40 schrieb Dmitry Torokhov:

> Thanks Oliver. And the patch below is for .37 properly enabling runtime
> PM for wacom.

Acked-by: Oliver Neukum <oneukum@suse.de>

	Regards
		Oliver
