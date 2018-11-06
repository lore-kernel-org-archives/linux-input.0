From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: asus: fix build warning wiht CONFIG_ASUS_WMI
 disabled
Date: Tue, 6 Nov 2018 13:58:03 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1811061357520.21975@cbobk.fhfr.pm>
References: <20181102151443.758229-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181102151443.758229-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Colin Ian King <colin.king@canonical.com>, Peter Hutterer <peter.hutterer@who-t.net>, Mustafa Kuscu <mustafakuscu@gmail.com>, Daniel Drake <drake@endlessm.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 2 Nov 2018, Arnd Bergmann wrote:

> asus_wmi_evaluate_method() is an empty dummy function when CONFIG_ASUS_WMI
> is disabled, or not reachable from a built-in device driver. This leads to
> a theoretical evaluation of an uninitialized variable that the compiler
> complains about, failing to check that the hardcoded return value makes
> this an unreachable code path:
> 
> In file included from include/linux/printk.h:336,
>                  from include/linux/kernel.h:14,
>                  from include/linux/list.h:9,
>                  from include/linux/dmi.h:5,
>                  from drivers/hid/hid-asus.c:29:
> drivers/hid/hid-asus.c: In function 'asus_input_configured':
> include/linux/dynamic_debug.h:135:3: error: 'value' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    __dynamic_dev_dbg(&descriptor, dev, fmt, \
>    ^~~~~~~~~~~~~~~~~
> drivers/hid/hid-asus.c:359:6: note: 'value' was declared here
>   u32 value;
>       ^~~~~
> 
> With an extra IS_ENABLED() check, the warning goes away.
> 
> Fixes: 3b692c55e58d ("HID: asus: only support backlight when it's not driven by WMI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to for-4.20/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
