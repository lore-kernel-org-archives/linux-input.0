From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: schedule corgi_ssp and corgi_ts to be removed
Date: Wed, 10 Feb 2010 23:08:08 -0800
Message-ID: <20100211070808.GE8252@core.coreip.homeip.net>
References: <f17812d71002041645n15e502a3sccc76fc3f2e75c76@mail.gmail.com>
	<20100208180625.GB1469@ucw.cz>
	<f17812d71002081715w485b33bbx3f67afb86c6d8ee1@mail.gmail.com>
	<20100209090918.GA12642@core.coreip.homeip.net>
	<f17812d71002090423j4f02225av24e5af0227e0809d@mail.gmail.com>
	<f17812d71002090433g35504bccwa58460c395847f80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f17812d71002090433g35504bccwa58460c395847f80@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Feb 09, 2010 at 08:33:49PM +0800, Eric Miao wrote:
> On Tue, Feb 9, 2010 at 8:23 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> > On Tue, Feb 9, 2010 at 5:09 PM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >> On Tue, Feb 09, 2010 at 09:15:38AM +0800, Eric Miao wrote:
> >>> On Tue, Feb 9, 2010 at 2:06 AM, Pavel Machek <pavel@ucw.cz> wrote:
> >>> > On Thu 2010-02-04 16:45:41, Eric Miao wrote:
> >>> >> commit 31cec413e534520111716802833675f53ac99b0b
> >>> >> Author: Eric Miao <eric.y.miao@gmail.com>
> >>> >> Date: =A0 Thu Feb 4 16:41:28 2010 -0800
> >>> >>
> >>> >> =A0 =A0 input: schedule corgi_ssp and corgi_ts to be removed
> >>> >>
> >>> >> =A0 =A0 Cc: Richard Purdie <rpurdie@rpsys.net>
> >>> >> =A0 =A0 Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> >>> >
> >>> > ACK.
> >>> >
> >>>
> >>> Thanks, guys.
> >>>
> >>> Dmitry, I'm hoping these two patches will go through your tree please?
> >>
> >> I have it in next, do you want it in .33 instead?
> >>
> >
> > No. -next is good, thanks man.
> >
> =

> Dmitry,
> =

> Attached are the two patches updated, with Pavel's suggestion to make them
> default to 'n' and with their Acks. Please consider re-apply, sorry for t=
he
> bother.

Re-applied (with just removing 'default y' instead of replacing with
'default n' which is the same thing).

Thanks.

-- =

Dmitry
