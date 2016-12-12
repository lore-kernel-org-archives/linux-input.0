From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v9] Input: synaptics-rmi4 - add support for F34 V7
 bootloader
Date: Mon, 12 Dec 2016 11:03:19 -0800
Message-ID: <20161212190319.GB10591@dtor-ws>
References: <1481415506-5152-1-git-send-email-nick@shmanahar.org>
 <20161211080349.GB39300@dtor-ws>
 <20161211201631.GA5882@lava.h.shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36081 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbcLLTDX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Dec 2016 14:03:23 -0500
Content-Disposition: inline
In-Reply-To: <20161211201631.GA5882@lava.h.shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Dec 11, 2016 at 08:16:31PM +0000, Nick Dyer wrote:
> On Sun, Dec 11, 2016 at 12:03:49AM -0800, Dmitry Torokhov wrote:
> > On Sun, Dec 11, 2016 at 12:18:26AM +0000, Nick Dyer wrote:
> > > +static void rmi_f34v7_parse_img_header_10_bl_container(struct f34_data *f34,
> > > +						       const u8 *image)
> > > +{
> > > +	int i;
> > > +	int num_of_containers;
> > > +	unsigned int addr;
> > > +	unsigned int container_id;
> > > +	unsigned int length;
> > > +	const u8 *content;
> > > +	struct container_descriptor *descriptor;
> > > +
> > > +	BUG_ON(f34->v7.img.bootloader.size < 4);
> > 
> > Killing the box because you got bad firmware is not very nice...
> > 
> > > +
> > > +	num_of_containers = (f34->v7.img.bootloader.size - 4) / 4;
> > 
> > Wouldn't
> > 
> > 	num_of_containes = f34->v7.img.bootloader.size / 4 - 1;
> > 
> > give the same result but be less "suspicious". The variable is 'int' so
> > for size < 4 we'll get a negative and the loop won't execute.
> 
> Neat!
> 
> > > +
> > > +	for (i = 1; i <= num_of_containers; i++) {
> > > +		addr = get_unaligned_le32(f34->v7.img.bootloader.data + i*4);
> > > +		descriptor = (struct container_descriptor *)(image + addr);
> > 
> > This casts away constness, which is not nice. DOes it still work if you
> > apply the below on top?
> 
> I've run it through a few flash cycles with no issues.
> 
> Tested-by: Nick Dyer <nick@shmanahar.org>

Great, I'll fold and apply then. Thanks!

-- 
Dmitry
