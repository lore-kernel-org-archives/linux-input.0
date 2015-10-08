From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v7 0/9] Goodix touchscreen enhancements
Date: Thu, 8 Oct 2015 12:19:41 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0F9A5F@irsmsx105.ger.corp.intel.com>
References: <1444299575-17417-1-git-send-email-irina.tirdea@intel.com>
 <5148493.XbtXJjEe71@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5148493.XbtXJjEe71@wuerfel>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Arnd Bergmann
> Sent: 08 October, 2015 14:10
> To: Tirdea, Irina
> Cc: Dmitry Torokhov; Bastien Nocera; Aleksei Mamlin; linux-input@vger.kernel.org; Mark Rutland; Purdila, Octavian; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v7 0/9] Goodix touchscreen enhancements
> 
> On Thursday 08 October 2015 13:19:26 Irina Tirdea wrote:
> > Add several enhancements to the Goodix touchscreen driver.
> >
> > Bastien, the functionality from this patches should be now skipped
> > for your devices (Onda v975w, WinBook TW100 and WinBook TW700).
> >
> > Aleksei, I have removed your Tested-by tag since I have done some
> > non-trivial changes to the "reset device at init" patch.
> >
> >
> 
> I've read over all 9 patches now, most of them look good, but I
> commented on the one that I have concerns about.
> 

Thanks for the review, Arnd!

Irina

> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
