From: Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: Re: [PATCH v2 4/8] drivers: input: use module_platform_driver_probe()
Date: Thu, 14 Mar 2013 18:51:58 +0100
Message-ID: <CAHkwnC-vOPxqWq3jF=sbDrhvyWhNYvV5rAd69K8b5iH3KyqyPQ@mail.gmail.com>
References: <1363280978-24051-1-git-send-email-fabio.porcedda@gmail.com>
 <1363280978-24051-5-git-send-email-fabio.porcedda@gmail.com> <3681471.ufqahH3gTF@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3681471.ufqahH3gTF@dtor-d630.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media <linux-media@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Bill Pemberton <wfp5p@virginia.edu>, Linus Walleij <linus.walleij@linaro.org>, David Howells <dhowells@redhat.com>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 14, 2013 at 6:30 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Fabio,
>
> On Thursday, March 14, 2013 06:09:34 PM Fabio Porcedda wrote:
>> This patch converts the drivers to use the
>> module_platform_driver_probe() macro which makes the code smaller and
>> a bit simpler.
>
> I already have patches from Sachin Kamat for this, I am waiting for -rc3
> to sync up with mainline and pick up the macro before applying them.

Thank for reviewing.

I've sent a updated patch without the patch already sent by Sachin Kamat.

Best regards
Fabio Porcedda

> Thanks.
>
> --
> Dmitry
