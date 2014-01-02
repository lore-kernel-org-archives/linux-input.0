From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/7] Input: pmic8xxx-pwrkey - Migrate to regmap APIs
Date: Thu, 2 Jan 2014 11:17:57 -0800
Message-ID: <20140102191757.GA2025@core.coreip.homeip.net>
References: <1386718996-3733-1-git-send-email-sboyd@codeaurora.org>
 <1386718996-3733-3-git-send-email-sboyd@codeaurora.org>
 <20131215113337.GB14818@core.coreip.homeip.net>
 <20140102184959.GI31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140102184959.GI31886@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jan 02, 2014 at 06:49:59PM +0000, Mark Brown wrote:
> On Sun, Dec 15, 2013 at 03:33:37AM -0800, Dmitry Torokhov wrote:
> > On Tue, Dec 10, 2013 at 03:43:11PM -0800, Stephen Boyd wrote:
> 
> > > +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> > > +	if (!regmap)
> > > +		return -ENODEV;
> 
> > And you are leaking memory here...
> 
> He's not, dev_get_regmap() just gets a pointer to an existing regmap -
> no reference is taken and nothing is allocated.  It's a helper that's
> mainly there so that generic code can be written without needing the
> regmap to be passed around.  The caller is responsible for ensuring that
> it will stick around for as long as it's used (generally by having it
> lifetime managed with the device).

I was not talking about data returned by dev_get_regmap() but all other
memory that was allocated before as this was pre devm conversion of the
driver.

Thanks.

-- 
Dmitry
