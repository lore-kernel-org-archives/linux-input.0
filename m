From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: remove self-assignment from hid_input_report
Date: Wed, 30 Oct 2013 14:41:44 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1310301441370.21144@pobox.suse.cz>
References: <1381253627-2223-1-git-send-email-felix.rueegg@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50494 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753873Ab3J3Nls (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Oct 2013 09:41:48 -0400
In-Reply-To: <1381253627-2223-1-git-send-email-felix.rueegg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Felix Rueegg <felix.rueegg@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 8 Oct 2013, Felix Rueegg wrote:

> The ternary expression will always result in a self-assignment, which is pointless.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
