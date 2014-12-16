From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 0/2] Input: atmel_mxt_ts - Add support for T100 multi-touch
Date: Tue, 16 Dec 2014 17:07:32 +0000
Message-ID: <549066D4.7000302@itdev.co.uk>
References: <1418639947-28765-1-git-send-email-javier.martinez@collabora.co.uk> <54905AD7.4070205@itdev.co.uk> <54905F00.4020107@collabora.co.uk> <54906031.8020309@itdev.co.uk> <54906285.3060907@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <54906285.3060907@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 16/12/14 16:49, Javier Martinez Canillas wrote:
> Awesome, what do you think about the change to have a common input device
> initialization function that I squashed in your original patch?
> mxt_initialize_t100_input_device() and mxt_initialize_t9_input_device()
> are very similar so I think that is a sensible refactoring as well.
> 
> If you agree with the change I can post it on top of your patch once it
> lands in mainline.

I had been keeping them separate on the basis that we don't want changes to
support new T100 features to cause regressions in the old T9 handling. But
there is a fair amount of duplication as you say, probably worth addressing.

FWIW I have a queue of stuff that might be considered higher priority, the
next 15-patch set would be up to "add regulator control support":
https://github.com/ndyer/linux/compare/dtor:next...for-dtor

It does cause me some issues to merge upstream refactorings past that lot...
