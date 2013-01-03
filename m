From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: uhid: use __packed__ for uhid_feature_answer_req
Date: Thu, 3 Jan 2013 10:40:09 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301031039590.27348@pobox.suse.cz>
References: <1355746843-14015-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51041 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915Ab3ACJkN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Jan 2013 04:40:13 -0500
In-Reply-To: <1355746843-14015-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org

On Mon, 17 Dec 2012, David Herrmann wrote:

> We use __packed__ for all API structures so we can extend them without
> breaking alignment rules. We do try to explicitly align the structures,
> but to be safe we also use __packed__.
> uhid_feature_answer_req is already 64bit aligned so we can add __packed__
> without breaking ABI.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>

Applied, thanks David.

-- 
Jiri Kosina
SUSE Labs
