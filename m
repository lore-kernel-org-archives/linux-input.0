From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Support for 3M multitouch panel
Date: Wed, 23 Dec 2009 10:47:58 +0100
Message-ID: <710D1CE6-4FB1-490F-9452-0ADEE565CC22@enac.fr>
References: <20091211101258.CD35D951F5@smtp.lii-enac-fr>  <20091211124226.GD17995@ibawizard.net>  <20091211141038.0CBD8951F5@smtp.lii-enac.fr>  <20091211223622.GA3067@core.coreip.homeip.net>  <694242AB-D4DC-470D-916D-9ADB2B798FBA@enac.fr>  <20091222185628.GA28392@core.coreip.homeip.net>  <20091222220417.EA008951F2@smtp.lii-enac.fr> <alpine.LNX.2.00.0912230131530.3755@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:48404 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbZLWJsG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Dec 2009 04:48:06 -0500
In-Reply-To: <alpine.LNX.2.00.0912230131530.3755@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Stephane Chatty <chatty@lii-enac.fr>, dmitry.torokhov@gmail.com, ynezz@true.cz, linux-input@vger.kernel.org


Le 23 d=E9c. 09 =E0 01:33, Jiri Kosina a =E9crit :

> On Tue, 22 Dec 2009, Stephane Chatty wrote:
>
>> Added support for 3M multitouch panels.
>
> ... I had to fix trivial build failure (3M vs. MMM inconsistency in
> defines).

Oops, sorry. This 3M / MMM thing has bothered me until the end, and I =20
probably did one change too much.

>
>> +config HID_3M_PCT
>> +	tristate "3M PCT" if EMBEDDED
>> +	depends on USB_HID
>> +	default !EMBEDDED
>
> Hmm, I wouldn't be so sure about this in this case ... the point =20
> behind
> 'default !EMBEDDED' was that simple a straightforward quirks for HID
> devices (which are implemented as drivers on HID bus) wouldn't have =20
> to be
> enabled separately, if the device is otherwise more-or-less HID =20
> standard
> compliant.
>
> But this driver is rather standalone driver, I guess we'd want to =20
> have it
> normally selectable.

I guess too. I had just copied other sections, not fully =20
understanding what I was doing.

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
