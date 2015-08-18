From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: gembird: add new driver to fix Gembird JPD-DualForce
 2
Date: Tue, 18 Aug 2015 15:05:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508181505050.25821@pobox.suse.cz>
References: <1439478687-15990-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58833 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310AbbHRNFU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2015 09:05:20 -0400
In-Reply-To: <1439478687-15990-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Orivej Desh <orivej@gmx.fr>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, 13 Aug 2015, Benjamin Tissoires wrote:

> This gamepad advertise 5 absolute axis while 4 are actually used.
> The second Z axis shows some garbage, so it has to be ignored by HID.
> The first Z axis and the Rz one are actually Rx and Ry. Remap them.
> 
> We could also just remap and ignore the axis in .input_mapping(). I
> went ahead with .report_fixup() first, so here it is.
> 
> Reported-by: Orivej Desh <orivej@gmx.fr>
> Tested-by: Orivej Desh <orivej@gmx.fr>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to for-4.3/gembird.

-- 
Jiri Kosina
SUSE Labs

