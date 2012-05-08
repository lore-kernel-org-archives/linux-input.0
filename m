From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC] Input: MT - Include win8 support
Date: Tue, 8 May 2012 20:40:52 +0200
Message-ID: <20120508184052.GA23748@polaris.bitmath.org>
References: <1336230499-1450-1-git-send-email-rydberg@euromail.se>
 <CAN+gG=HqGmf77P6=7RMFT_Ez7Ysp4ZVJ6skfAoDcZ7JN1JtYnw@mail.gmail.com>
 <20120506182835.GA12221@polaris.bitmath.org>
 <20120508060221.GA15925@yabbi.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120508060221.GA15925@yabbi.bne.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, chatty@enac.fr, chasedouglas@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> > to aid in the discussion, I have shared a drawing of the MT model
> > and the (supposed) win8 model.
> > 
> > https://docs.google.com/document/d/1KKu7kqPOsvE9tCmWhdGnmO8tgmN0Cd-Mv_crVaCZueY/view
> 
> having an asciiart version of this in Documentation/ would be quite useful,
> IMO

Yep, that ought to be possible to arrange.

> Insert a paragraph into the actual documentation. I think that's more
> helpful than tacking it on (if not quite as nice in a diff)
> 
> "The orientation of the ellipse. The value should describe a signed quarter
> of a revolution clockwise around the touch center. The signed value range
> is arbitrary, but zero should be returned for a finger aligned along the Y
> axis of the surface, a negative value when finger is turned to the left, and
> a positive value when finger turned to the right. When completely aligned
> with the X axis, the range max should be returned.  
> 
> Touch ellipsis are symmetrical by default. For devices capable of true 360
> degree orientation, the reported orientation must exceed the range max to
> indicate more than a quarter of a revolution. For an upside-down finger, 
> range max * 2 should be returned.
> 
> Orientation can be omitted if the touching object is circular, or if the
> information is not available in the kernel driver. Partial orientation
> support is possible if the device can distinguish between the two axis, but
> not (uniquely) any values in between. In such cases, the range of
> ABS_MT_ORIENTATION should be [0, 1] [4]."

Looks good, will copy that in its entirety. :-)

> Not a big fan of reporting values above absmin/absmax, tbh. It means we
> can't rely on the axis values and have to special-case it. Plus, there's no
> way to detect this before you actually get a value.

True, and I am open to other suggestions. However, I think the
proposal integrates pretty well with the existing model and is likely
to produce reasonable results without userland modifications.

> > Looking at the figure, it is clear that the MT model has two centers,
> > one for each ellipse. Thus, center is not discriminating
> > enough. Perhaps ABS_MT_OUTER_X/Y is more appropriate, then?
> 
> ABS_MT_OUTER_CENTER

I appreciate the suggestion, but along two-word combinations,
ABS_MT_OUTER_POSITION would integrate better with existing names. Both
seem awfully long, though.

Thanks for your input!

Henrik
