From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: core: prevent out-of-bound readings
Date: Tue, 19 Jan 2016 14:15:04 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601191414490.21446@cbobk.fhfr.pm>
References: <1453203298-24993-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49075 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628AbcASNPI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2016 08:15:08 -0500
In-Reply-To: <1453203298-24993-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 19 Jan 2016, Benjamin Tissoires wrote:

> Plugging a Logitech DJ receiver with KASAN activated raises a bunch of
> out-of-bound readings.
> 
> The fields are allocated up to MAX_USAGE, meaning that potentially, we do
> not have enough fields to fit the incoming values.
> Add checks and silence KASAN.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to for-4.5/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

