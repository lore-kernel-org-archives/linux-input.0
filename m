From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH v3] Input: gpio_keys - add dt abs/rel button support
Date: Wed, 15 Feb 2017 17:35:58 -0600
Message-ID: <20170215233558.eu7wa7zobycelhaj@rob-hp-laptop>
References: <20170209134128.GA3629@Gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170209134128.GA3629@Gaia>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Holmberg <hans@pixelmunchies.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Feb 09, 2017 at 02:41:31PM +0100, Hans Holmberg wrote:
> This change adds support for specifying device tree buttons emitting
> abs/rel events.
> 
> ABS events were previously supported, but only via platform data, so add
> the missing device tree attribute to allow axis values to be emitted with
> abs/rel events.
> 
> Also emit 0 on button releases for REL and ABS keys when all buttons of
> the same type and axis are released. This is a must-have for supporting
> digital joysticks.
> 
> Finally, report min/max values for abs axes to the input framework.
> 
> Signed-off-by: Hans Holmberg <hans@pixelmunchies.com>
> ---
> Thanks for your comments, Rob, Dimitry.
> 
> Changes since v2:
> * 0 is now only reported when no buttons on an axis is pressed. If several
>   buttons on the same axis are pressed simultaneously, the value reported
>   depends on the order the buttons are specified.
> * joystick example removed from the dt binding doc
> * rebased on top of next
> 
> Changes since v1:
> * Corrected cc list - now the mailing lists are looped in.
> 
> 
> I've updated the patch to report 0 only when there are no buttons
> pressed on the same axis and removed the joystick dt binding example.
> 
> If there are more than one pressed button on a given axis, only one
> value is reported, and that value is set depending on which order
> the buttons have been specified in the device tree. My idea here is 
> that the priority order is left to the dts-writer.
> 
> Note that gpio_keys_polled reports all pressed-button values on an axis
> but this makes less sense to me, (what value is the user supposed to use?)
> 
> It would be nice to have the two drivers behave the same. Let me know
> what you think.
> 
> gpio_keys_polled test: (as a reference)
> 
> Buttons defined(in this order)
> Button A value = 1
> Button B value = 2
> 
> Evtest:
> 
> [A down, B up]
> Event: time 1486029549.621182, type 3 (EV_ABS), code 0 (ABS_X), value 1
> Event: time 1486029549.621182, -------------- EV_SYN ------------
> 
> [A down, B down] 
> Event: time 1486029558.201182, type 3 (EV_ABS), code 0 (ABS_X), value 2
> Event: time 1486029558.201182, type 3 (EV_ABS), code 0 (ABS_X), value 1
> Event: time 1486029558.201182, -------------- EV_SYN ------------
> Event: time 1486029558.311190, type 3 (EV_ABS), code 0 (ABS_X), value 2
> Event: time 1486029558.311190, type 3 (EV_ABS), code 0 (ABS_X), value 1
> ...
> 
> (this keeps on repeating)
> 
> [A down, B up]
> <no events>
> 
> [A up, B up]
> Event: time 1486029561.391175, type 3 (EV_ABS), code 0 (ABS_X), value 0
> Event: time 1486029561.391175, -------------- EV_SYN ------------
> 
> 
> Thanks, Hans
> 
>  .../devicetree/bindings/input/gpio-keys.txt        |  7 +++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/keyboard/gpio_keys.c                 | 55 +++++++++++++++++++---
>  2 files changed, 55 insertions(+), 7 deletions(-)
