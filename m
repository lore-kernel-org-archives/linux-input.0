From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: hid-ntrig: add error handling for
 sysfs_create_group
Date: Mon, 25 Jun 2018 15:16:44 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1806251516350.6203@cbobk.fhfr.pm>
References: <1528707296-35785-1-git-send-email-jiazhouyang09@gmail.com> <1528983437-52903-1-git-send-email-jiazhouyang09@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528983437-52903-1-git-send-email-jiazhouyang09@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 14 Jun 2018, Zhouyang Jia wrote:

> When sysfs_create_group fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling sysfs_create_group.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
> v1->v2:
> - Remove goto statement.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
