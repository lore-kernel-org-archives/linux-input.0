From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 1/2] Input: add support for Semtech SX8654 I2C
 touchscreen controller
Date: Sat, 07 Mar 2015 23:12:20 +0100
Message-ID: <1425766340.2300.29.camel@x220>
References: <1425666099-8365-1-git-send-email-sebastien.szymanski@armadeus.com>
	 <20150306182155.GB4540@dtor-ws> <20150307005717.GD26151@dtor-ws>
	 <1425731545.2281.3.camel@tiscali.nl> <20150307212543.GA38770@dtor-ws>
	 <1425765281.2300.17.camel@x220>
	 <64C774DE-93CD-41FB-AF78-301503025592@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <64C774DE-93CD-41FB-AF78-301503025592@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?ISO-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, Kumar Gala <galak@codeaurora.org>
List-Id: linux-input@vger.kernel.org

On Sat, 2015-03-07 at 14:02 -0800, Dmitry Torokhov wrote:
> On March 7, 2015 1:54:41 PM PST, Paul Bolle <pebolle@tiscali.nl> wrote:
> >By that logic we might as well simplify the logic of
> >license_is_gpl_compatible() and MODULE_LICENSE() quite a bit. Why check
> >for six variants instead of just one and be done with it?
> 
> Because nobody wants to go through  hundreds of drivers and change them?

Not fun, but surely doable.

> >Anyhow, "GPL" and "GPL v2" are both allowed but not identical. So,
> >unless a patch is applied to treat them interchangeably, somehow, in
> >the module license checking code, 
> 
> They are treated interchangeably as far as I can see. Where do you see
> "GPL" is being treated differently than "GPL v2".

I'm not going to explain here why "GPL v2" or "GPL v2 or later" differ.

"GPL" is documented to mean "GPL v2 or later". "GPL v2" is documented to
mean just that (see include/linux/module.h). Again, you're free to
submit a patch to somehow simplify that. But unless a patch like that is
applied, we should make sure MODULE_LICENSE() matches the actual license
of the module involved.


Paul Bolle
