From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hidraw: switch to using memdup_user
Date: Thu, 24 Mar 2016 15:22:24 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603241521550.3656@cbobk.fhfr.pm>
References: <20160316235938.GA23827@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42056 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbcCXOW0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Mar 2016 10:22:26 -0400
In-Reply-To: <20160316235938.GA23827@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 16 Mar 2016, Dmitry Torokhov wrote:

> Instead of open-coding memory allocation and copying form user memory
> sequence let's use memdup_user().

Makes sense. Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

