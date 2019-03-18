From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Increase maximum report size allowed by
 hid_field_extract()
Date: Mon, 18 Mar 2019 14:48:25 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1903181448180.19912@cbobk.fhfr.pm>
References: <20190308051117.21899-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308051117.21899-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 8 Mar 2019, Kai-Heng Feng wrote:

> Commit 71f6fa90a353 ("HID: increase maximum global item tag report size
> to 256") increases the max report size from 128 to 256.
> 
> We also need to update the report size in hid_field_extract() otherwise
> it complains and truncates now valid report size:
> [ 406.165461] hid-sensor-hub 001F:8086:22D8.0002: hid_field_extract() called with n (192) > 32! (kworker/5:1)
> 
> BugLink: https://bugs.launchpad.net/bugs/1818547
> Fixes: 71f6fa90a353 ("HID: increase maximum global item tag report size to 256")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
