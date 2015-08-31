From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v2] Input: drivers/joystick: use parallel port device
 model
Date: Mon, 31 Aug 2015 20:15:25 +0530
Message-ID: <20150831144525.GA29009@sudip-pc>
References: <1438698351-24604-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150808103515.GC1301@sudip-pc>
 <20150813134614.GA29298@sudip-pc>
 <20150813162602.GA15693@dtor-ws>
 <20150814065541.GA25515@sudip-pc>
 <20150814070555.GA6877@pali>
 <20150817072934.GA12361@sudip-pc>
 <20150831134419.GA15922@sudip-pc>
 <20150831135558.GI14484@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150831135558.GI14484@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 31, 2015 at 03:55:58PM +0200, Pali Roh=E1r wrote:
> > > Sorry for the delay in replying. The change in parallel port code=
 was
> > > merged in 4.2, so you can test it againt 4.2-rc*.
> > Hi Pali,
> > Now that 4.2 is released you can test on it. And do you also have a=
ny
> > option to test the other joysticks using parallel port? Because, af=
ter
> > you test this patch I will be sending the similar patches for other
> > joysticks and parkbd.
> >=20
> > regards
> > sudip
>=20
> Hi! First I need to install new 4.2 kernel for testing on that machin=
e.
> It would not be easy...
Will it be easy if I backport the parallel port patch to 3.13? maximum
chance that the parallelport patch will apply on 3.13 but I need to tes=
t
first to confirm.

regards
sudip
