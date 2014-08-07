From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] ARM: dts: Add Peach Pit and Pi dts entry for atmel
 touchpad
Date: Thu, 07 Aug 2014 03:49:24 +0200
Message-ID: <53E2DB24.7050305@collabora.co.uk>
References: <1407373713-26281-1-git-send-email-javier.martinez@collabora.co.uk> <CAOMZO5CsUKuAcDMzHhy32457ihGqEBTdUijDbwA7QwUqq-ukbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5CsUKuAcDMzHhy32457ihGqEBTdUijDbwA7QwUqq-ukbQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>, Stephen Warren <swarren@nvidia.com>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, linux-input@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hello Fabio,

On 08/07/2014 03:35 AM, Fabio Estevam wrote:
> On Wed, Aug 6, 2014 at 10:08 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
> 
>> +&hsi2c_8 {
>> +       status = "okay";
>> +       clock-frequency = <333000>;
> 
> Doesn't it work at the more standard 400kHz i2c frequency?
> 

Most bits of this DTS snippet have been taken from the downstream Chrome OS 3.8
kernel so I'll let one of the Chromium folks to answer this question.

Best regards,
Javier
