From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v11 6/8] Input: goodix - add support for ESD
Date: Fri, 27 Nov 2015 17:24:21 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F1265D3@irsmsx105.ger.corp.intel.com>
References: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
 <1447936001-21420-7-git-send-email-irina.tirdea@intel.com>
 <20151120154458.GA12090@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14654 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754839AbbK0RYj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Nov 2015 12:24:39 -0500
In-Reply-To: <20151120154458.GA12090@rob-hp-laptop>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>



> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: 20 November, 2015 17:45
> To: Tirdea, Irina
> Cc: Dmitry Torokhov; Bastien Nocera; Aleksei Mamlin; Karsten Merker; linux-input@vger.kernel.org; Mark Rutland; Purdila, Octavian;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v11 6/8] Input: goodix - add support for ESD
> 
> On Thu, Nov 19, 2015 at 02:26:39PM +0200, Irina Tirdea wrote:
> > Add ESD (Electrostatic Discharge) protection mechanism.
> 
> [...]
> 
> > This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
> > driver gt9xx.c for Android (publicly available in Android kernel
> > trees for various devices).
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > For the binding: Acked-by: Rob Herring <robh@kernel.org>
> 
> You should not have the "For the binding:" part here. It was just a note
> so it was clear what part I looked at.
> 

I saw it done like that in another patch already merged, so I thought it's
the right way [1]. Dmitry, could you fix this at merge or you need me to
send another patchset?

Thanks,
Irina

[1] https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/commit/?id=d2a3e0931a8f3b95b910096d022ffd98adbd075c

> It is preferred to split DT bindings to separate patches for this
> reason.
> 
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > ---
> >  .../bindings/input/touchscreen/goodix.txt          |   4 +
> >  drivers/input/touchscreen/goodix.c                 | 160 ++++++++++++++++++++-
> >  2 files changed, 159 insertions(+), 5 deletions(-)
