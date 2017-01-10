From: noman pouigt <variksla@gmail.com>
Subject: Re: gpio_key.c device tree question
Date: Mon, 9 Jan 2017 23:29:11 -0800
Message-ID: <CAES_P+_L-7vLwBDqKy4L_1tNs0N2UTFHh2O+OLFYTE=Ky=zqmA@mail.gmail.com>
References: <CAES_P+_SWsRQZFRJU37FJuXPEcZPgADbcdN8-9EXKGL990XpDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAES_P+_SWsRQZFRJU37FJuXPEcZPgADbcdN8-9EXKGL990XpDQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Jan 8, 2017 at 7:42 PM, noman pouigt <variksla@gmail.com> wrote:
> Hello,
>
> I am trying to see how to disable the sub device nodes in
> gpio_keys device node.
>
> I have this in my base dtsi file:
>
> #include "vendor_file.dtsi"
>
>         gpio_keys {
>                 compatible = "gpio-keys";
>                 input-name = "gpio-keys";
>                 pinctrl-names = "gpio_key_active","gpio_key_suspend";
>                 pinctrl-0 = <&key_active>;
>                 pinctrl-1 = <&key_suspend>;
>                 camera_snapshot {
>                         label = "camera_snapshot";
>                         //snip
>                 };
>         };
>
> I have this in vendor_file.dtsi:
>        gpio_keys {
>                source_key_1 {
>                        label = "source_key_1";
>                        //snip
>                };
>        };
>
> In my current consolidated dtb file all nodes are getting
> added i.e. camera_snapshot and source_key_1. How
> can i remove camera_snapshot node from the
> gpio_keys device node or disable it?

This issue is fixed with below commit:

commit 809d9516da73345cca587743b57e45e9095d851e
Author: Laxman Dewangan <ldewangan@nvidia.com>
Date:   Wed Jan 13 00:14:19 2016 -0800

    Input: gpio-keys - allow disabling individual buttons in DT

    Add support to disable buttons from DT via status property if given button
    is not supported on given platforms. This will help re-using existing dtsi
    files across multiple platforms.

    Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
    Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
>
> Thanks,
