From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] drivers/hid: Check result of debugfs_create_dir()
 and debugfs_create_file()
Date: Fri, 4 Sep 2015 15:17:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509041516180.30132@pobox.suse.cz>
References: <1440092137-9228-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440092137-9228-1-git-send-email-kuleshovmail@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 20 Aug 2015, Alexander Kuleshov wrote:

> The debugfs_create_dir() and debugfs_create_file() functions may return -errno
> if an error occurs. This patch adds a couple of checks of the result of the
> debufs_create_dir() and debugfs_create_file() functions execution in the
> hid_debug_register() and othre places.
> 
> Changelog:
> 
> v3:
> 
>   * do not check hid_debug before the call of the hid_debug_init()
> and hid_debug_exit() from v2
> 
> v2:
> 
>   * add check for the result of the debugfs_create_file() calls
>   * call hid_debug_init() and hid_debug_exit() only if hid_debug
>   * add check for the hid_debug_root in the hid_debug_register()
> 
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>

Did you try to even compile-test your patch?

-- 
Jiri Kosina
SUSE Labs
