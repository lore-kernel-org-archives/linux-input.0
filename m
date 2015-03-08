From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: add support for Semtech SX8654 I2C
 touchscreen controller
Date: Sat, 7 Mar 2015 20:51:15 -0800
Message-ID: <20150308045115.GA4054@dtor-ws>
References: <1425666099-8365-1-git-send-email-sebastien.szymanski@armadeus.com>
 <20150306182155.GB4540@dtor-ws>
 <20150307005717.GD26151@dtor-ws>
 <1425731545.2281.3.camel@tiscali.nl>
 <20150307212543.GA38770@dtor-ws>
 <1425765281.2300.17.camel@x220>
 <64C774DE-93CD-41FB-AF78-301503025592@gmail.com>
 <1425766340.2300.29.camel@x220>
 <FACD03DB-5CFC-4C18-A185-1031903E3AAE@gmail.com>
 <1425767935.2300.48.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425767935.2300.48.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: linux-input@vger.kernel.org

On Sat, Mar 07, 2015 at 11:38:55PM +0100, Paul Bolle wrote:
> On Sat, 2015-03-07 at 14:26 -0800, Dmitry Torokhov wrote:
> > On March 7, 2015 2:12:20 PM PST, Paul Bolle <pebolle@tiscali.nl> wrote:
> > I was talking about them being treated differently from technological
> > standpoint (i.e. the code), not from legal one.
> 
> From a technological standpoint it would be easy to declare "GPL" (or
> any other string) to mean "GPL v2 compatible", which is, I think, all
> that matters. But license_is_gpl_compatible() doesn't do that. And I
> fear that's for a reason. Is my fear unfounded?

Well we might ask Rusty on the off chance that he remembers but my guess
would be that he added "GPL v2" in addition to "GPL" and other license
stings because at the time there was one driver,
drivers/net/tulip/xircom_tulip_cb.c, that used MODULE_LICENSE("GPL v2").

> 
> > If you want to fix up input drivers I'll take such patch, but I am
> > sure more such cases will sneak in unless you also make sure that
> > there are tools (such as checkpatch.pl) that can alert developers to
> >the inconsistency.
> 
> checkpatch.pl crossed my mind too. But in just over a week of checking
> the license comments of (a subset of) the submitted patches I've come to
> think that just won't work.

Thanks.

-- 
Dmitry
