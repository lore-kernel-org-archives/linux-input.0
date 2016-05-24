From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] i2c_hid: enable i2c-hid devices to suspend/resume
 asynchronously
Date: Tue, 24 May 2016 12:24:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1605241223460.31937@cbobk.fhfr.pm>
References: <573D2900.6090903@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57674 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435AbcEXKYq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2016 06:24:46 -0400
In-Reply-To: <573D2900.6090903@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: benjamin.tissoires@redhat.com, dtor@chromium.org, bleung@chromium.org, Mika Westerberg <mika.westerberg@linux.intel.com>, aduggan@synaptics.com, k.kozlowski@samsung.com, dianders@chromium.org, gabriele.mzt@gmail.com, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 19 May 2016, Fu, Zhonghui wrote:

> i2c-hid devices' suspend/resume are usually time-consuming process.
> For example, the touch controller(i2c-ATML1000:00) on ASUS T100 tablet
> takes about 160ms for suspending and 120ms for resuming. This patch
> enables i2c-hid devices to suspend/resume asynchronously. This will
> take advantage of multicore and speed up system suspend/resume process.

Umm, why do we need this in the first place, given the fact that we are 
enabling async suspend for each and every HID device allocated via 
hid_allocate_device() already?

-- 
Jiri Kosina
SUSE Labs

