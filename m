From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/5] drivers/rtc/rtc-pl030.c: Convert to
	use devm_*()
Date: Wed, 29 Mar 2017 03:45:57 +0200
Message-ID: <CACRpkdYHJinMhgUQLe3vf6P8hj3o_3ASi8pT+dtM5JtrE5ccJg@mail.gmail.com>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
 <1490539314-9681-3-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1490539314-9681-3-git-send-email-leo.yan@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, kvm@vger.kernel.org, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@armlinux.org.uk>, Alex Williamson <alex.williamson@redhat.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Linux Input <linux-input@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

On Sun, Mar 26, 2017 at 4:41 PM, Leo Yan <leo.yan@linaro.org> wrote:

> Convert driver to use devm_*() APIs so rely on driver model core layer
> to manage resources. This eliminates error path boilerplate and makes
> code neat.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
