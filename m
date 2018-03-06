From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-ntrig: use true and false for boolean values
Date: Tue, 6 Mar 2018 15:20:15 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1803061519430.15778@cbobk.fhfr.pm>
References: <20180306000624.GA2680@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180306000624.GA2680@embeddedgus>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-input@vger.kernel.org

On Mon, 5 Mar 2018, Gustavo A. R. Silva wrote:

> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

I've commited this (and the hid-multitouch variant of it as well) to 
for-4.17/upstream.

-- 
Jiri Kosina
SUSE Labs
