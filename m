From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: usbhid: quirk for PM1610 and PM1640 Touchscreen.
Date: Fri, 27 Jun 2014 16:04:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1406271604220.21386@pobox.suse.cz>
References: <1403857328-38892-1-git-send-email-penmount.touch@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59410 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740AbaF0OEd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Jun 2014 10:04:33 -0400
In-Reply-To: <1403857328-38892-1-git-send-email-penmount.touch@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Sung <penmount.touch@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 27 Jun 2014, John Sung wrote:

> These device needs to be added to the quirks list with HID_QUIRK_NOGET,
> otherwise they will reset upon receiving the get input report requests.
> 
> Signed-off-by: John Sung <penmount.touch@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
