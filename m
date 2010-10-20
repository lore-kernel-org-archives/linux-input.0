From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-sony, override usbhid_output_raw_report for
 Sixaxis
Date: Wed, 20 Oct 2010 16:51:32 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010201651190.6879@pobox.suse.cz>
References: <4CB71D2D.90200@signal11.us> <1287497590-10818-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:35561 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252Ab0JTOve (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Oct 2010 10:51:34 -0400
In-Reply-To: <1287497590-10818-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, Alan Ott <alan@signal11.us>, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, falktx@gmail.com

On Tue, 19 Oct 2010, Antonio Ospite wrote:

> Override usbhid_output_raw_report in order to force output reports (sent
> via hidraw_write, for instance) on the control endpoint.
> 
> The Sony Sixaxis (PS3 Controller) accepts output reports only on the
> control endpoint, it silently discards them when they arrive over the
> interrupt endpoint where usbhid would normally deliver them.
> 
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

Applied, thanks Antonio.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
