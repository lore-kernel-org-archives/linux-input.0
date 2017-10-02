From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/1] Revert "HID: multitouch: Support ALPS PTP stick with
 pid 0x120A"
Date: Mon, 2 Oct 2017 11:49:57 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710021149460.17517@jbgna.fhfr.qr>
References: <20171002075034.21586-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171002075034.21586-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2 Oct 2017, Kai-Heng Feng wrote:

> This reverts commit fcaa4a07d2a4b541e91da7a55d8b3331f96d1865.
> 
> As noted by Masaki [1], 0x120A + trackpoint will not be used in mass
> production machines, so remove the ID accordingly.
> 
> [1] http://www.spinics.net/lists/linux-input/msg53222.html
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied to for-4.14/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs
