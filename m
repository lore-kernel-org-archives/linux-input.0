From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [hid:for-4.10/i2c-hid 7/8] drivers/hid/i2c-hid/i2c-hid.c:772:19:
 error: 'struct i2c_hid' has no member named 'irq'
Date: Mon, 12 Dec 2016 09:50:02 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1612120949490.16984@cbobk.fhfr.pm>
References: <201612110449.vUI7nclV%fengguang.wu@intel.com> <20161210210618.GD1919@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45203 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbcLLIuH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Dec 2016 03:50:07 -0500
In-Reply-To: <20161210210618.GD1919@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, =?ISO-8859-15?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>, kbuild-all@01.org, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Sat, 10 Dec 2016, Benjamin Tissoires wrote:

> Ouch. Sorry, I should have spotted this during review.
> 
> Jiri, could you apply the following simple fix:

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

