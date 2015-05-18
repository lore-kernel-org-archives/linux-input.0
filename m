From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] max7359_keypad: implement DT bindings
Date: Mon, 18 May 2015 10:02:03 -0700
Message-ID: <20150518170203.GD19708@dtor-ws>
References: <ppRxn-3aD-5@gated-at.bofh.it>
 <pquS6-2DV-9@gated-at.bofh.it>
 <20150517165502.GA781@fifteen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150517165502.GA781@fifteen>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Evgeniy Dushistov <dushistov-JGs/UdohzUI@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, May 17, 2015 at 07:55:02PM +0300, Evgeniy Dushistov wrote:
> On Fri, May 15, 2015 at 11:00:02PM +0200, Dmitry Torokhov wrote:
> > On Thu, May 14, 2015 at 05:38:03AM +0300, Evgeniy Dushistov wrote:
> > > +		maxim,debounce_reg = /bits/ 8 <0x5F>;
> > > +		maxim,ports_reg = /bits/ 8 <0xFF>;
> > 
> > Specifying exact size for properties is quite uncommon; I think the
> > usual recommendation is is to use the "standard" u32 and validate the
> > range in parser function.
> > 
> 
> Using of u8 has advantages, it is possible on compilation stage
> (dts->dtb) check that you enter right value, but
> because of DT validation tools are not part of mainline,
> I replace u8 with u32 as you suggest, see patch bellow.

If you get DT folks to OK using /bits/ - that's fine. Grant, Rob, any
guidance here?

> 
> > > +		MATRIX_KEY(0, 7, KEY_RESERVED)
> > > +		...
> > 
> > 
> > Indent one more level? Also, maybe fill with something other than
> > KEY_RESERVED?
> > 
> 
> Fixed, see patch bellow.
> 
> > 
> > 
>  
> > >  	dev_dbg(&client->dev, "keys FIFO is 0x%02x\n", ret);
> > > +	if (!keymap_data) {
> > > +		error = max7359_parse_dt(&client->dev, &init_state);
> > > +		if (error) {
> > > +			dev_err(&client->dev, "platform data null, and no DT data\n");
> > > +			return error;
> > 
> > Both debounce and ports values are optional and we'll fail building
> > keymap if there are no platform data nor device tree data, so I would
> > drop this check and the stub for max7359_parse_dt() as well - we have
> > stubs for property parsing anyway.
> > 
> 
> Because of u32/u8 check at now max7359_parse_dt can return not 0.
> 
> > -- 
> > Dmitry
> > 
> 
> Thanks, for review. 
> 
> Please add me to CC, because of I'm not the part
> of any mailing list (too huge traffic for me).

Umm, if you want to be replied (or CCed) to, why do you make sure that
replies do not go to you by default??? Why do you set "Mail-Followup-To"
to exclude yourself?

> Mail-Followup-To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
> 	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
> 	linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
