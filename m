From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 08/33] Input: spear-keyboard - Drop unnecessary error
 messages and other changes
Date: Thu, 19 Jan 2017 09:26:32 +0530
Message-ID: <CAOh2x==4NruDhFQrmrTL7Hx6WGFLAzdVaU=-UuZ0SFQEmVBhXg@mail.gmail.com>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net> <1484761614-12225-9-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-9-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-input@vger.kernel.org

On Wed, Jan 18, 2017 at 11:16 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Error messages after memory allocation failures are unnecessary and
> can be dropped.
>
> This conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>
> - Drop unnecessary braces around conditional return statements
> - Drop error message after devm_kzalloc() failure
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/input/keyboard/spear-keyboard.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
