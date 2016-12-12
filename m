From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ALPS: fix protcol -> protocol
Date: Mon, 12 Dec 2016 11:01:21 -0800
Message-ID: <20161212190121.GA10591@dtor-ws>
References: <20161212095442.2391-1-marcos.souza.org@gmail.com>
 <20161212095608.GA18387@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161212095608.GA18387@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Dec 12, 2016 at 10:56:08AM +0100, Pali Rohár wrote:
> On Monday 12 December 2016 07:53:54 Marcos Paulo de Souza wrote:
> > Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> > ---
> >  drivers/input/mouse/alps.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
> > index b9417e2..50f05a7 100644
> > --- a/drivers/input/mouse/alps.h
> > +++ b/drivers/input/mouse/alps.h
> > @@ -146,7 +146,7 @@ struct alps_protocol_info {
> >   *   (aka command mode response) identifies the firmware minor version.  This
> >   *   can be used to distinguish different hardware models which are not
> >   *   uniquely identifiable through their E7 responses.
> > - * @protocol_info: information about protcol used by the device.
> > + * @protocol_info: information about protocol used by the device.
> >   *
> >   * Many (but not all) ALPS touchpads can be identified by looking at the
> >   * values returned in the "E7 report" and/or the "EC report."  This table
> 
> Thanks! Add my Reviewed-by: Pali Rohár <pali.rohar@gmail.com>

Applied, thank you.

-- 
Dmitry
