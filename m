From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c_hid: enable i2c-hid devices to suspend/resume
 asynchronously
Date: Mon, 23 May 2016 11:22:31 +0300
Message-ID: <20160523082231.GC2037@lahna.fi.intel.com>
References: <573D2900.6090903@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47859 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999AbcEWIWh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2016 04:22:37 -0400
Content-Disposition: inline
In-Reply-To: <573D2900.6090903@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, dtor@chromium.org, bleung@chromium.org, aduggan@synaptics.com, k.kozlowski@samsung.com, dianders@chromium.org, gabriele.mzt@gmail.com, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, May 19, 2016 at 10:46:24AM +0800, Fu, Zhonghui wrote:
> i2c-hid devices' suspend/resume are usually time-consuming process.
> For example, the touch controller(i2c-ATML1000:00) on ASUS T100 tablet
> takes about 160ms for suspending and 120ms for resuming. This patch
> enables i2c-hid devices to suspend/resume asynchronously. This will
> take advantage of multicore and speed up system suspend/resume process.
> 
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>

Looks reasonable to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
