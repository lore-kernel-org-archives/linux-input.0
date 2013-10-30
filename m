From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: i2c-hid: Stop querying for init reports
Date: Wed, 30 Oct 2013 14:24:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1310301423530.21144@pobox.suse.cz>
References: <1382329753-15589-1-git-send-email-bbasu@nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382329753-15589-1-git-send-email-bbasu@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bibek Basu <bbasu@nvidia.com>
Cc: benjamin.tissoires@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 21 Oct 2013, Bibek Basu wrote:

> According to specifications, HID over I2C devices
> are not bound to respond to query for INPUT
> REPORTS. Thus dropping the call during init
> as many devices does not respond causing error
> messages during boot.
> 
> Signed-off-by: Bibek Basu <bbasu@nvidia.com>

I am queuing this for 3.13. Thanks,

-- 
Jiri Kosina
SUSE Labs
