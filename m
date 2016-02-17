From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: RE: [PATCH v2 1/3] input: cygnus-update touchscreen dt node document
Date: Wed, 17 Feb 2016 15:23:49 +0530
Message-ID: <b2adbdb45d34485fbe8a29f580ab0c61@mail.gmail.com>
References: <1455702226-20599-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1455702226-20599-2-git-send-email-raveendra.padasalagi@broadcom.com> <13357929.DDBX61jLXt@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <13357929.DDBX61jLXt@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Richardson <jonathar@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Anup Patel <anup.patel@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-input@vger.kernel.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 17 February 2016 15:16
> To: Raveendra Padasalagi
> Cc: Dmitry Torokhov; Russell King; Rob Herring;
devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-input@vger.kernel.org; Pawel
Moll;
> Mark Rutland; Ian Campbell; Kumar Gala; Jonathan Richardson; Jon Mason;
> Florian Fainelli; Anup Patel; Ray Jui; Scott Branden; linux-
> kernel@vger.kernel.org; bcm-kernel-feedback-list@broadcom.com
> Subject: Re: [PATCH v2 1/3] input: cygnus-update touchscreen dt node
> document
>
> On Wednesday 17 February 2016 15:13:44 Raveendra Padasalagi wrote:
> > +
> > +       ts_adc_syscon: ts_adc_syscon@0x180a6000 {
> > +               compatible = "syscon";
> > +               reg = <0x180a6000 0xc30>;
> > +       };
> >
>
> This should have a more specific compatible string in addition to the
generic
> "syscon" one.

Ok, Thanks Arnd. I will address this in the next patch.

> 	Arnd
