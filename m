From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] Input: goodix: Add support for capacitive home
 button
Date: Wed, 6 Sep 2017 11:03:06 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709061102491.4077@jbgna.fhfr.qr>
References: <20170620160835.13904-1-hadess@hadess.net> <1504688419.6911.55.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504688419.6911.55.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Sergei A. Trusov" <sergei.a.trusov@ya.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Wed, 6 Sep 2017, Bastien Nocera wrote:

> Hey,
> 
> On Tue, 2017-06-20 at 18:08 +0200, Bastien Nocera wrote:
> > From: "Sergei A. Trusov" <sergei.a.trusov@ya.ru>
> > 
> > On some x86 tablets with a Goodix touchscreen, the Windows logo on
> > the
> > front is a capacitive home button. Touching this button results in a
> > touch
> > with bit 4 of the first byte set, while only the lower 4 bits (0-3)
> > are
> > used to indicate the number of touches.
> > 
> > Report a KEY_LEFTMETA press when this happens.
> > 
> > Note that the hardware might support more than one button, in which
> > case the "id" byte of coor_data would identify the button in
> > question.
> > This is not implemented as we don't have access to hardware with
> > multiple buttons.
> > 
> > Signed-off-by: Sergei A. Trusov <sergei.a.trusov@ya.ru>
> > Acked-by: Bastien Nocera <hadess@hadess.net>
> 
> Can we please get this merged? I didn't receive any reviews on it, and
> it's been sitting there for 2 months...

Let's CC Dmitry.

-- 
Jiri Kosina
SUSE Labs
