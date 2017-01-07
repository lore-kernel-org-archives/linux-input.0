From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: PROBLEM: Baytrail tablet touchscreen fails after pinctrl commit
 [3ae02c14d964499da76b5ef4d8912710902e64f8]
Date: Sat, 07 Jan 2017 20:14:01 +0200
Message-ID: <1483812841.26691.7.camel@linux.intel.com>
References: <6306d18a-d5d3-3e89-5f41-2a45d3de1398@uwyo.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41803 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941581AbdAGSO2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 7 Jan 2017 13:14:28 -0500
In-Reply-To: <6306d18a-d5d3-3e89-5f41-2a45d3de1398@uwyo.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Robert R. Howell" <rhowell@uwyo.edu>, Mika Westerberg <mika.westerberg@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-gpio@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Fri, 2017-01-06 at 02:30 -0700, Robert R. Howell wrote:
> [1.]  Baytrail tablet touchscreen fails after pinctrl commit 
> [3ae02c14d964499da76b5ef4d8912710902e64f8]
> 
> [2.]  Beginning with kernel 4.10-rc1 (and continuing with 4.10-rc2)
> the 
> touchscreen on two Baytrail devices, an ASUS T100TA and a Toshiba
> Encore 
> 8, no longer works.  They did work properly up though at least 4.9.0.
> As 
> indicated in the DMESG output appended below, the ATML1000
> touchscreen 
> controller fails to reset and initialize properly on boot. The reset 
> command issued through i2c_hid appears to time out after its 5 second 
> wait for completion.  (There are similar problems with an i2c 
> orientation sensor.)  Using git bisect I've found that the problem 
> begins with commit [3ae02c14d964499da76b5ef4d8912710902e64f8]
> pinctrl: intel: set default handler to be handle_bad_irq()
> 
> I've appended the git bisect log output at the end.  Reverting that 
> single commit (tested with 4.10-rc2) fixes the problem.

Thanks for the report. For me it looks like that commit actually
discovers other problems we have in the code somewhere.

Yeah, I confirm the issue on T100TA. I will investigate this next week.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
