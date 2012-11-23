From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] input: stmpe-ts: Add DT support for stmpe touchscreen
Date: Fri, 23 Nov 2012 12:05:01 +0000
Message-ID: <20121123120501.GA22268@gmail.com>
References: <f56ddb18f4e9c92f6a94c6d3ae3f5fe30e0bd892.1353652106.git.viresh.kumar@linaro.org>
 <20121123104620.GQ17471@gmail.com>
 <CAKohpon+iU93sviKrkR+sdCJk0Z6rz0FcvTNsh9Ap88+Qy2mVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64164 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab2KWMFH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Nov 2012 07:05:07 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so3822511bkw.19
        for <linux-input@vger.kernel.org>; Fri, 23 Nov 2012 04:05:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKohpon+iU93sviKrkR+sdCJk0Z6rz0FcvTNsh9Ap88+Qy2mVw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Vipul Kumar Samar <vipulkumar.samar@st.com>

> >> +++ b/Documentation/devicetree/bindings/input/touchscreen/stmpe.tx=
t
> >> @@ -0,0 +1,43 @@
> >> +STMPE Touchscreen
> >> +----------------
> >> +
> >> +Required properties:
> >> + - compatible: "st,stmpe-ts"
> >
> > You shouldn't be specifying a compatible string in the DT.
> >
> >> +Example:
> >> +
> >> +     stmpe_touchscreen {
> >> +             compatible =3D "st,stmpe-ts";
> >
> > This needs to be removed.
>=20
> Copying my earlier reply from stmpe-gpio patch for others to know
> what i have to say on this :)
>=20
> I believe these are required by the code you wrote in mfd-core.c
>=20
>         if (parent->of_node && cell->of_compatible) {
>                 for_each_child_of_node(parent->of_node, np) {
>                         if (of_device_is_compatible(np, cell->of_comp=
atible)) {
>                                 pdev->dev.of_node =3D np;
>                                 break;
>                         }
>                 }
>         }
>=20
> This matches compatible of child node with compatible of cell. And th=
at's
> why you have added that in your keypad mappings as well.

Yes, you're right. Please ignore this comment.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
