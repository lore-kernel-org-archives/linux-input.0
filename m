From: "Paulraj, Sandeep" <s-paulraj@ti.com>
Subject: RE: [PATCH 1/3] Input: DaVinci Key Scan Driver
Date: Mon, 28 Sep 2009 12:14:47 -0500
Message-ID: <0554BEF07D437848AF01B9C9B5F0BC5D92D139A6@dlee01.ent.ti.com>
References: <1253811202-21407-1-git-send-email-miguel.aguilar@ridgerun.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDAB3271@dbde02.ent.ti.com>
	<4ABCD1E8.5000200@ridgerun.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDAB36C3@dbde02.ent.ti.com>
 <0554BEF07D437848AF01B9C9B5F0BC5D92C8EBC0@dlee01.ent.ti.com>
 <4ABCD78B.5050605@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35499 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbZI1RO6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2009 13:14:58 -0400
In-Reply-To: <4ABCD78B.5050605@ridgerun.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: "Nori, Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "clark.becker@ridgerun.com" <clark.becker@ridgerun.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "santiago.nunez@ridgerun.com" <santiago.nunez@ridgerun.com>, "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>



> 
> >>>>> +     /* Enable Keyscan module and enable */
> >>>>> +     davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_AUTODET |
> >> DAVINCI_KEYSCAN_KEYEN,
> >>>>> +                     DAVINCI_KEYSCAN_KEYCTRL);
> >>>> We seem to be hardcoded to the 4x4 matrix type here.
> >>>> Some DM365 boards could use 5x3 matrix.
> >>>>
> >>>> Thanks,
> >>>> Sekhar
> >>>>
> >>> [MA] I will add a platform option for matrix type to choose 4x4 or 5x3
> >> matrix.
> >>> What do think about this?
> >>>
> >> Sounds good. I am not sure if any other piece of code
> >> needs to change though.
> > The strobe and interval have to change.  Afcourse that change comes into
> the picture only when the mode is changed from 4x4 to 5x3.
> > I can see that there are options given for this in board specific code.
> >> Thanks,
> >> Sekhar
> >
> > Thanks,
> > Sandeep
> >
> 
> struct davinci_ks_platform_data {
> 	unsigned short	*keymap;
> 	u32		keymapsize;
> 	u32		rep:1;
Don't think you need u32
> 	u32		strobe;
Strobe can be maximum 8 bits.
> 	u32		interval;
Interval can be maximum 8 bits.
> +	u32		matrix_type;
> };
> 
> I will add something like this, so from the board specific code you can
> define
> strobe, interval and matrix type.
> 
> Thanks,
> 
> Miguel Aguilar

