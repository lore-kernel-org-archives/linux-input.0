From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] pwm: Call pwm_enable() before pwm_config()
Date: Thu, 23 Aug 2012 19:19:36 +0200
Message-ID: <50366628.5020007@metafoo.de>
References: <36966374.2768747.1345741025741.JavaMail.root@advansee.com> <50366464.4070801@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50366464.4070801@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?QmVub8OudCBUaMOpYmF1ZGVhdQ==?= <benoit.thebaudeau@advansee.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <bryan.wu@canonical.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 08/23/2012 07:12 PM, Lars-Peter Clausen wrote:
>[...]
> Or maybe just use the runtime pm API for this. This probably makes even more
> sense and grab a reference to the pm context when the enable() is called,
> release it when disable() is called and also grab it before calling the
> device's config callback and release it afterward.

Btw. this seems to be exactly what the pwm-tiecap and pwm-tiehrpwm drivers
already do today. I'd just make that a core PWM framework feature.
