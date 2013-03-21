From: Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: Re: [PATCH v2 3/8] drivers: char: use module_platform_driver_probe()
Date: Thu, 21 Mar 2013 11:15:26 +0100
Message-ID: <CAHkwnC_AJpeVw2o8oJn+zMvSg1Lbmm1aXRYxCmtDYhkJG9nvig@mail.gmail.com>
References: <1363280978-24051-1-git-send-email-fabio.porcedda@gmail.com>
 <1363280978-24051-4-git-send-email-fabio.porcedda@gmail.com> <20130321095542.GH26931@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20130321095542.GH26931@gondor.apana.org.au>
Sender: linux-media-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-media <linux-media@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matt Mackall <mpm@selenic.com>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 21, 2013 at 10:55 AM, Herbert Xu
<herbert@gondor.apana.org.au> wrote:
> On Thu, Mar 14, 2013 at 06:09:33PM +0100, Fabio Porcedda wrote:
>> This patch converts the drivers to use the
>> module_platform_driver_probe() macro which makes the code smaller and
>> a bit simpler.
>>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Matt Mackall <mpm@selenic.com>
>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>> Cc: Fabio Estevam <fabio.estevam@freescale.com>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>
> Patch applied.

The patch is already in
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git.
Are you speaking about that?

Best regards
--
Fabio Porcedda
