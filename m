From: Feng Kan <fkan@apm.com>
Subject: Re: [PATCH v0] gpio_keys: fix gpio key driver to proper support GIC interrupt
Date: Thu, 4 Jun 2015 20:37:50 -0700
Message-ID: <CAL85gmC2oHVKzgfNFXRzSzigQu++OJv-TpwzeN5fC-5s3U0U-Q@mail.gmail.com>
References: <1433402712-21399-1-git-send-email-yvo@apm.com>
	<20150604172324.GA9074@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150604172324.GA9074@dtor-ws>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Y Vo <yvo@apm.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Phong Vo <pvo@apm.com>, Toan Le <toanle@apm.com>, Loc Ho <lho@apm.com>, patches <patches@apm.com>
List-Id: linux-input@vger.kernel.org

On Thu, Jun 4, 2015 at 10:23 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Y,
> On Thu, Jun 04, 2015 at 02:25:12PM +0700, Y Vo wrote:
>> GIC is designed to support two of trigger mechanisms - active level
>> high or edge rising. But in the gpio_keys driver, it tries to use both
>> edge rising and edge falling trigger. This patch fixes the gpio_keys
>> driver to request only the edge rising event when failed to configure the
>> interrupt.
>
> How do we get notified of button release if we only get interrupt on
> rising edge?

On the arm gic, only the rising edge is supported. So key press can
only be defined
as rising edge and no key release.
>
> Thanks.
>
> --
> Dmitry
