From: Olof Johansson <olofj@chromium.org>
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - add device id for touchpad variant
Date: Fri, 1 Mar 2013 19:57:34 -0800
Message-ID: <CALiw-2GOed+rEinqOOu2DKN82+hQwiZ1VYfzQGT=3PDma2cSFw@mail.gmail.com>
References: <1362187254-9227-1-git-send-email-bleung@chromium.org>
	<1362187254-9227-2-git-send-email-bleung@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1362187254-9227-2-git-send-email-bleung@chromium.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Benson Leung <bleung@chromium.org>
Cc: miletus@chromium.org, dmitry.torokhov@gmail.com, matthew.garrett@nebula.com, rydberg@euromail.se, djkurtz@chromium.org, jy0922.shim@samsung.com, wfp5p@virginia.edu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

(sorry for duplicate post to some of you, my mail client defaulted to
HTML email for some reason).


2013/3/1 Benson Leung <bleung@chromium.org>
>
> From: Daniel Kurtz <djkurtz@chromium.org>
>
> This same driver can be used by atmel based touchscreens and touchpads
> (buttonpads) by instantiating the i2c device as a "atmel_mxt_tp".
>
> This will cause the driver to perform some touchpad specific
> initializations, such as:
>   * register input device name "Atmel maXTouch Touchpad" instead of
>   Touchscreen.
>   * register BTN_LEFT & BTN_TOOL_* event types.
>   * register axis resolution (as a fixed constant, for now)
>   * register BUTTONPAD property
>   * process GPIO buttons using reportid T19
>
> For now, the left mouse button is mapped to GPIO3. Going forward,
> platform data should specify the configuration of the buttons.
> They can be configured via a future platform data change to
> specify optional middle and right buttons, as well as other possible
> uses for the GPIO object T19.
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Benson Leung <bleung@chromium.org>
>
> Change-Id: Ia82e75d85111c94f6c3fb423181df0fa4b964fc4

Please remember to remove Change-Id on future patch postings.

Tested with native Linux Mint +mainline kernel earlier today, so:

Tested-by: Olof Johansson <olof@lixom.net>
