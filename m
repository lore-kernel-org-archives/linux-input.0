From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: Remove check before calling pm_wakeup_event.
Date: Fri, 3 Aug 2018 09:07:59 -0700
Message-ID: <CAKdAkRQG08d_duPiKFi_=xUNO93c0Rcw9kpaYFFJahjJM-NdGw@mail.gmail.com>
References: <CGME20180803072628eucas1p26abe0cb121b974401759502f8807bb96@eucas1p2.samsung.com>
 <20180605224458.62692-1-ravisadineni@chromium.org> <20180803072628eucas1p26abe0cb121b974401759502f8807bb96~HTx4BGQjl1119311193eucas1p2U@eucas1p2.samsung.com>
 <CAEZbON7qLheHFuU6zwArCz=CG03JvnFjcehBGjE4RqROYrMLhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEZbON7qLheHFuU6zwArCz=CG03JvnFjcehBGjE4RqROYrMLhQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Ravi Chandra Sadineni <ravisadineni@google.com>, Dmitry Torokhov <dtor@google.com>, Todd Broch <tbroch@google.com>, lkml <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 3, 2018 at 8:51 AM Ravi Chandra Sadineni
<ravisadineni@chromium.org> wrote:
>
> Hi Marek,
>
> Can you please give me little more context ? Snow is still on 3.8.11. This patch is not backported to 3.8.11. Are you trying to flash a different kernel  on snow?
>

Ravi, from upstream perspective what kernel Google uses when shipping
Snow is completely immaterial. Mainline is supposed to work equally
well on all devices.

Thanks.

-- 
Dmitry
