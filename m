From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: multitouch: add support of Panasonic multitouch
 panels
Date: Tue, 21 Feb 2012 11:56:32 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202211155580.31150@pobox.suse.cz>
References: <1329209433-8149-1-git-send-email-Denis.Kovalev@dataart.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50955 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754584Ab2BUK4e (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Feb 2012 05:56:34 -0500
In-Reply-To: <1329209433-8149-1-git-send-email-Denis.Kovalev@dataart.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Denis Kovalev <Denis.Kovalev@dataart.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 14 Feb 2012, Denis Kovalev wrote:

> Signed-off-by: Denis Kovalev <Denis.Kovalev@dataart.com>
> ---
>  drivers/hid/Kconfig          |    1 +
>  drivers/hid/hid-core.c       |    2 ++
>  drivers/hid/hid-ids.h        |    6 +++++-
>  drivers/hid/hid-multitouch.c |   19 +++++++++++++++----
>  4 files changed, 23 insertions(+), 5 deletions(-)

Adjusted commit message, fixed a trivial conflict in multitouch branch 
(MT_CLS value needed to be changed) and applied, thanks Denis.

-- 
Jiri Kosina
SUSE Labs
