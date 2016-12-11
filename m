From: Nick Dyer <nick@shmanahar.org>
Subject: Re: [PATCH v8] Input: synaptics-rmi4 - add support for F34 V7
 bootloader
Date: Sun, 11 Dec 2016 00:14:08 +0000
Message-ID: <20161211001408.GA2327@lava.h.shmanahar.org>
References: <1480899769-31330-1-git-send-email-nick@shmanahar.org>
 <20161208021418.GD27638@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161208021418.GD27638@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Dec 07, 2016 at 06:14:18PM -0800, Dmitry Torokhov wrote:
> On Mon, Dec 05, 2016 at 01:02:49AM +0000, Nick Dyer wrote:
> > +static void rmi_f34v7_parse_img_header_10_bl_container(struct f34_data *f34,
> > +						       const u8 *image)
> > +{
> > +	int i;
> > +	u8 num_of_containers;
> > +	unsigned int addr;
> > +	unsigned int container_id;
> > +	unsigned int length;
> > +	const u8 *content;
> > +	struct container_descriptor *descriptor;
> > +
> > +	BUG_ON(f34->v7.img.bootloader.size < 4);
> > +
> > +	num_of_containers = (f34->v7.img.bootloader.size - 4) / 4;
> > +
> > +	for (i = 1; i <= num_of_containers; i++) {
> > +		addr = le32_to_cpu(f34->v7.img.bootloader.data + (i * 4));
> 
> This cannot possibly be right. "f34->v7.img.bootloader.data + (i * 4)"
> is a pointer in memory, you should not be converting it from le32.
> 
> Did you mean to use le32_to_cpup((__le32 *)(f34->v7.img.bootloader.data
> + (i * 4))) ?

You're quit right. It should be get_unaligned_le32() to read an offset
address from the firmware image. Will be fixed in v9.

Nick
