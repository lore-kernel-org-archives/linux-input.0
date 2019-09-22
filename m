From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V2 2/5] input: keyboard: imx_sc: Add i.MX system
 controller power key support
Date: Sun, 22 Sep 2019 18:14:01 +0200
Message-ID: <20190922161401.GC1999@bug>
References: <1567519424-32271-1-git-send-email-Anson.Huang@nxp.com>
 <1567519424-32271-2-git-send-email-Anson.Huang@nxp.com>
 <6d8dd5df-02da-b4cd-e61d-a4a15d0bf0c8@pengutronix.de>
 <DB3PR0402MB391602C6B425DD7EBFB9AF1DF5B90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <dbe0ba0a-29bc-ee96-541d-244b3dbf0b81@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dbe0ba0a-29bc-ee96-541d-244b3dbf0b81@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Anson Huang <anson.huang@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Andy Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, "mripard@kernel.org" <mripard@kernel.org>, "olof@lixom.net" <olof@lixom.net>
List-Id: linux-input@vger.kernel.org

Hi!

> >>Why is it global struct? It seems to be flexible configurable over devicetree.
> >>So I would assume it should be able to handle more then one button. Please
> >>remove global variables, make it allocatable per OF node.
> >
> >There is ONLY one button available for SC key, but yes, I think I can make the structure
> >private and get all necessary data from the structure using container_of.
> 
> And we will never need more then 640 kB RAM ;)
> https://en.wikiquote.org/wiki/Talk:Bill_Gates

Right question is "is it worth complicating kernel now (and making it slower/bigger)
for future flexibility?". And I believe answer is "no", but it is not a big deal
either way.								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
