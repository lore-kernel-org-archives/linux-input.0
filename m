From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: intel-ish-hid: use put_device() instead of
 kfree()
Date: Thu, 26 Apr 2018 14:37:12 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1804261437040.28147@cbobk.fhfr.pm>
References: <66bd5f1ab1322081927f657090a04b44da326140.1522408033.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <66bd5f1ab1322081927f657090a04b44da326140.1522408033.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 30 Mar 2018, Arvind Yadav wrote:

> Never directly free @dev after calling device_register(), even
> if it returned an error. Always use put_device() to give up the
> reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs
