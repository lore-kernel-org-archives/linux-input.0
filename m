From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/1] ARM: dts: Add Peach Pit and Pi dts entry for atmel touchpad
Date: Wed, 6 Aug 2014 22:35:42 -0300
Message-ID: <CAOMZO5CsUKuAcDMzHhy32457ihGqEBTdUijDbwA7QwUqq-ukbQ@mail.gmail.com>
References: <1407373713-26281-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1407373713-26281-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>, Stephen Warren <swarren@nvidia.com>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, linux-input@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Aug 6, 2014 at 10:08 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:

> +&hsi2c_8 {
> +       status = "okay";
> +       clock-frequency = <333000>;

Doesn't it work at the more standard 400kHz i2c frequency?
