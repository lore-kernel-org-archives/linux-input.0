From: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v3 0/4] input: touchscreen: Add goodix GT5553 CTP support
Date: Sun, 6 Jan 2019 22:08:14 +0530
Message-ID: <CAMty3ZBcXOm5VOU5WqrhdfgH=i6x4rUP4zbTsiv9BjoccJUzwg@mail.gmail.com>
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181215151802.18592-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Michael Trimarchi <michael@amarulasolutions.com>, linux-amarula@amarulasolutions.com
List-Id: linux-input@vger.kernel.org

On Sat, Dec 15, 2018 at 8:48 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> This patchset support goodix GT5553 CTP.
>
> Changes for v3:
> - add cover-letter
> - s/ADVV28/AVDD28 on commit head
> - fix few typo
> Changes for v2:
> - Rename vcc-supply with AVDD28-supply
> - disable regulator in remove
> - fix to setup regulator in probe code
> - add chipdata
> - drop example node in dt-bindings

Any comments?
