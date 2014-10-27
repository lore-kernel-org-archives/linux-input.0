From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] Input: pmic8xxx-keypad - use regmap_field for register access
Date: Mon, 27 Oct 2014 09:26:21 -0700
Message-ID: <3130587.MP3Z1uHjdW@dtor-glaptop>
References: <20141007172606.GG16469@dtor-ws> <20141027160641.GB7594@dtor-ws> <1414426831.20978.4.camel@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414426831.20978.4.camel@mm-sol.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Bjorn Andersson <bjorn.andersson@sonymobile.com>
List-Id: linux-input@vger.kernel.org

On Monday, October 27, 2014 06:20:31 PM Ivan T. Ivanov wrote:
> On Mon, 2014-10-27 at 09:06 -0700, Dmitry Torokhov wrote:
> > On Mon, Oct 27, 2014 at 05:30:41PM +0200, Ivan T. Ivanov wrote:
> > > Hi Dmitry,
> > > 
> > > On Mon, 2014-10-13 at 16:02 +0200, Mark Brown wrote:
> > > > On Wed, Oct 08, 2014 at 01:32:33PM -0700, Dmitry Torokhov wrote:
> > > > > On Wed, Oct 08, 2014 at 09:04:26PM +0100, Mark Brown wrote:
> > > > > > On Wed, Oct 08, 2014 at 11:20:58AM -0700, Stephen Boyd wrote:
> > > > > > > Srini/Mark, any reason why the regmap_field structure is opaque?
> > > > > > 
> > > > > > So you can't peer into it and rely on the contents.  I can see it
> > > > > > being
> > > > > > useful to add a bulk allocator.
> > > > > 
> > > > > And then one have to define offsets in an array and use awkward
> > > > > syntax
> > > > > to access individual fields. Can we just reply on
> > > > > reviews/documentation
> > > > > for users to not do wrong thing?
> > > > 
> > > > I have very little confidence in users not doing awful things to be
> > > > honest, this is the sort of API where the users are just random things
> > > > all over the kernel so this sort of thing tends to be found after the
> > > > fact.  I get a lot of these in drivers that just got thrown over the
> > > > wall so nobody really knows what things are doing when you do find
> > > > them.
> > > > 
> > > > If the standard allocators aren't doing a good job (I've not checked)
> > > > I'd much rather handle this inside the API if we can.
> > > 
> > > Is there something that I can help here or patches are good as they are?
> > > :-)> 
> > Well, as far as I can see Bjorn (in the other thread) has some
> > objections on merging these devices together, so I ma just waiting for
> > you settle this issue.
> 
> In the other thread we are discussing "pm8xxx-pwrkey" driver not this
> "pm8xxx-keypad" driver. Unless I not missing something?

Ah, sorry, I guess my parsing stops right after pm8xxx... Let me take another
look.

Thanks.

-- 
Dmitry
