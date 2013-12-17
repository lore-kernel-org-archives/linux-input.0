From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: debug: add labels for some new buttons
Date: Tue, 17 Dec 2013 13:56:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1312171355100.28730@pobox.suse.cz>
References: <1387281168-13856-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54712 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929Ab3LQM4P (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Dec 2013 07:56:15 -0500
In-Reply-To: <1387281168-13856-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org

On Tue, 17 Dec 2013, Antonio Ospite wrote:

> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

I have added some changelog and applied, thanks.

> ---
> 
> I also noticed that BTN_GEAR_DOWN is named "WheelBtn", should this be fixed?

	#define BTN_WHEEL		0x150
	#define BTN_GEAR_DOWN		0x150
	#define BTN_GEAR_UP		0x151

-- 
Jiri Kosina
SUSE Labs
