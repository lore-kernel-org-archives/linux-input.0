From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 04/16] HID: wiimote: Add extension support stub
Date: Mon, 14 Nov 2011 12:35:17 +0100
Message-ID: <201111141235.17887.oneukum@suse.de>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com> <201111140854.37983.oneukum@suse.de> <CANq1E4QbOHa=-Vqi5pmSDi5OHJhN6nXkxD1wcHUSi-2xnOagBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49180 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab1KNLeT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 06:34:19 -0500
In-Reply-To: <CANq1E4QbOHa=-Vqi5pmSDi5OHJhN6nXkxD1wcHUSi-2xnOagBw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

Am Montag, 14. November 2011, 12:26:28 schrieb David Herrmann:
> I also know that wdata lives longer than wdata->ext so I cannot find
> any race condition here. I have checked all four entry points of the
> extension-module and they all seem fine here.
> 
> As long as wdata->ext is non-NULL, wiiext_schedule may be called. So I
> first need to clear wdata->ext before I kill the worker. Otherwise the
> worker may be respawned before I reset wdata->ext ;)

Hi,

thank you for the detailed explanation. Could you include a comment
to explain the unusual order things are done in this function?

	Regards
		Oliver
