From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: pmic8xxx-pwrkey - Set sane default for debounce
 time
Date: Wed, 14 May 2014 12:02:10 -0700
Message-ID: <20140514190210.GJ30089@core.coreip.homeip.net>
References: <1396289664-31893-1-git-send-email-sboyd@codeaurora.org>
 <20140331182315.GA9198@core.coreip.homeip.net>
 <5339B407.1050308@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5339B407.1050308@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Mar 31, 2014 at 11:29:27AM -0700, Stephen Boyd wrote:
> On 03/31/14 11:23, Dmitry Torokhov wrote:
> > On Mon, Mar 31, 2014 at 11:14:24AM -0700, Stephen Boyd wrote:
> >> If the debounce time is 0 our usage of ilog2() later on in this
> >> driver will cause undefined behavior. If CONFIG_OF=n this fact is
> >> evident to the compiler, and it emits a call to ____ilog2_NaN()
> >> which doesn't exist. Fix this by setting a sane default for
> >> debounce.
> >>
> >> Reported-by: Arnd Bergmann <arnd@arndb.de>
> >> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> >> ---
> >>  drivers/input/misc/pmic8xxx-pwrkey.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
> >> index 1cb8fda7a166..27add04676e1 100644
> >> --- a/drivers/input/misc/pmic8xxx-pwrkey.c
> >> +++ b/drivers/input/misc/pmic8xxx-pwrkey.c
> >> @@ -92,7 +92,7 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
> >>  	bool pull_up;
> >>  
> >>  	if (of_property_read_u32(pdev->dev.of_node, "debounce", &kpd_delay))
> >> -		kpd_delay = 0;
> >> +		kpd_delay = 15625;
> > What if somebody supplied 0 via DT? Can we check and return -EINVAL?
> 
> Sure. Here's a v2.
> 
> -----8<------
> From: Stephen Boyd <sboyd@codeaurora.org>
> Subject: [PATCH v2] Input: pmic8xxx-pwrkey - Set sane default for debounce
>  time
> 
> If the debounce time is 0 our usage of ilog2() later on in this
> driver will cause undefined behavior. If CONFIG_OF=n this fact is
> evident to the compiler, and it emits a call to ____ilog2_NaN()
> which doesn't exist. Fix this by setting a sane default for
> debounce and failing to probe if debounce is 0 in the DT.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Applied, thank you. Sorry for the delay.

-- 
Dmitry
