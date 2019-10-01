From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] HID: hidraw: replace printk() with corresponding
 pr_xx() variant
Date: Tue, 1 Oct 2019 16:23:46 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1910011623370.13160@cbobk.fhfr.pm>
References: <20190919161613.GR237523@dtor-ws> <1568946901-29752-1-git-send-email-gupt21@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568946901-29752-1-git-send-email-gupt21@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rishi Gupta <gupt21@gmail.com>
Cc: dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 20 Sep 2019, Rishi Gupta wrote:

> This commit replaces direct invocations of printk with
> their appropriate pr_info/warn() variant.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> ---
> Changes in v3:
> * Use hid_warn() subsystem specific variant instead of pr_warn()

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
