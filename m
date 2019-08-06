From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/2] HID: hiddev: avoid opening a disconnected device
Date: Tue, 6 Aug 2019 09:57:10 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1908060956460.27147@cbobk.fhfr.pm>
References: <20190806035820.10492-1-hdanton@sina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806035820.10492-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hillf Danton <hdanton@sina.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>
List-Id: linux-input@vger.kernel.org

On Tue, 6 Aug 2019, Hillf Danton wrote:

> In order to avoid opening a disconnected device, we need to check exist
> again after acquiring the existance lock, and bail out if necessary.
> 
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Hillf Danton <hdanton@sina.com>

Could you please add proper Reported-by: reference to syzbot? (in 2/2 as 
well).

Thanks,

-- 
Jiri Kosina
SUSE Labs
