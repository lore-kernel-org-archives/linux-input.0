From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hiddev: fix potential Spectre v1
Date: Mon, 9 Jul 2018 14:31:40 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1807091431310.997@cbobk.fhfr.pm>
References: <20180629220844.GA13823@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180629220844.GA13823@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 29 Jun 2018, Gustavo A. R. Silva wrote:

> uref->field_index, uref->usage_index, finfo.field_index and
> cinfo.index can be indirectly controlled by user-space, hence
> leading to a potential exploitation of the Spectre variant 1
> vulnerability.
> 
> This issue was detected with the help of Smatch:

Applied, thanks Gustavo.

-- 
Jiri Kosina
SUSE Labs
