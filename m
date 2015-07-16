From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: snvs_pwrkey: add linux prefix for wakeup property
Date: Thu, 16 Jul 2015 11:34:08 -0700
Message-ID: <20150716183408.GD32571@dtor-ws>
References: <1436930409-6536-1-git-send-email-shawnguo@kernel.org>
 <CAHrpEqS2o6_B6dNrnWJ06ASWaB0SGxur1o3VuN2A-QywWhbWVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAHrpEqS2o6_B6dNrnWJ06ASWaB0SGxur1o3VuN2A-QywWhbWVA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhi Li <lznuaa@gmail.com>
Cc: Frank Li <Frank.Li@freescale.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 15, 2015 at 09:00:12AM -0500, Zhi Li wrote:
> On Tue, Jul 14, 2015 at 10:20 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> > The wakeup capability is somehow linux specific, and all existing
> > bindings name the property "linux,wakeup" to reflect that, e.g.
> > Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt.  Let's
> > follow the convention.

I do not believe it is Linux specific, it describes desired behavior of
hardware regardless of OS. I mean you want your device to wake up if you
press power button whether it runes Linux, Windows, FreeBSD or whatever.

> >
> > Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> > ---
> > This is a fixup for Frank's patch which is queued on i.MX tree, so I
> > will apply it to the same branch.
> >
> > Shawn
> >
> >  Documentation/devicetree/bindings/crypto/fsl-sec4.txt | 2 +-
> >  drivers/input/keyboard/snvs_pwrkey.c                  | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > index 71a39c5bd486..fa821c6a0b5b 100644
> > --- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > @@ -408,7 +408,7 @@ System ON/OFF key driver
> >        Value type: <int>
> >        Definition: Keycode to emit, KEY_POWER by default.
> >
> > -  - wakeup:
> > +  - linux,wakeup:
> 
> I remember Dmitry Torokhov said use wakeup, instead of linux, wakeup
> when I sent patch to review.

I should have said to use "wakeup-source", not simply "wakeup" so that
we'd match with I2C annotation.

I think I'll go over input driver and convert them (keeping old names
for compatibility reasons).

Thanks.

-- 
Dmitry
