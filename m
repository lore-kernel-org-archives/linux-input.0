From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3] hid: egalax: Convert to MT slots
Date: Tue, 7 Dec 2010 15:54:31 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012071554050.14806@pobox.suse.cz>
References: <1291722851-22909-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36697 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181Ab0LGOyc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Dec 2010 09:54:32 -0500
In-Reply-To: <1291722851-22909-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Philipp Merkel <mail@philmerk.de>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 7 Dec 2010, Henrik Rydberg wrote:

> The firmware in the joojoo reports touches sequentially, one per
> report, which confuses the current driver. A further complication is
> the absense of any indication of a touch frame. This patch converts
> the driver to the MT slots protocol, and outputs one full touch frame
> per report. This way, proper handling for both firmwares is ensured.
> 
> Tested-by: Philipp Merkel <mail@philmerk.de>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
