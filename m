From: Benson Leung <bleung@chromium.org>
Subject: Re: [patch] Input: remove a duplicative NULL test
Date: Wed, 12 Mar 2014 21:24:31 -0700
Message-ID: <CANLzEktLFDcMpt7Gq19=7T1Ak2Be4qs3fmDPyswHUNrVJiGjSQ@mail.gmail.com>
References: <20140221085506.GB13185@elgon.mountain>
	<e1cf3227a1484c3b931abb61b97391a6@BLUPR03MB373.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <e1cf3227a1484c3b931abb61b97391a6@BLUPR03MB373.namprd03.prod.outlook.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: "fugang.duan@freescale.com" <fugang.duan@freescale.com>, Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Feb 21, 2014 at 1:14 AM, fugang.duan@freescale.com
<fugang.duan@freescale.com> wrote:
>
> Agree, it is redundant. And if you have free time, you can convert the driver to support devicetree.

Please check with Nick Dyer before you convert this driver to support
devicetree. Much of the platform data this driver uses has been
eliminated or consolidated in a patch series that he's been working
on.



-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
