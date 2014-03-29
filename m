From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 07/10] ARM: sunxi: dt: Add
 x-powers-axp209.dtsi file
Date: Sat, 29 Mar 2014 17:14:17 +0100
Message-ID: <20140329161417.GC3952@localhost.fastwebnet.it>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-8-git-send-email-carlo@caione.org>
 <20140328133438.GA19846@sirena.org.uk>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDWJTUUC5UCBB3PB3OMQKGQEKRU3ITA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140328133438.GA19846-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Mar 28, 2014 at 01:34:38PM +0000, Mark Brown wrote:
> On Thu, Mar 27, 2014 at 10:29:21PM +0100, Carlo Caione wrote:
> > This dtsi describes the axp209 PMIC, and is to be included from inside
> > the i2c controller node to which the axp209 is connected.
> 
> >  arch/arm/boot/dts/x-powers-axp209.dtsi | 54 ++++++++++++++++++++++++++++++++++
> 
> Something is wrong here.  Either the changelog is inaccurate or this is
> broken, either way this should be cleaned up because this looks like
> very bad practice.  If this is a common include file for boards derived
> from some reference design then the changelog is misleading and the DT
> should be clearer about the board tie ins.  Otherwise the .dtsi is
> defining what should be board specific parameters.
> 
> The fact that the DT names everything after the regulator on the PMIC
> and not after the supply names on the board is especially suspicious and
> glancing at a couple of the regulators it looks like the constraints
> here are the maximum ranges the PMIC supports rather than anything to do
> with any board.
> 
> Please take a step back and think about what the regulator constraints
> are intended to do - they're about matching the regulator capabilities
> to the board since it is rare for boards to be able to do everything the
> regulator can support.  Duplicating the basic device capabilities into
> the DT would be a pointless waste of time.
> 
> > +	axp_dcdc2: dcdc2 {
> > +		regulator-min-microvolt = <700000>;
> > +		regulator-max-microvolt = <2275000>;
> > +		regulator-always-on;
> > +	};
> 
> What is this configuration actually for - what guarantee do we have that
> the above is safe for a given board using this regulator?  
> 
> In general I'd expect to see anything specifying variability for a
> regulator to also include the relevant consumer node.

Ok, you are completely right. These values in the DTSI are wrongly the
maximum and minimum ranges for the PMIC. Even worst I didn't specify the
board specific parameters for the regulators.

Thank you for reviewing and noticing it,

-- 
Carlo Caione
