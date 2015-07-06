From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v6 0/2] cap11xx: add LED support
Date: Sun, 5 Jul 2015 17:18:29 -0700
Message-ID: <CAKzfze9og8i7EBr=bUL4zxwKW9=6k80k3+dD3a3OknSZDwVxwQ@mail.gmail.com>
References: <1435128654-19454-1-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1435128654-19454-1-git-send-email-mranostay@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-leds@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-input@vger.kernel.org

Was there any more input or changes needed for this patchset?

Thanks,

Matt

On Tue, Jun 23, 2015 at 11:50 PM, Matt Ranostay <mranostay@gmail.com> wrote:
> changes from v5:
> * Dropped linux,led-brightness DT property
> * Removed several ifdefs to LED CLASS
> * Added cap11xx_init_leds stub
>
> Matt Ranostay (2):
>   dt: add cap11xx LED documentation
>   cap11xx: add LED support
>
>  .../devicetree/bindings/input/cap11xx.txt          |  19 +++
>  drivers/input/keyboard/cap11xx.c                   | 140 ++++++++++++++++++++-
>  2 files changed, 156 insertions(+), 3 deletions(-)
>
> --
> 1.9.1
>
