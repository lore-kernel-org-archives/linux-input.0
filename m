From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 4/8] drivers: input: use module_platform_driver_probe()
Date: Thu, 14 Mar 2013 10:30:18 -0700 (PDT)
Message-ID: <3681471.ufqahH3gTF@dtor-d630.eng.vmware.com>
References: <1363280978-24051-1-git-send-email-fabio.porcedda@gmail.com>
 <1363280978-24051-5-git-send-email-fabio.porcedda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1363280978-24051-5-git-send-email-fabio.porcedda@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Porcedda <fabio.porcedda@gmail.com>, Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-fbdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-ide@vger.kernel.org, Bill Pemberton <wfp5p@virginia.edu>, linux-input@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Fabio,

On Thursday, March 14, 2013 06:09:34 PM Fabio Porcedda wrote:
> This patch converts the drivers to use the
> module_platform_driver_probe() macro which makes the code smaller and
> a bit simpler.

I already have patches from Sachin Kamat for this, I am waiting for -rc3
to sync up with mainline and pick up the macro before applying them.

Thanks.

-- 
Dmitry
