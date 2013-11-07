From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: replace IS_ERR and PTR_ERR with PTR_ERR_OR_ZERO
Date: Thu, 07 Nov 2013 08:29:50 -0700
Message-ID: <527BB1EE.9070405@kernel.dk>
References: <1383724599-15754-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383724599-15754-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Duan Jiong <duanj.fnst@cn.fujitsu.com>, kernel@pengutronix.de, linux@arm.linux.org.uk, a.zummo@towertech.it, airlied@linux.ie, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, linux-input@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-input@vger.kernel.org

On 11/06/2013 12:56 AM, Duan Jiong wrote:
> This patch fixes coccinelle error regarding usage of IS_ERR and
> PTR_ERR instead of PTR_ERR_OR_ZERO.

Applied, thanks.

-- 
Jens Axboe
