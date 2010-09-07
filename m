From: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Subject: RE: input:rohm based bu21013 touch panel controller driver support
Date: Tue, 7 Sep 2010 10:53:45 +0200
Message-ID: <81C3A93C17462B4BBD7E272753C1057916DE769D1C@EXDCVYMBSTM005.EQ1STM.local>
References: <81C3A93C17462B4BBD7E272753C1057916DE6765F2@EXDCVYMBSTM005.EQ1STM.local>
 <20100901020427.GC23585@core.coreip.homeip.net>
 <81C3A93C17462B4BBD7E272753C1057916DE769064@EXDCVYMBSTM005.EQ1STM.local>
 <20100906051323.GE17212@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:38962 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752441Ab0IGIxy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Sep 2010 04:53:54 -0400
In-Reply-To: <20100906051323.GE17212@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry,

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Monday, September 06, 2010 10:43 AM
> To: Naveen Kumar GADDIPATI


> 
> > > > +static bool bu21013_verify_delta(int x1, int y1, int x2, int y2)
> > > > +{
> > > > +       int delta_x, delta_y;
> > > > +       if ((x1 != 0) && (y1 != 0)) {
> > > > +               delta_x = x2 - x1;
> > > > +               if (x1 > x2)
> > > > +                       delta_x = x1 - x2;
> > > > +               delta_y = y2 - y1;
> > > > +               if (y1 > y2)
> > > > +                       delta_y = y1 - y2;
> > > > +               if ((delta_x < DELTA_MIN) || (delta_y <
> DELTA_MIN))
> > > > +                       return false;
> > >
> > > If you specify "fuzz" for given axis I think input core will do
> this
> > > for
> > > you.
> > 	What is fuzz?
> 
> 
> It is one of the parameters in input_set_abs_params() calls that
> instructs input core to perform filtering on input events.
> 
Here the delta calculation is between two co-ordinates for multi touch case according to the controller specification.
Is the fuzz useful in this case also?

Thanks & Regards,
Naveen
	


