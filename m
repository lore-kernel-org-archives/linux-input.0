From: Alexandra Chin <alexandra.chin@tw.synaptics.com>
Subject: RE: [PATCH v6] staging: ste_rmi4: Convert to Type-B support
Date: Wed, 14 Nov 2012 17:33:00 +0000
Message-ID: <CC51EC7B5B7F984AA566DC102237848896F62879@hkdcw-mail1.synaptics-inc.local>
References: <20121103013623.0f3a1b28168a9a42881b0b00@tw.synaptics.com>
 <20121113201212.8550fb074e1f7cce78f29d97@tw.synaptics.com>
 <20121113175309.GA3601@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tw-mx2.synaptics.com.tw ([203.163.83.68]:50239 "EHLO
	tw-mx2.synaptics.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423081Ab2KNRdT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Nov 2012 12:33:19 -0500
In-Reply-To: <20121113175309.GA3601@polaris.bitmath.org>
Content-Language: zh-HK
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Mahesh Srinivasan <msrinivasan@synaptics.com>, Alex Chang <alex.chang@tw.synaptics.com>, Scott Lin <scott.lin@tw.synaptics.com>, Christopher Heiny <Cheiny@synaptics.com>

Hi Henrik,

> > @@ -367,50 +371,33 @@ static int synpatics_rmi4_touchpad_report(struct
> synaptics_rmi4_data *pdata,
> >  						data_offset, data,
> >  						data_reg_blk_size);
> >  			if (retval != data_reg_blk_size) {
> > -				printk(KERN_ERR "%s:read data failed\n",
> > +				dev_err(&client->dev, "%s:read data failed\n",
> 
> Still not needed for this patch. Please try to refrain from making
> unnecessary changes in the future.
> 

Thanks for your acceptance!
And I will remember that do not put irrelevant changes in the same patch.
I will follow the rule to keep updating changes of v4 in future patch.
Thanks you.

Alexandra Chin
