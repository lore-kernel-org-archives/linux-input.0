From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: serio - add writing multiple bytes at once
Date: Mon, 30 Apr 2018 14:20:07 -0700
Message-ID: <20180430212007.GC54182@dtor-ws>
References: <20180430090324.30845-1-david.engraf@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180430090324.30845-1-david.engraf@sysgo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Engraf <david.engraf@sysgo.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi David,

On Mon, Apr 30, 2018 at 11:03:24AM +0200, David Engraf wrote:
> The current version only supports forwarding a single byte to the tty
> layer.
> 
> This patch adds serio_write_length() to allow a serport driver writing
> multiple bytes at once. The patch also includes a fallback to
> serio_write_length() when a driver did not register a single byte function.

Without users I do not see point for this API.

Thanks.

-- 
Dmitry
