From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v2] Input: drivers/joystick: use parallel port device
 model
Date: Thu, 13 Aug 2015 19:16:14 +0530
Message-ID: <20150813134614.GA29298@sudip-pc>
References: <1438698351-24604-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150808103515.GC1301@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150808103515.GC1301@sudip-pc>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: linux-input@vger.kernel.org

On Sat, Aug 08, 2015 at 04:05:15PM +0530, Sudip Mukherjee wrote:
> On Tue, Aug 04, 2015 at 07:55:51PM +0530, Sudip Mukherjee wrote:
> > Modify db9 driver to use the new Parallel Port device model.
> >=20
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > ---
> >=20
> > v2: an extra check was removed. db9_base could not be removed. Alre=
ady
> > mailed you the reasons, reference is at:
> > https://lkml.org/lkml/2015/8/3/403
>=20
> Hi Dmitry,
> I was telling you on the other thread that to remove db9_base we will
> need to modify the parport code and then it has to be tested by every=
one
> again and that will also change the old behaviour of parport. The v2 =
to
> which I am replying now is still having that db9_base.
>=20
> Please see the following patch, this is the minimum change required t=
o
> update db9 driver. Personally I donot like this approach as in this
> method if a parallel port is hotplugged after this driver is loaded t=
hen
> it will not work. Please let me know your views on the posted v2 and
> also on the following proposal.

Hi Dmitry,
Did you have a chance to look at this?
Pali Roh=E1r has the hardware and he is ready to test it.

regards
sudip
