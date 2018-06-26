From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 net] nfp: cast sizeof() to int when comparing with
 error code
Date: Mon, 25 Jun 2018 19:10:59 -0700
Message-ID: <ff0b2834b771a467246b9f7c1b4600c38f5bb463.camel@perches.com>
References: <20180626011631.22717-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626011631.22717-1-cgxu519@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chengguang Xu <cgxu519@gmx.com>, jakub.kicinski@netronome.com, davem@davemloft.net, LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, cocci <cocci@systeme.lip6.fr>
Cc: oss-drivers@netronome.com, netdev@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, 2018-06-26 at 09:16 +0800, Chengguang Xu wrote:
> sizeof() will return unsigned value so in the error check
> negative error code will be always larger than sizeof().

This looks like a general class of error in the kernel
where a signed result that could be returning a -errno
is tested against < or <= sizeof()

A couple examples:

drivers/input/mouse/elan_i2c_smbus.c:

		len = i2c_smbus_read_block_data(client,
						ETP_SMBUS_IAP_PASSWORD_READ,
						val);
		if (len < sizeof(u16)) {

i2c_smbus_read_block_data can return a negative errno


net/smc/smc_clc.c:

	len = kernel_sendmsg(smc->clcsock, &msg, &vec, 1,
			     sizeof(struct smc_clc_msg_decline));
	if (len < sizeof(struct smc_clc_msg_decline))

where kernel_sendmsg can return a negative errno

There are probably others, I didn't look hard.

Perhaps a cocci script to find these could be generated?
