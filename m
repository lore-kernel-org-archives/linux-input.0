From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: usbhid: Add quirk for Redragon/Dragonrise Seymur
 2
Date: Thu, 11 Oct 2018 22:03:44 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810112203350.14430@cbobk.fhfr.pm>
References: <20181011075633.18868-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011075633.18868-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 11 Oct 2018, Kai-Heng Feng wrote:

> Redragon Seymur 2 stops working since commit 190d7f02ce8e ("HID: input:
> do not increment usages when a duplicate is found").
> 
> Use quirk HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE suggested by the commit
> can solve the issue.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200995
> BugLink: https://bugs.launchpad.net/bugs/1793846
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
