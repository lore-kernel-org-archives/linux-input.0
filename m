From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: Remove check before calling
 pm_wakeup_event.
Date: Mon, 6 Aug 2018 07:29:48 +0200
Message-ID: <20180806052949eucas1p2483800c02730febd03d4a661a25fa405~INH40XvCx2719627196eucas1p2X@eucas1p2.samsung.com>
References: <CGME20180803072628eucas1p26abe0cb121b974401759502f8807bb96@eucas1p2.samsung.com>
        <20180605224458.62692-1-ravisadineni@chromium.org>
        <20180803072628eucas1p26abe0cb121b974401759502f8807bb96~HTx4BGQjl1119311193eucas1p2U@eucas1p2.samsung.com>
        <CAEZbON7qLheHFuU6zwArCz=CG03JvnFjcehBGjE4RqROYrMLhQ@mail.gmail.com>
        <CAKdAkRQG08d_duPiKFi_=xUNO93c0Rcw9kpaYFFJahjJM-NdGw@mail.gmail.com>
        <CAEZbON4O0X8Fo6eAbmPOSiB1_Tw7x+Ox3ROoGfZQn72uQGQLkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEZbON4O0X8Fo6eAbmPOSiB1_Tw7x+Ox3ROoGfZQn72uQGQLkg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ravi Chandra Sadineni <ravisadineni@google.com>, Dmitry Torokhov <dtor@google.com>, Todd Broch <tbroch@google.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Ravi,

On 2018-08-03 18:53, Ravi Chandra Sadineni wrote:
> Understood. I am trying to reproduce this issue locally. Wanted to 
> know the version of the kernel so I can give a try. Marek, can you 
> please confirm the kernel version.
>

Yes, sorry for the missing context, I was in hurry writing the report and
I wanted to send it before leaving the office. I'm testing mainline on Snow
with exynos_defconfig.

Suspend/resume is partially broken already with mainline, but if you disable
CPUfreq support, it works fine on Linux v4.17.

I've posted CPUfreq related fixes here if you are interested:
https://patchwork.kernel.org/patch/10554607/
https://patchwork.kernel.org/patch/10554603/

The issue with cros_ec_keyb patch appears first on Linux v4.18-rc1, which is
the first release with that patch. Linux -next from 20180803, which has 
a few
more patches for cros_ec_keyb suffers from the same issue.


>
> On Fri, Aug 3, 2018 at 9:08 AM Dmitry Torokhov 
> <dmitry.torokhov@gmail.com <mailto:dmitry.torokhov@gmail.com>> wrote:
>
>     On Fri, Aug 3, 2018 at 8:51 AM Ravi Chandra Sadineni
>     <ravisadineni@chromium.org <mailto:ravisadineni@chromium.org>> wrote:
>     >
>     > Hi Marek,
>     >
>     > Can you please give me little more context ? Snow is still on
>     3.8.11. This patch is not backported to 3.8.11. Are you trying to
>     flash a different kernel  on snow?
>     >
>
>     Ravi, from upstream perspective what kernel Google uses when shipping
>     Snow is completely immaterial. Mainline is supposed to work equally
>     well on all devices.
>
>     Thanks.
>
>     -- 
>     Dmitry
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
